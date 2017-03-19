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
    property var currentPhase: LunaCalc.getCurrentPhase()
    property var phaseNames:{
        // i18n: Names of Moon Phases:
        0:i18n("New Moon"), 1:i18n("First Quarter"), 2:i18n("Full Moon"), 3:i18n("Last Quarter"), 4:i18n("Next New Moon")}

    /** FUNCTIONS **/
    function update() {
        currentPhase=LunaCalc.getCurrentPhase()
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
