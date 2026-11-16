# A minimal yardstick

Two small, model-free evaluations used in the chapter on measuring a changed
method. Neither calls a hosted model.

- `promptfooconfig.yaml` with `prompts/`: two briefs for the same task, the
  built-in `echo` provider, three tests. Run in this directory:
  `promptfoo eval -c promptfooconfig.yaml --no-cache --no-share -o results.json`.
  Expected: 4 passed, 2 failed, exit code 100. The baseline brief fails the
  cutoff and read-only tests.
- `zero_task.py`: an Inspect task with three samples and a custom mock model
  that always answers "keep". Run:
  `inspect eval zero_task.py --model mockllm/model --log-dir ./logs`.
  Expected accuracy 0.667. The plain built-in mock needs a tokenizer download;
  this file sets token usage itself so that it runs offline.

Checked on 2026-11-14 with promptfoo 0.125.1 and Inspect 0.3.289.
