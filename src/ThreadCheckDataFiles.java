
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.PrintStream;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.StringTokenizer;
import java.util.Timer;
import java.util.TimerTask;
import org.apache.log4j.Logger;
import org.ini4j.InvalidFileFormatException;
import org.ini4j.Wini;

import com.file.FileProperty;


public class ThreadCheckDataFiles extends Thread {

	static Logger logger = Logger.getLogger(Start.class);

	static Wini ini;
	static String archiveFolder ;
	static String dataFileName;
	static String sourceFolder;
	static String temporaryFolder;
	static String adapterType;
	static String pricerDataFilesFolder;
	static String pricerMessageFilesFolder;
	static String pricerResultFilesFolder;
	static HashMap<String, String> mapRayon;
	static int tempo;
	
	
	Timer timer = new Timer();
	
	
	public ThreadCheckDataFiles() {

		logger.info("Starting Thread ThreadCheckDataFiles");

		GetIni();

		adapterType					= ini.get("Application", "AdapterType");
		archiveFolder 				= ini.get("Folders", "ArchiveFolder");
		dataFileName 				= ini.get("Files", "DataFileName");
		sourceFolder 				= ini.get("Folders", "SourceFolder");
		temporaryFolder 			= ini.get("Folders", "TemporaryFolder");
		tempo 						= Integer.valueOf(ini.get("FTP", "timer"));
		pricerDataFilesFolder 		= ini.get("Folders", "PricerDataFiles");
		pricerMessageFilesFolder 	= ini.get("Folders", "PricerMessageFiles");
		pricerResultFilesFolder		= ini.get("Folders", "PricerResultFiles");

	 mapRayon = new HashMap<String,String>();
		
		
		for (String key : ini.get("SHELVESNAME").keySet())
        {
            //System.out.println("sleepy/" + key + " = " + ini.get("ESL_FORCED_POSITION").fetch(key));
			mapRayon.put(key, ini.get("SHELVESNAME").fetch(key));
        }
		
		
		
		
		TimerTask task = new TimerTask() {
			@Override
			public void run() {
System.out.println("start task datafile");


ArrayList<String> lstFiles =  listFilesFromDirectory(sourceFolder + "\\",dataFileName);



			for (String fileNameFilter : lstFiles) {
			


					ZipFile (sourceFolder + "\\", fileNameFilter);
					MoveFile(sourceFolder + "\\" + fileNameFilter,temporaryFolder + "\\" + fileNameFilter);
						
						if (adapterType.equalsIgnoreCase("0")) {
								ProcessFileSocamil(temporaryFolder + "\\" + fileNameFilter);
						}
				
						else if (adapterType.equalsIgnoreCase("1")) {
							ProcessFileSocamaine(temporaryFolder + "\\" + fileNameFilter);	
						}
					
				
				
			}
	
		}

			
			

			

		};

		timer.scheduleAtFixedRate(task, 0, tempo * 1000);
	}

	
	
	
	
	
	private void ProcessFileSocamaine(String temporaryFile) {

		
		FileProperty fpTemporaryFile = new FileProperty(temporaryFile);
	    boolean bdatafile_Update_opened=false;
	    String dataFileName_Update		=	null;
        String messageFileName_Update	=	null;
        String resultFileName_Update	=	null;
        PrintStream datafile_Update		=	null;
        String contentMessageFile_Update=	null;
       	PrintStream messagefile_Update	=	null;
        SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd_Hmmss");
        Date d = new Date(); 
        String dateOfFile		=	sdf.format(d);
        StringBuffer completeLine ;
        
        
        
        
        String ean;
        String libelle;
        String priceEuro;
        String codeTVA;
        String saisieQuantiteObligatoire;
        String saisiePrixDeVente;
        String articleChaineSurUnAutre;
        String originPrice;
        String articleConsigneYN;
        String articleConsigneValue;
        String rayon;
        String famille;
        String sousFamille;
        String unitePriceEuro;
        String unitCode;
        String flagDEEE;
        
        String montantDEEE;
        String prixUnitaireLot;
        String promoFlag;
        String itemSize;
        dataFileName_Update		=	pricerDataFilesFolder		+ "\\"	+ "data_price_" + dateOfFile + ".i1";
        messageFileName_Update	=	pricerMessageFilesFolder	+ "\\"	+ "data_price_" + dateOfFile + ".m1";
        resultFileName_Update	=	pricerResultFilesFolder		+ "\\"	+ "data_price_" + dateOfFile + ".r7";
        
        
        contentMessageFile_Update = "UPDATE,0001,," + dataFileName_Update + "," + resultFileName_Update;
        
      
		
			
        
		
		if (!fpTemporaryFile.FileExist() == true ) {
			logger.debug("temporary file is empty");
			return;
			
		}

		
		
		if (fpTemporaryFile.fileIsGrowing()==true) {
			
			logger.warn("file is growing waiting... : " + temporaryFile);
			return ;
		}
		
		
		System.out.println("let's GO!!!" );
		
		
		List<String> lstMapFile = fpTemporaryFile.fileToMap();
		
		
		
		for (String line : lstMapFile) {
			
			//System.out.println("line = " + line);
			
			if (line.trim().equals("")) {
			continue;
			}
			
			if(line.contains("Erreur Element MART")) {
				logger.warn("lines with \"Erreur Element MART\" " + line + "  on the file : " +temporaryFile);
				continue;
			}
			
			
			List<String> splitedTabLine = splitLine(line, ";");
			if (splitedTabLine.size() < 15) {
				continue;
			}
			
		
			
			 
			  try {
			 
				  if (bdatafile_Update_opened==false){
				  
					datafile_Update=new PrintStream(new BufferedOutputStream(new FileOutputStream(dataFileName_Update,true)),true);
					System.out.println("dataFileName_Update =" + dataFileName_Update);
					bdatafile_Update_opened=true;
				  }
		    	
		    }
		    	catch (FileNotFoundException e) {
		    		logger.fatal("File Not Found, Unable to create File : " + dataFileName_Update );
		    		return;
		    	}
		 
			
			
			completeLine = new StringBuffer(); 
			
	try {	
		
		//if(!splitedTabLine.get(14).equalsIgnoreCase("Erreur Element MART")) {
		
		
		 ean 							= splitedTabLine.get(1);
         libelle						= splitedTabLine.get(2).replace("'", "`");
         
         
       if(splitedTabLine.get(3) != null && splitedTabLine.get(3) != "")
         priceEuro						= String.valueOf(Integer.parseInt(splitedTabLine.get(3).trim().replace(".", "")));
        else
        priceEuro = "0000000";
         
         
         codeTVA						= splitedTabLine.get(4);
         saisieQuantiteObligatoire		= splitedTabLine.get(5).substring(0,1);
         saisiePrixDeVente				= splitedTabLine.get(5).substring(1,2);
         articleChaineSurUnAutre		= splitedTabLine.get(5).substring(2,3);		
         articleConsigneYN				= splitedTabLine.get(6);	
         originPrice					= splitedTabLine.get(7);
         articleConsigneValue			= splitedTabLine.get(8);
         rayon							= mapRayon.get(splitedTabLine.get(9).trim());
         famille						= splitedTabLine.get(10);
         sousFamille					= splitedTabLine.get(11);
 
         unitePriceEuro					= String.valueOf(Integer.parseInt(splitedTabLine.get(12).trim().substring(0, 8).replace(".", "")));
         unitCode						= splitedTabLine.get(12).substring(8,9);
         flagDEEE						= splitedTabLine.get(12).substring(17,18);
         montantDEEE					= splitedTabLine.get(12).substring(9,17);
         prixUnitaireLot				= splitedTabLine.get(12).substring(18,26);
         promoFlag						= splitedTabLine.get(12).substring(26,27);
         itemSize						= splitedTabLine.get(12).substring(28,40).trim();		
         
         
         completeLine.append("0001 ").append(ean);
         completeLine.append(" 7 0 |").append(libelle);
         completeLine.append("| 23 0 |").append(priceEuro);
         completeLine.append("| 47 0 |").append(codeTVA);
         completeLine.append("| 48 0 |").append(saisieQuantiteObligatoire);
         completeLine.append("| 49 0 |").append(saisiePrixDeVente);
         completeLine.append("| 50 0 |").append(articleChaineSurUnAutre);
         completeLine.append("| 51 0 |").append(articleConsigneYN);
         completeLine.append("| 52 0 |").append(originPrice);
         completeLine.append("| 53 0 |").append(articleConsigneValue);
         completeLine.append("| 5 0 |").append(rayon);
         completeLine.append("| 6 0 |").append(famille);
         completeLine.append("| 3 0 |").append(sousFamille);
         completeLine.append("| 45 0 |").append(unitePriceEuro); 
         completeLine.append("| 71 0 |").append(unitCode); 
         
         if (flagDEEE.equalsIgnoreCase("1")) {
         completeLine.append("| 35 0 |").append(montantDEEE); 
         }
         
         else {
        	 completeLine.append("| 35 0 |"); 
        	 
         }
         
                  
         completeLine.append("| 34 0 |").append(flagDEEE); 
         completeLine.append("| 46 0 |").append(prixUnitaireLot); 
         completeLine.append("| 37 0 |").append(promoFlag); 
         completeLine.append("| 12 0 |").append(itemSize);
         completeLine.append("|,");
         
         
        // System.out.println( completeLine.toString());
         datafile_Update.println(completeLine.toString());
         datafile_Update.flush();

	//}
		//else	
		//logger.warn("lines with \"Erreur Element MART\" " + line + "  on the file : " +temporaryFile);
        
        	   }
       
		 catch (IndexOutOfBoundsException indx){
			logger.warn("line empty or out of bound...." + line);
		
			 
		 } 
			
		}
		
		
		if (bdatafile_Update_opened==true){
	 		datafile_Update.close(); 
	 		try {
				messagefile_Update=new PrintStream(new BufferedOutputStream(new FileOutputStream(messageFileName_Update)),true);
			} catch (FileNotFoundException e) {
				logger.fatal("unable to create Message File : " + e.getMessage() + ":" + e.getCause());
				
			}
	
	messagefile_Update.print(contentMessageFile_Update);	
	messagefile_Update.flush();
	messagefile_Update.close();
	
		}
		
		
	System.out.println("delete file " + temporaryFolder + "\\" + dataFileName);
	//new File(temporaryFolder + "\\" + dataFileName).delete();
	File fileToDelete = new File(temporaryFile);
	if(fileToDelete.delete()) 
    { 
        System.out.println("File deleted successfully"); 
    } 
    else
    { 
        System.out.println("Failed to delete the file"); 
    } 
	
		
	}
	
	
	
	
	
	
	
	
	
	
	
	
	private void ProcessFileSocamil(String temporaryFile) {
		
		FileProperty fpTemporaryFile = new FileProperty(temporaryFile);
	    boolean bdatafile_Update_opened=false;
	    String dataFileName_Update		=	null;
        String messageFileName_Update	=	null;
        String resultFileName_Update	=	null;
        PrintStream datafile_Update		=	null;
        String contentMessageFile_Update=	null;
       	PrintStream messagefile_Update	=	null;
        SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd_Hmmss");
        Date d = new Date(); 
        String dateOfFile		=	sdf.format(d);
        StringBuffer completeLine ;
        
        
        
        
        String ean = "";
        String libelle = "";
        String priceEuro = "";
        String codeTVA = "";
        String saisieQuantiteObligatoire = "";
        String saisiePrixDeVente = "";
        String articleChaineSurUnAutre = "";
        String originPrice = "";
        String articleConsigneYN = "";
        String articleConsigneValue = "";
        String rayon = "";
        String famille = "";
        String sousFamilleString= "";
        String unitePriceEuro = "";
        String unitCode = "";
        String ancienPrixAvantPromo = "";
        String flagAncienPrixPromo = "";
        String prixUnitaireLot = "";
        String promoFlag = "";
        String itemSize = "";
        String DEEE = "";
        String supplier = "";
        String margeArticle ="";
        String Free = "";
        String sousFamille = "";
        
        
        
        
        
        
        
        dataFileName_Update		=	pricerDataFilesFolder		+ "\\"	+ "data_price_" + dateOfFile + ".i1";
        messageFileName_Update	=	pricerMessageFilesFolder	+ "\\"	+ "data_price_" + dateOfFile + ".m1";
        resultFileName_Update	=	pricerResultFilesFolder		+ "\\"	+ "data_price_" + dateOfFile + ".r7";
        
        
        contentMessageFile_Update = "UPDATE,0001,," + dataFileName_Update + "," + resultFileName_Update;
        
      
		
			
        
		
		if (!fpTemporaryFile.FileExist() == true ) {
			logger.debug("temporary file is empty");
			return;
			
		}
		
		
		if (fpTemporaryFile.fileIsGrowing()==true) {
			
			logger.warn("file is growing waiting... : " + temporaryFile);
			return ;
		}
		
		
		System.out.println("let's GO!!!" );
		
		
		List<String> lstMapFile = fpTemporaryFile.fileToMap();
		
		
		
		for (String line : lstMapFile) {
			
			System.out.println("line = " + line);
			
			if (line.trim().equals("")) {
			continue;
			}
			
			if(line.contains("Erreur Element MART")) {
				logger.warn("lines with \"Erreur Element MART\" " + line + "  on the file : " +temporaryFile);
				continue;
			}
			
			
			List<String> splitedTabLine = splitLine(line, ";");
			if (splitedTabLine.size() < 15) {
				continue;
			}
			
		
			
			 
			  try {
			 
				  if (bdatafile_Update_opened==false){
				  
					datafile_Update=new PrintStream(new BufferedOutputStream(new FileOutputStream(dataFileName_Update,true)),true);
					System.out.println("dataFileName_Update =" + dataFileName_Update);
					bdatafile_Update_opened=true;
				  }
		    	
		    }
		    	catch (FileNotFoundException e) {
		    		logger.fatal("File Not Found, Unable to create File : " + dataFileName_Update );
		    		return;
		    	}
		 
			
			
			completeLine = new StringBuffer(); 
			
	try {		
		
		if(splitedTabLine.get(0).equalsIgnoreCase("U"))
		
		{
		 ean 							= splitedTabLine.get(1);
         libelle						= splitedTabLine.get(2).replace("'", "`");
         priceEuro						= String.valueOf(Integer.parseInt(splitedTabLine.get(3).trim().replace(".", "")));
         codeTVA						= splitedTabLine.get(4);
         saisieQuantiteObligatoire		= splitedTabLine.get(5).substring(0,1);
         saisiePrixDeVente				= splitedTabLine.get(5).substring(1,2);
         articleChaineSurUnAutre		= splitedTabLine.get(5).substring(2,3);		
         articleConsigneYN				= splitedTabLine.get(6);	
         originPrice					= splitedTabLine.get(7);
         articleConsigneValue			= splitedTabLine.get(8);	
         rayon							= splitedTabLine.get(9);
         famille						= splitedTabLine.get(10);
         sousFamille					= splitedTabLine.get(11);
         unitePriceEuro					= String.valueOf(Integer.parseInt(splitedTabLine.get(12).trim().substring(0, 8).replace(".", "")));
         unitCode						= splitedTabLine.get(12).substring(8,9);
         ancienPrixAvantPromo			= splitedTabLine.get(12).substring(9,17);
         flagAncienPrixPromo			= splitedTabLine.get(12).substring(17,18);
         prixUnitaireLot				= splitedTabLine.get(12).substring(18,26);
         promoFlag						= splitedTabLine.get(12).substring(26,27);
         itemSize						= splitedTabLine.get(12).substring(28,40).trim();		
         DEEE							= String.valueOf(Integer.parseInt(splitedTabLine.get(12).trim().substring(41, 48).replace(".", "")));
         supplier						= splitedTabLine.get(12).substring(48,72).trim();	
         margeArticle					= splitedTabLine.get(12).substring(72,73);
         Free							= splitedTabLine.get(12).substring(73,80);
         
		}
		else {
			ean 					= splitedTabLine.get(1);
		}

         
         completeLine.append("0001 ").append(ean);
         completeLine.append(" 7 0 |").append(libelle);
         completeLine.append("| 23 0 |").append(priceEuro);
         completeLine.append("| 47 0 |").append(codeTVA);
         completeLine.append("| 48 0 |").append(saisieQuantiteObligatoire);
         completeLine.append("| 49 0 |").append(saisiePrixDeVente);
         completeLine.append("| 50 0 |").append(articleChaineSurUnAutre);
         completeLine.append("| 51 0 |").append(articleConsigneYN);
         completeLine.append("| 52 0 |").append(originPrice);
         completeLine.append("| 53 0 |").append(articleConsigneValue);
         completeLine.append("| 5 0 |").append(rayon);
         completeLine.append("| 6 0 |").append(famille);
         completeLine.append("| 3 0 |").append(sousFamille);
         completeLine.append("| 45 0 |").append(unitePriceEuro); 
         completeLine.append("| 71 0 |").append(unitCode); 
         completeLine.append("| 54 0 |").append(ancienPrixAvantPromo); 
         completeLine.append("| 55 0 |").append(flagAncienPrixPromo); 
         completeLine.append("| 46 0 |").append(prixUnitaireLot); 
         completeLine.append("| 37 0 |").append(promoFlag); 
         completeLine.append("| 12 0 |").append(itemSize);
         completeLine.append("| 35 0 |").append(DEEE);
         completeLine.append("| 9 0 |").append(supplier);
         completeLine.append("| 57 0 |").append(margeArticle);
         completeLine.append("| 56 0 |").append(Free);
         completeLine.append("|,");
         
         
         System.out.println( completeLine.toString());
         datafile_Update.println(completeLine.toString());
         datafile_Update.flush();

        
        	   }
        	  
     
	 
		
		 
		 catch (IndexOutOfBoundsException indx){
			logger.warn("line empty or out of bound...." + line);
		
			 
		 } 
			
		}
		
		
		if (bdatafile_Update_opened==true){
	 		datafile_Update.close(); 
	 		try {
				messagefile_Update=new PrintStream(new BufferedOutputStream(new FileOutputStream(messageFileName_Update)),true);
			} catch (FileNotFoundException e) {
				logger.fatal("unable to create Message File : " + e.getMessage() + ":" + e.getCause());
				
			}
	 messagefile_Update.print(contentMessageFile_Update);	
	 messagefile_Update.flush();
	 messagefile_Update.close();
	 	}
		
		
		System.out.println("delete file " + temporaryFile);
		File fileToDelete = new File(temporaryFile);
		if(fileToDelete.delete()) 
        { 
            System.out.println("File deleted successfully"); 
        } 
        else
        { 
            System.out.println("Failed to delete the file"); 
        } 
	
		
		
		
	}

	
	
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
	
	
	
