import java.io.*;
import java.util.zip.*;
 

public class Test {
	
	
	public static void main(String[] args) {
		/*
		 * String server = "localhost"; int port = 21; String user = "pricer"; String
		 * password = "pricer"; final String filterName = "FICWLST005"; String
		 * dirToSearch = "/Export_EVO_C";
		 * 
		 * 
		 * OperationOnFTP operationOnFTP = new OperationOnFTP(server, port, user,
		 * password) ;
		 * 
		 * FTPFile[] files = operationOnFTP.GetListFiles(dirToSearch, filterName);
		 * 
		 * if (files != null && files.length > 0) {
		 * System.out.println("SEARCH RESULT:"); for (FTPFile aFile : files) {
		 * System.out.println("founf file : " + aFile.getName()); } }
		 * 
		 * 
		 * operationOnFTP.disconnect();
		 * 
		 * 
		 */
		
	 

	 
	        
	    	String INPUT_FILE = "C:\\FTP\\FICWLST005";
		    String OUTPUT_FILE = "C:\\FTP\\FICWLST005.zip";
	    	zipFile(new File(INPUT_FILE), OUTPUT_FILE);
		
	}
	
	
		public static void zipFile(File inputFile, String zipFilePath) {
	        try {
	 
	            // Wrap a FileOutputStream around a ZipOutputStream
	            // to store the zip stream to a file. Note that this is
	            // not absolutely necessary
	            FileOutputStream fileOutputStream = new FileOutputStream(zipFilePath);
	            ZipOutputStream zipOutputStream = new ZipOutputStream(fileOutputStream);
	 
	            // a ZipEntry represents a file entry in the zip archive
	            // We name the ZipEntry after the original file's name
	            ZipEntry zipEntry = new ZipEntry(inputFile.getName());
	            zipOutputStream.putNextEntry(zipEntry);
	 
	            FileInputStream fileInputStream = new FileInputStream(inputFile);
	            byte[] buf = new byte[1024];
	            int bytesRead;
	 
	            // Read the input file by chucks of 1024 bytes
	            // and write the read bytes to the zip stream
	            while ((bytesRead = fileInputStream.read(buf)) > 0) {
	                zipOutputStream.write(buf, 0, bytesRead);
	            }
	 
	            // close ZipEntry to store the stream to the file
	            zipOutputStream.closeEntry();
	 
	            zipOutputStream.close();
	            fileOutputStream.close();
	 
	            System.out.println("Regular file :" + inputFile.getCanonicalPath()+" is zipped to archive :"+zipFilePath);
	 
	        } catch (IOException e) {
	            e.printStackTrace();
	        }
	 
	    }
		
	
	        
	}


