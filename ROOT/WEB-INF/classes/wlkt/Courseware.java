package wlkt;
import java.sql.*;
import java.util.*;
import dbConn.*;
import client.*;
import module.*;
import java.io.*;

public class Courseware{
		public String getConfigFromDb(String para){
				String value;
				value = "";
				String pp[] = new String[]{para};
				Object[] p = new Object[]{"SELECT VALUE FROM EMP.T_WLKT_SYSCONFIG WHERE PARA = ?",pp};
				ServiceResult result = DataProviderClient.getData("system","","","DBConnectionPool","executeQuery",p);
				System.out.println(result.getDescription());
				if (result.getErrorCode()==0){
					db.ResultData rData = (db.ResultData)result.getResults()[0];
					String[] colNames = rData.getCollumName();
					java.util.Vector<java.util.Vector> datas = rData.getDatas();
					if (datas!=null){
						for (int i=0;i<datas.size();i++){
							java.util.Vector row = (java.util.Vector)datas.get(i);
							for (int j=0;j<colNames.length;j++){
								value = (String)row.get(j);
							}
						}
					}else System.out.println(rData.getDescription());
				}
				return 	value;
				//Dbconn conn;
				//conn = null;	
				//conn = new Dbconn();
				//String sql1;
				//sql1 = "SELECT VALUE FROM EMP.T_WLKT_SYSCONFIG WHERE PARA ='"+para+"'";
				//ResultSet rst1 = null;
				//Statement stmt1 = conn.createStatement();
				//rst1 = stmt1.executeQuery(sql1);
				/*if(rst1.next()){
					value =  rst1.getString("VALUE");
				}
				rst1.close();
				rst1.getStatement().close();*/
				//conn.close();
		}
		
		public boolean  makeDir(String path) {
		    boolean flag = false;
		    java.io.File dir;
		    dir =new java.io.File(path);
		    if (dir == null) {
        			return flag;
    		}
    		if (dir.isFile()) {
        			return flag;
    		}
    		if (!dir.exists()) {
        		boolean result = dir.mkdirs();
        		if (result == false) {
            			return flag;
        		}
        		flag = true;
        		return flag;
        }
        return flag;
		}
		
		public boolean saveCWRef(String cwname,String cwtype,String cwurl,String cwpurl,String cwref,String filename,String filelocal,String filetype,String filesize,String ipaddr){
				String pp[] = new String[]{cwtype,cwname,cwurl,cwpurl,filelocal,cwref,filename,filetype,filesize,ipaddr};
				Object[] p = new Object[]{"INSERT INTO EMP.T_WANGLUOJIAOXUEZIYUAN(ID,ZIYUANLEIXING,ZIYUANMINGCHENG,ZIYUANURL,PNODEID,CUNFANGLUJING,ZIYUANMIAOSHU,WENJIANMINGCHENG,WENJIANLEIXING,WENJIANCHICUN,IPADDR) VALUES( emp.seq_cw.nextval,?,?,?,?,?,?,?,?,?,?)",pp};
				ServiceResult result = DataProviderClient.getData("system","","","DBConnectionPool","execute",p);
				System.out.println(result.getDescription());
				db.ResultData rData = (db.ResultData)result.getResults()[0];
				return 	rData.isExecuteOk();
		}
		
		public boolean updateCWRef(String cwid,String cwname,String cwtype,String cwref){
				String pp[] = new String[]{cwtype,cwname,cwref,cwid};
				Object[] p = new Object[]{"UPDATE EMP.T_WANGLUOJIAOXUEZIYUAN SET ZIYUANLEIXING = ?,ZIYUANMINGCHENG = ?,ZIYUANMIAOSHU = ? WHERE ID = ?",pp};
				ServiceResult result = DataProviderClient.getData("system","","","DBConnectionPool","execute",p);
				System.out.println(result.getDescription());
				db.ResultData rData = (db.ResultData)result.getResults()[0];
				return 	rData.isExecuteOk();
		}
		
		
		public boolean removeCWRef(String id){
				String pp[] = new String[]{id};
				Object[] p = new Object[]{"DELETE FROM EMP.T_WANGLUOJIAOXUEZIYUAN WHERE ID = ?",pp};
				ServiceResult result = DataProviderClient.getData("system","","","DBConnectionPool","execute",p);
				System.out.println(result.getDescription());
				db.ResultData rData = (db.ResultData)result.getResults()[0];
				return 	rData.isExecuteOk();
		}
		
		
		
		public Vector<Vector> cwList(String ziyuanurl){
					Vector<Vector> cw;
					cw = new Vector<Vector>();
					String pp[] = new String[]{ziyuanurl};
					//Object[] p = new Object[]{"SELECT ZIYUANLEIXING,ZIYUANMINGCHENG,SHANGCHUANSHIJIAN,ZIYUANMIAOSHU,WENJIANLEIXING,WENJIANCHICUN,WENJIANMINGCHENG,IPADDR,ZIYUANURL,ID FROM EMP.T_WANGLUOJIAOXUEZIYUAN WHERE ZIYUANURL = ? order by id desc",pp};
					Object[] p = new Object[]{"SELECT ZIYUANLEIXING,ZIYUANMINGCHENG,ZIYUANMIAOSHU,ZIYUANURL,ID,WENJIANMINGCHENG FROM EMP.T_WANGLUOJIAOXUEZIYUAN WHERE ZIYUANURL = ? order by id desc",pp};
					ServiceResult result = DataProviderClient.getData("system","","","DBConnectionPool","executeQuery",p);
					System.out.println(result.getDescription());
					if (result.getErrorCode()==0){
						db.ResultData rData = (db.ResultData)result.getResults()[0];
						String[] colNames = rData.getCollumName();
						cw = rData.getDatas();
					}
					return cw;
		}
		
