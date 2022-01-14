package com.file;
import java.io.File;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.LinkedList;
import javax.swing.JFileChooser;

import org.apache.log4j.Logger;

import java.io.BufferedReader;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.UnsupportedEncodingException;
import java.util.zip.ZipEntry;
import java.util.zip.ZipOutputStream;


/**
 * read property of a file

 * @author mohamed.derraz
 */
public class FileProperty {
	static Logger logger = Logger.getLogger(FileProperty.class);
    
private File file = null;

    /**
     * Contructor
     * @param filename path+file 
     */
    public FileProperty(String filename) {
        file = new File(filename);
    }

   public boolean FileExist(){
	   boolean value=false;
	   
	 if (file.exists()==true) {
		 value= true;
	 }
	 if (file.exists()==false) {
		 value= false;
	 }   
   
	 return value;
   
   }
   
    
    
    /**
     * read date of file
     * @return
     */
    public long getDate() {
        return this.file.lastModified();
    }

    /**
     * Afficher la date du fichier
     * @return date au format dd/m/yyyy H:mm:ss
     */
    public String getFormatedDate() {
        //SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy H:mm:ss");
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy/MM/dd H:mm:ss");
        Date d = new Date(this.file.lastModified());
        return sdf.format(d);
    }

    
    
    public String getZipFileNameFormatedWithTodayDate() {
        //SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy H:mm:ss");
        SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd_Hmmss");
       // Date d = new Date(this.file.lastModified());
        Date d = new Date(); 
        return sdf.format(d);
    }
    
    public boolean bIsDateFileToday(){
        
     boolean value=false;
        SimpleDateFormat tdf = new SimpleDateFormat("yyyy/MM/dd");
         
     String Today=tdf.format(Calendar.getInstance().getTime());
     String TodayFile=tdf.format(new Date(this.file.lastModified()));
     
     if (TodayFile.equals(Today)==true){ value=true ;}
     if (TodayFile.equals(Today)!=true){ value=false ;}
     
     
     return value;
    
    
    }
    
    
    
    
    
    public String getFileName(){
    	return file.getName();
    }
    
    
    
    public boolean moveToFolder(String fileName){
      
    File destFileName = new File(fileName);
    
    
    if (destFileName.exists()==false) {	
    	boolean success = file.renameTo(new File(fileName));
    	return success;
       
    }
    
    
    else {
    	
    	return false;
    	
    }
    
    }
    
  
   
    
    
    
    
    
	
	public boolean zipFile(String zipFilePath, String zipFileName) {
        try {
 

            FileOutputStream fileOutputStream = new FileOutputStream(zipFilePath + "\\" + zipFileName);
            ZipOutputStream zipOutputStream = new ZipOutputStream(fileOutputStream);
 
            ZipEntry zipEntry = new ZipEntry(this.file.getName());
            zipOutputStream.putNextEntry(zipEntry);
 
            FileInputStream fileInputStream = new FileInputStream(this.file);
            byte[] buf = new byte[1024];
            int bytesRead;
 
            // Read the input file by chucks of 1024 bytes
            // and write the read bytes to the zip stream
            while ((bytesRead = fileInputStream.read(buf)) > 0) {
                zipOutputStream.write(buf, 0, bytesRead);
            }
 
            // close ZipEntry to store the stream to the file
            
            
            fileInputStream.close();
            zipOutputStream.closeEntry();
 
            zipOutputStream.close();
            fileOutputStream.close();
 
            System.out.println("Regular file :" + this.file.getCanonicalPath()+" is zipped to archive :"+zipFilePath);
 
        } catch (IOException e) {
            e.printStackTrace();
            return false;
        }
        return true;
 
    }
	
    
    
    
    
