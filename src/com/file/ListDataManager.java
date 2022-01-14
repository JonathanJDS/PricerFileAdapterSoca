package com.file;



import java.io.File;
import java.io.FilenameFilter;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Comparator;
import java.util.List;

public class ListDataManager {

	private String sourcePathName;

	private String patternData;
	private String patternFlag;
	private int filesLeftSize;
	private int currentIdList;
	private List<String> filesLeft;
       

    
        
	public ListDataManager () {
		
		filesLeft = null;
		filesLeftSize = 0;
		setCurrentIdList(0);
		setFilesLeftSize();
	
	}
	
	public ListDataManager (String pathToLookFor, String patternFile) {
		super();
		sourcePathName = pathToLookFor;
		patternData = patternFile;
		filesLeft = populateFilesLeft();
                setFilesLeftSize();
	}

	
	
	public File getCurrentFile () {
		return new File(filesLeft.get(getCurrentIdList()));
	}
	
	public void sortFilesLeft () {
		File[] files = new File[this.getFilesLeftSize()];
		for (int i = 0; i < this.getFilesLeftSize(); i++) {
			files[i] = new File(this.getSourcePathName() + this.getFilesLeft().get(i));
		}

		Arrays.sort(files, new Comparator<File>(){
		    public int compare(File f1, File f2)
		    {
		        return Long.valueOf(f1.lastModified()).compareTo(f2.lastModified());
		    } });

		List <String> tempLeftFiles  = new ArrayList<String>(); 
		for (int i = 0; i < filesLeftSize; i++){
			tempLeftFiles.add(i, files[i].getName());
		}
		
		if (tempLeftFiles != null)
			this.setFilesLeft(tempLeftFiles);
	}
	
	public void nextFile () {
		filesLeft.remove(getCurrentFile());
		this.setCurrentIdList(this.getCurrentIdList() + 1);
	}
	
	private boolean flagIsPresent() {
		File fDir = new File(sourcePathName + patternFlag);
		return fDir.isFile();
	}
	
	private List<String> populateFilesLeft() {
		File fDir = new File(sourcePathName);
		FilenameFilter ffFilter = new FilenameFilter() {
			
		
			public boolean accept(File fDir, String sName) {
								
				return ((sName.matches(patternData)));
			}
		};
		return Arrays.asList(fDir.list(ffFilter));
	}
	
	private void setFilesLeftSize () {
		filesLeftSize = (filesLeft == null) ? 0 : filesLeft.size();   
	}
	
	public void clearFilesLeft() {
		filesLeft = null;
		filesLeftSize = 0;
		currentIdList = 0;
	}
	
	/**
	 * @return the filesLeftSize
	 */
	public int getFilesLeftSize() {
		return filesLeftSize;
	}

	/**
	 * @return the filesLeft
	 */
	public List<String> getFilesLeft() {
		return filesLeft;
	}


	/**
	 * @param filesLeft the filesLeft to set
	 */
	public void setFilesLeft(List<String> filesLeft) {
		this.filesLeft = filesLeft;
	}

	/**
	 * @return the currentIdList
	 */
	public int getCurrentIdList() {
		return this.currentIdList;
	}

	/**
	 * @param currentIdList the currentIdList to set
	 */
	public void setCurrentIdList(int currentIdList) {
		this.currentIdList = currentIdList;
	}
	
	/**
	 * @return the sourcePathName
	 */
	public String getSourcePathName() {
		return sourcePathName;
	}
        
        
        
    
}
