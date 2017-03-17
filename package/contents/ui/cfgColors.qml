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
import QtQuick.Layouts 1.3
import QtQuick.Controls 1.4

import org.kde.plasma.core 2.0 as PlasmaCore

Item {
    id: root

    property alias cfg_backgroundColor: _preview.color
    property alias cfg_primaryFontColor:    _pri.color
    property alias cfg_secondaryFontColor:  _sec.color
    ColumnLayout {
        id: coll
        spacing: units.smallSpacing

        Row {
            spacing: units.smallSpacing
            Label { text: i18n("Primary Font Color")}
            TextField {
                onTextChanged: _pri.color=text
                Component.onCompleted: text=_pri.color
            }
        }

        Row {
            spacing: units.smallSpacing
            Label { text: i18n("Secondary Font Color")}
            TextField {
                onTextChanged: _sec.color=text
                Component.onCompleted: text=_sec.color
            }
        }

        Row {
            spacing: units.smallSpacing
            Label { text: i18n("Background Color")}
            TextField {
                onTextChanged: _preview.color=text
                Component.onCompleted: text=_preview.color
            }
        }

        Row {
            spacing: units.smallSpacing
            Label { text: i18n("Preview")}
            Rectangle {
                id: _preview
                color: PlasmaCore.ColorScope.backgroundColor
                height: _pri.height*3
                width: _pri.width+_sec.width+units.smallSpacing*2
                Column {
                    Text {
                        id: _pri;
                        color: PlasmaCore.ColorScope.highlightColor;
                        text: i18n("Primary Font Color")

                    }
                    Text {
                        id: _sec;
                        color: PlasmaCore.ColorScope.textColor;
                        text: i18n("Secondary Font Color")

                    }
                }
            }
        }
        Row {
            spacing: units.smallSpacing
            Button {
                id: bt
                text: i18n("Show/Hide Explanation")
                checkable: true
            }
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
