import importlib
import os
import unittest

export_rows = importlib.import_module(os.environ.get("EXPORT_MODULE", "export_bug")).export_rows


class ExportContract(unittest.TestCase):
    def test_keeps_zero_and_negative_return(self):
        rows = [{"return_bps": 0}, {"return_bps": 50}, {"return_bps": -100}, {"return_bps": None}]
        self.assertEqual(export_rows(rows), rows[:3])

    def test_empty_input(self):
        self.assertEqual(export_rows([]), [])


if __name__ == "__main__":
    unittest.main()
