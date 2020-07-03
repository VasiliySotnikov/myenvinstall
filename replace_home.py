#!/usr/bin/env python3

from argparse import ArgumentParser
from pathlib import Path
home = str(Path.home())

parser = ArgumentParser()
parser.add_argument("-f", dest="filename", required=True)

args = parser.parse_args()

filename = args.filename

with open(filename) as f:
    newText = f.read().replace('@HOME@', home)

    with open(filename, "w") as f:
        f.write(newText)
