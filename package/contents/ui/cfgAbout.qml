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

Item {
    Text {
        id: txt
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.right: parent.right
        wrapMode: Text.WordWrap
        onLinkActivated: Qt.openUrlExternally(link)
        MouseArea {
            id: txtMA
            anchors.fill: parent
        }
        text: "<br /><h3>This page is dedicated to the earlier maintainers and creators of Luna and Luna II.
Thank you for sharing your work!</h3><br /><br />
<a href=\"mailto:dxtwjb@gmail.com\">Bill Binder</a> for porting the Luna QML plasmoid from Plasma 4 to Plasma 5.
<br /><br />
<a href=\"mailto:glad.deschrijver@gmail.com\">Glad Deschrijver</a> for maintaining Luna QML 2011-2013
<br /><br />
The JavaScript code is based on the C++ code of the original Luna plasmoid in the KDE Plasma Workspace. This C++ code is licensed as follows:<br />
Copyright 1996 <a href=\"mailto:chris@speakeasy.org\">Christopher Osburn</a><br />
Copyright 1998,2000 <a href=\"mailto:coolo@kde.org\">Stephan Kulow</a><br />
Copyright 2008 by <a href=\"mailto:davide.bettio@kdemail.net\">Davide Bettio</a><br />
licensed under the GNU GPL version 2 or later.<br />
<br />
The luna images are extracted from the luna SVG file created by:<br />
Copyright 2009 Jose Alcala (project manager), Dan Gerhards (moon artwork),
Jeremy M. Todaro (shadows and layout)<br />
(available at <a href=\"http://kde-look.org/content/show.php/luna.svgz+(full+SVG+image)?content=106013\">http://kde-look.org/content/show.php/luna.svgz+(full+SVG+image)?content=106013</a> original available at <a href=\"http://www.public-domain-photos.com/free-cliparts/science/astronomy/the_moon_dan_gerhards_01-5094.htm\">http://www.public-domain-photos.com/free-cliparts/science/astronomy/the_moon_dan_gerhards_01-5094.htm</a>) released in the public domain<br /><br />"
    }
    QtControls.Label {
        id: linker
        anchors.bottom: parent.bottom
        anchors.left: parent.left
        anchors.right: parent.right
        wrapMode: Text.WordWrap
    }
    states: State {
        name: "cursor"; when: txt.hoveredLink.length > 0
        PropertyChanges { target: txtMA; cursorShape: Qt.PointingHandCursor; }
        PropertyChanges { target: linker; text: txt.hoveredLink}
    }
}
