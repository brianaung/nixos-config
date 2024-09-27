{ pkgs, ... }:
let
  umpv = pkgs.writers.writePython3Bin "umpv" {} ''
    import sys
    import os
    import socket
    import errno
    import subprocess
    import string
    import shlex

    files = sys.argv[1:]


    # this is the same method mpv uses to decide this
    def is_url(filename):
        parts = filename.split("://", 1)
        if len(parts) < 2:
            return False
        # protocol prefix has no special characters => it's an URL
        allowed_symbols = string.ascii_letters + string.digits + '_'
        prefix = parts[0]
        return all(map(lambda c: c in allowed_symbols, prefix))


    # make them absolute; also makes them safe against interpretation as options
    def make_abs(filename):
        if not is_url(filename):
            return os.path.abspath(filename)
        return filename


    files = (make_abs(f) for f in files)

    SOCK = (os.path.join(
        os.getenv("XDG_RUNTIME_DIR", os.getenv("HOME")), ".umpv_socket"
    ))

    sock = None
    try:
        sock = socket.socket(socket.AF_UNIX)
        sock.connect(SOCK)
    except socket.error as e:
        if e.errno == errno.ECONNREFUSED:
            sock = None
            pass  # abandoned socket
        elif e.errno == errno.ENOENT:
            sock = None
            pass  # doesn't exist
        else:
            raise e

    if sock:
        # Unhandled race condition: what if mpv is terminating right now?
        for f in files:
            # escape: \ \n "
            f = f.replace("\\", "\\\\").replace("\"", "\\\"").replace("\n", "\\n")
            f = "\"" + f + "\""
            sock.send(("raw loadfile " + f + " append\n").encode("utf-8"))
    else:
        # Let mpv recreate socket if it doesn't already exist.

        opts = shlex.split(os.getenv("MPV") or "mpv")
        opts.extend([
            "--no-terminal",
            "--force-window",
            "--input-ipc-server=" + SOCK,
            "--"
        ])
        opts.extend(files)

        subprocess.check_call(opts)
  '';
in
{
  home.packages = [ umpv ];
}
