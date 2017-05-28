import subprocess
import sys

str(sys.argv)

models_files = "Tests/best_model/family_1"

command = ['grep',
           str('Best model according to BIC:'),
           str(models_files)
           ]
# First want the output of the source command -> check_output()
# Secondly, we want to avoid to have the output as byte -> .decode(sys.stdout.encoding)
best_model = subprocess.check_output(command).decode(sys.stdout.encoding).rstrip().split(':')[1]
