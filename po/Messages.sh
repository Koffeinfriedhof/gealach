#! /usr/bin/env bash
# Copied this script from gmail-plasmoid-0.7.20 which is copyrighted as follows:
# Copyright (C) 2009 Mark McCans <mjmccans@gmail.com>
# under the GPLv2 or later
# Modifications for QML plasmoids by:
# Copyright (C) 2012 Glad Deschrijver <glad.deschrijver@gmail.com>
# further modifications in 2017 by <koffeinfriedhof@gmail.com>
#
# USE THIS ONLY FOR PLASMOIDS!!!
#

#current path
myPath=$(find -name Messages.sh); myPath=${myPath%%\/Messages.sh};

#if a language is passed as argument
#TODO: check if its a correct one.
REQUESTED_LANG=""
if ! [[ $# -eq 0 ]] ; then
    REQUESTED_LANG=$1
fi

########################
### METADATA.DESKTOP ###
########################

#Plasmoid .pot files MUST be named like X-KDE-PluginInfo-Name!
NAME=$(grep "X-KDE-PluginInfo-Name" $myPath/../package/metadata.desktop | sed 's/.*=//')
VERSION=$(grep "X-KDE-PluginInfo-Version" $myPath/../package/metadata.desktop | sed 's/.*=//')
AUTHOR=$(grep "X-KDE-PluginInfo-Author" $myPath/../package/metadata.desktop | sed 's/.*=//')
EMAIL=$(grep "X-KDE-PluginInfo-Email" $myPath/../package/metadata.desktop | sed 's/.*=//')

API=$(grep "X-Plasma-API" $myPath/../package/metadata.desktop | sed 's/.*=//')
case "$API" in
  "python") SCRIPTEXT="py" ;;
  "ruby-script") SCRIPTEXT="rb" ;;
  "webkit") SCRIPTEXT="js" ;;
  "declarativeappletscript") SCRIPTEXT="js" ;;
  * ) exit ;;
esac


#######################
### EXTRACTING TEXT ###
#######################

POT=$myPath/"plasma_applet_$NAME.pot"
YEAR=$(date +'%Y')

XGETTEXT="xgettext --from-code=UTF-8 -kde -ci18n -ki18n:1 -ki18nc:1c,2 -ki18np:1,2 \
          -ki18ncp:1c,2,3 -ktr2i18n:1 -kI18N_NOOP:1 -kI18N_NOOP2:1c,2 -kaliasLocale \
          -kki18n:1 -kki18nc:1c,2 -kki18np:1,2 -kki18ncp:1c,2,3xgettext -ki18n -ki18nc
          -ki18ncp -ki18np"
EXTRACTRC="./extractrc"

$EXTRACTRC $myPath/../package/contents/ui/*.ui $myPath/../package/contents/config/*.xml > $myPath/rc.$SCRIPTEXT
echo 'i18nc("NAME OF TRANSLATORS","Your names");' >> $myPath/rc.$SCRIPTEXT
echo 'i18nc("EMAIL OF TRANSLATORS","Your emails");' >> $myPath/rc.$SCRIPTEXT

dateiliste=$(find $myPath/../ -name *.qml -o -name *.js)
echo DATLIST=$dateiliste
#$XGETTEXT ../package/*/*.qml rc.$SCRIPTEXT ../package/contents/code/*.$SCRIPTEXT -L Java -o "$POT"
$XGETTEXT $dateiliste -L Java -o "$POT" 
sed -e 's/charset=CHARSET/charset=UTF-8/g' -i "$POT"
sed -e "s/SOME DESCRIPTIVE TITLE./$NAME language translation file./g" -i "$POT"
sed -e "s/Copyright (C) YEAR THE PACKAGE'S COPYRIGHT HOLDER/Copyright (C) $YEAR, $AUTHOR <$EMAIL>/g" -i "$POT"
sed -e "s/This file is distributed under the same license as the PACKAGE package./This file is distributed under the same license as the $NAME package./g" -i "$POT"
sed -e "s/FIRST AUTHOR <EMAIL@ADDRESS>, YEAR./$AUTHOR <$EMAIL>, $YEAR/g" -i "$POT"
sed -e "s/Project-Id-Version: PACKAGE VERSION/Project-Id-Version: $VERSION/g" -i "$POT"
echo ding
#check existing translation files
if [ "$( find $myPath/ -type f -name '*.po' )" ]; then
    #sync available .po files into pot and compile them to mo
    for d in $myPath/*.po; do
        echo "Merging $d → $POT"
        msgmerge -U "$d" "$POT"
        echo -e "\nCompiling $d → ${d%.po}.mo"
        msgfmt "$d" -o "${d%.po}.mo"
        echo "Done."
    done
fi


#######################
### NEW TRANSLATION ###
#######################

#if new language is requested, copy it:
if ! [ -z "$REQUESTED_LANG" ]; then
    if [ -f  $myPath/plasma_applet_"$NAME"_"$REQUESTED_LANG".po ]; then
        echo -e '\n' plasma_applet_"$NAME"_"$REQUESTED_LANG".po is already created. Please edit it to fit your needs. '\n'
    else
        echo Copying "$POT" -> plasma_applet_"$NAME"_"$REQUESTED_LANG".po ...
        cp "$POT" $myPath/plasma_applet_"$NAME"_"$REQUESTED_LANG".po
    fi
fi


###############
### CLEANUP ###
###############

rm -f $myPath/rc.$SCRIPTEXT
find $myPath/ -type f -name "*.po~" -exec rm {} \;
