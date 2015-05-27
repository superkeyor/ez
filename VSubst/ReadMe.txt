=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
Visual Subst v1.0 for Windows 2000/XP/Vista
Copyright (c) 2006-2008 NTWind Software
http://www.ntwind.com/software/utilities/visual-subst.html
=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=


Introduction
============

Visual Subst is a small tool that allows you to associate the most accessed 
directories with virtual drives. It uses the same API similar to the console 
'subst' utility, but makes it easier to create and remove virtual drives in a 
GUI way.

Personally, I use virtual drives everywhere – I always prefer to press ALT+F1 
in the file manager and switch to a project directory where hundreds of various 
files are kept. Using virtual drives, these files can be quickly accessed at 
any time.


For Programmers
===============

If you have the Platform SDK installed and need to use it frequently, it is 
possible to create a virtual drive mounted on the Samples directory. You can 
therefore reduce a long path like 'C:\Program Files\Microsoft Platform 
SDK\Samples\Multimedia\DirectShow' to just one letter.

In my opinion, this is the shortest way to gain access to the sample source 
code from the SDK when it is required on a continual basis.


How It Works
============

Generally, a virtual drive is just a symbolic link in the Local MS-DOS Device 
namespace. It is just one more Windows feature added for backward compatibility 
with old programs.

Virtual drives are therefore objects of the operating system, and Visual Subst 
can create, enumerate and delete these objects. All local MS-DOS device names 
are removed when the user is logging off. To handle this issue, Visual Subst 
saves the list of virtual drives into an INI-file and is able to load them the 
next time.


System requirements
===================

Visual Subst was especially developed for Microsoft Windows 2000/XP and newer 
operating systems. Please do not ask for Windows 9x support.


Reporting problems
==================

If you encounter problems, please visit http://www.ntwind.com/ and download the 
latest version to see if the issue has been resolved.

To post any comments and bug reports, use certain forums at: 
http://www.ntwind.com/forum/

I ask to use forums of all. But if you wish to contact me personally, you can 
email me at: alexander@ntwind.com


Credits
=======

Icons used with permission from FOOOD’s Icons (http://www.foood.net/).



Alexander Avdonin
Saint Petersburg, Russia

NTWind Software - www.ntwind.com