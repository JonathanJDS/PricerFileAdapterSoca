@ECHO OFF
Echo "Lock Application" > D:\ADVANTAG\CONV\APPEL.CTL
C:\WINNT\SYSTEM32\rcp -a fronXXXX.eeg:/usr/serveur/caisse/data/XXXX/E/FEEG.DAT \\eeg\D$\BOFFICE
Del D:\ADVANTAG\CONV\APPEL.CTL
