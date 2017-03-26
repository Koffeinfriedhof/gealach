# gealach
This is a rewritten Plasmoid displaying the current phase of the moon. Gealach (or ghealach) is the gaelic word for moon.

On being clicked it presents the important moon phases and shows:
 - last new moon
 - first quarter
 - full moon
 - third quarter
 - next new moon
of current month. Using the arrow-buttons navigates through other months.
System logic is the one delivered with "Luna II", another Plasma-Port of Luna QML.

Installation
---------------------
after cloning the source use the ./setup - script to install the plasmoid with localisation support.
Usage:
 * -i|--install         :   (local) installation
 * -u|--update          :   update (local) installation
 * -r|--remove          :   remove (local) installation
 * -r -i                :   remove and install (reinstall)

 * -g|--global-install  :   run cmake,make and make install

Manual Installation
---------------------
Local Installation: `plasmapkg2 -i package`
If you need translations: copy the apropriate .mo file to
`$USER/.local/share/locale/$LANG/LC_MESSAGES/plasma_applet_org.koffeinfriedhof.gealach.mo`

Global Installation:
`cmake CMakeLists.txt`
`make`
`sudo make install`

Sources:
--------
* Plasma 5 Port: Luna II
*   https://github.com/wwjjbb/Luna-II
*   https://store.kde.org/p/1165459/
* which originates on
* Luna QML
*   Version 1.4
*   <https://store.kde.org/p/1002036/>
*
* Werewolf picture: by Woofer - Created 2016-05-11 - Description: Color version of werewolf in front of a full moon.
* https://openclipart.org/detail/248378/werewolf-and-moon-in-color licensed unter CC0 Public Domain
*
* Moon in Hand - used as "screenshot.png":
* https://pixabay.com/de/mond-planet-himmelsk%C3%B6rper-2134881/
* by: https://pixabay.com/de/users/FunkyFocus-3900817/ licensed unter CC0 Public Domain

License
-------
Copyright 2017 <koffeinfriedhof@gmail.com>

Rewritten QML-Code to fit dynamic layouts in QML 2.

Copyright 2016 Bill Binder <dxtwjb@gmail.com>

Updated the Luna QML plasmoid from Plasma 4 to Plasma 5.

Copyright (C) 2011, 2012, 2013 Glad Deschrijver <glad.deschrijver@gmail.com>

The JavaScript code is based on the C++ code of the original Luna plasmoid
in the KDE Plasma Workspace. This C++ code is licensed as follows:
  Copyright 1996 Christopher Osburn <chris@speakeasy.org>
  Copyright 1998,2000  Stephan Kulow <coolo@kde.org>
  Copyright 2008 by Davide Bettio <davide.bettio@kdemail.net>
  licensed under the GNU GPL version 2 or later.

The luna images are extracted from the luna SVG file created by:
  Copyright 2009 Jose Alcala (project manager), Dan Gerhards (moon artwork),
                 Jeremy M. Todaro (shadows and layout)
  (available at http://kde-look.org/content/show.php/luna.svgz+(full+SVG+image)?content=106013
  original available at http://www.public-domain-photos.com/free-cliparts/science/astronomy/the_moon_dan_gerhards_01-5094.htm)
  released in the public domain

This program is free software; you can redistribute it and/or modify it under
the terms of the GNU General Public License as published by the Free Software
Foundation; either version 3 of the License, or (at your option) any later
version.

This program is distributed in the hope that it will be useful, but WITHOUT
ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.

Possible bug warning
--------------------

In contents/code/lunacalc.js a reasonable lower approximation for the number
of lunations since the New Moon of January 6, 2000 is calculated in order to
reduce the number of iterations in a costly while loop and thus speed up the
startup of the plasmoid.  Since the lunation duration is not fixed, it may
happen that the calculated number of lunations is too high, and then the
plasmoid will display phases of the moon which are one month in the future.
Since the average lunation duration is used, this bug will only occasionaly
appear, if it appears at all.  This can be solved by setting the variable
lunationDuration to a higher value (with the negative impact that the startup
of the plasmoid may be slower).