	private void MoveFile(String source, String destination) {
		
		
		FileProperty fpSourceFile = new FileProperty(source);
	  
		if (fpSourceFile.FileExist()) {
		
		if (!fpSourceFile.moveToFolder(destination)) {
		  
		  logger.warn("Unable to copy file to destination : " + destination);
		  logger.warn("waiting for end of threatment...");
	  }
		
		
		}
		
		
		else {
			logger.debug("source file not present : " + source);
			logger.debug("nothing to do ....");
			
		}
		
	}
		
	

	private static void ZipFile(String sourceFolder,String sourceFile) {

		String dateOfFile ;			
		String completeFileName = sourceFolder + "\\" + sourceFile;
				
		
		FileProperty fpCurrentFile = new FileProperty(completeFileName);
		FileProperty fpTempFile = new FileProperty(temporaryFolder + "\\" + sourceFile);
		
if (fpTempFile.FileExist() == false) {
		if (fpCurrentFile.FileExist()) {

		
			while(fpCurrentFile.fileIsGrowing()) {
				
				logger.warn("file is growing waiting for end of threatment... " + fpCurrentFile.getFileName());
			}
			
			
			if (fpCurrentFile.fileIsGrowing() == false) {

				dateOfFile = new SimpleDateFormat("yyyyMMdd_Hmmss").format(new Date());
				fpCurrentFile.zipFile(archiveFolder, sourceFile + "_" + dateOfFile + ".zip");
			}
		
			
		}
}
	
	
	else if (fpCurrentFile.FileExist() && fpTempFile.FileExist()){
		logger.warn("unable to zip file : " +  completeFileName);
		logger.warn(dataFileName + " is already present into temporary folder, waiting for end of threatment...");

	}




}

