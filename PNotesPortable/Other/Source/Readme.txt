PNotes Portable Launcher
================================

Copyright 2004-2009 John T. Haller
Copyright 2008-2009 Oliver Krystal
Copyright 2007 Ryan McCue

Website: http://PortableApps.com/PNotesPortable

This software is OSI Certified Open Source Software.
OSI Certified is a certification mark of the Open Source Initiative.

This program is free software; you can redistribute it and/or
modify it under the terms of the GNU General Public License
as published by the Free Software Foundation; either version 2
of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program; if not, write to the Free Software
Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.

About PNotes Portable
=====================
The PNotes Portable Launcher launches PNotes with its settings in Portable Apps Format Complaint Directory format.


LICENSE
=======
This code is released under the GPL.  The full code is included with this package as
PNotesPortable.nsi.


INSTALLATION / DIRECTORY STRUCTURE
==================================
The program expects this directory structure:

-\ <--- Directory with PNotesPortable.exe
	+\App\
		+\PNotes\
	+\Data\
		+\settings\
	+PNotesPortable.ini (Optional)

PNotesPortable.INI CONFIGURATION
==================================
The PNotes Portable Launcher will look for an ini file called PNotesPortable.ini (read the previous section for details on placement).  If you are happy with the default options, it is not necessary, though.  The INI file is formatted as follows:

[PNotesPortable]
AdditionalParameters=
DisableSplashScreen=false

The AdditionalParameters entry allows you to pass additional commandline parameter
entries to PNotes.exe.  Whatever you enter here will be appended to the call to
PNotes.exe.

DisableSplashScreen allows you to disable the splash screen when set to true.

Support for renaming the App directories, Settings directory, and the PNotes executable was dropped in the PNotes Portable 5.5 (Launcher version 1.8.0.0) Release.
