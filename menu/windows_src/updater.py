# A simple file to check for updates
# License: GNU GPL v3
# Project: Cubebox
# Authors: The Cubebox Team

from time import sleep
import os
import subprocess
import urllib2


request = urllib2.Request("http://www.cubebox.bplaced.net/version")
handle = urllib2.urlopen(request)
versioninformations = handle.read().split('\n')
newversion = versioninformations.pop(0)
handle.close()

versionfile = open("version", "r")
oldversion = versionfile.read()
versionfile.close()

if oldversion != newversion:
	print "The new version '" + newversion + "' is available."
	print "Your version is '" + oldversion + "'"
	print "Press return to update or something else and return to quit!"
	
	if raw_input() != "":
		quit()

	print "Downloading updates..."

	for filename in versioninformations:
		print filename
		request = urllib2.Request("http://www.cubebox.bplaced.net/updates/" + filename)
		handle = urllib2.urlopen(request)
		
		if filename != "updater.exe":
			localfile = open(filename, "wb")
		else:
			localfile = open("tmp_updater.exe", "wb")
		
		localfile.write(handle.read())
		localfile.close()
		handle.close()

		print "Updated '" + filename + "'"
		
		if filename == "updater.exe":
			subprocess.call(["updater_update.exe"])
			quit()
		
	print ""
	print "Update downloaded and sucessfully installed!..."
	print "Press return to quit!"

	raw_input()

	quit()
	
else:
	print "You are already up-to-date!"
	print "Press return to quit!"
	raw_input()
	
