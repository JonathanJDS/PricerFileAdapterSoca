
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.PrintStream;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.StringTokenizer;
import java.util.Timer;
import java.util.TimerTask;
import java.util.TreeSet;

import org.apache.log4j.Logger;
import org.ini4j.InvalidFileFormatException;
import org.ini4j.Wini;

import com.file.FileProperty;


public class ThreadCheckStockFiles extends Thread {

	static Logger logger = Logger.getLogger(Start.class);

	static Wini ini;
	static String archiveFolder ;
	static String stockFileName;
	static String sourceFolder;
	static String temporaryFolder;
	static String adapterType;
	static String pricerDataFilesFolder;
	static String pricerMessageFilesFolder;
	static String pricerResultFilesFolder;
	static int tempo;
	
	
	Timer timer = new Timer();
	
	
	public ThreadCheckStockFiles() {

		logger.info("Starting Thread ThreadCheckDataFiles");

		GetIni();

		adapterType					= ini.get("Application", "AdapterType");
		archiveFolder 				= ini.get("Folders", "ArchiveFolder");
		stockFileName 				= ini.get("Files", "StockFileName");
		sourceFolder 				= ini.get("Folders", "SourceFolder");
		temporaryFolder 			= ini.get("Folders", "TemporaryFolder");
		tempo 						= Integer.valueOf(ini.get("FTP", "timer"));
		pricerDataFilesFolder 		= ini.get("Folders", "PricerDataFiles");
		pricerMessageFilesFolder 	= ini.get("Folders", "PricerMessageFiles");
		pricerResultFilesFolder		= ini.get("Folders", "PricerResultFiles");
		

	
		
		
		
		TimerTask task = new TimerTask() {
			@Override
			public void run() {
				
				ArrayList<String> lstFiles =  listFilesFromDirectory(sourceFolder + "\\",stockFileName);
				
					for (String fileNameFilter : lstFiles) {
					
						ZipFile (sourceFolder, fileNameFilter);
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
        String natureDuProduit;
        String quantiteEnStock;
        String uniteQuantiteEnStock;
        String encoursDeCommande;
        String uniteEncoursDeCommande;
        String dateProchaineLivraison;
        String prochaineQuantitéLivre;
        String uniteProchaineQuantiteLivre;
        String UVCparCarton;
        String fondDeRayon;
        String nbreJoursReserve;
        String quantiteDeReserve;
        String uniteQuantiteDeReserve;
        String etatCentraleEtatMagasin;
        String dateDerniereVente;
        String qteDerniereVente;
        String uniteDerniereVente;
        String numeroDePese;
        String designationAffichette;
        String provenance;
        String categorie;
        String variete;
        String calibre;
        String codePays;
        String libellePays;
        String traitement;
        String qteLot;
        String contenanceArticle;
        String uniteDeContenance;
        String taille;
        String colori;
        String gondole;
        String element;
        String niveau;
        String gondole2;
        String libelle2;
        String libelle3;
        
       
        
        
        dataFileName_Update		=	pricerDataFilesFolder		+ "\\"	+ "data_stock_" + dateOfFile + ".i1";
        messageFileName_Update	=	pricerMessageFilesFolder	+ "\\"	+ "data_stock_" + dateOfFile + ".m1";
        resultFileName_Update	=	pricerResultFilesFolder		+ "\\"	+ "data_stock_" + dateOfFile + ".r7";
        
        
        contentMessageFile_Update = "UPDATE,0001,," + dataFileName_Update + "," + resultFileName_Update;
       
		
		if (!fpTemporaryFile.FileExist() == true ) {
			logger.debug("temporary file is empty");
			return;
			
		}
		
		
		if (fpTemporaryFile.fileIsGrowing()==true) {
			
			logger.warn("file is growing waiting... : " + temporaryFile);
			return ;
		}
		
		
		
		
		
		List<String> lstMapFile = fpTemporaryFile.fileToMap();
		
		
		
		for (String line : lstMapFile) {
			
			//System.out.println("line = " + line);
			
			if (line.trim().equals("")) {
			continue;
			}
			
			
			List<String> splitedTabLine = splitLine(line, ";");
			if (splitedTabLine.size() < 15) {
				continue;
			}
			
		
			
			 
			  try {
			 
				  if (bdatafile_Update_opened==false){
				  
					datafile_Update=new PrintStream(new BufferedOutputStream(new FileOutputStream(dataFileName_Update,true)),true);
					//System.out.println("dataFileName_Update =" + dataFileName_Update);
					bdatafile_Update_opened=true;
				  }
		    	
		    }
		    	catch (FileNotFoundException e) {
		    		logger.fatal("File Not Found, Unable to create File : " + dataFileName_Update );
		    		return;
		    	}
		 
			
			
			completeLine = new StringBuffer(); 
			
	try {		
		
		
		
		  ean 									= splitedTabLine.get(2).trim();
	      natureDuProduit						= splitedTabLine.get(7).trim();
	      quantiteEnStock						= splitedTabLine.get(14).trim();
	      uniteQuantiteEnStock					= splitedTabLine.get(15).trim();
	      encoursDeCommande						= splitedTabLine.get(18).trim().replace(",","");
	      uniteEncoursDeCommande				= splitedTabLine.get(19).trim();
	      dateProchaineLivraison				= splitedTabLine.get(22).trim();
	      prochaineQuantitéLivre				= splitedTabLine.get(23).trim();
	      uniteProchaineQuantiteLivre			= splitedTabLine.get(24).trim();
	      UVCparCarton							= String.valueOf(Integer.parseInt(splitedTabLine.get(25))).trim();
	      fondDeRayon							= String.valueOf(Integer.parseInt(splitedTabLine.get(26))).trim();
	      nbreJoursReserve						= String.valueOf(Integer.parseInt(splitedTabLine.get(27))).trim();
	      quantiteDeReserve						= String.valueOf(Integer.parseInt(splitedTabLine.get(28))).trim();
	      uniteQuantiteDeReserve				= splitedTabLine.get(29).trim();
	      etatCentraleEtatMagasin				= splitedTabLine.get(30).trim() + splitedTabLine.get(30).trim();
	      dateDerniereVente						= splitedTabLine.get(32).trim();
	      qteDerniereVente						= splitedTabLine.get(33).trim().replace(",", "");
	      uniteDerniereVente					= splitedTabLine.get(34).trim();	
	      numeroDePese							= splitedTabLine.get(35).trim();
	      designationAffichette					= splitedTabLine.get(36).trim().replace("'", "`");
	      provenance							= splitedTabLine.get(37).trim();
	      categorie								= splitedTabLine.get(38).trim();
	      variete								= splitedTabLine.get(39).trim();
	      calibre								= splitedTabLine.get(40).trim();
	      codePays								= splitedTabLine.get(41).trim();
	      libellePays							= splitedTabLine.get(42).trim();
	      traitement							= splitedTabLine.get(43).trim();
	      qteLot								= splitedTabLine.get(44).trim();
	      contenanceArticle						= splitedTabLine.get(45).trim();
	      uniteDeContenance						= splitedTabLine.get(46).trim();
	      taille								= splitedTabLine.get(47).trim();
	      colori								= splitedTabLine.get(48).trim();
	      gondole								= splitedTabLine.get(49).trim();
	      element								= splitedTabLine.get(50).trim();
	      niveau								= splitedTabLine.get(51).trim();
	      gondole2								= splitedTabLine.get(3).trim();
	      libelle2								= splitedTabLine.get(11).trim().replace("'", "`");
	      libelle3								= splitedTabLine.get(12).trim().replace("'", "`");
	              
         
         completeLine.append("0001 ").append(ean);
         completeLine.append(" 340 0 |").append(natureDuProduit);
         completeLine.append("| 323 0 |").append(quantiteEnStock);
         completeLine.append("| 325 0 |").append(uniteQuantiteEnStock);
         completeLine.append("| 341 0 |").append(encoursDeCommande);
         completeLine.append("| 342 0 |").append(uniteEncoursDeCommande);
         completeLine.append("| 321 0 |").append(dateProchaineLivraison);
         completeLine.append("| 320 0 |").append(prochaineQuantitéLivre);
         completeLine.append("| 326 0 |").append(uniteProchaineQuantiteLivre);
         completeLine.append("| 327 0 |").append(UVCparCarton);
         completeLine.append("| 318 0 |").append(fondDeRayon);
         completeLine.append("| 343 0 |").append(nbreJoursReserve);
         completeLine.append("| 344 0 |").append(quantiteDeReserve);
         completeLine.append("| 345 0 |").append(uniteQuantiteDeReserve);
         completeLine.append("| 4 0 |").append(etatCentraleEtatMagasin);
         completeLine.append("| 346 0 |").append(dateDerniereVente);
         completeLine.append("| 322 0 |").append(qteDerniereVente);
         completeLine.append("| 328 0 |").append(uniteDerniereVente);
         completeLine.append("| 400 0 |").append(numeroDePese);
         completeLine.append("| 401 0 |").append(designationAffichette);
         completeLine.append("| 402 0 |").append(provenance);
         completeLine.append("| 403 0 |").append(categorie);
         completeLine.append("| 404 0 |").append(variete);
         completeLine.append("| 405 0 |").append(calibre);
         completeLine.append("| 406 0 |").append(codePays);
         completeLine.append("| 407 0 |").append(libellePays);
         completeLine.append("| 408 0 |").append(traitement);
         completeLine.append("| 409 0 |").append(qteLot);
         completeLine.append("| 410 0 |").append(contenanceArticle);
         completeLine.append("| 411 0 |").append(uniteDeContenance);
         completeLine.append("| 412 0 |").append(taille);
         completeLine.append("| 413 0 |").append(colori);
         completeLine.append("| 414 0 |").append(gondole);
         completeLine.append("| 415 0 |").append(element);
         completeLine.append("| 416 0 |").append(niveau);
         completeLine.append("| 417 0 |").append(gondole2);
         completeLine.append("| 418 0 |").append(libelle2);
         completeLine.append("| 419 0 |").append(libelle3);
         
         
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
		
	try {	
		System.out.println("delete file " + temporaryFolder + "\\" + stockFileName);
		new File(temporaryFolder + "\\" + stockFileName).delete();
	}
	
	catch (Exception ex) {
		logger.error("Unable to delete File :" + temporaryFolder + "\\" + stockFileName);
		
	}
		
		
		
	}
	
	
	
	
	
	
	
	
	
	
	@SuppressWarnings("resource")
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
        
        
        
        
        String ean;
        String quantiteEnStock;
        String uniteStock;
        String date;
        String quantiteCommande;
        String unitCommande;
        String UVCparCarton;
        String quantiteVendue;
        String uniteQuantiteVendue;
        String commandable;
        String stockOptimal;
        
        
        dataFileName_Update		=	pricerDataFilesFolder		+ "\\"	+ "data_stock_" + dateOfFile + ".i1";
        messageFileName_Update	=	pricerMessageFilesFolder	+ "\\"	+ "data_stock_" + dateOfFile + ".m1";
        resultFileName_Update	=	pricerResultFilesFolder		+ "\\"	+ "data_stock_" + dateOfFile + ".r7";
        
        
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
		List<String> lstFile  =	new ArrayList<String>();
		String[] lineSplited2 = null;
		List<String> lstItems;

		
		logger.info("Purging gest file, getting linked items ... ");

		TreeSet<String> lstLinkedItems = new OperationOnDB().lstLinkedItems();
		
		for(String line : lstMapFile) {
			
			lineSplited2 = line.split(";");
			
		lstItems = new ArrayList<String>();
		lstItems.add(lineSplited2[0].trim());
			
				for(String itemid : lstItems) {
					
					if(lstLinkedItems.contains(itemid)) {
						lstFile.add(line);
					}
					
				}
			
			
			
		}
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		for (String line : lstFile) {
			
			//System.out.println("line = " + line);
			
			if (line.trim().equals("")) {
			continue;
			}
			
			
			List<String> splitedTabLine = splitLine(line, ";");
			if (splitedTabLine.size() < 10) {
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
		
		
		
		ean 				= splitedTabLine.get(0);
		quantiteEnStock		= splitedTabLine.get(1).trim();
		uniteStock			= splitedTabLine.get(2).trim();
		date				= splitedTabLine.get(3).trim();
		
		
		if (splitedTabLine.get(4).equals("")) {
			
			quantiteCommande	= splitedTabLine.get(4).trim();	
		}
		else {
		
			quantiteCommande 	= splitedTabLine.get(4).trim().replace("-", "");
		}
		
				
		unitCommande		= splitedTabLine.get(5).trim();
		UVCparCarton		= String.valueOf(Integer.parseInt(splitedTabLine.get(6))).trim();		
		quantiteVendue		= String.valueOf(Integer.parseInt(splitedTabLine.get(7))).trim();	
		uniteQuantiteVendue	= splitedTabLine.get(8).trim();
		commandable			= splitedTabLine.get(9).trim();
		stockOptimal		= String.valueOf(Integer.parseInt(splitedTabLine.get(10))).trim();	
        
         
         completeLine.append("0001 ").append(ean);
         completeLine.append(" 323 0 |").append(quantiteEnStock);
         completeLine.append("| 325 0 |").append(uniteStock);
         completeLine.append("| 321 0 |").append(date);
         completeLine.append("| 320 0 |").append(quantiteCommande);
         completeLine.append("| 326 0 |").append(unitCommande);
         completeLine.append("| 327 0 |").append(UVCparCarton);
         completeLine.append("| 322 0 |").append(quantiteVendue);
         completeLine.append("| 328 0 |").append(uniteQuantiteVendue);
         completeLine.append("| 4 0 |").append(commandable);
         completeLine.append("| 318 0 |").append(stockOptimal);
         
         completeLine.append("|,");
         
         
        // System.out.println( completeLine.toString());
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
		
		
		System.out.println("delete file " + temporaryFolder + "\\" + stockFileName);
		new File(temporaryFolder + "\\" + stockFileName).delete();
	
		
		
		
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
		FileProperty fpTempFile = new FileProperty(temporaryFolder + "\\" + stockFileName);
		
if (fpTempFile.FileExist() == false) {
		if (fpCurrentFile.FileExist()) {

			if (fpCurrentFile.fileIsGrowing() == false) {

				dateOfFile = new SimpleDateFormat("yyyyMMdd_Hmmss").format(new Date());
				//fpCurrentFile.zipFile(archiveFolder + "\\" + stockFileName + "_" + dateOfFile + ".zip");
				fpCurrentFile.zipFile(archiveFolder, sourceFile + "_" + dateOfFile + ".zip");

				

			}
		}
}
	
	
	else if (fpCurrentFile.FileExist() && fpTempFile.FileExist()){
		logger.warn("unable to zip file : " +  completeFileName);
		logger.warn(stockFileName + " is already present into temporary folder, waiting for end of threatment...");

	}
}

	static void ProcessFiles(FileProperty fpFile) {

		System.out.println("Processing File : " + fpFile.getFileName());

	}

	private static List<String> splitLine(String sLine, String sSeparator) {
		
		List<String> lSplitLine = new ArrayList<String>();
		String tmp;
		boolean pipetmp = false;
		int j = 0;
		
		StringTokenizer st = new StringTokenizer(sLine, sSeparator, true);
		while (st.hasMoreTokens()) {
			
			tmp = st.nextToken();
			if (tmp.equals(sSeparator)) {
				if (pipetmp == true) {
					lSplitLine.add("");
					j++;
				}
				pipetmp = true;
			} else {
				pipetmp = false;
				lSplitLine.add(tmp);
				
				j++;
			}
		}
		j = 0;
		
		return lSplitLine;
	}

	public static boolean isNumeric(String str) {
		try {
			double d = Double.parseDouble(str);
		} catch (NumberFormatException nfe) {
			return false;
		}
		return true;
	}

}
