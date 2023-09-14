import sys

setup_file = sys.argv[1]
wheel_file = sys.argv[2]

with open(setup_file, "r") as f:
    contents = f.read()

new_contents = ""

for line in contents.split("\n"):
    if line.strip().startswith("'botocore"):
        new_contents += f"    'botocore @ {wheel_file}',\n"
    else:
        new_contents += line + "\n"

with open(setup_file, "w") as f:
    f.write(new_contents)
