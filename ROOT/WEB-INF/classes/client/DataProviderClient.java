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
	//����web service url
	private final static String url = "http://122.204.63.90:8080/services/";
	//private final static String url = "http://210.42.24.98:8080/services/";
	private final static String domain = "sf";
	
	/**	
		
		userName:������
		userPassword������������
		mn�������õ�ģ������
		fName�������õĺ���
		parameters����������б�
		ע�����û������¼
	*/
	public static ServiceResult getData(String userName,String userPassword,String uniqueId,String mn,String fName,Object parameters[]) {
		try {
			//��������
			String endpoint = url+"DataProvider";
	
			//**������룬����3��
			Service  service = new Service();
			Call call = (Call) service.createCall();
			call.setTargetEndpointAddress( new java.net.URL(endpoint) );
			
			//��ȡweb service �ľ��巽��,����Ŀ��ֻ��һ����Ϊget
			call.setOperationName("get");
			//��д����
			Object[] p = new Object[]{domain,userName,userPassword,uniqueId,mn,fName,parameters};
			
			//����11��Ϊ���л��������
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
			
			//���÷���
			buff  = (byte[])call.invoke(new Object[]{buff});
			//System.out.println(result.getDescription());
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
	
	
	
	public static void main(String[] args){
		/* --------------- ȡ��ϵͳʱ�������
		ServiceResult result = getData(args[0],args[1],"SystemTimer","getNow",null);
		if (result.getErrorCode()==0){
			//long now = (long)result.getResults()[0];
			System.out.println(result.getResults()[0]);
		}else {
			System.out.println(result.getDescription());
		}------------------*/
		//---------------------------------------------------------------------------------------------
		/*
		//----------------ȡ��ҵ������
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
		//--------------------���Դ洢����
		/*
		String[] pp = new String[]{"aaaaa1","aaaaa2","1123"};
		//"SISDEST.FUNC_INSERTZCZT" : ������
		//new Integer(java.sql.Types.VARCHAR): ������������,�뺯���йأ���Ҫ֪�������ķ������ͣ�Ȼ��ָ����Ӧ��java����
		//pp����Ҫ����Ĳ���
		Object[] p = new Object[]{"SISDEST.FUNC_INSERTZCZT",new Integer(java.sql.Types.VARCHAR),pp};
		ServiceResult result = getData(args[0],args[1],args[2],"DBConnectionPool","executeFunction",p);
		System.out.println(result.getDescription());
		if (result.getErrorCode()==0){
		}
		*/
		//----------------------
		
	
		//---------------------------------------------------------------------------------------------
		//����Ϊ�������ݿ������
		
		//sql���Ϊselect * from dhcp_block where gateway='210.42.24.254';
		//�������Ϊ"210.42.26.254"
		//����sql����
		String[] pp = new String[]{};
		
		//����web service����
		Object[] p = new Object[]{"select count(*) from sisdest.v_xsjbxx",pp};
		
		//����DBConnectionPool,�е�executeQuery����������Ϊp
		ServiceResult result = getData(args[0],args[1],args[2],"DBConnectionPool","executeQuery",p);
		
		
		//��ӡ��������
		System.out.println(result.getDescription());
		//�жϷ����Ƿ�ִ�гɹ�����������sql����Ƿ�ִ�гɹ���sql����Ƿ�ִ�гɹ���Ǳ�����ResultData�ṹ��
		if (result.getErrorCode()==0){
			//�õ�sql����ִ�н��
			db.ResultData rData = (db.ResultData)result.getResults()[0];
			//�õ����ص�����
			String[] colNames = rData.getCollumName();
			//�õ��������ݣ�������ʽΪ2ά����,����ṹΪVector<Vector>
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
	
	//�ݹ����ҵ���裬ҵ����Ϊ���ṹ
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