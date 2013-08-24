package wit.sql;

import module.ServiceResult;
import wit.module.WITService;
import wit.user.UserInfo;
import wit.util.ObjectModule;

public class DataProvider{

	public static ServiceResult getData(UserInfo caller,String sql,String[] parameters)throws Exception{
		Object[] p = new Object[]{sql,parameters};
		
		ServiceResult rs = WITService.getData(caller.getUserName(),caller.getUserPassword(),caller.getUserUniqueId(),"DBConnectionPool","executeQuery",p);
		return rs;
	}
}