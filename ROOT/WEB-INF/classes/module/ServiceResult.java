package module;

import java.io.*;
public class ServiceResult implements Serializable{
	
	
	private int errorCode=0;
	private String description="";
	private Object[] results=null;
	
	
	
	public int getErrorCode(){
		return errorCode;
	}
	
	public void setErrorCode(int ec){
		errorCode = ec;
	}
	
	public void setDescription(String des){
		if (des==null)
			des = "";
		description = des;
	}
	public void setResults(Object[] res){
		results = res;
	}
	
	
	public String getDescription(){
		return description;
	}
	
	public Object[] getResults(){
		return results;
	}
	
}