	/*
	 * public boolean zipFile(String destinationFileName) {
	 * 
	 * byte[] buffer = new byte[1024];
	 * 
	 * 
	 * 
	 * try{
	 * 
	 * 
	 * 
	 * 
	 * 
	 * 
	 * FileOutputStream fos = new FileOutputStream(destinationFileName);
	 * 
	 * ZipOutputStream zos = new ZipOutputStream(fos);
	 * 
	 * 
	 * //System.out.println("new zip Entry : " + file.getName());
	 * 
	 * logger.info("Trying to zip source file :" + file.getPath() + "//" +
	 * file.getName()); ZipEntry ze= new ZipEntry(file.getName());
	 * 
	 * 
	 * zos.putNextEntry(ze);
	 * 
	 * logger.info("destination zip file : " + destinationFileName); FileInputStream
	 * in = new FileInputStream(destinationFileName);
	 * 
	 * int len; while ((len = in.read(buffer)) > 0) { zos.write(buffer, 0, len); }
	 * 
	 * in.close(); zos.closeEntry();
	 * 
	 * //remember close it zos.close();
	 * 
	 * 
	 * logger.info("Zip file ok "); }catch(IOException ex){ ex.printStackTrace();
	 * return false; }
	 * 
	 * 
	 * return true;
	 * 
	 * 
	 * 
	 * }
	 */
    
    
    
    public boolean deleteFile() {
    	
    	

        // Make sure the file or directory exists and isn't write protected
        if (!this.file.exists())
         logger.error("Delete: no such file or directory: " + file.getName());
        	
        if (!file.canWrite()) {
          
        	logger.error("Delete: write protected: " + file.getName());
        	return false;
        
        }
        // If it is a directory, make sure it is empty
        if (file.isDirectory()) {
          String[] files = file.list();
          if (files.length > 0)
            
        	  logger.error("Delete: directory not empty: " + file.getName());
        return false;	  
        }

        // Attempt to delete it
        boolean success = file.delete();

        
      
        return success;
    }
    	
    	
    	
    		
    
    
    /**
     * Taille du fichier
     * @return unitÃ© byte
     */
    public Long getSize() {
        return this.file.length();
    }

    /**
     * Afficher la taille
     * @return taille au format xx Ko ou xx Mo
     */
    public String getFormatedSize() {
        int size = (int) (this.file.length() / 1024) + 1;
        if (size > 1024) {
            return (size / 1024) + " Mo";
        } else {
            return size + " ko";
        }
    }

    /**
     * Type du fichier
     * @return par exemple Image bitmap
     */
    public String getType() {
        JFileChooser chooser = new JFileChooser();
        return chooser.getTypeDescription(this.file);
    }

   

    
    
    /**
     * Extraire le nom du fichier sans l'extension
     * @param filename.xxx
     * @return filename
     */
    public String getFileNameWithoutExt() {
        
    	int pos = this.file.getName().lastIndexOf(".");
    	
        if (pos > -1) {
            return this.file.getName().substring(0,pos);
        } else {
            return this.file.getName().toString();
        }


}
    
    
    public String getFileExt() {
        
    	
    	int pos = file.getName().lastIndexOf(".");
        if (pos > -1) {
            return file.getName().substring(pos);
        } else {
            return file.getName();
        }


}
    
    

public boolean fileIsGrowing(){
		long initialModifiedValue = file.length();
		System.out.println("initial vallue of " + file.toString() + "=" + initialModifiedValue);
		try {
		
                    Thread.sleep(2000);
			if (initialModifiedValue < file.length()) {
				System.out.println("file " + file.getPath() + file.getName() + " is growing.....");
                            return true;
			} else {
				System.out.println("file is ok");
				return false;
			}
		} catch (InterruptedException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			
                        return false;
		}
	}    
    
  

public String getPathFilename(){

	
	return this.file.getPath();
	
	
	
}



/* put the content of file into a tab (Linked List) 
 * 
 * 
 * */
public  LinkedList<String> fileToMap(){

LinkedList<String> map=new LinkedList<String>();
	
long count =0;
	try {
		
		
		File filDir=new File(file.getPath());
		BufferedReader in = new BufferedReader(  new InputStreamReader( new FileInputStream(filDir)));
		
		String str;
		 
		while ((str = in.readLine()) != null) {
		    map.add(str);
		}
		
			
			str="";
			count=count+1;
			 in.close();
			 	
		}
		
		


catch (IOException e) 
{
	System.out.println(e.getMessage());

}
catch (Exception e)
{
	System.out.println(e.getMessage());
}

	return  map;  

}

}






