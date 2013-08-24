package test;

import javax.xml.namespace.QName;

import org.apache.axis2.AxisFault;
import org.apache.axis2.addressing.EndpointReference;
import org.apache.axis2.client.Options;
import org.apache.axis2.rpc.client.RPCServiceClient;

import java.util.Vector;
import java.io.*;

import wit.user.*;


//页面加载
import wit.client.RPCClient;
import module.ServiceResult;

public class Test{

	public static void main(String[] argvs)throws Exception{
                ServiceResult rs = RPCClient.call(	"http://210.42.24.34:8080/axis2/services/User",
                					"http://user.ws",
                					"login",
                					//new Object{"aaa","aaa"}
                					new Object[]{new UserInfo("public","public",""),new UserInfo("2004020779","2008","")});
                System.out.println(rs.getDescription());
                
                UserInfo uInfo=null;
                if (rs.getErrorCode()==0){
			uInfo = (UserInfo)(rs.getResults()[0]);
			System.out.println(uInfo.getParameterValue("name"));
			System.out.println(uInfo.getParameterValue("usergroup"));
			System.out.println(uInfo.getParameterValue("private_level"));
			long t1 = System.currentTimeMillis();
			rs = RPCClient.call(	"http://210.42.24.34:8080/axis2/services/StudInfo",
					"http://studinfo.ws",
					"getRoomsByCollege",
					new Object[]{uInfo,"03"});
			long t2 = System.currentTimeMillis()-t1;
                	System.out.println(rs.getDescription());
                	if (rs.getErrorCode()==0){
                		//得到李主任的数据结构
                		Vector vct = (Vector)(rs.getResults()[0]);
                		System.out.println(vct.size());
                		for (int i=0;i<vct.size();i++){
                			Object[] msg = (Object[])(vct.get(i));
                			for (int j=0;j<msg.length;j++){
                				System.out.print(msg[j]+"---");
                			}
                			System.out.println();
                		}
                	}
                	System.out.println(t2);
		}
		
		
	}
}