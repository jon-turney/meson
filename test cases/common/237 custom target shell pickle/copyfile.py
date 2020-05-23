#!/usr/bin/env python3

import sys
import shutil

if len(sys.argv) != 3:
    raise SystemExit('Unexpected arguments {!r}'.format(sys.argv))

shutil.copyfile(sys.argv[1], sys.argv[2])
