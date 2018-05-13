/*
 * Copyright 2017  koffeinfriedhof <koffeinfriedhof@gmail.com>
 *
 * This program is free software; you can redistribute it and/or
 * modify it under the terms of the GNU General Public License as
 * published by the Free Software Foundation; either version 2 of
 * the License, or (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 */

import QtQuick 2.7
import QtQuick.Layouts 1.3 as QtLayouts
import QtQuick.Controls 1.4 as QtControls

import org.kde.plasma.core 2.0 as PlasmaCore
import org.kde.plasma.components 2.0 as PlasmaComponents
import org.kde.plasma.plasmoid 2.0

import "../code/phases.js" as Phases
import "../code/lunacalc.js" as LunaCalc


Item {
    id: root
    //** outsourcing function as a workaround for bug#3 (https://github.com/Koffeinfriedhof/gealach/issues/3)**//
    function getCurrentPhase() // this function assumes that today is between phases[0] (last new moon) and phases[4] (next new moon)
    {
        var oneDay = 86400000; //1000 * 60 * 60 * 24;
        var today = new Date().getTime();
        var phases = LunaCalc.getTodayPhases();

        // set time for all phases to 00:00:00 in order to obtain the correct phase for today (these changes should be local)
        for (var i = 0; i < 5; i++) {
            phases[i].setHours(0);
            phases[i].setMinutes(0);
            phases[i].setSeconds(0);
        }

        // if today <= first quarter, calculate day since last new moon
        var daysFromFirstQuarter = Math.floor((today - phases[1].getTime()) / oneDay);
        if (daysFromFirstQuarter == 0)
            return {number: 7, text: i18n("First Quarter")};
        else if (daysFromFirstQuarter < 0) {
            var daysFromLastNew = Math.floor((today - phases[0].getTime()) / oneDay);
            if (daysFromLastNew == 0)
                return {number: 0, text: i18n("New Moon"), subText: i18n("Today is New Moon")};
            else if (daysFromLastNew == 1)
                return {number: 1, text: i18n("Waxing Crescent"), subText: i18n("Yesterday was New Moon")};
            else // assume that today >= last new moon
                return {number: daysFromLastNew, text: i18n("Waxing Crescent"),
                    subText: i18np("%1 day since New Moon", "%1 days since New Moon", daysFromLastNew)};
        }

        // if today >= third quarter, calculate day until next new moon
        var daysFromThirdQuarter = Math.floor((today - phases[3].getTime()) / oneDay);
        if (daysFromThirdQuarter == 0)
            return {number: 21, text: i18n("Last Quarter")};
        else if (daysFromThirdQuarter > 0) {
            var daysToNextNew = -Math.floor((today - phases[4].getTime()) / oneDay);
            if (daysToNextNew == 0)
                return {number: 0, text: i18n("New Moon"), subText: i18n("Today is New Moon")};
            else if (daysToNextNew == 1)
                return {number: 27, text: i18n("Waning Crescent"), subText: i18n("Tomorrow is New Moon")};
            else // assume that today <= next new moon
                return {number: 28 - daysToNextNew, text: i18n("Waning Crescent"),
                    subText: i18np("%1 day to New Moon", "%1 days to New Moon", daysToNextNew)};
        }

        // in all other cases, calculate day from or until full moon
        var daysFromFullMoon = Math.floor((today - phases[2].getTime()) / oneDay);
        if (daysFromFullMoon == 0)
            return {number: 14, text: i18n("Full Moon"), subText: i18n("Today is Full Moon")};
        else if (daysFromFullMoon == -1)
            return {number: 13, text: i18n("Waxing Gibbous"), subText: i18n("Tomorrow is Full Moon")};
        else if (daysFromFullMoon < -1)
            return {number: 14 + daysFromFullMoon, text: i18n("Waxing Gibbous"),
                subText: i18np("%1 day to Full Moon", "%1 days to Full Moon", -daysFromFullMoon)};
                else if (daysFromFullMoon == 1)
                    return {number: 15, text: i18n("Waning Gibbous"), subText: i18n("Yesterday was Full Moon")};
                else if (daysFromFullMoon > 1)
                    return {number: 14 + daysFromFullMoon, text: i18n("Waning Gibbous"),
                        subText: i18np("%1 day since Full Moon", "%1 days since Full Moon", daysFromFullMoon)};

                        // this should never happen:
                        console.log("We cannot count :-(");
                        return {number: -1, text: ""};
    }

    /** CONFIGURATION **/
    //ICON
    property bool showBackground: Plasmoid.configuration.showBackground
    property bool hemisphere: Plasmoid.configuration.hemisphere
    property int updateInterval: Plasmoid.configuration.updateInterval

    //POPUP
    property int dateFormat: Plasmoid.configuration.dateFormat
    property string dateFormatString: Plasmoid.configuration.dateFormatString
    property bool buttonTextVisible: Plasmoid.configuration.buttonTextVisible

    //Colors
    property string backgroundColor: Plasmoid.configuration.backgroundColor
    property string primaryFontColor: Plasmoid.configuration.primaryFontColor
    property string secondaryFontColor: Plasmoid.configuration.secondaryFontColor

    /** PROPERTIES **/
    property var phases: LunaCalc.reloadPhases()
    property var currentPhase: getCurrentPhase()
    property var phaseNames:{
        // i18n: Names of Moon Phases:
        0:i18n("New Moon"), 1:i18n("First Quarter"), 2:i18n("Full Moon"), 3:i18n("Last Quarter"), 4:i18n("Next New Moon")}

    /** FUNCTIONS **/
    function update() {
        currentPhase=getCurrentPhase()
        phases=LunaCalc.reloadPhases()
    }

    /** PLASMOID DETAILS **/
    Plasmoid.backgroundHints: showBackground ? "DefaultBackground" : "NoBackground"
    Plasmoid.preferredRepresentation: Plasmoid.compactRepresentation

    Plasmoid.toolTipMainText: currentPhase.text
    Plasmoid.toolTipSubText: currentPhase.subText

    /** COMPACT **/
    Plasmoid.compactRepresentation: Component {
        MouseArea {
            id: compactRoot

            onClicked: plasmoid.expanded = !plasmoid.expanded

            PlasmaCore.Svg {
                id: lunaSvg
                imagePath: plasmoid.file("images", "luna-gskbyte" + root.currentPhase.number + ".svg");
            }

            PlasmaCore.SvgItem {
                id: lunaSvgItem

                anchors.fill: parent
                height: 100
                width: 100

                svg: lunaSvg
                // deal with northern <-> southern hemisphere
                transformOrigin: Item.Center
                rotation: hemisphere  ? 0 : 180
            }
        }
    }

    /** FULL **/
    Plasmoid.fullRepresentation: Rectangle {
        id: iAmJustHereForCustomBackgroundColor
        QtLayouts.Layout.preferredWidth: fullRoot.QtLayouts.Layout.minimumWidth + units.smallSpacing
        QtLayouts.Layout.preferredHeight: fullRoot.QtLayouts.Layout.minimumHeight + units.smallSpacing
        color: backgroundColor
        PhasesPopup{
            id: fullRoot
        }
    }

    Timer {
        id: updateTimer
        interval: updateInterval //default 1h: 3600000
        repeat: true
        running: true
        onTriggered: update()
    }
}
