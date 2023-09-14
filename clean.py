import os
import shutil
import sys

dir = sys.argv[1]
subfolders = [f.path for f in os.scandir(dir) if f.is_dir()]

for filepath in subfolders:
    basename = os.path.basename(filepath)

    if basename not in ("ec2", "ssm", "iam"):
        print(f"Deleting {basename}")
        shutil.rmtree(filepath)
