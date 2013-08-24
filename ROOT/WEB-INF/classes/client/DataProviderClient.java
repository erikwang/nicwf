package client;
import module.ServiceResult;
import org.apache.axis.client.Call;
import org.apache.axis.client.Service;

import java.io.ByteArrayInputStream; 
import java.io.IOException; 
import java.io.ObjectInputStream; 

import java.io.ByteArrayOutputStream; 
import java.io.IOException; 
import java.io.ObjectOutputStream;
import java.util.Vector;

public class DataProviderClient {
	//连接web service url
	private final static String url = "http://122.204.63.90:8080/services/";
	//private final static String url = "http://210.42.24.98:8080/services/";
	private final static String domain = "sf";
	
	/**	
		
		userName:调用者
		userPassword：调用者密码
		mn：被调用的模块名称
		fName：本调用的函数
		parameters：带入参数列表
		注：该用户必须登录
	*/
	public static ServiceResult getData(String userName,String userPassword,String uniqueId,String mn,String fName,Object parameters[]) {
		try {
			//服务名称
			String endpoint = url+"DataProvider";
	
			//**申请代码，以下3行
			Service  service = new Service();
			Call call = (Call) service.createCall();
			call.setTargetEndpointAddress( new java.net.URL(endpoint) );
			
			//获取web service 的具体方法,此项目中只有一个，为get
			call.setOperationName("get");
			//填写参数
			Object[] p = new Object[]{domain,userName,userPassword,uniqueId,mn,fName,parameters};
			
			//以下11行为序列化传入参数
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
			
			//调用服务
			buff  = (byte[])call.invoke(new Object[]{buff});
			//System.out.println(result.getDescription());
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
	
	
	
	public static void main(String[] args){
		/* --------------- 取得系统时间的例子
		ServiceResult result = getData(args[0],args[1],"SystemTimer","getNow",null);
		if (result.getErrorCode()==0){
			//long now = (long)result.getResults()[0];
			System.out.println(result.getResults()[0]);
		}else {
			System.out.println(result.getDescription());
		}------------------*/
		//---------------------------------------------------------------------------------------------
		/*
		//----------------取得业务描述
		ServiceResult result = getData(args[0],args[1],args[2],"Business","getBusinessDescription",new Object[]{"TestBusiness"});
		if (result.getErrorCode()==0){
			//long now = (long)result.getResults()[0];
			ext.BusinessDescription bd = (ext.BusinessDescription)result.getResults()[0];
			scanBusinessStep(bd.getSteps());
		}else {
			System.out.println(result.getDescription());
		}
		-----------------*/
		//---------------------------------------------------------------------------------------------
		//--------------------测试存储函数
		/*
		String[] pp = new String[]{"aaaaa1","aaaaa2","1123"};
		//"SISDEST.FUNC_INSERTZCZT" : 函数名
		//new Integer(java.sql.Types.VARCHAR): 带出参数类型,与函数有关，需要知道函数的返回类型，然后指定相应的java类型
		//pp：需要带入的参数
		Object[] p = new Object[]{"SISDEST.FUNC_INSERTZCZT",new Integer(java.sql.Types.VARCHAR),pp};
		ServiceResult result = getData(args[0],args[1],args[2],"DBConnectionPool","executeFunction",p);
		System.out.println(result.getDescription());
		if (result.getErrorCode()==0){
		}
		*/
		//----------------------
		
	
		//---------------------------------------------------------------------------------------------
		//以下为调用数据库的例子
		
		//sql语句为select * from dhcp_block where gateway='210.42.24.254';
		//带入参数为"210.42.26.254"
		//生成sql参数
		String[] pp = new String[]{};
		
		//声称web service参数
		Object[] p = new Object[]{"select count(*) from sisdest.v_xsjbxx",pp};
		
		//调用DBConnectionPool,中的executeQuery方法，参数为p
		ServiceResult result = getData(args[0],args[1],args[2],"DBConnectionPool","executeQuery",p);
		
		
		//打印返回描述
		System.out.println(result.getDescription());
		//判断服务是否执行成功，但不代表sql语句是否执行成功，sql语句是否执行成功标记保存在ResultData结构中
		if (result.getErrorCode()==0){
			//得到sql语句的执行结果
			db.ResultData rData = (db.ResultData)result.getResults()[0];
			//得到返回的列名
			String[] colNames = rData.getCollumName();
			//得到返回数据，保存形式为2维数组,保存结构为Vector<Vector>
			java.util.Vector<java.util.Vector> datas = rData.getDatas();
			if (datas!=null){
				for (int i=0;i<datas.size();i++){
					java.util.Vector row = (java.util.Vector)datas.get(i);
					for (int j=0;j<colNames.length;j++){
						System.out.print(row.get(j));
						System.out.print("---");
					}
					System.out.println();
				}
			}else System.out.println(rData.getDescription());
		}
		
	}
	

	/*
	
	//递归遍历业务步骤，业务步骤为树结构
	private static void scanBusinessStep(ext.BusinessStep bs){
		if (bs==null)
			return;
		Vector<ext.BusinessStepGroup> bsgList = bs.getGroups();
		for (int i=0;i<bsgList.size();i++)
			System.out.println(bsgList.get(i).getView());
		for (int i=0;i<bs.getNextStep().size();i++){
			
			scanBusinessStep(bs.getNextStep().get(i));
		}
	}
	*/
}