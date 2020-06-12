ArmA 2: Operation Arrowhead - Linux Dedicated Server
===============================================================

Copyrigt (c) 2010 Bohemia Interactive Studio. All rights reserved.

For more information please visit
http://community.bistudio.com/wiki/ArmA:_Dedicated_Server


    Installation instructions:
    ==========================

   Requirements:
   =============
1. The following programs must be installed on your Linux system:
   tar, gcc. Optional: md5sum (for setup integrity check). On 64-bit
   systems you will need 32-bit libraries installed, see Community
   Wiki for details.

2. On some distributions of Linux (this was reported for RedHat 9
   and Gentoo Linux 2.4.20) the NSCD deamon must be installed to
   run ArmA 2 server successfully. Caching of DNS would be sufficient.

   Copying and running:
   ==================
3. Copy the whole "ArmA 2: Operation Arrowhead" directory from 
   Windows to some Linux-directory. DON'T DO ANY DATA CONVERSIONS  
   (even "dos2unix" translation of text files is not necessary). 
   ArmA2 directory should contain subdirectories "Addons", "Dta", 
   "Expansion", etc.

   Example: pack with PKZIP (WinZip, PowerArchiver, etc.) on Windows 
   and unpack with "unzip" on Linux.
   
   DO NOT use upper case letters in the ArmA2 directory name (or in any 
   files that the server uses like missions or mods):
   GOOD: "/home/bob/arma2arrowhead"
   BAD:  "/home/bob/ArmA2ArrowHead"

4. Copy the "a2oaserver-x.xx.xxxxx.tar.bz2" (x.xx.xxxxx is version and build 
   number) file into the arma2arrowhead directory. Unpack and install it 
   with commands:

   $ tar -xvjf a2oaserver-x.xx.xxxxx.tar.bz2
   $ ./install

   Watch the messages - they might inform you whether your installation
   failed. Double check that all directories were renamed to lower case.
   Remove any .dll files you might still find (in battleye, expansion and 
   expansion/battleye directories).

5. Dedicated server can be started in foreground:

   $ ./server

   Or in background:

   $ nohup ./server > out.txt 2> err.txt &
   [1] <pid>

   Or by using:
   $ ./arma2oaserver start|stop|restart|status|check

   The "arma2oaserver" script needs to be configured and it is described 
   later in this file.

6. Running server can be stopped by executing:

   $ kill -s SIGINT <pid>

   Where <pid> is process-id of mother server thread (printed out in
   "nohup" command).

   Configuration and notes:
   ========================
7. ArmA 2: Operation Arrowhead server command-line parameter "-pid=<pid_file>"
   creates a <pid_file> with PID in the root ArmA2 directory. If the IP port 
   specified with "-port=<nn>" parameter is busy (in use), ArmA2 will 
   terminate immediately and <pid_file> won't be created.

8. The "arma2oaserver" script is for automatic server start/restart/status 
   query/etc. Please be sure to edit CONFIGURATION PARAMETERS between lines 
   12 to 18! After this is done, you can install the script into your 
   system services directory (/etc/rc.d/init.d) or run the script from the 
   server root directory. If linked into services directory it can be managed 
   by "chkconfig" (see info/man) on systems that use "chkconfig".

9. When adding mission .pbo's or mods remember to run ./tolower again or 
   manually change the filenames to lowercase. ANY uppercase letter in 
   a filename will crash the server!

   SECURITY WARNING! 
   Any file that is located in the ArmA 2 dedicated server directory or any 
   subdirectories, can be read with ingame commands by remote clients! This
means 
   that any config files with server passwords etc. can be read from inside
the 
   game if they know the filename. So do not use default .cfg names and for
the best 
   security place them outside the server directory. This can be further
hindered by 
   accepting only signed addons on your server although this is not
necessarily 100% 
   secure. Check Community Wiki for more details.
   SECURITY WARNING! 

