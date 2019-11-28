#!/bin/bash

########################################################################
#         Postinstall - Effects and Virtual Instrument Bundles         #
#################### Written by Phil Walker Nov 2019 ###################
########################################################################

#Mount the DMG's and then copy the effects and virtual instrument content

########################################################################
#                            Variables                                 #
########################################################################

#Get the current logged in user and store in variable
loggedInUser=$(python -c 'from SystemConfiguration import SCDynamicStoreCopyConsoleUser; import sys; username = (SCDynamicStoreCopyConsoleUser(None, None, None) or [None])[0]; username = [username,""][username in [u"loginwindow", None, u""]]; sys.stdout.write(username + "\n");')
#Get the Mac hostname
hostName=$(scutil --get HostName)

########################################################################
#                            Functions                                 #
########################################################################

function jamfHelperCopyInProgress ()
{
#Show a message via Jamf Helper that the data copy is in progress
su - $loggedInUser <<'jamfmsg1'
/Library/Application\ Support/JAMF/bin/jamfHelper.app/Contents/MacOS/jamfHelper -windowType utility -icon /Library/Application\ Support/JAMF/bin/Management\ Action.app/Contents/Resources/Self\ Service.icns -title "Message from Bauer IT" -heading "Effects and Virtual Instrument Bundles" -alignHeading natural -description "Installation in progress...
This can take between 2 - 20 minutes to complete depending on your external hard disk" -alignDescription natural &
jamfmsg1
}

function jamfHelperCopyComplete ()
{
#Show a message via Jamf Helper that the install has completed
/Library/Application\ Support/JAMF/bin/jamfHelper.app/Contents/MacOS/jamfHelper -windowType utility -icon /Library/Application\ Support/JAMF/bin/Management\ Action.app/Contents/Resources/Self\ Service.icns -title "Message from Bauer IT" -heading "Effects and Virtual Instrument Bundles" -description "Effects and Virtual Instrument Bundles install complete" -alignDescription natural -timeout 30 -button1 "Ok" -defaultButton "1"
}

function dittoWhile ()
{
#While the content copy is running we wait, this leaves the jamf helper message up. Once the copy is complete the message is killed
while ps axg | grep -vw grep | grep -w ditto > /dev/null;
do
        echo "Copying data..."
        sleep 1;
done
echo "Copy finished"
killall jamfHelper
sleep 2
}

function mountDMGs ()
{
#Mount all the DMG's silently
hdiutil mount -noverify -nobrowse /usr/local/Pro\ Tools/Virtual\ Instruments\ and\ Effects/First_AIR_Effects_Bundle_12.0_Mac.dmg
hdiutil mount -noverify -nobrowse /usr/local/Pro\ Tools/Virtual\ Instruments\ and\ Effects/AIR\ Instruments\ and\ XPand2.dmg
}

function copyVirtualInstrumentContent ()
{
#Create the Folders to hold the plugins on the Pro Tools HDD
mkdir -v /Volumes/$hostName\ Pro\ Tools\ Sessions/Pro\ Tools\ Sessions/
mkdir -v /Volumes/$hostName\ Pro\ Tools\ Sessions/Virtual\ Instrument\ Content/
#Allow everybody to RW the folders
chmod 777 /Volumes/$hostName\ Pro\ Tools\ Sessions/Pro\ Tools\ Sessions/
chmod 777 /Volumes/$hostName\ Pro\ Tools\ Sessions/Virtual\ Instrument\ Content/

#Now copy in the audio files from the AIR Instruments and XPand2.dmg
ditto -v /Volumes/Virtual\ Instrument\ Content/ /Volumes/$hostName\ Pro\ Tools\ Sessions/Virtual\ Instrument\ Content/

#Remove the packages that got copied in via ditto
rm -f /Volumes/$hostName\ Pro\ Tools\ Sessions/Virtual\ Instrument\ Content/XPand\ II\ NoAudio.pkg
rm -f /Volumes/$hostName\ Pro\ Tools\ Sessions/Virtual\ Instrument\ Content/First\ AIR\ Instruments\ Bundle\ 12\ NoAudio.pkg
}

function cleanUp ()
{
#Clean up
#UnMount all DMG's
hdiutil unmount -force /Volumes/First\ AIR\ Effects\ Bundle/
hdiutil unmount -force /Volumes/Virtual\ Instrument\ Content/
#Remove Install DMG's and packages
rm -rf /usr/local/Pro\ Tools/

if [[ ! -d "/usr/local/Pro\ Tools/" ]]; then
  echo "Clean up has been successful"
else
  echo "Clean up FAILED, please delete the folder /usr/local/Pro\ Tools/ manually"
fi
}

########################################################################
#                         Script starts here                           #
########################################################################

#Mount DMG's
mountDMGs
#Copy in progress jamf Helper window
jamfHelperCopyInProgress
#Copy the Effects and Virtual Instrument content
copyVirtualInstrumentContent
#Keep checking the copy and kill the jamf Helper window once its complete
dittoWhile
#Display a jamf Helper window once the copy has completed
jamfHelperCopyComplete
#Unmount all DMG's and remove all temporary content
cleanUp

exit 0