		public Vector<Vector> cwListByType(){
					Vector<Vector> cw;
					cw = new Vector<Vector>();
					String pp[] = new String[]{};
					//Object[] p = new Object[]{"SELECT ZIYUANLEIXING,ZIYUANMINGCHENG,SHANGCHUANSHIJIAN,ZIYUANMIAOSHU,WENJIANLEIXING,WENJIANCHICUN,WENJIANMINGCHENG,IPADDR,ZIYUANURL,ID FROM EMP.T_WANGLUOJIAOXUEZIYUAN ORDER BY ZIYUANLEIXING",pp};
					Object[] p = new Object[]{"SELECT ZIYUANLEIXING,ZIYUANMINGCHENG,ZIYUANMIAOSHU,ZIYUANURL,ID,WENJIANMINGCHENG FROM EMP.T_WANGLUOJIAOXUEZIYUAN ORDER BY ZIYUANLEIXING",pp};
					ServiceResult result = DataProviderClient.getData("system","","","DBConnectionPool","executeQuery",p);
					System.out.println(result.getDescription());
					if (result.getErrorCode()==0){
						db.ResultData rData = (db.ResultData)result.getResults()[0];
						String[] colNames = rData.getCollumName();
						cw = rData.getDatas();
					}
					return cw;
		}
		
		public Vector<Vector> childCwList(String ziyuanurl){
					Vector<Vector> cw;
					cw = new Vector<Vector>();
					String pp[] = new String[]{ziyuanurl};
					//Object[] p = new Object[]{"SELECT ZIYUANLEIXING,ZIYUANMINGCHENG,SHANGCHUANSHIJIAN,ZIYUANMIAOSHU,WENJIANLEIXING,WENJIANCHICUN,WENJIANMINGCHENG FROM EMP.T_WANGLUOJIAOXUEZIYUAN WHERE PNODEID = ? order by id desc",pp};
					Object[] p = new Object[]{"SELECT ZIYUANURL FROM EMP.T_WANGLUOJIAOXUEZIYUAN WHERE PNODEID = ? order by ziyuanleixing desc",pp};
					ServiceResult result = DataProviderClient.getData("system","","","DBConnectionPool","executeQuery",p);
					System.out.println(result.getDescription());
					if (result.getErrorCode()==0){
						db.ResultData rData = (db.ResultData)result.getResults()[0];
						String[] colNames = rData.getCollumName();
						cw = rData.getDatas();
					}
					return cw;
		}
		
		
		public Vector<Vector> getCwType(){
					Vector<Vector> cw;
					cw = new Vector<Vector>();
					String pp[] = new String[]{};
					Object[] p = new Object[]{"SELECT cwtype FROM EMP.T_WLKT_CWTYPE",pp};
					ServiceResult result = DataProviderClient.getData("system","","","DBConnectionPool","executeQuery",p);
					System.out.println(result.getDescription());
					if (result.getErrorCode()==0){
						db.ResultData rData = (db.ResultData)result.getResults()[0];
						String[] colNames = rData.getCollumName();
						cw = rData.getDatas();
					}
					return cw;
		}
		
		public Vector<Vector> getCw(String cwid){
					Vector<Vector> cw;
					cw = new Vector<Vector>();
					String pp[] = new String[]{cwid};
					Object[] p = new Object[]{"SELECT ZIYUANMINGCHENG,ZIYUANLEIXING,ZIYUANMIAOSHU,WENJIANMINGCHENG FROM EMP.T_WANGLUOJIAOXUEZIYUAN WHERE ID = ?",pp};
					ServiceResult result = DataProviderClient.getData("system","","","DBConnectionPool","executeQuery",p);
					System.out.println(result.getDescription());
					if (result.getErrorCode()==0){
						db.ResultData rData = (db.ResultData)result.getResults()[0];
						String[] colNames = rData.getCollumName();
						cw = rData.getDatas();
					}
					return cw;
		}
		
		
		public String getParentId(String nid){
				String value;
				value = "";
				String pp[] = new String[]{nid};
				Object[] p = new Object[]{"SELECT OBJECTID FROM EMP.T_XMGL_XIANGMUSHU WHERE ID = (SELECT PARENTID FROM EMP.T_XMGL_XIANGMUSHU WHERE ID = ?)",pp};
				ServiceResult result = DataProviderClient.getData("system","","","DBConnectionPool","executeQuery",p);
				System.out.println(result.getDescription());
				if (result.getErrorCode()==0){
					db.ResultData rData = (db.ResultData)result.getResults()[0];
					String[] colNames = rData.getCollumName();
					java.util.Vector<java.util.Vector> datas = rData.getDatas();
					if (datas!=null){
						for (int i=0;i<datas.size();i++){
							java.util.Vector row = (java.util.Vector)datas.get(i);
							for (int j=0;j<colNames.length;j++){
								value = (String)row.get(j);
							}
						}
					}else System.out.println(rData.getDescription());
				}
					return 	value;
		}	
}