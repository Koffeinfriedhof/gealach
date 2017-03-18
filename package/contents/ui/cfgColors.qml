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
import QtQuick.Dialogs 1.0
import QtQuick.Layouts 1.3 as QtLayouts
import QtQuick.Controls 1.4 as QtControls

import org.kde.plasma.core 2.0 as PlasmaCore

Item {
    id: root

    property alias cfg_backgroundColor: _preview.color
    property alias cfg_primaryFontColor:    _pri.color
    property alias cfg_secondaryFontColor:  _sec.color

    //Color dialog
    ColorDialog {
        id: colorDialog
        property var current: _priField
        title: i18n("Please choose a color for %1").arg(current.text)
        onAccepted: {
            current.text=colorDialog.color
            console.log("You chose: " + colorDialog.color)
            Qt.quit()
        }
        onRejected: {
            console.log("Canceled")
            Qt.quit()
        }
    }

    QtLayouts.GridLayout {
        id: coll
        columns: 3

        QtControls.Label { text: i18n("Primary Font Color")}
        QtControls.TextField {
            id: _priField
            onTextChanged: _pri.color=text
            Component.onCompleted: text=cfg_primaryFontColor
        }
        QtControls.Button {
            iconName: "color-picker.png"
            onClicked: {
                colorDialog.current=_priField
                colorDialog.color=_pri.color
                colorDialog.visible=true
            }
        }


        QtControls.Label { text: i18n("Secondary Font Color")}
        QtControls.TextField {
            id: _secField
            onTextChanged: _sec.color=text
            Component.onCompleted: text=cfg_secondaryFontColor
        }
        QtControls.Button {
            iconName: "color-picker.png"
            onClicked: {
                colorDialog.current=_secField
                colorDialog.color=_sec.color
                colorDialog.visible=true
            }
        }

        QtControls.Label { text: i18n("Background Color")}
        QtControls.TextField {
            id: _bgcField
            onTextChanged: _preview.color=text
            Component.onCompleted: text=cfg_backgroundColor
        }
        QtControls.Button {
            iconName: "color-picker.png"
            onClicked: {
                colorDialog.current=_bgcField
                colorDialog.color=_preview.color
                colorDialog.visible=true
            }
        }


        QtControls.Label { text: i18n("Preview")}
        Rectangle {
            id: _preview
            height: _pri.height*3
            width: _pri.width+_sec.width+units.smallSpacing*2
            QtLayouts.Layout.columnSpan: 3

            Column {
                QtControls.Label {
                    id: _pri;
                    text: i18n("Primary Font Color")
                }
                QtControls.Label {
                    id: _sec;
                    text: i18n("Secondary Font Color")
                }
            }
        }
        QtControls.Button {
            text: i18n("Set Theme Colors")
            onClicked: {
                _priField.text=PlasmaCore.ColorScope.highlightColor
                _secField.text=PlasmaCore.ColorScope.textColor
                _bgcField.text=PlasmaCore.ColorScope.backgroundColor
            }
        }
            QtControls.Button {
                id: bt
                QtLayouts.Layout.columnSpan: 3
                text: i18n("Show/Hide Explanation")
                checkable: true
            }

    }

        Text {
            visible: bt.checked
            id: txt
            anchors.top: coll.bottom
            width: parent.width*0.9
            wrapMode: Text.WordWrap
            onLinkActivated: Qt.openUrlExternally(link)
            //TODO: onLinkHovered: change mouse cursor
            text: i18n("You may enter a color by a SVG color name, such as \"red\", \"green\" or \"lightsteelblue\" or by a hexadecimal triplet or quad in the form \"#RRGGBB\" and \"#AARRGGBB\" respectively. For example, the color red corresponds to a triplet of \"#FF0000\" and a slightly transparent blue to a quad of \"#800000FF\". For details have a look at <a href=\"http://doc.qt.io/qt-5/qml-color.html\">QML Colors</a>")
        }
}
