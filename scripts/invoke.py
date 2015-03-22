#!/usr/bin/python

import subprocess
import sys
import os
import re

command = sys.argv[1:]

proc = subprocess.Popen(command)

if proc.wait() == 0:
    sys.exit(0)

bash_metas = r'<>|?*[]$\(){}"`&;' + "'"
bash_bad = re.compile(r"\s|" + '|'.join("\\" + x for x in bash_metas))

def bashquote(x):
    if not re.search(bash_bad, x):
        return x
    return "'" + re.sub(r"'", r"'\''", x) + "'"

def bashquote_list(x):
    return ' '.join(map(bashquote, x))

ttyw = open("/dev/tty", "w")
ttyr = open("/dev/tty", "r")

print >>ttyw, "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
print >>ttyw, "!!!"
print >>ttyw, "!!! command failed: " + bashquote_list(command)
print >>ttyw, "!!!"
print >>ttyw, "!!! starting an interactive shell for debugging..."
print >>ttyw, "!!!"
print >>ttyw, "!!! exit this shell to return to the build"
print >>ttyw, "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"

proc = subprocess.Popen(os.environ['SHELL'].split() + ['-i'],
                        stdout=ttyw, stdin=ttyr, stderr=ttyw)


proc.wait()

sys.exit(1)
