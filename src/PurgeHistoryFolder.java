import java.io.File;
import java.util.Calendar;
import java.util.List;
import org.apache.log4j.Logger;
import com.file.FileProperty;

import java.text.SimpleDateFormat;



public class PurgeHistoryFolder {
	

	
	
	static Logger logger = Logger.getLogger(PurgeHistoryFolder.class);

	

	public void purgeFilesFromDirectory(List<String> lstFileName,String directoryPath, int NbrOfDayToKeep) {

logger.info("Purging Archives Folder :" + directoryPath + "\\*.zip");
		
	FileProperty fileToDelete=null;
	Calendar calendar=Calendar.getInstance();
	//définir le format de la date
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy/MM/dd H:mm:ss");
	 
	 String today=sdf.format(calendar.getTime());
	  
	 
	 calendar.add(calendar.DAY_OF_MONTH,-NbrOfDayToKeep);
	 String filterDay=sdf.format(calendar.getTime());
	 
for (String fileName : lstFileName) {	

	try{ 
logger.info("check file :" + fileName);
	 
	 File directory = new File(directoryPath + "\\");
			
			if (!directory.exists()) {
				logger.warn("File or directory doesn't exist : " + directory);
							} else if (!directory.isDirectory()) {
				logger.warn("Srouce is not a directory : " + directory);
				
			} else{   
	     
	ListDataManager ldm=new ListDataManager(directoryPath + "\\", fileName + "*.*");
	ldm.sortFilesLeft();
	logger.info("size of ListDataManager = " + ldm.getFilesLeftSize());


	for (int i=0;i<ldm.getFilesLeftSize();i++){

	File subfile = ldm.getCurrentFile();
					
	
	logger.info("found file : " + subfile.getName());

	String fileNametoCheck=directoryPath + "\\" +  subfile.getName();    
	FileProperty fichier=new FileProperty(fileNametoCheck);

	//si le fichier n'est pas dans la plage de date correspondant au filtre alors on ne le stocke pas dans le tableau.
	
	
	logger.info("compare date file :" + fichier.getFormatedDate() + " with " + filterDay);
	logger.info("difference day = :" + filterDay.compareTo(fichier.getFormatedDate()));
	
	
	
	if (filterDay.compareTo(fichier.getFormatedDate())>0){
		logger.info("date du fichier " + fichier.getFormatedDate().toString());
		logger.info("date à comparer : " + filterDay.toString());
		logger.info("fichier.getFormatedDate().compareTo(filterDay)>0   ?  :" + fichier.getFormatedDate().compareTo(filterDay));
		logger.info("le fichier :" + fileNametoCheck + " est en date du jours ");
	    
	    
	   
	   fileToDelete=new FileProperty(directoryPath + "\\" + subfile.getName().toString());
		
	   
	   logger.info("deleting History file : " + fileToDelete.getPathFilename());
			 
	   
	   fileToDelete.deleteFile();
	    
	    
	}

	ldm.nextFile();    


	}
	                }
	            

	
	 
	 }
	 catch(java.lang.Exception err){
	// vect.add(err.getMessage());
		logger.error("error in java Class ==> purgeHistoryFolder when trying to delete file" + fileToDelete.getFileName());
	    
	 	 }      
	   
	
	
	
	}
	
	}
	
	
	
	
	
	
	
}
