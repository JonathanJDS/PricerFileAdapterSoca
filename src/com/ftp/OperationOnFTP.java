package com.ftp;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import org.apache.log4j.Logger;
import org.apache.commons.net.ftp.FTP;
import org.apache.commons.net.ftp.FTPClient;
import org.apache.commons.net.ftp.FTPFile;
import org.apache.commons.net.ftp.FTPFileFilter;
import org.apache.commons.net.ftp.FTPReply;

public class OperationOnFTP {
	
	
	Logger logger=Logger.getLogger(OperationOnFTP.class);
	private FTPClient ftpClient ;
	
	public FTPClient getFtpClient() {
		return ftpClient;
	}



	public OperationOnFTP(String server,int port,String user,String password) {
		
	 logger.info("Getting Files from FTP Server..");
		
	 FTPClient ftpClient = new FTPClient();
	 

	 try {
		 
         ftpClient.connect(server, port);
         
         showServerReply(ftpClient);

         int replyCode = ftpClient.getReplyCode();
         if (!FTPReply.isPositiveCompletion(replyCode)) {
             logger.fatal("Connect failed");
             return;
         }

         boolean success = ftpClient.login(user, password);
         
         
         showServerReply(ftpClient);

         if (!success) {
        	 logger.fatal("Could not login to the server ");
            return;
         }

        if (success) {
        	this.ftpClient=ftpClient;
        	logger.info("connection Successfull ...");
        
        }


     } catch (IOException  ex) {
         logger.fatal("Oops! Something wrong happened : " + ex.getMessage());
         return;
     } 
	 
	 catch(NullPointerException ca) {
		 logger.fatal("Oops! Something wrong happened : " + ca.getMessage());
	 }
	
	
	}
    
		
	public  FTPFile[] GetListFiles (final String dirToSearch,final String filterName) {
		FTPFile[] result = null;
		
		
		
		FTPFileFilter filter = new FTPFileFilter() {
			 
            @Override
            public boolean accept(FTPFile ftpFile) {

                return (ftpFile.isFile() && ftpFile.getName().startsWith(filterName.replace("*.*", "")));
                //return (ftpFile.isFile() && ftpFile.getName().contains(filterName));
              //  return (ftpFile.isFile() );
            }
        };
		
		
        try {
			result = ftpClient.listFiles(dirToSearch, filter);
			 showServerReply(ftpClient);
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
        
        catch (NullPointerException ca) {
        	ca.printStackTrace();
        }
		
        
		return result;
	}
	
	

	
	public boolean downloadFTPFile(String ftpsourcepath, String filename, String destinationFoldeName, boolean bDeleteAfterCopy) {
        
		
		
		File file = new File(destinationFoldeName + "/" + filename);
    	if (file.exists()) {
    		
    		logger.warn("File Already exist : " + file.getName() + " unable to overwrite, waiting for next time");
    	
    		return false;
    	}
    	
		
    	try {
			ftpClient.setFileType(FTP.BINARY_FILE_TYPE);
			ftpClient.enterLocalPassiveMode();
			
			
			
		} catch (IOException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}
    	
    	
    	FileOutputStream fos = null;	
		
		try {
			
			
			 fos = new FileOutputStream(destinationFoldeName + "/" + filename);
        	
        	this.ftpClient.retrieveFile(ftpsourcepath + "/" + filename, fos);
            if (bDeleteAfterCopy==true) {
            	logger.info("Trying to delete file" + ftpsourcepath + "/" + filename );
            	this.ftpClient.deleteFile(ftpsourcepath + "/" + filename);
            	//ftpClient.deleteFile(ftpsourcepath+"/"+filename);
            	logger.info("file deleted successfully ...");
            }
            
            
        } catch (IOException e) {
            e.printStackTrace();
        return false ;
        }
      
		finally {
			try {
				fos.close();
			}
			catch (IOException ex) {
				
				logger.warn("unable to close file after copy " + destinationFoldeName + "/" + filename);
			}
		}
		
		
        return true;
    }
	
	
	
	public boolean disconnect() {
	
		
		
		
		try {
			this.ftpClient.logout();
			this.ftpClient.disconnect();
			showServerReply(ftpClient);
		} catch (IOException e) {
			System.out.println("Unable to disconnect from FTP Server !!! : " + e.getMessage());
			
		
		return false;
		}
		
		catch(NullPointerException ca) {
			System.out.println("Unable to disconnect from FTP Server !!! : " + ca.getMessage());
			return false;
		}
		
		return true;
		
	}
	
	
	
	public void showServerReply(FTPClient ftpClient) {
        
		logger.debug("getting Response For FTP Server...");
		String[] replies = ftpClient.getReplyStrings();
        if (replies != null && replies.length > 0) {
            for (String aReply : replies) {
            	 //System.out.println("SERVER: " + aReply);
            	 logger.debug("SERVER: " + aReply);
            }
        }
	}
	
}
