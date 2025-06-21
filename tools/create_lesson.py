import os
import sys
import shutil
import subprocess

from tools.find_bazel import find_bazel_process

if __name__ == "__main__":
    # 1. Find the Bazel binary path
    _, bazel_bin = find_bazel_process()
    if not bazel_bin:
        print("Could not locate Bazel binary.")
        sys.exit(1)

    # 2. Get workspace directory
    workspace_dir = os.environ.get("BUILD_WORKSPACE_DIRECTORY")
    if not workspace_dir:
        print("BUILD_WORKSPACE_DIRECTORY environment variable not set.")
        sys.exit(1)

    # 3. Change working directory to workspace as bazel cannot run from an output directory
    os.chdir(workspace_dir)

    # 4. Parse CLI argument
    if len(sys.argv) < 2:
        print("Usage: script.py <lesson-name>")
        sys.exit(1)
    lesson = sys.argv[1]

    # 5. Copy template directory
    src = os.path.join("exercises", ".template")
    dst = os.path.join("exercises", lesson)
    if os.path.exists(dst):
        print(f"Target folder already exists: {dst}")
        sys.exit(1)
    shutil.copytree(src, dst)
    print(f"Created exercise folder: {dst}")

    # 6. Update deleted packages in .bazelrc
    result = subprocess.run([
        bazel_bin,
        "run",
        "@rules_bazel_integration_test//tools:update_deleted_packages"
    ])
    sys.exit(result.returncode)
