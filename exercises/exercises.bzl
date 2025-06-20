"""
This module is used to list all the info about the exercises
"""

def get_exercise_info():
    return [
        struct(workspace_path = workspace, lesson_name = workspace + "_test")
        for workspace in [
            module.split("/")[0] for module in native.glob(["*/MODULE.bazel"])
        ]
    ]
