#!/usr/bin/perl

$pathToScript=$0;
$pathToPackage=$ARGV[0];
$targetLocation=$ARGV[1];
$targetVolume=$ARGV[2];
$log="/var/log/jamf.log";
$DATE= localtime(time);
@DATE =split (' ',$DATE);
$DATE=$DATE[0]." ".$DATE[1]."  ".$DATE[2]." ".$DATE[3];

#####################################################################################################
#CS suites, the list is based on Master Collection Suites.

my @foldersCS3=('/Applications/Adobe Acrobat 8 Professional', '/Applications/Adobe After Effects CS3', '/Applications/Adobe Bridge CS3', '/Applications/Adobe Contribute CS3', '/Applications/Adobe Device Central CS3', '/Applications/Adobe Dreamweaver CS3', '/Applications/Adobe Encore CS3', '/Applications/Adobe Extension Manager', '/Applications/Adobe Fireworks CS3', '/Applications/Adobe Flash CS3', '/Applications/Adobe Flash CS3 Video Encoder', '/Applications/Adobe Help Viewer 1.0.app', '/Applications/Adobe Help Viewer 1.1.app', '/Applications/Adobe Illustrator CS3', '/Applications/Adobe InDesign CS3', '/Applications/Adobe Photoshop CS3', '/Applications/Adobe Premiere Pro CS3', '/Applications/Adobe Soundbooth CS3', '/Applications/Adobe Soundbooth Scores', '/Applications/Adobe Stock Photos CS3', '/Applications/Utilities/Adobe Installers', '/Applications/Utilities/Adobe Utilities.localized', '/Library/Application Support/Adobe', '/Library/Application Support/FLEXnet Publisher', '/Library/Application Support/Macromedia/FlashAuthor.cfg', '/Library/Application Support/Macromedia/FlashPlayerTrust', '/Library/Application Support/Synthetic Aperture Adobe Bundle', '/Library/Internet Plug-Ins/AdobePDFViewer.plugin', '/Library/Logs/Adobe', '/Library/PreferencePanes/VersionCueCS3.prefPane', '/Library/Preferences/FLEXnet Publisher', '/Library/Printers/PPD Plugins/AdobePDFPDE800.plugin', '/Library/QuickTime/FLV.component', '/Library/QuickTime/SoundboothScoreCodec.component' );
my @filesCS3=('/Library/Fonts/ACaslonPro-Bold.otf', '/Library/Fonts/ACaslonPro-BoldItalic.otf', '/Library/Fonts/ACaslonPro-Italic.otf', '/Library/Fonts/ACaslonPro-Regular.otf', '/Library/Fonts/ACaslonPro-Semibold.otf', '/Library/Fonts/ACaslonPro-SemiboldItalic.otf', '/Library/Fonts/AGaramondPro-Bold.otf', '/Library/Fonts/AGaramondPro-BoldItalic.otf', '/Library/Fonts/AGaramondPro-Italic.otf', '/Library/Fonts/AGaramondPro-Regular.otf', '/Library/Fonts/ArnoPro-Bold.otf', '/Library/Fonts/ArnoPro-BoldCaption.otf', '/Library/Fonts/ArnoPro-BoldDisplay.otf', '/Library/Fonts/ArnoPro-BoldItalic.otf', '/Library/Fonts/ArnoPro-BoldItalicCaption.otf', '/Library/Fonts/ArnoPro-BoldItalicDisplay.otf', '/Library/Fonts/ArnoPro-BoldItalicSmText.otf', '/Library/Fonts/ArnoPro-BoldItalicSubhead.otf', '/Library/Fonts/ArnoPro-BoldSmText.otf', '/Library/Fonts/ArnoPro-BoldSubhead.otf', '/Library/Fonts/ArnoPro-Caption.otf', '/Library/Fonts/ArnoPro-Display.otf', '/Library/Fonts/ArnoPro-Italic.otf', '/Library/Fonts/ArnoPro-ItalicCaption.otf', '/Library/Fonts/ArnoPro-ItalicDisplay.otf', '/Library/Fonts/ArnoPro-ItalicSmText.otf', '/Library/Fonts/ArnoPro-ItalicSubhead.otf', '/Library/Fonts/ArnoPro-LightDisplay.otf', '/Library/Fonts/ArnoPro-LightItalicDisplay.otf', '/Library/Fonts/ArnoPro-Regular.otf', '/Library/Fonts/ArnoPro-Smbd.otf', '/Library/Fonts/ArnoPro-SmbdCaption.otf', '/Library/Fonts/ArnoPro-SmbdDisplay.otf', '/Library/Fonts/ArnoPro-SmbdItalic.otf', '/Library/Fonts/ArnoPro-SmbdItalicCaption.otf', '/Library/Fonts/ArnoPro-SmbdItalicDisplay.otf', '/Library/Fonts/ArnoPro-SmbdItalicSmText.otf', '/Library/Fonts/ArnoPro-SmbdItalicSubhead.otf', '/Library/Fonts/ArnoPro-SmbdSmText.otf', '/Library/Fonts/ArnoPro-SmbdSubhead.otf', '/Library/Fonts/ArnoPro-SmText.otf', '/Library/Fonts/ArnoPro-Subhead.otf', '/Library/Fonts/BellGothicStd-Black.otf', '/Library/Fonts/BellGothicStd-Bold.otf', '/Library/Fonts/BickhamScriptPro-Bold.otf', '/Library/Fonts/BickhamScriptPro-Regular.otf', '/Library/Fonts/BickhamScriptPro-Semibold.otf', '/Library/Fonts/BirchStd.otf', '/Library/Fonts/BlackoakStd.otf', '/Library/Fonts/BrushScriptStd.otf', '/Library/Fonts/ChaparralPro-Bold.otf', '/Library/Fonts/ChaparralPro-BoldIt.otf', '/Library/Fonts/ChaparralPro-Italic.otf', '/Library/Fonts/ChaparralPro-Regular.otf', '/Library/Fonts/CharlemagneStd-Bold.otf', '/Library/Fonts/CooperBlackStd-Italic.otf', '/Library/Fonts/CooperBlackStd.otf', '/Library/Fonts/EccentricStd.otf', '/Library/Fonts/GaramondPremrPro-It.otf', '/Library/Fonts/GaramondPremrPro-Smbd.otf', '/Library/Fonts/GaramondPremrPro-SmbdIt.otf', '/Library/Fonts/GaramondPremrPro.otf', '/Library/Fonts/GiddyupStd.otf', '/Library/Fonts/HoboStd.otf', '/Library/Fonts/KozGoPro-Bold.otf', '/Library/Fonts/KozGoPro-ExtraLight.otf', '/Library/Fonts/KozGoPro-Heavy.otf', '/Library/Fonts/KozGoPro-Light.otf', '/Library/Fonts/KozGoPro-Medium.otf', '/Library/Fonts/KozGoPro-Regular.otf', '/Library/Fonts/KozMinPro-Bold.otf', '/Library/Fonts/KozMinPro-ExtraLight.otf', '/Library/Fonts/KozMinPro-Heavy.otf', '/Library/Fonts/KozMinPro-Light.otf', '/Library/Fonts/KozMinPro-Medium.otf', '/Library/Fonts/KozMinPro-Regular.otf', '/Library/Fonts/LetterGothicStd-Bold.otf', '/Library/Fonts/LetterGothicStd-BoldSlanted.otf', '/Library/Fonts/LetterGothicStd-Slanted.otf', '/Library/Fonts/LetterGothicStd.otf', '/Library/Fonts/LithosPro-Black.otf', '/Library/Fonts/LithosPro-Regular.otf', '/Library/Fonts/MesquiteStd.otf', '/Library/Fonts/MinionPro-Bold.otf', '/Library/Fonts/MinionPro-BoldCn.otf', '/Library/Fonts/MinionPro-BoldCnIt.otf', '/Library/Fonts/MinionPro-BoldIt.otf', '/Library/Fonts/MinionPro-It.otf', '/Library/Fonts/MinionPro-Medium.otf', '/Library/Fonts/MinionPro-MediumIt.otf', '/Library/Fonts/MinionPro-Regular.otf', '/Library/Fonts/MinionPro-Semibold.otf', '/Library/Fonts/MinionPro-SemiboldIt.otf', '/Library/Fonts/MyriadPro-Bold.otf', '/Library/Fonts/MyriadPro-BoldCond.otf', '/Library/Fonts/MyriadPro-BoldCondIt.otf', '/Library/Fonts/MyriadPro-BoldIt.otf', '/Library/Fonts/MyriadPro-Cond.otf', '/Library/Fonts/MyriadPro-CondIt.otf', '/Library/Fonts/MyriadPro-It.otf', '/Library/Fonts/MyriadPro-Regular.otf', '/Library/Fonts/MyriadPro-Semibold.otf', '/Library/Fonts/MyriadPro-SemiboldIt.otf', '/Library/Fonts/NuevaStd-BoldCond.otf', '/Library/Fonts/NuevaStd-BoldCondItalic.otf', '/Library/Fonts/NuevaStd-Cond.otf', '/Library/Fonts/NuevaStd-CondItalic.otf', '/Library/Fonts/OCRAStd.otf', '/Library/Fonts/OratorStd-Slanted.otf', '/Library/Fonts/OratorStd.otf', '/Library/Fonts/PoplarStd.otf', '/Library/Fonts/PrestigeEliteStd-Bd.otf', '/Library/Fonts/RosewoodStd-Regular.otf', '/Library/Fonts/StencilStd.otf', '/Library/Fonts/TektonPro-Bold.otf', '/Library/Fonts/TektonPro-BoldCond.otf', '/Library/Fonts/TektonPro-BoldExt.otf', '/Library/Fonts/TektonPro-BoldObl.otf', '/Library/Fonts/TrajanPro-Bold.otf', '/Library/Fonts/TrajanPro-Regular.otf', '/Library/LaunchDaemons/com.adobe.versioncueCS3.plist', '/Library/Preferences/com.adobe.acrobat.pdfviewer.plist', '/Library/Preferences/com.adobe.PDFAdminSettings.plist', '/Library/Preferences/com.Adobe.Premiere Pro.3.0.plist', '/Library/Preferences/com.adobe.versioncueCS3.plist', '/Library/Printers/PPDs/Contents/Resources/en.lproj/ADPDF8.PPD', '/Library/Printers/PPDs/Contents/Resources/ja.lproj/ADPDF8J.PPD', '/Library/Printers/PPDs/Contents/Resources/ko.lproj/ADPDF8K.PPD', '/Library/Printers/PPDs/Contents/Resources/zh_CN.lproj/ADPDF8CS.PPD', '/Library/Printers/PPDs/Contents/Resources/zh_TW.lproj/ADPDF8CT.PPD', '/private/etc/cups/ppd/AdobePDF8.ppd', '/private/etc/mach_init_per_user.d/com.adobe.versioncueCS3.monitor.plist', '/usr/libexec/cups/backend/pdf800');
my @foldersCS4=('/Applications/Adobe', '/Applications/Adobe Acrobat 9 Pro', '/Applications/Adobe After Effects CS4', '/Applications/Adobe Bridge CS4', '/Applications/Adobe Contribute CS4', '/Applications/Adobe Device Central CS4', '/Applications/Adobe Dreamweaver CS4', '/Applications/Adobe Drive CS4', '/Applications/Adobe Encore CS4', '/Applications/Adobe Extension Manager CS4', '/Applications/Adobe Fireworks CS4', '/Applications/Adobe Flash CS4', '/Applications/Adobe Illustrator CS4', '/Applications/Adobe InDesign CS4', '/Applications/Adobe Media Encoder CS4', '/Applications/Adobe Media Player.app', '/Applications/Adobe OnLocation CS4', '/Applications/Adobe Photoshop CS4', '/Applications/Adobe Premiere Pro CS4', '/Applications/Adobe Soundbooth CS4', '/Applications/Adobe Soundbooth Scores', '/Applications/Utilities/Adobe AIR Application Installer.app', '/Applications/Utilities/Adobe AIR Uninstaller.app', '/Applications/Utilities/Adobe Installers', '/Applications/Utilities/Adobe Utilities.localized', '/Library/Application Support/.Macrovision11.5.0.0 build 56285.uct2', '/Library/Application Support/Adobe', '/Library/Application Support/FLEXnet Publisher', '/Library/Application Support/Macromedia/FlashAuthor.cfg', '/Library/Application Support/Macromedia/FlashPlayerTrust', '/Library/Application Support/Synthetic Aperture Adobe CS4 Bundle', '/Library/ColorSync/Profiles/Profiles', '/Library/ColorSync/Profiles/Recommended', '/Library/Contextual Menu Items/ADFSMenu.plugin', '/Library/Frameworks/Adobe AIR.framework', '/Library/Internet Plug-Ins/AdobePDFViewer.plugin', '/Library/Internet Plug-Ins/npContributeMac.bundle', '/Library/Logs/Adobe', '/Library/PreferencePanes/VersionCueCS4.prefPane', '/Library/Preferences/FLEXnet Publisher', '/Library/Printers/PPD Plugins/AdobePDFPDE900.plugin', '/Library/QuickTime/SoundboothScoreCodec.component', '/Library/ScriptingAdditions/Adobe Unit Types.osax', '/Users/Shared/Adobe', '/Users/Shared/Library/Application Support/Adobe');
my @filesCS4=('/Library/Filesystems/AdobeDriveCS4.fs', '/Library/Fonts/ACaslonPro-Bold.otf', '/Library/Fonts/ACaslonPro-BoldItalic.otf', '/Library/Fonts/ACaslonPro-Italic.otf', '/Library/Fonts/ACaslonPro-Regular.otf', '/Library/Fonts/ACaslonPro-Semibold.otf', '/Library/Fonts/ACaslonPro-SemiboldItalic.otf', '/Library/Fonts/AdobeFangsongStd-Regular.otf', '/Library/Fonts/AdobeHeitiStd-Regular.otf', '/Library/Fonts/AdobeKaitiStd-Regular.otf', '/Library/Fonts/AdobeMingStd-Light.otf', '/Library/Fonts/AdobeMyungjoStd-Medium.otf', '/Library/Fonts/AdobeSongStd-Light.otf', '/Library/Fonts/AGaramondPro-Bold.otf', '/Library/Fonts/AGaramondPro-BoldItalic.otf', '/Library/Fonts/AGaramondPro-Italic.otf', '/Library/Fonts/AGaramondPro-Regular.otf', '/Library/Fonts/BellGothicStd-Black.otf', '/Library/Fonts/BellGothicStd-Bold.otf', '/Library/Fonts/BirchStd.otf', '/Library/Fonts/BlackoakStd.otf', '/Library/Fonts/BrushScriptStd.otf', '/Library/Fonts/ChaparralPro-Bold.otf', '/Library/Fonts/ChaparralPro-BoldIt.otf', '/Library/Fonts/ChaparralPro-Italic.otf', '/Library/Fonts/ChaparralPro-Regular.otf', '/Library/Fonts/CharlemagneStd-Bold.otf', '/Library/Fonts/CooperBlackStd-Italic.otf', '/Library/Fonts/CooperBlackStd.otf', '/Library/Fonts/EccentricStd.otf', '/Library/Fonts/GiddyupStd.otf', '/Library/Fonts/HoboStd.otf', '/Library/Fonts/KozGoPro-Bold.otf', '/Library/Fonts/KozGoPro-ExtraLight.otf', '/Library/Fonts/KozGoPro-Heavy.otf', '/Library/Fonts/KozGoPro-Light.otf', '/Library/Fonts/KozGoPro-Medium.otf', '/Library/Fonts/KozGoPro-Regular.otf', '/Library/Fonts/KozMinPro-Bold.otf', '/Library/Fonts/KozMinPro-ExtraLight.otf', '/Library/Fonts/KozMinPro-Heavy.otf', '/Library/Fonts/KozMinPro-Light.otf', '/Library/Fonts/KozMinPro-Medium.otf', '/Library/Fonts/KozMinPro-Regular.otf', '/Library/Fonts/LetterGothicStd-Bold.otf', '/Library/Fonts/LetterGothicStd-BoldSlanted.otf', '/Library/Fonts/LetterGothicStd-Slanted.otf', '/Library/Fonts/LetterGothicStd.otf', '/Library/Fonts/LithosPro-Black.otf', '/Library/Fonts/LithosPro-Regular.otf', '/Library/Fonts/MesquiteStd.otf', '/Library/Fonts/MinionPro-Bold.otf', '/Library/Fonts/MinionPro-BoldCn.otf', '/Library/Fonts/MinionPro-BoldCnIt.otf', '/Library/Fonts/MinionPro-BoldIt.otf', '/Library/Fonts/MinionPro-It.otf', '/Library/Fonts/MinionPro-Medium.otf', '/Library/Fonts/MinionPro-MediumIt.otf', '/Library/Fonts/MinionPro-Regular.otf', '/Library/Fonts/MinionPro-Semibold.otf', '/Library/Fonts/MinionPro-SemiboldIt.otf', '/Library/Fonts/MyriadPro-Bold.otf', '/Library/Fonts/MyriadPro-BoldCond.otf', '/Library/Fonts/MyriadPro-BoldCondIt.otf', '/Library/Fonts/MyriadPro-BoldIt.otf', '/Library/Fonts/MyriadPro-Cond.otf', '/Library/Fonts/MyriadPro-CondIt.otf', '/Library/Fonts/MyriadPro-It.otf', '/Library/Fonts/MyriadPro-Regular.otf', '/Library/Fonts/MyriadPro-Semibold.otf', '/Library/Fonts/MyriadPro-SemiboldIt.otf', '/Library/Fonts/NuevaStd-BoldCond.otf', '/Library/Fonts/NuevaStd-BoldCondItalic.otf', '/Library/Fonts/NuevaStd-Cond.otf', '/Library/Fonts/NuevaStd-CondItalic.otf', '/Library/Fonts/OCRAStd.otf', '/Library/Fonts/OratorStd-Slanted.otf', '/Library/Fonts/OratorStd.otf', '/Library/Fonts/PoplarStd.otf', '/Library/Fonts/PrestigeEliteStd-Bd.otf', '/Library/Fonts/RosewoodStd-Regular.otf', '/Library/Fonts/StencilStd.otf', '/Library/Fonts/TektonPro-Bold.otf', '/Library/Fonts/TektonPro-BoldCond.otf', '/Library/Fonts/TektonPro-BoldExt.otf', '/Library/Fonts/TektonPro-BoldObl.otf', '/Library/Fonts/TrajanPro-Bold.otf', '/Library/Fonts/TrajanPro-Regular.otf', '/Library/LaunchAgents/com.adobe.CS4ServiceManager.plist', '/Library/LaunchDaemons/com.adobe.versioncueCS4.plist', '/Library/Preferences/com.adobe.acrobat.pdfviewer.plist', '/Library/Preferences/com.adobe.AdobeOnlineHelp.plist', '/Library/Preferences/com.adobe.PDFAdminSettings.plist', '/Library/Preferences/com.adobe.versioncueCS4.plist', '/Library/Preferences/com.apple.audio.AggregateDevices.plist', '/Library/Printers/PPDs/Contents/Resources/en.lproj/ADPDF9.PPD', '/Library/Printers/PPDs/Contents/Resources/ja.lproj/ADPDF9J.PPD', '/Library/Printers/PPDs/Contents/Resources/ko.lproj/ADPDF9K.PPD', '/Library/Printers/PPDs/Contents/Resources/zn_CN.lproj/ADPDF9CS.PPD', '/Library/Printers/PPDs/Contents/Resources/zn_TW.lproj/ADPDF9CT.PPD', '/private/etc/cups/ppd/AdobePDF9.ppd', '/private/etc/mach_init_per_user.d/com.adobe.versioncueCS4.monitor.plist', '/usr/libexec/cups/backend/pdf900');
my @foldersCS5=('/Applications/Adobe', '/Applications/Adobe Acrobat 9 Pro', '/Applications/Adobe Acrobat X Pro', '/Applications/Adobe After Effects CS5', '/Applications/Adobe Bridge CS5', '/Applications/Adobe Contribute CS5', '/Applications/Adobe Device Central CS5', '/Applications/Adobe Dreamweaver CS5', '/Applications/Adobe Encore CS5', '/Applications/Adobe Extension Manager CS5', '/Applications/Adobe Fireworks CS5', '/Applications/Adobe Flash Builder 4', '/Applications/Adobe Flash Catalyst CS5', '/Applications/Adobe Flash CS5', '/Applications/Adobe Illustrator CS5', '/Applications/Adobe InDesign CS5', '/Applications/Adobe Media Encoder CS5', '/Applications/Adobe Media Player.app', '/Applications/Adobe OnLocation CS5', '/Applications/Adobe Photoshop CS5', '/Applications/Adobe Premiere Pro CS5', '/Applications/Adobe Soundbooth CS5', '/Applications/Utilities/Adobe AIR Application Installer.app', '/Applications/Utilities/Adobe AIR Uninstaller.app', '/Applications/Utilities/Adobe Installers', '/Applications/Utilities/Adobe Utilities-CS5.localized', '/Applications/osx', '/Library/Application Support/Adobe', '/Library/Application Support/Macromedia/.rskya9250.bin', '/Library/Application Support/Macromedia/FlashAuthor.cfg', '/Library/Application Support/Macromedia/FlashPlayerTrust', '/Library/Application Support/Mozilla', '/Library/Application Support/PACE Anti-Piracy', '/Library/Application Support/regid.1986-12.com.adobe', '/Library/Application Support/Synthetic Aperture Adobe CS5 Bundle', '/Library/ColorSync/Profiles/Profiles', '/Library/ColorSync/Profiles/Recommended', '/Library/Frameworks/Adobe AIR.framework', '/Library/Internet Plug-Ins/Flash Player.plugin', '/Library/Internet Plug-Ins/npContributeMac.bundle', '/Library/Logs/Adobe', '/Library/QuickTime/SoundboothScoreCodec.component', '/Library/ScriptingAdditions/Adobe Unit Types.osax', '/Users/Shared/Adobe', '/Users/Shared/Library');
my @filesCS5=('/Library/Fonts/ACaslonPro-Bold.otf', '/Library/Fonts/ACaslonPro-BoldItalic.otf', '/Library/Fonts/ACaslonPro-Italic.otf', '/Library/Fonts/ACaslonPro-Regular.otf', '/Library/Fonts/ACaslonPro-Semibold.otf', '/Library/Fonts/ACaslonPro-SemiboldItalic.otf', '/Library/Fonts/AdobeArabic-Bold.otf', '/Library/Fonts/AdobeArabic-BoldItalic.otf', '/Library/Fonts/AdobeArabic-Italic.otf', '/Library/Fonts/AdobeArabic-Regular.otf', '/Library/Fonts/AdobeFangsongStd-Regular.otf', '/Library/Fonts/AdobeFanHeitiStd-Bold.otf', '/Library/Fonts/AdobeGothicStd-Bold.otf', '/Library/Fonts/AdobeHebrew-Bold.otf', '/Library/Fonts/AdobeHebrew-BoldItalic.otf', '/Library/Fonts/AdobeHebrew-Italic.otf', '/Library/Fonts/AdobeHebrew-Regular.otf', '/Library/Fonts/AdobeHeitiStd-Regular.otf', '/Library/Fonts/AdobeKaitiStd-Regular.otf', '/Library/Fonts/AdobeMingStd-Light.otf', '/Library/Fonts/AdobeMyungjoStd-Medium.otf', '/Library/Fonts/AdobeSongStd-Light.otf', '/Library/Fonts/AGaramondPro-Bold.otf', '/Library/Fonts/AGaramondPro-BoldItalic.otf', '/Library/Fonts/AGaramondPro-Italic.otf', '/Library/Fonts/AGaramondPro-Regular.otf', '/Library/Fonts/BirchStd.otf', '/Library/Fonts/BlackoakStd.otf', '/Library/Fonts/BrushScriptStd.otf', '/Library/Fonts/ChaparralPro-Bold.otf', '/Library/Fonts/ChaparralPro-BoldIt.otf', '/Library/Fonts/ChaparralPro-Italic.otf', '/Library/Fonts/ChaparralPro-Regular.otf', '/Library/Fonts/CharlemagneStd-Bold.otf', '/Library/Fonts/CooperBlackStd-Italic.otf', '/Library/Fonts/CooperBlackStd.otf', '/Library/Fonts/GiddyupStd.otf', '/Library/Fonts/HoboStd.otf', '/Library/Fonts/KozGoPr6N-Bold.otf', '/Library/Fonts/KozGoPr6N-ExtraLight.otf', '/Library/Fonts/KozGoPr6N-Heavy.otf', '/Library/Fonts/KozGoPr6N-Light.otf', '/Library/Fonts/KozGoPr6N-Medium.otf', '/Library/Fonts/KozGoPr6N-Regular.otf', '/Library/Fonts/KozGoPro-Bold.otf', '/Library/Fonts/KozGoPro-ExtraLight.otf', '/Library/Fonts/KozGoPro-Heavy.otf', '/Library/Fonts/KozGoPro-Light.otf', '/Library/Fonts/KozGoPro-Medium.otf', '/Library/Fonts/KozGoPro-Regular.otf', '/Library/Fonts/KozMinPr6N-Bold.otf', '/Library/Fonts/KozMinPr6N-ExtraLight.otf', '/Library/Fonts/KozMinPr6N-Heavy.otf', '/Library/Fonts/KozMinPr6N-Light.otf', '/Library/Fonts/KozMinPr6N-Medium.otf', '/Library/Fonts/KozMinPr6N-Regular.otf', '/Library/Fonts/KozMinPro-Bold.otf', '/Library/Fonts/KozMinPro-ExtraLight.otf', '/Library/Fonts/KozMinPro-Heavy.otf', '/Library/Fonts/KozMinPro-Light.otf', '/Library/Fonts/KozMinPro-Medium.otf', '/Library/Fonts/KozMinPro-Regular.otf', '/Library/Fonts/LetterGothicStd-Bold.otf', '/Library/Fonts/LetterGothicStd-BoldSlanted.otf', '/Library/Fonts/LetterGothicStd-Slanted.otf', '/Library/Fonts/LetterGothicStd.otf', '/Library/Fonts/LithosPro-Black.otf', '/Library/Fonts/LithosPro-Regular.otf', '/Library/Fonts/MesquiteStd.otf', '/Library/Fonts/MinionPro-Bold.otf', '/Library/Fonts/MinionPro-BoldCn.otf', '/Library/Fonts/MinionPro-BoldCnIt.otf', '/Library/Fonts/MinionPro-BoldIt.otf', '/Library/Fonts/MinionPro-It.otf', '/Library/Fonts/MinionPro-Medium.otf', '/Library/Fonts/MinionPro-MediumIt.otf', '/Library/Fonts/MinionPro-Regular.otf', '/Library/Fonts/MinionPro-Semibold.otf', '/Library/Fonts/MinionPro-SemiboldIt.otf', '/Library/Fonts/MyriadPro-Bold.otf', '/Library/Fonts/MyriadPro-BoldCond.otf', '/Library/Fonts/MyriadPro-BoldCondIt.otf', '/Library/Fonts/MyriadPro-BoldIt.otf', '/Library/Fonts/MyriadPro-Cond.otf', '/Library/Fonts/MyriadPro-CondIt.otf', '/Library/Fonts/MyriadPro-It.otf', '/Library/Fonts/MyriadPro-Regular.otf', '/Library/Fonts/MyriadPro-Semibold.otf', '/Library/Fonts/MyriadPro-SemiboldIt.otf', '/Library/Fonts/MyriadWebPro-Bold.ttf', '/Library/Fonts/MyriadWebPro-Italic.ttf', '/Library/Fonts/MyriadWebPro.ttf', '/Library/Fonts/NuevaStd-BoldCond.otf', '/Library/Fonts/NuevaStd-BoldCondItalic.otf', '/Library/Fonts/NuevaStd-Cond.otf', '/Library/Fonts/NuevaStd-CondItalic.otf', '/Library/Fonts/OCRAStd.otf', '/Library/Fonts/OratorStd-Slanted.otf', '/Library/Fonts/OratorStd.otf', '/Library/Fonts/PoplarStd.otf', '/Library/Fonts/PrestigeEliteStd-Bd.otf', '/Library/Fonts/RosewoodStd-Regular.otf', '/Library/Fonts/StencilStd.otf', '/Library/Fonts/TektonPro-Bold.otf', '/Library/Fonts/TektonPro-BoldCond.otf', '/Library/Fonts/TektonPro-BoldExt.otf', '/Library/Fonts/TektonPro-BoldObl.otf', '/Library/Fonts/TrajanPro-Bold.otf', '/Library/Fonts/TrajanPro-Regular.otf', '/Library/LaunchAgents/com.adobe.AAM.Updater-1.0.plist', '/Library/LaunchAgents/com.adobe.CS5ServiceManager.plist', '/Library/LaunchDaemons/com.adobe.SwitchBoard.plist', '/Library/Preferences/com.adobe.acrobat.pdfviewer.plist', '/Library/Preferences/com.adobe.headlights.apip.plist', '/Library/Preferences/com.adobe.Illustrator.15.0.2.plist', '/Library/Preferences/com.adobe.InDesign.7.0.3.plist', '/Library/Preferences/com.adobe.Contribute.6.0.plist', '/Library/Preferences/com.adobe.CSXS2Preferences.plist', '/Library/Preferences/com.adobe.Dreamweaver.11.plist', '/Library/Preferences/com.adobe.Fireworks.11.0.0.plist', '/Library/Preferences/com.adobe.Illustrator.15.0.0.plist', '/Library/Preferences/com.adobe.InDesign.7.0.plist', '/Library/Preferences/com.adobe.PDFAdminSettings.plist', '/Library/Preferences/com.apple.audio.AggregateDevices.plist', '/Library/Preferences/com.apple.mediaio.DeviceSettings.plist', '/Library/Preferences/com.masi.ddpp.plist', '/private/etc/mach_init_per_user.d/com.adobe.SwitchBoard.monitor.plist');
my @foldersCS55=('/Applications/Adobe Acrobat X Pro', '/Applications/Adobe After Effects CS5.5', '/Applications/Adobe Audition CS5.5', '/Applications/Adobe Bridge CS5.1', '/Applications/Adobe Contribute CS5.1', '/Applications/Adobe Device Central CS5.5', '/Applications/Adobe Dreamweaver CS5.5', '/Applications/Adobe Encore CS5.1', '/Applications/Adobe Extension Manager CS5.5', '/Applications/Adobe Fireworks CS5.1', '/Applications/Adobe Flash Builder 4.5', '/Applications/Adobe Flash Catalyst CS5.5', '/Applications/Adobe Flash CS5.5', '/Applications/Adobe Illustrator CS5.1', '/Applications/Adobe InDesign CS5.5', '/Applications/Adobe Media Encoder CS5.5', '/Applications/Adobe OnLocation CS5.1', '/Applications/Adobe Photoshop CS5.1', '/Applications/Adobe Premiere Pro CS5.5', '/Applications/Adobe Story.app', '/Applications/Adobe', '/Applications/Utilities/Adobe AIR Application Installer.app', '/Applications/Utilities/Adobe AIR Uninstaller.app', '/Applications/Utilities/Adobe Installers', '/Applications/Utilities/Adobe Utilities-CS5.5.localized', '/Library/Application Support/Adobe', '/Library/Application Support/Macromedia', '/Library/Application Support/regid.1986-12.com.adobe', '/Library/Application Support/Synthetic Aperture Adobe CS5.5 Bundle', '/Library/Automator/Save as Adobe PDF.action', '/Library/ColorSync/Profiles/Profiles', '/Library/ColorSync/Profiles/Recommended', '/Library/Frameworks/Adobe AIR.framework', '/Library/Internet Plug-Ins/Flash Player.plugin', '/Library/Internet Plug-Ins/npContributeMac.bundle', '/Library/Logs/Adobe', '/Library/PDF Services/Save as Adobe PDF.app', '/Library/ScriptingAdditions/Adobe Unit Types.osax', '/private/var/root/Library/Preferences/Macromedia', '/Users/Shared/Library/Application Support/Adobe');
my @filesCS55=('/Library/Fonts/ACaslonPro-Bold.otf', '/Library/Fonts/ACaslonPro-BoldItalic.otf', '/Library/Fonts/ACaslonPro-Italic.otf', '/Library/Fonts/ACaslonPro-Regular.otf', '/Library/Fonts/ACaslonPro-Semibold.otf', '/Library/Fonts/ACaslonPro-SemiboldItalic.otf', '/Library/Fonts/AdobeArabic-Bold.otf', '/Library/Fonts/AdobeArabic-BoldItalic.otf', '/Library/Fonts/AdobeArabic-Italic.otf', '/Library/Fonts/AdobeArabic-Regular.otf', '/Library/Fonts/AdobeFangsongStd-Regular.otf', '/Library/Fonts/AdobeFanHeitiStd-Bold.otf', '/Library/Fonts/AdobeGothicStd-Bold.otf', '/Library/Fonts/AdobeHebrew-Bold.otf', '/Library/Fonts/AdobeHebrew-BoldItalic.otf', '/Library/Fonts/AdobeHebrew-Italic.otf', '/Library/Fonts/AdobeHebrew-Regular.otf', '/Library/Fonts/AdobeHeitiStd-Regular.otf', '/Library/Fonts/AdobeKaitiStd-Regular.otf', '/Library/Fonts/AdobeMingStd-Light.otf', '/Library/Fonts/AdobeMyungjoStd-Medium.otf', '/Library/Fonts/AdobeSongStd-Light.otf', '/Library/Fonts/AGaramondPro-Bold.otf', '/Library/Fonts/AGaramondPro-BoldItalic.otf', '/Library/Fonts/AGaramondPro-Italic.otf', '/Library/Fonts/AGaramondPro-Regular.otf', '/Library/Fonts/BirchStd.otf', '/Library/Fonts/BlackoakStd.otf', '/Library/Fonts/BrushScriptStd.otf', '/Library/Fonts/ChaparralPro-Bold.otf', '/Library/Fonts/ChaparralPro-BoldIt.otf', '/Library/Fonts/ChaparralPro-Italic.otf', '/Library/Fonts/ChaparralPro-Regular.otf', '/Library/Fonts/CharlemagneStd-Bold.otf', '/Library/Fonts/CooperBlackStd-Italic.otf', '/Library/Fonts/CooperBlackStd.otf', '/Library/Fonts/GiddyupStd.otf', '/Library/Fonts/HoboStd.otf', '/Library/Fonts/KozGoPr6N-Bold.otf', '/Library/Fonts/KozGoPr6N-ExtraLight.otf', '/Library/Fonts/KozGoPr6N-Heavy.otf', '/Library/Fonts/KozGoPr6N-Light.otf', '/Library/Fonts/KozGoPr6N-Medium.otf', '/Library/Fonts/KozGoPr6N-Regular.otf', '/Library/Fonts/KozGoPro-Bold.otf', '/Library/Fonts/KozGoPro-ExtraLight.otf', '/Library/Fonts/KozGoPro-Heavy.otf', '/Library/Fonts/KozGoPro-Light.otf', '/Library/Fonts/KozGoPro-Medium.otf', '/Library/Fonts/KozGoPro-Regular.otf', '/Library/Fonts/KozMinPr6N-Bold.otf', '/Library/Fonts/KozMinPr6N-ExtraLight.otf', '/Library/Fonts/KozMinPr6N-Heavy.otf', '/Library/Fonts/KozMinPr6N-Light.otf', '/Library/Fonts/KozMinPr6N-Medium.otf', '/Library/Fonts/KozMinPr6N-Regular.otf', '/Library/Fonts/KozMinPro-Bold.otf', '/Library/Fonts/KozMinPro-ExtraLight.otf', '/Library/Fonts/KozMinPro-Heavy.otf', '/Library/Fonts/KozMinPro-Light.otf', '/Library/Fonts/KozMinPro-Medium.otf', '/Library/Fonts/KozMinPro-Regular.otf', '/Library/Fonts/LetterGothicStd-Bold.otf', '/Library/Fonts/LetterGothicStd-BoldSlanted.otf', '/Library/Fonts/LetterGothicStd-Slanted.otf', '/Library/Fonts/LetterGothicStd.otf', '/Library/Fonts/LithosPro-Black.otf', '/Library/Fonts/LithosPro-Regular.otf', '/Library/Fonts/MesquiteStd.otf', '/Library/Fonts/MinionPro-Bold.otf', '/Library/Fonts/MinionPro-BoldCn.otf', '/Library/Fonts/MinionPro-BoldCnIt.otf', '/Library/Fonts/MinionPro-BoldIt.otf', '/Library/Fonts/MinionPro-It.otf', '/Library/Fonts/MinionPro-Medium.otf', '/Library/Fonts/MinionPro-MediumIt.otf', '/Library/Fonts/MinionPro-Regular.otf', '/Library/Fonts/MinionPro-Semibold.otf', '/Library/Fonts/MinionPro-SemiboldIt.otf', '/Library/Fonts/MyriadPro-Bold.otf', '/Library/Fonts/MyriadPro-BoldCond.otf', '/Library/Fonts/MyriadPro-BoldCondIt.otf', '/Library/Fonts/MyriadPro-BoldIt.otf', '/Library/Fonts/MyriadPro-Cond.otf', '/Library/Fonts/MyriadPro-CondIt.otf', '/Library/Fonts/MyriadPro-It.otf', '/Library/Fonts/MyriadPro-Regular.otf', '/Library/Fonts/MyriadPro-Semibold.otf', '/Library/Fonts/MyriadPro-SemiboldIt.otf', '/Library/Fonts/MyriadWebPro-Bold.ttf', '/Library/Fonts/MyriadWebPro-Italic.ttf', '/Library/Fonts/MyriadWebPro.ttf', '/Library/Fonts/NuevaStd-BoldCond.otf', '/Library/Fonts/NuevaStd-BoldCondItalic.otf', '/Library/Fonts/NuevaStd-Cond.otf', '/Library/Fonts/NuevaStd-CondItalic.otf', '/Library/Fonts/OCRAStd.otf', '/Library/Fonts/OratorStd-Slanted.otf', '/Library/Fonts/OratorStd.otf', '/Library/Fonts/PoplarStd.otf', '/Library/Fonts/PrestigeEliteStd-Bd.otf', '/Library/Fonts/RosewoodStd-Regular.otf', '/Library/Fonts/StencilStd.otf', '/Library/Fonts/TektonPro-Bold.otf', '/Library/Fonts/TektonPro-BoldCond.otf', '/Library/Fonts/TektonPro-BoldExt.otf', '/Library/Fonts/TektonPro-BoldObl.otf', '/Library/Fonts/TrajanPro-Bold.otf', '/Library/Fonts/TrajanPro-Regular.otf', '/Library/Internet Plug-Ins/flashplayer.xpt', '/Library/LaunchAgents/com.adobe.AAM.Updater-1.0.plist', '/Library/LaunchDaemons/com.adobe.SwitchBoard.plist', '/Library/Preferences/com.adobe.Contribute.6.1.plist', '/Library/Preferences/com.adobe.CSXS.2.5.plist', '/Library/Preferences/com.adobe.Dreamweaver.11.5.plist', '/Library/Preferences/com.adobe.Fireworks.11.1.0.plist', '/Library/Preferences/com.adobe.headlights.apip.plist.lockfile', '/Library/Preferences/com.adobe.headlights.apip.plist', '/Library/Preferences/com.adobe.Illustrator.15.1.0.plist', '/Library/Preferences/com.adobe.InDesign.7.5.1.plist', '/Library/Preferences/com.adobe.InDesign.7.5.plist', '/Library/Preferences/com.adobe.PDFAdminSettings.plist', '/private/etc/mach_init_per_user.d/com.adobe.SwitchBoard.monitor.plist', '/private/var/root/Library/Preferences/com.apple.loginwindow.plist.lockfile', '/private/var/root/Library/Preferences/com.apple.loginwindow.plist');
my @foldersCS6=('/Applications/Adobe', '/Applications/Adobe Acrobat X Pro', '/Applications/Adobe After Effects CS6', '/Applications/Adobe Audition CS6', '/Applications/Adobe Bridge CS6', '/Applications/Adobe Dreamweaver CS6', '/Applications/Adobe Encore CS6', '/Applications/Adobe Extension Manager CS6', '/Applications/Adobe Fireworks CS6', '/Applications/Adobe Flash Builder 4.6', '/Applications/Adobe Flash CS6', '/Applications/Adobe Illustrator CS6', '/Applications/Adobe InDesign CS6', '/Applications/Adobe Media Encoder CS6', '/Applications/Adobe Photoshop CS6', '/Applications/Adobe Prelude CS6', '/Applications/Adobe Premiere Pro CS6', '/Applications/Adobe SpeedGrade CS6', '/Applications/Utilities/Adobe Installers', '/Applications/Utilities/Adobe AIR Application Installer.app', '/Applications/Utilities/Adobe AIR Uninstaller.app', '/Applications/Utilities/Adobe Application Manager', '/Applications/Utilities/Adobe Utilities-CS6.localized', '/Library/Logs/Adobe', '/Library/Application Support/Macromedia', '/Library/Application Support/Adobe', '/Library/ColorSync/Profiles/Profiles', '/Library/ColorSync/Profiles/Recommended', '/Library/Internet Plug-Ins/AdobePDFViewer.plugin', '/Library/PDF Services/Save as Adobe PDF.app', '/Library/Frameworks/Adobe AIR.framework', '/Library/Application Support/regid.1986-12.com.adobe', '/Library/ScriptingAdditions/Adobe Unit Types.osax', '/Library/Automator/Save as Adobe PDF.action', '/Library/Application Support/Mozilla', '/Users/Shared/Library/Application Support/Adobe', '/private/var/root/Library/Preferences/Adobe', '/private/var/root/Library/Preferences/Macromedia', '/private/var/root/Library/Application Support', '/private/var/root/Library/Preferences/QuickTime Preferences');
my @filesCS6=('/private/etc/mach_init_per_user.d/com.adobe.SwitchBoard.monitor.plist', '/Library/Preferences/com.adobe.Fireworks.12.0.0.plist', '/Library/Preferences/com.adobe.PDFAdminSettings.plist', '/Library/Preferences/com.adobe.headlights.apip.plist', '/Library/LaunchAgents/com.adobe.AAM.Updater-1.0.plist', '/Library/LaunchDaemons/com.adobe.SwitchBoard.plist', '/Library/Preferences/com.adobe.CSXS.3.plist', '/Library/Preferences/com.adobe.acrobat.pdfviewer.plist', '/Library/Fonts/KozGoPro-Bold.otf', '/Library/Fonts/TrajanPro-Bold.otf', '/Library/Fonts/AdobeDevanagari-Regular.otf', '/Library/Fonts/KozMinPr6N-Regular.otf', '/Library/Fonts/NuevaStd-Bold.otf', '/Library/Fonts/OratorStd.otf', '/Library/Fonts/OCRAStd.otf', '/Library/Fonts/MinionPro-SemiboldIt.otf', '/Library/Fonts/MyriadPro-CondIt.otf', '/Library/Fonts/TrajanPro-Regular.otf', '/Library/Fonts/NuevaStd-BoldCondItalic.otf', '/Library/Fonts/ChaparralPro-BoldIt.otf', '/Library/Updates/ProductMetadata.plist', '/Library/Fonts/MyriadPro-BoldCond.otf', '/Library/Fonts/KozMinPr6N-Light.otf', '/Library/Fonts/KozGoPr6N-Bold.otf', '/Library/Fonts/AdobeFangsongStd-Regular.otf', '/Library/Fonts/MyriadPro-Regular.otf', '/Library/Fonts/ACaslonPro-BoldItalic.otf', '/Library/Fonts/BrushScriptStd.otf', '/Library/Fonts/CooperBlackStd.otf', '/Library/Fonts/AGaramondPro-BoldItalic.otf', '/Library/Fonts/AGaramondPro-Regular.otf', '/Library/Fonts/AGaramondPro-Italic.otf', '/Library/Fonts/AdobeHebrew-Bold.otf', '/Library/Fonts/AdobeDevanagari-BoldItalic.otf', '/Library/Fonts/ChaparralPro-Bold.otf', '/Library/Fonts/KozGoPr6N-Heavy.otf', '/Library/Fonts/StencilStd.otf', '/Library/Fonts/AdobeMyungjoStd-Medium.otf', '/Library/Fonts/TektonPro-BoldObl.otf', '/Library/Fonts/KozMinPro-Light.otf', '/Library/Fonts/MyriadHebrew-It.otf', '/Library/Fonts/AdobeHebrew-Regular.otf', '/Library/Fonts/PrestigeEliteStd-Bd.otf', '/Library/Fonts/ACaslonPro-Regular.otf', '/Library/Fonts/ChaparralPro-Regular.otf', '/Library/Fonts/ChaparralPro-LightIt.otf', '/Library/Fonts/KozGoPro-Medium.otf', '/Library/Fonts/CooperBlackStd-Italic.otf', '/Library/Fonts/RosewoodStd-Regular.otf', '/Library/Fonts/NuevaStd-Italic.otf', '/Library/Fonts/MyriadPro-BoldIt.otf', '/Library/Fonts/TektonPro-BoldExt.otf', '/Library/Fonts/KozMinPro-Medium.otf', '/Library/Fonts/KozGoPr6N-Regular.otf', '/Library/Fonts/AdobeDevanagari-Bold.otf', '/Library/Fonts/MyriadArabic-BoldIt.otf', '/Library/Fonts/KozGoPr6N-ExtraLight.otf', '/Library/Fonts/AdobeFanHeitiStd-Bold.otf', '/Library/Fonts/TektonPro-BoldCond.otf', '/Library/Fonts/MesquiteStd.otf', '/Library/Fonts/AdobeHeitiStd-Regular.otf', '/Library/Fonts/KozMinPr6N-ExtraLight.otf', '/Library/Fonts/KozGoPro-Regular.otf', '/Library/Fonts/AdobeKaitiStd-Regular.otf', '/Library/Fonts/MyriadArabic-Regular.otf', '/Library/Fonts/MyriadPro-It.otf', '/Library/Fonts/ACaslonPro-Bold.otf', '/Library/Fonts/BirchStd.otf', '/Library/Fonts/BlackoakStd.otf', '/Library/Fonts/MyriadPro-Bold.otf', '/Library/Fonts/TektonPro-Bold.otf', '/Library/Fonts/MinionPro-BoldCn.otf', '/Library/Fonts/KozGoPro-Heavy.otf', '/Library/Fonts/AGaramondPro-Bold.otf', '/Library/Fonts/AdobeArabic-Italic.otf', '/Library/Fonts/GiddyupStd.otf', '/Library/Fonts/MyriadPro-Semibold.otf', '/Library/Fonts/MinionPro-Semibold.otf', '/Library/Fonts/AdobeHebrew-Italic.otf', '/Library/Fonts/KozGoPr6N-Medium.otf', '/Library/Fonts/ACaslonPro-Italic.otf', '/Library/Fonts/MinionPro-Bold.otf', '/Library/Fonts/MyriadPro-SemiboldIt.otf', '/Library/Fonts/MyriadHebrew-Bold.otf', '/Library/Fonts/MinionPro-BoldCnIt.otf', '/Library/Fonts/LithosPro-Regular.otf', '/Library/Fonts/MyriadHebrew-BoldIt.otf', '/Library/Fonts/CharlemagneStd-Bold.otf', '/Library/Fonts/KozMinPr6N-Medium.otf', '/Library/Fonts/MinionPro-Regular.otf', '/Library/Fonts/OratorStd-Slanted.otf', '/Library/Fonts/KozMinPr6N-Heavy.otf', '/Library/Fonts/AdobeMingStd-Light.otf', '/Library/Fonts/AdobeSongStd-Light.otf', '/Library/Fonts/HoboStd.otf', '/Library/Fonts/LetterGothicStd-Slanted.otf', '/Library/Fonts/MinionPro-It.otf', '/Library/Fonts/AdobeArabic-Bold.otf', '/Library/Receipts/InstallHistory.plist', '/Library/Fonts/ACaslonPro-SemiboldItalic.otf', '/Library/Fonts/KozGoPr6N-Light.otf', '/Library/Fonts/ACaslonPro-Semibold.otf', '/Library/Fonts/NuevaStd-Cond.otf', '/Library/Fonts/ChaparralPro-Italic.otf', '/Library/Fonts/MinionPro-BoldIt.otf', '/Library/Fonts/MyriadArabic-Bold.otf', '/Library/Fonts/KozGoPro-ExtraLight.otf', '/Library/Fonts/MinionPro-MediumIt.otf', '/Library/Fonts/KozMinPr6N-Bold.otf', '/Library/Fonts/MyriadHebrew-Regular.otf', '/Library/Fonts/LithosPro-Black.otf', '/Library/Fonts/LetterGothicStd.otf', '/Library/Fonts/AdobeArabic-BoldItalic.otf', '/Library/Fonts/NuevaStd-CondItalic.otf', '/Library/Fonts/AdobeDevanagari-Italic.otf', '/Library/Fonts/AdobeNaskh-Medium.otf', '/Library/Fonts/AdobeArabic-Regular.otf', '/Library/Fonts/MyriadPro-Cond.otf', '/Library/Fonts/MyriadPro-BoldCondIt.otf', '/Library/Fonts/KozMinPro-Heavy.otf', '/Library/Fonts/LetterGothicStd-Bold.otf', '/Library/Fonts/AdobeGothicStd-Bold.otf', '/Library/Fonts/MinionPro-Medium.otf', '/Library/Fonts/KozMinPro-Bold.otf', '/Library/Fonts/PoplarStd.otf', '/Library/Fonts/MyriadArabic-It.otf', '/Library/Fonts/NuevaStd-BoldCond.otf', '/Library/Fonts/LetterGothicStd-BoldSlanted.otf', '/Library/Fonts/KozMinPro-Regular.otf', '/Library/Fonts/KozGoPro-Light.otf', '/Library/Fonts/KozMinPro-ExtraLight.otf', '/Library/Fonts/AdobeHebrew-BoldItalic.otf');

