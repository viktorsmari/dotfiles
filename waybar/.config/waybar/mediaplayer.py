#!/usr/bin/env python3

import argparse
import json
import subprocess
import sys


def metadata(player):
    cmd = [
        "playerctl",
        f"--player={player}",
        "--no-messages",
        "metadata",
        "--format",
        "{{status}}\n{{artist}}\n{{title}}\n{{mpris:trackid}}",
    ]

    try:
        result = subprocess.run(
            cmd,
            check=True,
            stdout=subprocess.PIPE,
            stderr=subprocess.DEVNULL,
            text=True,
        )
    except (FileNotFoundError, subprocess.CalledProcessError):
        return None

    lines = result.stdout.rstrip("\n").split("\n", 3)
    while len(lines) < 4:
        lines.append("")

    return {
        "status": lines[0],
        "artist": lines[1],
        "title": lines[2],
        "trackid": lines[3],
    }


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument("--player", default="spotify")
    args = parser.parse_args()

    data = metadata(args.player)
    if not data:
        print(json.dumps({"text": "", "alt": args.player, "class": args.player}))
        return

    if args.player == "spotify" and ":ad:" in data["trackid"]:
        text = "Advertisement"
    elif data["artist"] and data["title"]:
        text = f"{data['artist']} - {data['title']}"
    else:
        text = data["title"] or data["artist"]

    if text:
        icon = "▶" if data["status"] == "Playing" else "⏸"
        text = f"{icon} {text}"

    print(json.dumps({
        "text": text,
        "alt": args.player,
        "class": data["status"].lower(),
    }))


if __name__ == "__main__":
    try:
        main()
    except BrokenPipeError:
        sys.exit(0)
