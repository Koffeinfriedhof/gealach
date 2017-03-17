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
import QtQuick.Controls 1.2
import QtQuick.Layouts 1.2

Item {
    property alias cfg_dateFormat: dF.currentValue
    property alias cfg_dateFormatString: dFS.text
    property alias cfg_buttonTextVisible: btv.checked

    property real itemSpacing: 20

    ColumnLayout {
        spacing: itemSpacing
        Row {
            spacing: itemSpacing
            Label {
                text: i18n("Choose Date Format")
            }
            ComboBox {
                id: dF
                textRole: "name"
                property int currentValue: 0
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
                onCurrentIndexChanged: currentValue=limo.get(currentIndex).value
            }
        }
        Row {
            spacing: itemSpacing
            visible: limo.get(dF.currentIndex).value==99
            Label { text: i18n("Custom Date Format: "); height: dFS.height }
            TextField {
                id: dFS
            }
            Label {
                id: pv
                text: i18n("Preview: ")+Qt.formatDateTime(new Date(), dFS.text)
            }
        }
        Row {
            visible: limo.get(dF.currentIndex).value==99
            Label { text: i18n("Available expressions:") }
            Label { text: "<a href=\"http://doc.qt.io/qt-5/qml-qtqml-date.html#details\">Date: Expression / Output</a>" }
        }

        Row {
            spacing: itemSpacing
            CheckBox {
                id: btv
                text: i18n("Show Button Text")
                checked: false
            }
        }
    }
}

