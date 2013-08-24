package wit.util;


import java.io.ByteArrayInputStream; 
import java.io.IOException; 
import java.io.ObjectInputStream; 

import java.io.ByteArrayOutputStream; 
import java.io.IOException; 
import java.io.ObjectOutputStream;

public class ObjectModule{
	
	public static Object[] bytes2Objects(byte[] inbuff)throws Exception{
		if (inbuff==null)
			return null;
		ByteArrayInputStream bis =new   ByteArrayInputStream(inbuff); 
		ObjectInputStream ois = new ObjectInputStream(bis);
		Object[] parameters = (Object[])ois.readObject();
		ois.close();
		return parameters;
	}
	
	public static Object bytes2Object(byte[] inbuff)throws Exception{
		if (inbuff==null)
			return null;
		ByteArrayInputStream bis =new   ByteArrayInputStream(inbuff); 
		ObjectInputStream ois = new ObjectInputStream(bis);
		Object parameters = (Object)ois.readObject();
		ois.close();
		return parameters;
	}
	
	public static byte[] object2Bytes(Object o)throws IOException{
		if (o==null)
			return null;
		ByteArrayOutputStream bos=new ByteArrayOutputStream();
		ObjectOutputStream oos = new ObjectOutputStream(bos);
			
		oos.writeObject(o);
		byte[] buff = bos.toByteArray();
		oos.close();
		return buff;
	}
	
	public static byte[] objects2Bytes(Object[] o)throws IOException{
		if (o==null)
			return null;
		ByteArrayOutputStream bos=new ByteArrayOutputStream();
		ObjectOutputStream oos = new ObjectOutputStream(bos);
			
		oos.writeObject(o);
		byte[] buff = bos.toByteArray();
		oos.close();
		return buff;
	}
}