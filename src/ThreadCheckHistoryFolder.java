



import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.Timer;
import java.util.TimerTask;

import org.apache.log4j.Logger;
import org.ini4j.InvalidFileFormatException;
import org.ini4j.Wini;





/**
 *
 * @author mohamed.derraz
 */
public class ThreadCheckHistoryFolder extends Thread{
    

	static Logger logger = Logger.getLogger(ThreadCheckHistoryFolder.class);
	static Wini ini;
	static String archivFolder ;
	static String dataFileName 	;
	static String stockFileName ;
	static String printFileName ;
	static int tempo	;
	static int nbrOfDayTokeep ;
	static List<String> lstFileName = new ArrayList<String>();
	
	
	
	private void GetIni() {
		try {
			ini = new Wini(new File("preference.ini"));
		} catch (InvalidFileFormatException e1) {

			logger.fatal("Unable to Read Preference.ini File, check your configuration cause : " + e1.getCause() + "/"
					+ e1.getMessage());
			logger.fatal("Exit Application");
			System.exit(1);

		} catch (IOException e1) {
			logger.fatal("Unable to Read Preference.ini File, check your configuration cause : " + e1.getCause() + "/"
					+ e1.getMessage());
			logger.fatal("Exit Application");
			System.exit(1);

		}
		
	}
	
	public ThreadCheckHistoryFolder(){
			
		GetIni();
    	   		
    		archivFolder		= ini.get("Folders", "ArchiveFolder");
    		dataFileName		= ini.get("Files","DataFileName").replace("*.*", "");
    		stockFileName		= ini.get("Files","StockFileName");
    		printFileName		= ini.get("Files","PrintFileName");
    		tempo				= Integer.valueOf(ini.get("FTP","timer"));
    		nbrOfDayTokeep		= Integer.valueOf(ini.get("Folders","NbrOfDayToKeep"));
    		
    		
    		lstFileName = new ArrayList<String>();
    		
    		lstFileName.add(dataFileName);
    		lstFileName.add(stockFileName);
    		lstFileName.add(printFileName);
    				
    			
	
	}
	
	
	
	public void run() 
	{
		

	//System.out.println("checking history Folder   :"  + config.getiDisplayTimerHistoryFolder());
	PurgeHistoryFolder purging = new PurgeHistoryFolder();
	
	
	purging.purgeFilesFromDirectory(lstFileName,archivFolder,nbrOfDayTokeep);
	
	
	
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
}
    	



    			
    			
    			
    			
    			
    			
    	
		








 