my %hash = ("3" => {"files" => \@filesCS3,
					"folders" => \@foldersCS3},
			"4" => {"files" => \@filesCS4,
					"folders" => \@foldersCS4},
			"5" => {"files" => \@filesCS5,
					"folders" => \@foldersCS5},
			"5.5" => {"files" => \@filesCS55,
					"folders" => \@foldersCS55},
			"6" => {"files" => \@filesCS6,
					"folders" => \@foldersCS6}
												);

####################################################################################################
open(LOG, ">>$log") || die "Can't open file: $!\n";
# check for the version of the CS, using Flash as reference. Photoshop was used before CS5.5.
my $dirname = "/Applications/";
my $file;
my $dir;
opendir(DIR, $dirname) or die "can't opendir $dirname: $!";
while (defined($file = readdir(DIR))) {
     if (-d "$dirname$file" && "$dirname$file" =~ /Adobe Photoshop CS([0-9].[0-9])/gi || "$dirname$file" =~ /Adobe Photoshop CS([0-9])/gi) {
   	 print LOG "$DATE \t\t Adobe Creative Suite Software installed is CS$1. \n";
    		&checkversion($1);
	}
}
close (LOG);
####################################################################################################

sub checkversion {
	my $version = shift;
	if ($version == 3) {
	    print LOG "$DATE \t\t Deleting Adobe CS$version... \n";
	    &deleteCS($version);
	}
	elsif ($version == 4) {
	    print LOG "$DATE \t\t Deleting Adobe CS$version... \n";
	    &deleteCS($version);
	}
	elsif ($version == 5) {
	    print LOG "$DATE \t\t Deleting Adobe CS$version... \n";
	    &deleteCS($version);
	}
	elsif ($version == 5.5) {
	    print LOG "$DATE \t\t Deleting Adobe CS$version... \n";
	    &deleteCS($version);
	}
		elsif ($version == 6) {
	    print LOG "$DATE \t\t Deleting Adobe CS$version... \n";
	    &deleteCS($version);
	}
	else {
	    print LOG "$DATE \t\t CS Suite version is CS$version \n";
	}
}

####################################################################################################

sub deleteCS {
    my $version = shift;
    my @files = @{$hash{$version}{"files"}};
    my @folders  = @{$hash{$version}{"folders"}};

    foreach my $file (@files) {
    	#print "deleting \t\t $file\n";
    	unlink($file) or warn "couldn't unlink $file: $!";
    }
    use File::Path;
    foreach my $folder (@folders) {
   		#print "deleting \t\t $folder\n";
    	rmtree($folder) or warn "couldn't delete folder $folder: $!";
    }
}

####################################################################################################

exit 0;
