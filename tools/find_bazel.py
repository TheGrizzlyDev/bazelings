import os

def get_cmdline(pid):
    try:
        with open(f"/proc/{pid}/cmdline", "rb") as f:
            return f.read().decode().replace('\x00', ' ').strip()
    except Exception:
        return ""

def find_bazel_process():
    pid = os.getpid()
    visited = set()
    while pid != 1 and pid not in visited:
        visited.add(pid)
        cmdline = get_cmdline(pid)
        if cmdline:
            executable = cmdline.split(" ")[0]
            if "bazel" in executable.lower():
                return pid, executable
        try:
            with open(f"/proc/{pid}/status") as f:
                for line in f:
                    if line.startswith("PPid:"):
                        pid = int(line.split()[1])
                        break
                else:
                    break  # No PPid line found
        except Exception:
            break
    return None, None