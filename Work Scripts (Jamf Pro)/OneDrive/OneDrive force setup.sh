#!/bin/bash

########################################################################
#                      One Drive User Adoption                         #
############# Written by Suleyman Twana and Phil Walker ################
########################################################################

########################################################################
#                            Variables                                 #
########################################################################

LoggedInUser=$(python -c 'from SystemConfiguration import SCDynamicStoreCopyConsoleUser; import sys; username = (SCDynamicStoreCopyConsoleUser(None, None, None) or [None])[0]; username = [username,""][username in [u"loginwindow", None, u""]]; sys.stdout.write(username + "\n");')
ScreenSaverStatus=$(ps ax | grep [S]creenSaverEngine)
LockScreenStatus=$(python -c 'import sys,Quartz; d=Quartz.CGSessionCopyCurrentDictionary(); print d' | grep -i "locked" | head -n1 | awk '{print $3}' | sed 's/;//g')
ODAppPath=$(ls -l /Applications/ | grep -i "onedrive" | grep -v "OneDrive for Business" | awk '{print $9}' | sed 's/.app//g')
#OneDrive folder paths. Previous and latest path.
OldTenantName="/Users/"${LoggedInUser}"/OneDrive - Bauer Group"
NewTenantName="/Users/"${LoggedInUser}"/OneDrive - Bauer Media Group"
SIZE="1000"

########################################################################
#                            Functions                                 #
########################################################################

function checkloginstatus ()
{
# Check if mac is at login window
		if [[ "${LoggedInUser}" == "root" ]]; then
		echo "No user logged in"
exit 0
else
		echo "${LoggedInUser} is logged in"
fi
}

function checkscreensaver ()
{
# Check if screensaver is running
	if [[ "${ScreenSaverStatus}" != "" ]]; then
		echo "Screensaver is running"
exit 0
else
		echo "Screensaver is not running"
fi
}

function checklockscreen ()
{
# Check if the screen is locked with user loged in
	if [[ "${LockScreenStatus}" == 1 ]]; then
		echo "Screen is locked"
exit 0
else
		echo "Screen is unlocked"
fi
}

function checkonedriveapp ()
{
# Check if OneDrive is installed
	if [[ "${ODAppPath}" == "" ]]; then
		echo "${ODAppPath} is not installed"
exit 0
else
		echo "${ODAppPath} is installed"
fi
}

function checkonedrivefolder()
{
# Check if the users OneDrive folder exists and which tenant name its onfigured to use
	if [[ -d "$OldTenantName" ]] && [[ ! -d "$NewTenantName" ]]; then
		ODFolderPath="/Users/"${LoggedInUser}"/OneDrive - Bauer Group"
			echo "${ODFolderPath} folder exists"
			ODFolderSize=$(du -ks "$ODFolderPath" | awk '{print $1}')
	elif [[ ! -d "$OldTenantName" ]] && [[ -d "$NewTenantName" ]]; then
		ODFolderPath="/Users/"${LoggedInUser}"/OneDrive - Bauer Media Group"
			echo "${ODFolderPath} folder exists"
			ODFolderSize=$(du -ks "$ODFolderPath" | awk '{print $1}')
  elif [[ -d "$OldTenantName" ]] && [[ -d "$NewTenantName" ]]; then
		ODFolderPath="/Users/"${LoggedInUser}"/OneDrive - Bauer Media Group"
			echo "${ODFolderPath} folder exists"
			ODFolderSize=$(du -ks "$ODFolderPath" | awk '{print $1}')
	else
		ODFolderPath="/Users/"${LoggedInUser}"/OneDrive - Bauer Media Group"
			echo "${ODFolderPath} folder does not exist"
			ODFolderSize=""
fi
}

function checkonedrivefoldersize ()
{
# Check the size of the users OneDrive folder
if [[ "${ODFolderSize}" -gt "${SIZE}" ]]; then
		echo "${ODFolderPath} folder is not empty"
exit 0
else
	if [[ "${ODFolderSize}" -lt "${SIZE}" ]] || [[ "${ODFolderSize}" == "" ]]; then
		echo "OneDrive sync folder is empty or does not exist"
# If OneDrivefolder is empty then prompt user to setup OneDrive
HELPER=$(/Library/Application\ Support/JAMF/bin/jamfHelper.app/Contents/MacOS/jamfHelper -windowType utility -icon /Applications/OneDrive.app/Contents/Resources/OneDrive.icns -title "Microsoft OneDrive" -heading "Have you heard about OneDrive?" -description "Did you know that as an Office 365 user you have
1000 GB of cloud storage available!

Using the new OneDrive sync client you can easily sync all of your important local data to the cloud.

Giving you the flexibility to access your documents on your Mac, smartphone/tablet or browser." -button1 "Get Started" -defaultButton 1)

	if [[ "${HELPER}" == "0" ]]; then
		echo "Opening OneDrive"
# Launch OneDrive client for user to setup
su -l "$LoggedInUser" -c "open -a /Applications/OneDrive.app"
# If OneDrive folder is found but empty open it for the user
	if [[ "${OldFolderSize}" != "" ]]; then
	open "${ODFolderPath}"
else
		echo "OneDrive sync folder has not been created yet"
			fi
		fi
	fi
fi
}

########################################################################
#                         Script starts here                           #
########################################################################

	checkloginstatus
	checkscreensaver
	checklockscreen
	checkonedriveapp
	checkonedrivefolder
	checkonedrivefoldersize

exit 0
