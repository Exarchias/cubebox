# The script to update the updater!
# License: GNU GPL v3
# Project: Cubebox
# Authors: The Cubebox Team


from time import sleep

print "Updating the updater ..."
sleep(2)

tmpupdater = open("tmp_updater.exe", "rb")
newupdater = open("updater.exe", "wb")
newupdater.write(tmpupdater.read())
tmpupdater.close()
newupdater.close()


print ""
print "Update downloaded and sucessfully installed!..."
print "Press return to quit!"

raw_input()


