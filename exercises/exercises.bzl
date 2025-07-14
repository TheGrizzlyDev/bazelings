"""
This module is used to list all the info about the exercises
"""

def get_exercise_info():
    exercises = []
    for module in native.glob(["*/README.md"]):
        if module.startswith(".template"):
            continue
        workspace = module.rsplit("/", 1)[0]
        lesson_name = workspace
        use_default_runner = len(native.glob([workspace + "/.use_dedicated_runner"], allow_empty=True)) == 0
        exercises.append(struct(workspace_path = workspace, lesson_name = lesson_name, use_default_runner = use_default_runner))
    return exercises
