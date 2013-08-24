package wit.module;

import module.ServiceResult;
import wit.user.*;
import org.apache.axis.client.Call;
import org.apache.axis.client.Service;

import java.io.ByteArrayInputStream; 
import java.io.IOException; 
import java.io.ObjectInputStream; 

import java.io.ByteArrayOutputStream; 
import java.io.IOException; 
import java.io.ObjectOutputStream;

import wit.util.ObjectModule;

public class WITService{
	private final static String url = "http://122.204.63.90:8080/services/";

	private final static String domain = "zc";

	public static ServiceResult getData(String userName,String userPassword,String uniqueId,String mn,String fName,Object parameters[]) {
		try {

			String endpoint = url+"DataProvider";
	

			Service  service = new Service();
			Call call = (Call) service.createCall();
			call.setTargetEndpointAddress( new java.net.URL(endpoint) );
			

			call.setOperationName("get");
			
			Object[] p = new Object[]{domain,userName,userPassword,uniqueId,mn,fName,parameters};
			

			ServiceResult inBuff = new ServiceResult();
			inBuff.setResults(p);
			byte[] buff=null;
			try{
				ByteArrayOutputStream bos=new ByteArrayOutputStream();
				ObjectOutputStream oos = new ObjectOutputStream(bos);
				oos.writeObject(inBuff);
				buff = bos.toByteArray();
				oos.close();
			}catch(Exception e){
			}
			

			buff  = (byte[])call.invoke(new Object[]{buff});
			ByteArrayInputStream bis =new   ByteArrayInputStream(buff); 
			ObjectInputStream ois = new ObjectInputStream(bis);
			ServiceResult result = (ServiceResult)ois.readObject();
			ois.close();
			return result;
		} catch (Exception e) {
			System.err.println(e.toString());
			return null;
		}
	}
}