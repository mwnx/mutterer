#!/usr/bin/env python2
# Do not modify this file. Place any custom python functions in a file
# called userPython.py in ~/.offlineimap/ and it will be imported. The
# functions defined in that file can be accessed in the 'userDefined'
# namespace.
# Ex. "~/.offlineimap/userPython.py":
#     def testing():
#         print ("test")
# Can be used called in .muttererrc as:
#     userDefined.testing()

import os
import subprocess
import imp

def mailpasswd(accountName):
    keysDirectory = os.path.expanduser("~/.offlineimap/keys/");
    path = keysDirectory + accountName + ".asc"
    args = ["gpg", "--use-agent", "--quiet", "--batch", "-d", path]
    try:
        return subprocess.check_output(args).strip()
    except subprocess.CalledProcessError:
        return ""

userPythonPath = os.path.expanduser("~/.offlineimap/userPython.py");
if os.path.exists(userPythonPath):
    userDefined = imp.load_source('module.name', userPythonPath)
