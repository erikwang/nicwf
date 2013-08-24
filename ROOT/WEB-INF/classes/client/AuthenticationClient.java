package client;
import module.ServiceResult;
import org.apache.axis.client.Call;
import org.apache.axis.client.Service;


import java.io.ByteArrayInputStream; 
import java.io.IOException; 
import java.io.ObjectInputStream; 

public class AuthenticationClient {
	//连接web service url
	private final static String url = "http://122.204.63.90:8080/services/";
	//private final static String url = "http://210.42.24.98:8080/services/";
	private final static String domain = "sf";
	
	/**
		caller:调用者
		callerPassword:调用者密码
		userName:被调用者用户名
		userPassword：被调用者密码
		ServiceResult.getErrorCode() 为0表示成功，其他为失败
	*/
	public static ServiceResult login(String caller,String callerPassword,String userName,String userPassword) {
		try {
			//服务名称
			String endpoint = url+"Authentication";
	
			//**申请代码，以下3行
			Service  service = new Service();
			Call call = (Call) service.createCall();

			call.setTargetEndpointAddress( new java.net.URL(endpoint) );
			//**
			
			
			//获取web service 的具体方法,此项目中只有一个，为get
			call.setOperationName("get");
			
			//填写参数
			Object[] p = new Object[]{domain,userName,userPassword};
			
			//调用远程服务，并填写具体调用过程参数 ，此段代码为：new Object[] {caller,callerPassword,"login",p }
			byte[] buff  = (byte[])call.invoke(new Object[] {domain,caller,callerPassword,"login",p });
			
			//以下三行为得到结果
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
		caller:调用者
		callerPassword:调用者密码
		userName:被调用者用户名
		userPassword：被调用者密码
		ServiceResult.getErrorCode() 为0表示成功，其他为失败
	*/
	public static ServiceResult checkOnline(String caller,String callerPassword,String userName,String userPassword) {
		try {
			//服务名称
			String endpoint = url+"Authentication";
	
			//**申请代码，以下3行
			Service  service = new Service();
			Call call = (Call) service.createCall();

			call.setTargetEndpointAddress( new java.net.URL(endpoint) );
			//**
			
			
			//获取web service 的具体方法,此项目中只有一个，为get
			call.setOperationName("get");
			
			//填写参数
			Object[] p = new Object[]{domain,userName,userPassword};
			
			
			//调用远程服务，并填写具体调用过程参数 ，此段代码为：new Object[] {caller,callerPassword,"checkOnline",p }
			byte[] buff  = (byte[])call.invoke(new Object[] {domain,caller,callerPassword,"checkOnline",p });
			
			
			//以下三行为得到结果
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
		caller:调用者
		callerPassword:调用者密码
		userName:被调用者用户名
		userPassword：被调用者密码
		ServiceResult.getErrorCode() 为0表示成功，其他为失败
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
		得到被调用者可访问的页面资源
		caller:调用者
		callerPassword:调用者密码
		userName:被调用者用户名
		userPassword：被调用者密码
		ServiceResult.getResults()[0]返回Vector<String>对象
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
		检查被调用者是否可访问的某一个页面资源
		userName:被调用者用户名
		userPassword：被调用者密码
		uniqueId: 随机密码
		page：被检查的页面url
		ServiceResult.getErrorCode() 为0表示成功，其他为失败
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
		得到被调用者可访问的业务资源
		userName:被调用者用户名
		userPassword：被调用者密码
		uniqueId: 随机密码
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
		得到被调用者可访问的业务资源
		userName:被调用者用户名
		userPassword：被调用者密码
		uniqueId: 随机密码
		configKey: 配置名称
		ServiceResult.getResults()[0]返回Vector<String>对象，存放名字为configKey的值
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
		得到被调用者可访问的业务资源
		userName:被调用者用户名
		userPassword：被调用者密码
		uniqueId: 随机密码
		newPassword: 配置名称
		ServiceResult.getErrorCode() 为0表示成功，其他为失败
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
				返回该用户可使用的页面资源列，存放在result.getResults()[0]中，数据类型为Vector
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
				只有返回错误代码，没有返回值
			*/
			if (args[0].equals("logout")){
				ServiceResult result = logout(args[1],args[2]);
				System.out.print("error code : ");
				System.out.println(result.getErrorCode());
				System.out.println(result.getDescription());
			}
			
			/*
				返回改用户可用的页面资源（用户必须登录），存放在result.getResults()[0]中，数据类型为Vector
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
				只有返回错误代码，没有返回值
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