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
    id: root
    property alias cfg_showBackground: bg.checked
    property alias cfg_hemisphere: northern.checked
    property alias cfg_updateInterval: ival.interval

    property real itemSpacing: 20

    ColumnLayout {
        spacing: itemSpacing
        GroupBox {
            title: i18n("Choose Hemisphere")

            RowLayout {
                spacing: itemSpacing
                ExclusiveGroup { id: hemisphereGroup }
                RadioButton {
                    id: northern
                    text: i18n("Northern")
                    checked: true
                    exclusiveGroup: hemisphereGroup
                }
                RadioButton {
                    text: i18n("Southern")
                    exclusiveGroup: hemisphereGroup
                }
            }
        }
        Row {
            spacing: itemSpacing
            Label { text: i18n("Icon Update Interval")}
            SpinBox {
                id: ival
                property int interval: 0
                value: 60
                decimals: 0
                minimumValue: 1
                suffix: i18n(" minutes")
                onValueChanged: interval=value*60*1000
            }
        }
        CheckBox {
            id: bg
            text: i18n("Show Icon Background")
            checked: false
        }
    }
}
