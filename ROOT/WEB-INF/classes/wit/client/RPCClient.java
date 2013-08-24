package wit.client;

import javax.xml.namespace.QName;

import org.apache.axis2.AxisFault;
import org.apache.axis2.addressing.EndpointReference;
import org.apache.axis2.client.Options;
import org.apache.axis2.rpc.client.RPCServiceClient;

//import org.apache.axiom.om.OMElement;
import java.io.*;


import wit.util.ObjectModule;
import module.ServiceResult;

public class RPCClient{
	public static ServiceResult call(String epr,String qname,String m,Object[] parameters)throws Exception{
		EndpointReference targetEPR = new EndpointReference(epr);
		RPCServiceClient   serviceClient   =   new   RPCServiceClient(); 
                Options   options   =   serviceClient.getOptions(); 
                options.setTo(targetEPR);
                QName   opEntry   =   new   QName( qname,   m); 
                byte[] buff = ObjectModule.objects2Bytes(parameters);
                
                Object[]   opEntryArgs;
                if (buff==null)
                	opEntryArgs   =   new   Object[]   {}; 
                else 	opEntryArgs   =   new   Object[]   {buff}; 
                Class[]   returnTypes   =   new   Class[]   {  byte[].class  };   
                Object[]   response   =   serviceClient.invokeBlocking(opEntry, 
                                opEntryArgs,   returnTypes); 

                byte[] rst = (byte[])response[0];
                
                ServiceResult rs = (ServiceResult)ObjectModule.bytes2Object(rst);
                return rs;
	}
}