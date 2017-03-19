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

Item {
    property alias cfg_dateFormat: dF.currentDateFormatValue
    property alias cfg_dateFormatString: dFS.text
    property alias cfg_buttonTextVisible: btv.checked

    property real itemSpacing: units.largeSpacing

    QtLayouts.ColumnLayout {
        QtLayouts.Layout.fillWidth: true
        spacing: itemSpacing
        Row {
            spacing: itemSpacing
            QtControls.Label {
                text: i18n("Choose Date Format")
            }
            QtControls.ComboBox {
                id: dF
                textRole: "name"
                property int currentDateFormatValue: 0
                model: ListModel {
                    id: limo
                    dynamicRoles: true
                    Component.onCompleted: {
                        append({ "name": i18n("Text Date"), "value": Qt.TextDate } )
                        append({ "name": i18n("ISO Date"), "value": Qt.ISODate } )
                        append({ "name": i18n("Short Date"), "value": Qt.DefaultLocaleShortDate } )
                        append({ "name": i18n("Long Date"), "value": Qt.DefaultLocaleLongDate } )
                        append({ "name": i18n("Custom Date"), "value": 99 } )
                    }
                }
                onCurrentIndexChanged: currentDateFormatValue=limo.get(currentIndex).value
            }
        }
        Row {
            spacing: itemSpacing
            visible: limo.get(dF.currentIndex).value==99
            QtLayouts.GridLayout {
                columns: 2
                QtControls.Label { text: i18n("Custom Date Format: "); height: dFS.height }
                QtControls.Label {
                    id: pv
                    text: i18n("Preview: ")+Qt.formatDateTime(new Date(), dFS.text)
                }

                QtControls.TextField {
                    QtLayouts.Layout.columnSpan: 2
                    QtLayouts.Layout.fillWidth: true
                    id: dFS
                }

                QtControls.Label {
                    // i18n: Expressions for custom date format
                    text: i18n("Available expressions:") }
                QtControls.Label {
                    id: txt
                    onLinkActivated: Qt.openUrlExternally(link)
                    text: "<a href=\"http://doc.qt.io/qt-5/qml-qtqml-date.html#details\">Date: Expression / Output</a>"
                    MouseArea { id: txtMA; anchors.fill: parent }
                }
                states: State {
                    name: "cursor"; when: txt.hoveredLink.length > 0
                    PropertyChanges { target: txtMA; cursorShape: Qt.PointingHandCursor; }
                }
            }
        }

        Row {
            spacing: itemSpacing
            QtControls.CheckBox {
                id: btv
                // i18n: Button Text of prev|current|next moon phase
                text: i18n("Show Button Text")
                checked: false
            }
        }
    }
}

