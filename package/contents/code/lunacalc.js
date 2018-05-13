/**

    Copyright 1998, 2000  Stephan Kulow <coolo@kde.org>
    Copyright 2008 by Davide Bettio <davide.bettio@kdemail.net>
    Copyright (C) 2009, 2011, 2012, 2013 Glad Deschrijver <glad.deschrijver@gmail.com>

    This program is free software; you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation; either version 2 of the License, or
    (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with this program; if not, see <http://www.gnu.org/licenses/>.

*/

var lunation = 0;

function getLunation(time)
{
//	var lunation = 0;
	var nextNew = new Date(0);

	// obtain reasonable start value for lunation so that the while loop below has a minimal amount of iterations (for faster startup of the plasmoid)
	var reference = 947178885000; // number of milliseconds between 1970-01-01 00:00:00 and 2000-01-06 18:14:45 (first new moon of 2000, see lunation in phases.js)
	var lunationDuration = 2551442877; // number of milliseconds in 29.530588853 days (average lunation duration, same number as in (47.1) in phases.js)
//	var lunationDuration = 2583360000; // number of milliseconds in 29.9 days (maximum lunation duration, see wikipedia on synodic month); use this if the bug ever appears that the lunar phases displayed at startup are too much in the future
	var lunation = Math.floor((time.getTime() - reference) / lunationDuration);

	do {
		var JDE = Phases.moonphasebylunation(lunation, 0);
		nextNew = Phases.JDtoDate(JDE);
		lunation++;
	} while (nextNew < time);

	lunation -= 2;
	return lunation;
}

function getPhasesByLunation(lunation)
{
	var phases = new Array();
	phases[0] = Phases.JDtoDate(Phases.moonphasebylunation(lunation, 0)); // new moon
	phases[1] = Phases.JDtoDate(Phases.moonphasebylunation(lunation, 1)); // first quarter
	phases[2] = Phases.JDtoDate(Phases.moonphasebylunation(lunation, 2)); // full moon
	phases[3] = Phases.JDtoDate(Phases.moonphasebylunation(lunation, 3)); // last quarter
	phases[4] = Phases.JDtoDate(Phases.moonphasebylunation(lunation+1, 0)); // next new moon
	return phases;
}

function getTodayPhases()
{
	var today = new Date();
	lunation = getLunation(today);
	return getPhasesByLunation(lunation);
}

function getPreviousPhases()
{
	lunation--;
	return getPhasesByLunation(lunation);
}

function getNextPhases()
{
	lunation++;
	return getPhasesByLunation(lunation);
}

function reloadPhases()
{
	return getPhasesByLunation(lunation);
}
