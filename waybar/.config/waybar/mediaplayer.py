#!/usr/bin/env python3

import argparse
import json
import subprocess
import sys


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument("--player", default="spotify")
    args = parser.parse_args()

    cmd = [
        "playerctl",
        f"--player={args.player}",
        "--follow",
        "metadata",
        "--format",
        "{{status}}\n{{artist}}\n{{title}}\n{{mpris:trackid}}".replace("\\n", "\n"),
    ]

    proc = subprocess.Popen(
        cmd,
        stdout=subprocess.PIPE,
        stderr=subprocess.DEVNULL,
        text=True,
    )

    lines = []
    for line in proc.stdout:
        line = line.rstrip("\n")
        lines.append(line)
        if len(lines) < 4:
            continue

        status, artist, title, trackid = lines
        lines = []

        if args.player == "spotify" and ":ad:" in trackid:
            text = "Advertisement"
        elif artist and title:
            text = f"{artist} - {title}"
        else:
            text = title or artist

        if text:
            icon = ">" if status == "Playing" else "||"
            text = f"{icon} {text}"

        print(json.dumps({
            "text": text,
            "alt": args.player,
            "class": status.lower(),
        }), flush=True)


if __name__ == "__main__":
    try:
        main()
    except (BrokenPipeError, KeyboardInterrupt):
        sys.exit(0)
