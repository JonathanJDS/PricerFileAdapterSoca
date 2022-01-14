connect to SFTP server "only with user and password" !!!

installation:
copy "PricerGetSFTPFiles" folder into pricer directory.

go to PricerGetSFTPFiles/bat/ an execute installService.bat in administrator mode.


before starting service please adapt your config.properties like below



host = ftp.pi-cloud.eu       'FTP server 
port = 22						 
username = EDI_PLISSON			
password = 95KC18Tt
filenamefilter = Document*.txt ' filter name for taking several files 
destinationpath = c:/pricer/ftp ' destination for copied files 
removefileaftercopy = true		' remove file at server side true or false
timer = 30						' timer after each connection to the server (in seconds)


