import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.Timer;
import java.util.TimerTask;
import org.apache.commons.net.ftp.FTPFile;
import org.apache.log4j.Logger;
import org.ini4j.InvalidFileFormatException;
import org.ini4j.Wini;

import com.ftp.OperationOnFTP;





public class ThreadGetSFTPFiles extends Thread {
	
	Logger logger=Logger.getLogger(Start.class);
	Wini ini;
	
	
  Timer timer = new Timer();
  


  public ThreadGetSFTPFiles()
  {
   

		try {
			ini = new Wini(new File("preference.ini"));
		} catch (InvalidFileFormatException e1) {
			
			logger.fatal("Unable to Read Preference.ini File, check your configuration cause : " + e1.getCause() + "/" + e1.getMessage());
			logger.fatal("Exit Application");
			System.exit(1);
			
			
		} catch (IOException e1) {
			logger.fatal("Unable to Read Preference.ini File, check your configuration cause : " + e1.getCause() + "/" + e1.getMessage());
			logger.fatal("Exit Application");
			System.exit(1);
			
		}
		
	  
	  logger.info("Starting Application PricerGetSFTPFile Version 1.0 by MDZ 2019/11");
	  	
	  
	 logger.info("getting FTP parameters"); 
	 
	 
	  	final String ftpserver					= ini.get("FTP", "host");
		final int ftpport						= Integer.valueOf(ini.get("FTP","port"));
		final String ftpuser					= ini.get("FTP","username");
		final String ftppassword				= ini.get("FTP","password");
		final String ftpsourcepath				= ini.get("FTP","sourcepath");
		final boolean ftpremovefileaftercopy	= Boolean.valueOf(ini.get("FTP","removefileaftercopy"));	
		
		
		final int tempo							= Integer.valueOf(ini.get("FTP","timer"));
		
		final String sourceFolder				= ini.get("Folders", "SourceFolder");
		final String dataFTPFilterFileName 	= ini.get("Files","DataFileName");
		final String stockFTPFilterFileName = ini.get("Files","StockFileName");
		final String printFTPFilterFileName = ini.get("Files","PrintFileName");
		System.out.println("ftp filer sub = " +dataFTPFilterFileName);
		//dataFTPFilterFileName.substring(0, 9);
		
		final List<String> lstFTPFilterFileName = new ArrayList<String>();
		
		lstFTPFilterFileName.add(dataFTPFilterFileName);
		lstFTPFilterFileName.add(stockFTPFilterFileName);
		lstFTPFilterFileName.add(printFTPFilterFileName);
		
		// get the property value and print it out
		 logger.info("host = " + ftpserver);
		 logger.info("port = " + ftpport);
		 logger.info("username = " + ftpuser);
		 logger.info("password = " + ftppassword);
		
		 logger.info("Source path = " + ftpsourcepath);
		 logger.info("removefileaftercopy = " + ftpremovefileaftercopy); 
		 logger.info("timer = " + tempo + " Sec"); 
				
		TimerTask task = new TimerTask()
    
    
    {





      public void run()
      {
    	  FTPFile[] files ;
    	  
    	  OperationOnFTP operationOnFTP = new OperationOnFTP(ftpserver, ftpport, ftpuser, ftppassword) ;
    	  
    	if(operationOnFTP.getFtpClient() != null) {
    	  
    	  for (String filtername : lstFTPFilterFileName) {  
    		
    		
    		
    	  
    	  files = operationOnFTP.GetListFiles(ftpsourcepath,filtername);
    	  System.out.println("filernameftp: "+filtername);
    	 
    	  if (files != null && files.length > 0 ) {
    	       System.out.println("SEARCH RESULT:");
    	       for (FTPFile aFile : files) {
    	           System.out.println("found file : " + aFile.getName());
    	           logger.info("found file :" + aFile.getName());
    	          
    	           operationOnFTP.downloadFTPFile(ftpsourcepath,aFile.getName(), sourceFolder,ftpremovefileaftercopy);
    	       }
    	   }  
    	   
    	   
    	}
    	   operationOnFTP.disconnect(); 
    	   
        }else {
      	  System.out.println("Could not login !!");
        }  
    	   
      }

      



    };
    timer.scheduleAtFixedRate(task, 0L, tempo*1000);
  }
  




 
}
