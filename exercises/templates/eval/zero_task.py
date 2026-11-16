from inspect_ai import Task, task
from inspect_ai.dataset import Sample
from inspect_ai.model import ModelOutput, ModelUsage, get_model
from inspect_ai.scorer import includes
from inspect_ai.solver import generate


def always_keep(input, tools, tool_choice, config):
    out = ModelOutput.from_content(model="mockllm", content="keep")
    out.usage = ModelUsage(input_tokens=1, output_tokens=1, total_tokens=2)
    return out


@task
def zero_task():
    return Task(
        dataset=[
            Sample(input="A row has return_bps = 0. Keep or drop? One word.", target="keep"),
            Sample(input="A row has return_bps = -100. Keep or drop? One word.", target="keep"),
            Sample(input="A row has return_bps = None. Keep or drop? One word.", target="drop"),
        ],
        solver=generate(),
        scorer=includes(),
        model=get_model("mockllm/model", custom_outputs=always_keep),
    )