	static void ProcessFiles(FileProperty fpFile) {

		System.out.println("Processing File : " + fpFile.getFileName());

	}
	
	
	  static ArrayList<String> listFilesFromDirectory(String directoryPath,String filterName) {
	    	 
    	  System.out.println("filtername = " + filterName);

	    	try{ 

	    	 ArrayList<String> data=new ArrayList<String>();
	    	  
	    	 File directory = new File(directoryPath);
	    			
	    	 
	    	 
	    	 
	    			if (!directory.exists()) {
	    				logger.warn("File Or Directory '" + directoryPath + "' doesn't exist !!!!");
	    				
	    			} else if (!directory.isDirectory()) {
	    				logger.warn("PATH Of  '" + directoryPath + "' is a File, not a Folder !!!!");
	    			} else{   
	    	     
	    	ListDataManager ldm=new ListDataManager(directoryPath, filterName);
	    	ldm.sortFilesLeft();



	    	for (int i=0;i<ldm.getFilesLeftSize();i++){

	    	File subfile = ldm.getCurrentFile();
	    					
	    	


	    	String fileName= subfile.getName();    
	    	   
	    	    data.add(fileName);
	       	System.out.println("found file : " + fileName);
	    	   
	    	    
	    	    ldm.nextFile();    


	    	}
	    	                }
	    	            

	    	 return data;  
	    	 
	    	 }
	    	 catch(java.lang.Exception err){
	    	// vect.add(err.getMessage());
	    	
	    		 logger.warn(err.getMessage() + " , detail :" + err.getCause());
	    	  return null;
	    	 }      
	    	}
	

	private static List<String> splitLine(String sLine, String sSeparator) {
		
		List<String> lSplitLine = new ArrayList<String>();
		String tmp;
		boolean pipetmp = false;
		StringTokenizer st = new StringTokenizer(sLine, sSeparator, true);
		while (st.hasMoreTokens()) {
			
			tmp = st.nextToken();
			if (tmp.equals(sSeparator)) {
				if (pipetmp == true) {
					lSplitLine.add("");
				}
				pipetmp = true;
			} else {
				pipetmp = false;
				lSplitLine.add(tmp);
			}
		}
		return lSplitLine;
	}

	public static boolean isNumeric(String str) {
		try {
			Double.parseDouble(str);
		} catch (NumberFormatException nfe) {
			return false;
		}
		return true;
	}

}
