#!/usr/bin/env python3
import os
import json
from sphinx_action import action

# This is the entrypoint called by Github when our action is run. All the
# Github specific setup is done here to make it easy to test the action code
# in isolation.
if __name__ == "__main__":
    requirements = os.environ['INPUT_PIP-REQUIREMENTS']
    if requirements != "" and os.path.exists(requirements):
        print("[sphinx-action] Installing pip requirements.")
        subprocess.check_call(["pip", "install", "-r", requirements])

    environment = os.environ['INPUT_CONDA-ENVIRONMENT']
    if environment!= "" and os.path.exists(environment):
        print("[sphinx-action] Installing conda environment.")
        subprocess.check_call(["conda", "env", "update",
                               "--name", "base",
                               "--file", environment])

    print("[sphinx-action] Starting sphinx-action build.")

    if "INPUT_PRE-BUILD-COMMAND" in os.environ:
        pre_command = os.environ["INPUT_PRE-BUILD-COMMAND"]
        print("Running: {}".format(pre_command))
        os.system(pre_command)

    github_env = action.GithubEnvironment(
        build_command=os.environ.get("INPUT_BUILD-COMMAND"),
    )

    # We build the doc folder passed in the inputs.
    action.build_all_docs(github_env, [os.environ.get("INPUT_DOCS-FOLDER")])
