# -*- coding: cp932 -*-

"""
Makinge dotfiles link
""" 

import os
import sys
import subprocess
import glob
import ctypes

def make_link( path , dest  ):
    if sys.platform == "win32":
        #p = subprocess.Popen(["cmd", "/C", "mklink", dest, path]  )
        return subprocess.call(["cmd", "/C", "mklink", dest, path] )
    else:
        os.symlink( path , dest )

def make_dot_link(filename , action_if_exist = "backup" ):
    home = None
    # Select Command Platforms
    if sys.platform == "win32":
        home = os.environ["USERPROFILE"] 
    elif sys.platform == "linux":
        home = "~/" 
    else:
        return False
    # Override Check
    dest = os.path.join( home , filename )
    path = os.path.join( home , "dotfiles" , filename )
    if os.path.exists(dest) :
        if action_if_exist == "override":
            print "remove:  \"%s\""%dest
            os.remove( dest )
            pass
        # <todo> Impliment Back Up Way in the feature
        #elif action_if_exist == "backup":
        #    print "---backup:  \"%s\" -> \"%s\" "%dest
        else:
            print "skip  : %s"%dest
            print "  --Cannot detect the way if found"
            return False
        #subprocess.popen("mklink %s %s" )
    # Exec 
    if 0 == make_link( path, dest):
        print "link  : \"%s\" -> \"%s\" "%(path,dest)
    else:
        print "link-fail: \"%s\" -> \"%s\" "%(path,dest)
if __name__ == "__main__":
    make_dot_link( ".vimrc"  )

