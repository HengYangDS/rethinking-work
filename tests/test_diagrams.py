"""Check the data-chain relationships in real native-rendered SVG geometry."""

import math
from pathlib import Path
import re
import subprocess
import unittest
import xml.etree.ElementTree as ET


ROOT = Path(__file__).resolve().parents[1]
NODES = {
    "A": "冻结快照",
    "B": "dlt：加载",
    "C": "DuckDB：原表",
    "D": "SQLMesh：模型／审计",
    "E": "结果／拒绝",
    "F": "Dagster：依赖／检查",
    "G": "负责人接受",
}
RELATIONSHIPS = (
    ("A", "B", "solid"),
    ("B", "C", "solid"),
    ("C", "D", "solid"),
    ("D", "E", "solid"),
    ("E", "G", "solid"),
    ("F", "B", "dotted"),
    ("F", "D", "dotted"),
)
NUMBER = r"-?\d+(?:\.\d+)?"


class DataChainRender(unittest.TestCase):
    @classmethod
    def setUpClass(cls):
        result = subprocess.run(
            ["just", "--justfile", "publication/justfile", "diagram", "data-chain", "svg"],
            cwd=ROOT,
            stdin=subprocess.DEVNULL,
            capture_output=True,
            text=True,
            timeout=60,
            check=False,
        )
        if result.returncode:
            raise AssertionError(result.stderr)
        cls.svg = ET.parse(ROOT / "build/artifacts/diagrams/data-chain.svg").getroot()

    def test_render_preserves_complete_nodes_and_directed_relationships(self):
        nodes = {}
        for element in self.svg.iter():
            if element.get("class", "").startswith("node "):
                identity = element.get("id").rsplit("-", 1)[-1]
                nodes[identity] = element
        self.assertEqual(set(nodes), set(NODES))
        centers = {}
        for identity, label in NODES.items():
            self.assertEqual("".join(nodes[identity].itertext()).strip(), label)
            coordinates = re.fullmatch(
                rf"translate\(({NUMBER}),\s*({NUMBER})\)",
                nodes[identity].get("transform", ""),
            )
            self.assertIsNotNone(coordinates, identity)
            centers[identity] = tuple(map(float, coordinates.groups()))

        edges = [e for e in self.svg.iter() if e.get("data-edge") == "true"]
        self.assertEqual(len(edges), len(RELATIONSHIPS))
        markers = {e.get("id"): e for e in self.svg.iter() if e.tag.endswith("}marker")}
        for source, target, pattern in RELATIONSHIPS:
            with self.subTest(source=source, target=target):
                selected = [
                    e for e in edges if e.get("data-id", "").endswith(f"-{source}-{target}")
                ]
                self.assertEqual(len(selected), 1)
                edge = selected[0]
                self.assertIn(f"edge-pattern-{pattern}", edge.get("class", ""))
                self.assertIsNone(edge.get("marker-start"))
                marker = re.fullmatch(r"url\(#([^)]+)\)", edge.get("marker-end", ""))
                self.assertIsNotNone(marker)
                self.assertEqual(markers[marker.group(1)].get("orient"), "auto")

                # A coincident final segment leaves the arrowhead without a direction.
                path = edge.get("d", "")
                points = re.findall(rf"[ML]({NUMBER}),({NUMBER})", path)
                segments = re.findall(rf"([ML])({NUMBER}),({NUMBER})", path)
                self.assertEqual("".join(f"{command}{x},{y}" for command, x, y in segments), path)
                self.assertGreaterEqual(len(points), 2)
                before, end = (tuple(map(float, point)) for point in points[-2:])
                tangent = (end[0] - before[0], end[1] - before[1])
                self.assertGreater(
                    math.hypot(*tangent),
                    0.01,
                    f"{source} -> {target}: degenerate arrowhead tangent",
                )
                toward_target = tuple(b - a for a, b in zip(centers[source], centers[target]))
                self.assertGreater(
                    sum(a * b for a, b in zip(tangent, toward_target)),
                    0,
                    f"{source} -> {target}: arrow points away from target",
                )


if __name__ == "__main__":
    unittest.main()
