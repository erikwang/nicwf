package client;
import module.ServiceResult;
import org.apache.axis.client.Call;
import org.apache.axis.client.Service;


import java.io.ByteArrayInputStream; 
import java.io.IOException; 
import java.io.ObjectInputStream; 

public class AuthenticationClient {
	//����web service url
	private final static String url = "http://122.204.63.90:8080/services/";
	//private final static String url = "http://210.42.24.98:8080/services/";
	private final static String domain = "sf";
	
	/**
		caller:������
		callerPassword:����������
		userName:���������û���
		userPassword��������������
		ServiceResult.getErrorCode() Ϊ0��ʾ�ɹ�������Ϊʧ��
	*/
	public static ServiceResult login(String caller,String callerPassword,String userName,String userPassword) {
		try {
			//��������
			String endpoint = url+"Authentication";
	
			//**������룬����3��
			Service  service = new Service();
			Call call = (Call) service.createCall();

			call.setTargetEndpointAddress( new java.net.URL(endpoint) );
			//**
			
			
			//��ȡweb service �ľ��巽��,����Ŀ��ֻ��һ����Ϊget
			call.setOperationName("get");
			
			//��д����
			Object[] p = new Object[]{domain,userName,userPassword};
			
			//����Զ�̷��񣬲���д������ù��̲��� ���˶δ���Ϊ��new Object[] {caller,callerPassword,"login",p }
			byte[] buff  = (byte[])call.invoke(new Object[] {domain,caller,callerPassword,"login",p });
			
			//��������Ϊ�õ����
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
	
	/**
		caller:������
		callerPassword:����������
		userName:���������û���
		userPassword��������������
		ServiceResult.getErrorCode() Ϊ0��ʾ�ɹ�������Ϊʧ��
	*/
	public static ServiceResult checkOnline(String caller,String callerPassword,String userName,String userPassword) {
		try {
			//��������
			String endpoint = url+"Authentication";
	
			//**������룬����3��
			Service  service = new Service();
			Call call = (Call) service.createCall();

			call.setTargetEndpointAddress( new java.net.URL(endpoint) );
			//**
			
			
			//��ȡweb service �ľ��巽��,����Ŀ��ֻ��һ����Ϊget
			call.setOperationName("get");
			
			//��д����
			Object[] p = new Object[]{domain,userName,userPassword};
			
			
			//����Զ�̷��񣬲���д������ù��̲��� ���˶δ���Ϊ��new Object[] {caller,callerPassword,"checkOnline",p }
			byte[] buff  = (byte[])call.invoke(new Object[] {domain,caller,callerPassword,"checkOnline",p });
			
			
			//��������Ϊ�õ����
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
	
	/**
		caller:������
		callerPassword:����������
		userName:���������û���
		userPassword��������������
		ServiceResult.getErrorCode() Ϊ0��ʾ�ɹ�������Ϊʧ��
	*/
	public static ServiceResult logout(String userName,String userPassword) {
		try {
			String endpoint = url+"Authentication";
	
			Service  service = new Service();
			Call call = (Call) service.createCall();

			call.setTargetEndpointAddress( new java.net.URL(endpoint) );
			call.setOperationName("get");
			Object[] p = new Object[]{domain,userName,userPassword};
			
			byte[] buff  = (byte[])call.invoke(new Object[] {domain,userName,userPassword,"logout",p });
			//System.out.println(result.getDescription());
			ByteArrayInputStream bis =new   ByteArrayInputStream(buff); 
			ObjectInputStream ois = new ObjectInputStream(bis);
			ServiceResult result = (ServiceResult)ois.readObject();
			return result;
		} catch (Exception e) {
			System.err.println(e.toString());
			return null;
		}
	}
	

	
	/**
		�õ��������߿ɷ��ʵ�ҳ����Դ
		caller:������
		callerPassword:����������
		userName:���������û���
		userPassword��������������
		ServiceResult.getResults()[0]����Vector<String>����
	*/
	
	public static ServiceResult getPageResource(String userName,String userPassword,String uniqueId){
		try {
			String endpoint = url+"Authentication";
	
			Service  service = new Service();
			Call call = (Call) service.createCall();

			call.setTargetEndpointAddress( new java.net.URL(endpoint) );
			call.setOperationName("get");
			Object[] p = new Object[]{domain,userName,userPassword,uniqueId,"pages"};
			
			byte[] buff  = (byte[])call.invoke(new Object[] {domain,userName,userPassword,"getResource",p });
			//System.out.println(result.getDescription());
			ByteArrayInputStream bis =new   ByteArrayInputStream(buff); 
			ObjectInputStream ois = new ObjectInputStream(bis);
			ServiceResult result = (ServiceResult)ois.readObject();
			return result;
		} catch (Exception e) {
			System.err.println(e.toString());
			return null;
		}
	}
	
	/**
		��鱻�������Ƿ�ɷ��ʵ�ĳһ��ҳ����Դ
		userName:���������û���
		userPassword��������������
		uniqueId: �������
		page��������ҳ��url
		ServiceResult.getErrorCode() Ϊ0��ʾ�ɹ�������Ϊʧ��
	*/
	
	public static ServiceResult checkPage(String userName,String userPassword,String uniqueId,String page){
		try {
			String endpoint = url+"Authentication";
	
			Service  service = new Service();
			Call call = (Call) service.createCall();

			call.setTargetEndpointAddress( new java.net.URL(endpoint) );
			call.setOperationName("get");
			Object[] p = new Object[]{domain,userName,userPassword,uniqueId,page,"pages"};
			
			byte[] buff  = (byte[])call.invoke(new Object[] {domain,userName,userPassword,"checkResource",p });
			ByteArrayInputStream bis =new   ByteArrayInputStream(buff); 
			ObjectInputStream ois = new ObjectInputStream(bis);
			ServiceResult result = (ServiceResult)ois.readObject();
			return result;
		} catch (Exception e) {
			System.err.println(e.toString());
			return null;
		}
	}
	
	
	/**
		�õ��������߿ɷ��ʵ�ҵ����Դ
		userName:���������û���
		userPassword��������������
		uniqueId: �������
	*/
	/*
	public static ServiceResult getBusinessResource(String userName,String userPassword,String uniqueId){
		try {
			String endpoint = url+"Authentication";
	
			Service  service = new Service();
			Call call = (Call) service.createCall();

			call.setTargetEndpointAddress( new java.net.URL(endpoint) );
			call.setOperationName("get");
			Object[] p = new Object[]{userName,userPassword,uniqueId};
			
			byte[] buff  = (byte[])call.invoke(new Object[] {userName,userPassword,"getBusinessResource",p });
			//System.out.println(result.getDescription());
			ByteArrayInputStream bis =new   ByteArrayInputStream(buff); 
			ObjectInputStream ois = new ObjectInputStream(bis);
			ServiceResult result = (ServiceResult)ois.readObject();
			return result;
		} catch (Exception e) {
			System.err.println(e.toString());
			return null;
		}
	}
	*/
	/**
		�õ��������߿ɷ��ʵ�ҵ����Դ
		userName:���������û���
		userPassword��������������
		uniqueId: �������
		configKey: ��������
		ServiceResult.getResults()[0]����Vector<String>���󣬴������ΪconfigKey��ֵ
	*/
	public static ServiceResult getUserConfigure(String userName,String userPassword,String uniqueId,String configKey){
		try {
			String endpoint = url+"Authentication";
	
			Service  service = new Service();
			Call call = (Call) service.createCall();

			call.setTargetEndpointAddress( new java.net.URL(endpoint) );
			call.setOperationName("get");
			Object[] p = new Object[]{domain,userName,userPassword,uniqueId,configKey};
			
			byte[] buff  = (byte[])call.invoke(new Object[] {domain,userName,userPassword,"getUserConfigure",p });
			//System.out.println(result.getDescription());
			ByteArrayInputStream bis =new   ByteArrayInputStream(buff); 
			ObjectInputStream ois = new ObjectInputStream(bis);
			ServiceResult result = (ServiceResult)ois.readObject();
			return result;
		} catch (Exception e) {
			System.err.println(e.toString());
			return null;
		}
	}
	
	/**
		�õ��������߿ɷ��ʵ�ҵ����Դ
		userName:���������û���
		userPassword��������������
		uniqueId: �������
		newPassword: ��������
		ServiceResult.getErrorCode() Ϊ0��ʾ�ɹ�������Ϊʧ��
	*/
	public static ServiceResult modifyUserPassword(String userName,String userPassword,String uniqueId,String newPassword){
		try {
			String endpoint = url+"Authentication";
	
			Service  service = new Service();
			Call call = (Call) service.createCall();

			call.setTargetEndpointAddress( new java.net.URL(endpoint) );
			call.setOperationName("get");
			Object[] p = new Object[]{domain,userName,userPassword,uniqueId,newPassword};
			
			byte[] buff  = (byte[])call.invoke(new Object[] {domain,userName,userPassword,"modifyUserPassword",p });
			//System.out.println(result.getDescription());
			ByteArrayInputStream bis =new   ByteArrayInputStream(buff); 
			ObjectInputStream ois = new ObjectInputStream(bis);
			ServiceResult result = (ServiceResult)ois.readObject();
			return result;
		} catch (Exception e) {
			System.err.println(e.toString());
			return null;
		}
	}
	
	public static void main(String[] args){
		if (args.length<3){
			System.out.println("java Authentication USERNAME USERPASSWORD");
			
		}else {
			/*
				���ظ��û���ʹ�õ�ҳ����Դ�У������result.getResults()[0]�У���������ΪVector
			*/
			if (args[0].equals("login")){
				ServiceResult result = login("public","public",args[1],args[2]);
		
				//java.util.Vector<String> pages = (java.util.Vector<String>)result.getResults()[0];
				
				if (result.getErrorCode()==0){
					Object o = result.getResults()[0];
					String uniqueId= (String)o;
		
					System.out.println(uniqueId);
				}else {
					System.out.print("error code : ");
					System.out.println(result.getErrorCode());
					System.out.println(result.getDescription());
				}
			}
			
			/*
				ֻ�з��ش�����룬û�з���ֵ
			*/
			if (args[0].equals("logout")){
				ServiceResult result = logout(args[1],args[2]);
				System.out.print("error code : ");
				System.out.println(result.getErrorCode());
				System.out.println(result.getDescription());
			}
			
			/*
				���ظ��û����õ�ҳ����Դ���û������¼���������result.getResults()[0]�У���������ΪVector
			*/
			if (args[0].equals("getPageResource")){
				ServiceResult result = getPageResource(args[1],args[2],args[3]);
		
				if (result.getErrorCode()==0){
					Object o = result.getResults()[0];
					java.util.Vector pages = null;
					pages = (java.util.Vector)o;
		
					for (int i=0;i<pages.size();i++)
						System.out.println(pages.get(i));
				}else {
					System.out.print("error code : ");
					System.out.println(result.getErrorCode());
					System.out.println(result.getDescription());
				}
			}
			/*
				ֻ�з��ش�����룬û�з���ֵ
			*/
			
			if (args[0].equals("checkPage")){
				ServiceResult result = checkPage(args[1],args[2],args[3],args[4]);
				System.out.print("error code : ");
				System.out.println(result.getErrorCode());
				System.out.println(result.getDescription());
			}
			/*
			if (args[0].equals("getBusinessResource")){
				ServiceResult result = getBusinessResource(args[1],args[2],args[3]);
				java.util.Vector ss = (java.util.Vector)result.getResults()[0];
				for (int i=0;i<ss.size();i++)
					System.out.println(ss.get(i));
				System.out.print("error code : ");
				System.out.println(result.getErrorCode());
				System.out.println(result.getDescription());
			}
			*/
			if (args[0].equals("checkOnline")){
				ServiceResult result = checkOnline("public","public",args[1],args[2]);
				System.out.println(result.getDescription());
			}
			if (args[0].equals("getConfigure")){
				ServiceResult result = getUserConfigure(args[1],args[2],args[3],args[4]);
				System.out.println(result.getDescription());
				if (result.getErrorCode()==0)
					System.out.println(((java.util.Vector)(result.getResults()[0])).get(0));
			}
			if (args[0].equals("modifyUserPassword")){
				ServiceResult result = modifyUserPassword(args[1],args[2],args[3],args[4]);
				System.out.println(result.getDescription());
				
			}
		}
	}
}