package client;

import java.util.*;

public class User{
	private String userName=null;
	private String userPassword=null;
	private String userUniqueId=null;
	private Vector<String[]> parameterList;
	
	public User(String un,String up,String uui){
		userName = un;
		userPassword = up;
		userUniqueId = uui;
		parameterList = new Vector<String[]>();
	}
	
	public String getUserName(){
		return userName;
	}
	
	public String getUserPassword(){
		return userPassword;
	}
	
	public String getUserUniqueId(){
		return userUniqueId;
	}
	
	public void setUserPassword(String newPwd){
		if (newPwd==null)
			newPwd = "";
			userPassword = newPwd;
	}
	
	synchronized public boolean addParameter(String pKey,String pValue){
		if (pKey==null)
			return false;
		int index = getParameterIndex(pKey);
		if (index>=0)
			return false;
		String[] p = new String[2];
		p[0]=pKey;
		p[1]=pValue;
		parameterList.add(p);
		return true;
	}
	
	private int getParameterIndex(String pKey){
		if (pKey==null)
			return -1;
		for (int i=0;i<parameterList.size();i++){
			String[] p = parameterList.get(i);
			if (p.length==2){
				if (pKey.equals(p[0]))
					return i;
			}
		}
		return -1;
	}
	
	synchronized public String getParameterValue(String pKey){
		if (pKey==null)
			return null;
		int index = getParameterIndex(pKey);
		if (index>=0)
			return parameterList.get(index)[1];
		return null;
	}
	
	synchronized public boolean modifyParameterValue(String pKey,String value){
		if (pKey==null)
			return false;
		int index = getParameterIndex(pKey);
		if (index>=0){
			parameterList.get(index)[1]=value;
			return true;
		}
		return false;
	}
}