package sshd;
import java.sql.*;
import java.util.*;
import java.io.*;
import dbConn.*;
import client.*;
import module.*;
import oracle.jdbc.driver.*;
import oracle.sql.*;
import java.sql.Types;
import java.text.*;

public class Forms{
		public static String getConfigFromDb(String para){
				String value;
				value = "";
				String pp[] = new String[]{para};
				Object[] p = new Object[]{"SELECT VALUE FROM NICWF.T_WF_SYSCONFIG WHERE PARA = ?",pp};
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

		public String getSeq(){
				String value;
				value = "";
				String pp[] = new String[]{};
				Object[] p = new Object[]{"SELECT emp.seq_topic.nextval FROM DUAL",pp};
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
								value = row.get(j).toString();
							}
						}
					}else System.out.println(rData.getDescription());
				}
				return 	value;
		}
		
		public boolean updateImgNoteid(String imgid,String noteid){
				String pp[] = new String[]{noteid,imgid};
				Object[] p = new Object[]{"UPDATE NICWF.T_WF_IMGREF SET NOTEID = ? WHERE NOTEID = ?",pp};
				ServiceResult result = DataProviderClient.getData("system","","","DBConnectionPool","execute",p);
				System.out.println(result.getDescription());
				db.ResultData rData = (db.ResultData)result.getResults()[0];
				return 	rData.isExecuteOk();
		}
		
	/*	public boolean saveTopicBlob(String topicname,String topictype,String txmain,String txowner,String dsid,String uip,String imgid){
				try{
									Connection conn;
									String sip = "210.42.24.100";
									String ssid = "dbeleven";
									String dbDriver = "oracle.jdbc.driver.OracleDriver";
									String strUrl = "jdbc:oracle:thin:@"+sip+":1521:"+ssid;
									Class.forName(dbDriver);
									conn = DriverManager.getConnection(strUrl, "nicwf", "nicwf");
									conn.setAutoCommit(false);
									String sql1;
									String stxmain;
									stxmain = sortString(txmain);
									String sn = getSeq();
									sql1 = "INSERT INTO NICWF.T_WF_ZHUTI(ZHUTISN,ZHUTIMINGCHENG,ZHUTILEIBIE,ZHUTINEIRONG,FAQIREN,LINGYUBIANMA,IPADDR,LASTHUIFU)VALUES("+sn+",'"+topicname+"','"+topictype+"',EMPTY_BLOB(),'"+txowner+"','"+dsid+"','"+uip+"',"+sn+")";
									Statement stmt1 = conn.createStatement();
									stmt1.executeQuery(sql1);
									stmt1.close();
									String sql2;
									sql2 = "SELECT ZHUTINEIRONG FROM NICWF.T_WF_ZHUTI WHERE ZHUTISN = "+sn+" FOR UPDATE";
									Statement stmt2 = conn.createStatement();
									ResultSet rst2;
									rst2 = stmt2.executeQuery(sql2);
									rst2.next();
									oracle.sql.BLOB blob = (oracle.sql.BLOB) rst2.getBlob("ZHUTINEIRONG");
  								OutputStream os = blob.getBinaryOutputStream();
			  					InputStream   is   =   new   ByteArrayInputStream(stxmain.getBytes());
			  					byte[] b = new byte[blob.getBufferSize()]; 
						      int len = 0; 
					        int sum = 0;
					        while ( (len = is.read(b)) != -1) { 
					        	os.write(b, 0, len); 
				          	sum = sum + len;
					       	} 
					       	is.close(); 
							   	os.flush(); 
							   	os.close(); 
  								System.out.println(sum);
  								rst2.close();
  								stmt2.close();
  								conn.commit();
  								conn.setAutoCommit(true);
  								conn.close();
  								updateImgNoteid(imgid,sn);
  			}catch(Exception e){
  				System.out.println(e);
  			}
  			return true;
		}*/

public boolean saveTopicBlob(String topicname,String topictype,String txmain,String txowner,String dsid,String uip,String imgid,String suser,String sphone,String sdate,String splace,String stype,String sgivenby,String sassignto,String estat){
				try{
									Connection conn;
									String sip = "210.42.24.100";
									String ssid = "dbeleven";
									String dbDriver = "oracle.jdbc.driver.OracleDriver";
									String strUrl = "jdbc:oracle:thin:@"+sip+":1521:"+ssid;
									Class.forName(dbDriver);
									conn = DriverManager.getConnection(strUrl, "nicwf", "nicwf");
									conn.setAutoCommit(false);
									String sql1;
									String stxmain;
									stxmain = sortString(txmain);
									String sn = getSeq();
									sql1 = "INSERT INTO NICWF.T_WF_ZHUTI(ZHUTISN,ZHUTIMINGCHENG,ZHUTILEIBIE,ZHUTINEIRONG,FAQIREN,LINGYUBIANMA,IPADDR,LASTHUIFU,SUSER,SPHONE,SDATE,SPLACE,STYPE,SGIVENBY,SASSIGNTO,ESTAT)VALUES("+sn+",'"+topicname+"','"+topictype+"',EMPTY_BLOB(),'"+txowner+"','"+dsid+"','"+uip+"',"+sn+",'"+suser+"','"+sphone+"','"+sdate+"','"+splace+"','"+stype+"','"+sgivenby+"','"+sassignto+"','"+estat+"')";
									Statement stmt1 = conn.createStatement();
									stmt1.executeQuery(sql1);
									stmt1.close();
									String sql2;
									sql2 = "SELECT ZHUTINEIRONG FROM NICWF.T_WF_ZHUTI WHERE ZHUTISN = "+sn+" FOR UPDATE";
									Statement stmt2 = conn.createStatement();
									ResultSet rst2;
									rst2 = stmt2.executeQuery(sql2);
									rst2.next();
									//System.out.println(sql1);
									//System.out.println(sql2);
									oracle.sql.BLOB blob = (oracle.sql.BLOB) rst2.getBlob("ZHUTINEIRONG");
  								OutputStream os = blob.getBinaryOutputStream();
			  					InputStream   is   =   new   ByteArrayInputStream(stxmain.getBytes());
			  					byte[] b = new byte[blob.getBufferSize()]; 
						      int len = 0; 
					        int sum = 0;
					        while ( (len = is.read(b)) != -1) { 
					        	os.write(b, 0, len); 
				          	sum = sum + len;
					       	} 
					       	is.close(); 
							   	os.flush(); 
							   	os.close(); 
  								//System.out.println(sum);
  								rst2.close();
  								stmt2.close();
  								conn.commit();
  								conn.setAutoCommit(true);
  								conn.close();
  								updateImgNoteid(imgid,sn);
  			}catch(Exception e){
  				System.out.println(e);
  			}
  			return true;
		}

		
		public boolean saveReplyBlob(String lasthuifu,String topicid,String replytitle,String replytype,String txmain,String txowner,String dsid,int floor,String uip,String imgid){
				try{
									Connection conn;
									String sip = "210.42.24.100";
									String ssid = "dbeleven";
									String dbDriver = "oracle.jdbc.driver.OracleDriver";
									String strUrl = "jdbc:oracle:thin:@"+sip+":1521:"+ssid;
									Class.forName(dbDriver);
									conn = DriverManager.getConnection(strUrl, "nicwf", "nicwf");
									conn.setAutoCommit(false);
									String sql1,sql0;
									String stxmain;
									stxmain = sortString(txmain);
									String sn = getSeq();
									sql1 = "INSERT INTO NICWF.T_WF_HUIFU(HUIFUSN,LASTHUIFU,HUIFUZHUTI,HUIFULEIBIE,HUIFUREN,LINGYUBIANMA,ZHUTISN,FLOOR,IPADDR,HUIFUNEIRONG)VALUES("+sn+",'"+lasthuifu+"','"+replytitle+"','"+replytype+"','"+txowner+"','"+dsid+"',"+topicid+","+floor+",'"+uip+"',EMPTY_BLOB())";
									Statement stmt1 = conn.createStatement();
									stmt1.executeQuery(sql1);
									stmt1.close();
									String sql2;
									sql0 = "UPDATE NICWF.T_WF_ZHUTI SET SFLAG = '"+replytype+"' WHERE ZHUTISN = (SELECT DUIYINGZHUTI FROM NICWF.V_WF_ALLNOTES WHERE ZHUTISN = "+sn+")";
									Statement stmt0 = conn.createStatement();
									stmt0.executeQuery(sql0);
									stmt0.close();
									//System.out.println("$$"+sql0);
									sql2 = "SELECT HUIFUNEIRONG FROM NICWF.T_WF_HUIFU WHERE HUIFUSN = "+sn+" FOR UPDATE";
									Statement stmt2 = conn.createStatement();
									ResultSet rst2;
									rst2 = stmt2.executeQuery(sql2);
									rst2.next();
									oracle.sql.BLOB blob = (oracle.sql.BLOB) rst2.getBlob("HUIFUNEIRONG");
  								OutputStream os = blob.getBinaryOutputStream();
			  					InputStream   is   =   new   ByteArrayInputStream(stxmain.getBytes());
			  					byte[] b = new byte[blob.getBufferSize()]; 
						      int len = 0; 
					        int sum = 0;
					        while ( (len = is.read(b)) != -1) { 
					        	os.write(b, 0, len); 
				          	sum = sum + len;
					       	} 
					       	is.close(); 
							   	os.flush(); 
							   	os.close(); 
  								rst2.close();
  								stmt2.close();
  								conn.commit();
  								conn.setAutoCommit(true);
  								conn.close();
  								updateImgNoteid(imgid,sn);
									updateTopicsn(sn,topicid);
  			}catch(Exception e){
  				System.out.println(e);
  			}
  			return true;
		}

	public boolean saveADBlob(String topicid,String adtype,String txmain,String txowner,String dsid,String uip,String imgid){
				try{
									Connection conn;
									String sip = "210.42.24.100";
									String ssid = "dbeleven";
									String dbDriver = "oracle.jdbc.driver.OracleDriver";
									String strUrl = "jdbc:oracle:thin:@"+sip+":1521:"+ssid;
									Class.forName(dbDriver);
									conn = DriverManager.getConnection(strUrl, "nicwf", "nicwf");
									conn.setAutoCommit(false);
									String sql1,sql0;
									String stxmain;
									stxmain = sortString(txmain);
									String sn = getSeq();
									sql1 = "INSERT INTO NICWF.T_WF_ASSIGNDESCRIBE(ADSN,ADREN,ADTYPE,LINGYUBIANMA,ZHUTISN,IPADDR,ADNEIRONG)VALUES("+sn+",'"+txowner+"','"+adtype+"','"+dsid+"',"+topicid+",'"+uip+"',EMPTY_BLOB())";
									Statement stmt1 = conn.createStatement();
									stmt1.executeQuery(sql1);
									stmt1.close();
									String sql2;
									sql2 = "SELECT ADNEIRONG FROM NICWF.T_WF_ASSIGNDESCRIBE WHERE ADSN = "+sn+" FOR UPDATE";
									Statement stmt2 = conn.createStatement();
									ResultSet rst2;
									rst2 = stmt2.executeQuery(sql2);
									rst2.next();
									oracle.sql.BLOB blob = (oracle.sql.BLOB) rst2.getBlob("ADNEIRONG");
  								OutputStream os = blob.getBinaryOutputStream();
			  					InputStream   is   =   new   ByteArrayInputStream(stxmain.getBytes());
			  					byte[] b = new byte[blob.getBufferSize()]; 
						      int len = 0; 
					        int sum = 0;
					        while ( (len = is.read(b)) != -1) { 
					        	os.write(b, 0, len); 
				          	sum = sum + len;
					       	} 
					       	is.close(); 
							   	os.flush(); 
							   	os.close(); 
  								rst2.close();
  								stmt2.close();
  								conn.commit();
  								conn.setAutoCommit(true);
  								conn.close();
  								updateImgNoteid(imgid,sn);
									updateTopicsn(sn,topicid);
  			}catch(Exception e){
  				System.out.println(e);
  			}
  			return true;
		}		
		
		public boolean updateTopicsn(String replysn,String topicid){
				String pp[] = new String[]{replysn,topicid};
				Object[] p = new Object[]{"UPDATE NICWF.T_WF_ZHUTI SET LASTHUIFU = ? WHERE ZHUTISN = ?",pp};
				ServiceResult result = DataProviderClient.getData("system","","","DBConnectionPool","execute",p);
				System.out.println(result.getDescription());
				db.ResultData rData = (db.ResultData)result.getResults()[0];
				return 	rData.isExecuteOk();
		}
		

		public boolean updateNoteBlob(String topicsn,String txmain,String uip,String ntype,String sname,String sphone,String sdate,String splace,String stype,String sgivenby,String topictype,String mby,String zhutimingcheng,String estat,String sassignto ){
							try{
									Connection conn;
									String sip = "210.42.24.100";
									String ssid = "dbeleven";
									String dbDriver = "oracle.jdbc.driver.OracleDriver";
									String strUrl = "jdbc:oracle:thin:@"+sip+":1521:"+ssid;
									Class.forName(dbDriver);
									conn = DriverManager.getConnection(strUrl, "nicwf", "nicwf");
									conn.setAutoCommit(false);
									String stxmain;
									//System.out.println("#"+txmain);
									stxmain = sortString(txmain);
									//System.out.println("*"+stxmain);
									String sql0,sql2;
									if (ntype.equals("t")){
										sql0 = "UPDATE NICWF.T_WF_ZHUTI SET ZHUTINEIRONG = empty_blob(),SUSER='"+sname+"',SPHONE='"+sphone+"',SDATE='"+sdate+"',SPLACE='"+splace+"',STYPE='"+stype+"',SGIVENBY='"+sgivenby+"',ZHUTILEIBIE='"+topictype+"',LASTMODIFY=sysdate,LASTMODIFYBY='"+mby+"',ZHUTIMINGCHENG='"+zhutimingcheng+"',ESTAT='"+estat+"',SASSIGNTO='"+sassignto+"' WHERE ZHUTISN = "+topicsn;
										sql2 = "SELECT ZHUTINEIRONG FROM NICWF.T_WF_ZHUTI WHERE ZHUTISN = "+topicsn+" FOR UPDATE";
									}else{
										sql0 = "UPDATE NICWF.T_WF_HUIFU SET HUIFUNEIRONG = empty_blob(),LASTMODIFY=sysdate,LASTMODIFYBY='"+mby+"' WHERE HUIFUSN = "+topicsn;
										sql2 = "SELECT HUIFUNEIRONG FROM NICWF.T_WF_HUIFU WHERE HUIFUSN = "+topicsn+" FOR UPDATE";
									}
									Statement stmt0 = conn.createStatement();
									stmt0.executeQuery(sql0);
									stmt0.close();
									Statement stmt2 = conn.createStatement();
									ResultSet rst2;
									rst2 = stmt2.executeQuery(sql2);
									rst2.next();
									oracle.sql.BLOB blob = null;
									if (ntype.equals("t")){
										blob = (oracle.sql.BLOB) rst2.getBlob("ZHUTINEIRONG");
									}else{
										blob = (oracle.sql.BLOB) rst2.getBlob("HUIFUNEIRONG");
									}
  								OutputStream os = blob.getBinaryOutputStream();
			  					InputStream   is   =   new   ByteArrayInputStream(stxmain.getBytes());
			  					byte[] b = new byte[blob.getBufferSize()]; 
						      int len = 0; 
					        int sum = 0;
					        while ( (len = is.read(b)) != -1) { 
					        	os.write(b, 0, len); 
					       	} 
					       	is.close(); 
							   	os.flush(); 
							   	os.close(); 
  								rst2.close();
  								stmt2.close();	
  								conn.commit();
  								conn.setAutoCommit(true);
  								conn.close();
						}catch (Exception e){
								System.out.println(e);
						}
						return true;
		}
		
		public boolean updateTopicSflagByAD(String topicsn,String sflag){
				String pp[] = new String[]{sflag,topicsn};
				Object[] p;
				p = new Object[]{"UPDATE NICWF.T_WF_ZHUTI SET SFLAG = ? WHERE ZHUTISN = ?",pp};
				ServiceResult result = DataProviderClient.getData("system","","","DBConnectionPool","execute",p);
				System.out.println(result.getDescription());
				db.ResultData rData = (db.ResultData)result.getResults()[0];
				return 	rData.isExecuteOk();
		}
		
		public boolean updateNoteBlobReply(String topicsn,String txmain,String uip,String ntype,String topictype,String mby, String sflag ){
							try{
									Connection conn;
									String sip = "210.42.24.100";
									String ssid = "dbeleven";
									String dbDriver = "oracle.jdbc.driver.OracleDriver";
									String strUrl = "jdbc:oracle:thin:@"+sip+":1521:"+ssid;
									Class.forName(dbDriver);
									conn = DriverManager.getConnection(strUrl, "nicwf", "nicwf");
									conn.setAutoCommit(false);
									String stxmain;
									//System.out.println("#"+txmain);
									stxmain = sortString(txmain);
									//System.out.println("*"+stxmain);
									String sql0,sql2,sql3;
									sql0 = "UPDATE NICWF.T_WF_HUIFU SET HUIFUNEIRONG = empty_blob(),HUIFULEIBIE='"+sflag+"',LASTMODIFY=sysdate,LASTMODIFYBY='"+mby+"' WHERE HUIFUSN = "+topicsn;
									sql2 = "SELECT HUIFUNEIRONG FROM NICWF.T_WF_HUIFU WHERE HUIFUSN = "+topicsn+" FOR UPDATE";
									sql3 = "UPDATE NICWF.T_WF_ZHUTI SET SFLAG = '"+sflag+"' WHERE ZHUTISN = (SELECT DUIYINGZHUTI FROM NICWF.V_WF_ALLNOTES WHERE ZHUTISN = "+topicsn+")";
									//System.out.println("#"+sql0);
									//System.out.println("#"+sql3);
									Statement stmt0 = conn.createStatement();
									stmt0.executeQuery(sql0);
									stmt0.close();
									Statement stmt3 = conn.createStatement();
									stmt3.executeQuery(sql3);
									stmt3.close();
									Statement stmt2 = conn.createStatement();
									ResultSet rst2;
									rst2 = stmt2.executeQuery(sql2);
									rst2.next();
									oracle.sql.BLOB blob = null;
									if (ntype.equals("t")){
										blob = (oracle.sql.BLOB) rst2.getBlob("ZHUTINEIRONG");
									}else{
										blob = (oracle.sql.BLOB) rst2.getBlob("HUIFUNEIRONG");
									}
  								OutputStream os = blob.getBinaryOutputStream();
			  					InputStream   is   =   new   ByteArrayInputStream(stxmain.getBytes());
			  					byte[] b = new byte[blob.getBufferSize()]; 
						      int len = 0; 
					        int sum = 0;
					        while ( (len = is.read(b)) != -1) { 
					        	os.write(b, 0, len); 
					       	} 
					       	is.close(); 
							   	os.flush(); 
							   	os.close(); 
  								rst2.close();
  								stmt2.close();	
  								conn.commit();
  								conn.setAutoCommit(true);
  								conn.close();
						}catch (Exception e){
								System.out.println(e);
						}
						return true;
		}
		
		public boolean updateADBlob(String topicsn,String txmain,String uip,String mby, String adtype){
							try{
									Connection conn;
									String sip = "210.42.24.100";
									String ssid = "dbeleven";
									String dbDriver = "oracle.jdbc.driver.OracleDriver";
									String strUrl = "jdbc:oracle:thin:@"+sip+":1521:"+ssid;
									Class.forName(dbDriver);
									conn = DriverManager.getConnection(strUrl, "nicwf", "nicwf");
									conn.setAutoCommit(false);
									String stxmain;
									//System.out.println("#"+txmain);
									stxmain = sortString(txmain);
									//System.out.println("*"+stxmain);
									String sql0,sql2,sql3;
									sql0 = "UPDATE NICWF.T_WF_ASSIGNDESCRIBE SET ADNEIRONG = empty_blob(),LASTMODIFY=sysdate,LASTMODIFYBY='"+mby+"' WHERE ZHUTISN = "+topicsn;
									sql2 = "SELECT ADNEIRONG FROM NICWF.T_WF_ASSIGNDESCRIBE WHERE ZHUTISN = "+topicsn+" FOR UPDATE";
									//System.out.println("#"+sql0);
									Statement stmt0 = conn.createStatement();
									stmt0.executeQuery(sql0);
									stmt0.close();
									Statement stmt2 = conn.createStatement();
									ResultSet rst2;
									rst2 = stmt2.executeQuery(sql2);
									rst2.next();
									oracle.sql.BLOB blob = null;
									blob = (oracle.sql.BLOB) rst2.getBlob("ADNEIRONG");
  								OutputStream os = blob.getBinaryOutputStream();
			  					InputStream   is   =   new   ByteArrayInputStream(stxmain.getBytes());
			  					byte[] b = new byte[blob.getBufferSize()]; 
						      int len = 0; 
					        int sum = 0;
					        while ( (len = is.read(b)) != -1) { 
					        	os.write(b, 0, len); 
					       	} 
					       	is.close(); 
							   	os.flush(); 
							   	os.close(); 
  								rst2.close();
  								stmt2.close();	
  								conn.commit();
  								conn.setAutoCommit(true);
  								conn.close();
						}catch (Exception e){
								System.out.println(e);
						}
						return true;
		}

		
		public int getFloor(String topicsn){
					int maxfloor = 0;
					Vector row;
					Vector<Vector> cw;
					cw = new Vector<Vector>();
					String pp[] = new String[]{topicsn};
					Object[] p = new Object[]{"SELECT max(FLOOR) FROM NICWF.T_WF_HUIFU WHERE ZHUTISN = ?",pp};
					ServiceResult result = DataProviderClient.getData("system","","","DBConnectionPool","executeQuery",p);
					System.out.println(result.getDescription());
					if (result.getErrorCode()==0){
						db.ResultData rData = (db.ResultData)result.getResults()[0];
						String[] colNames = rData.getCollumName();
						cw = rData.getDatas();
						//System.out.println("Size"+cw.size());
						if (cw.size() > 0){
							row = (java.util.Vector)cw.get(0);
							//System.out.println("rowsize:"+row.size());
							if (row.get(0) != null){
								String ff;
								ff = row.get(0).toString();
								//maxfloor = ((Integer)row.get(0)).intValue();
								maxfloor = Integer.parseInt(ff);
							}
						}
					}
					return maxfloor;
		}
		
		public String getTopicsn(String notesn){
					String ff = "";
					Vector row;
					Vector<Vector> cw;
					cw = new Vector<Vector>();
					String pp[] = new String[]{notesn};
					Object[] p = new Object[]{"SELECT DUIYINGZHUTI FROM NICWF.V_WF_ALLNOTES WHERE ZHUTISN = ?",pp};
					ServiceResult result = DataProviderClient.getData("system","","","DBConnectionPool","executeQuery",p);
					System.out.println(result.getDescription());
					if (result.getErrorCode()==0){
						db.ResultData rData = (db.ResultData)result.getResults()[0];
						String[] colNames = rData.getCollumName();
						cw = rData.getDatas();
						//System.out.println("Size"+cw.size());
						if (cw.size() > 0){
							row = (java.util.Vector)cw.get(0);
							//System.out.println("rowsize:"+row.size());
							if (row.get(0) != null){
								ff = row.get(0).toString();
								return ff;
							}
						}
					}
					return ff;
		}
		
		
		public Vector<Vector> formList(){
					Vector<Vector> cw;
					cw = new Vector<Vector>();
					String pp[] = new String[]{};
					Object[] p = new Object[]{"SELECT ZHUTIMINGCHENG,FAQIREN,ZHUTILEIBIE,LINGYUBIANMA,FAQISHIJIAN,ZHUTISN FROM NICWF.T_WF_ZHUTI WHERE ZHUTIMINGCHENG IS NOT NULL  group by LINGYUBIANMA,ZHUTIMINGCHENG,FAQIREN,ZHUTILEIBIE,FAQISHIJIAN,ZHUTISN ORDER BY lingyubianma ASC ,ZHUTIsn DESC",pp};
					ServiceResult result = DataProviderClient.getData("system","","","DBConnectionPool","executeQuery",p);
					System.out.println(result.getDescription());
					if (result.getErrorCode()==0){
						db.ResultData rData = (db.ResultData)result.getResults()[0];
						String[] colNames = rData.getCollumName();
						cw = rData.getDatas();
					}
					return cw;
		}
		
		public Vector<Vector> getDsOwner(String dssn){
					Vector<Vector> cw;
					cw = new Vector<Vector>();
					Object[] p;
					p = null;
					String pp[] = new String[]{dssn};
					p = new Object[]{"SELECT LINGYUBIANMA,ACCT,ACCTNAME FROM NICWF.V_WF_DSOWNER WHERE LINGYUBIANMA = ?",pp};	
					ServiceResult result = DataProviderClient.getData("system","","","DBConnectionPool","executeQuery",p);
					System.out.println(result.getDescription());
					if (result.getErrorCode()==0){
						db.ResultData rData = (db.ResultData)result.getResults()[0];
						String[] colNames = rData.getCollumName();
						cw = rData.getDatas();
					}
					return cw;
		}

		public Vector<Vector> getDs(String dssn){
					Vector<Vector> cw;
					cw = new Vector<Vector>();
					Object[] p;
					p = null;
					String pp[] = new String[]{dssn};
					p = new Object[]{"SELECT LINGYUBIANMA,LINGYUMINGCHENG,nvl(SUOSHUJIAOSHI,'尚未有负责教师'),LINGYUMIAOSHU FROM NICWF.T_WF_DOMAINSPACE WHERE LINGYUBIANMA = ?",pp};
					ServiceResult result = DataProviderClient.getData("system","","","DBConnectionPool","executeQuery",p);
					System.out.println(result.getDescription());
					if (result.getErrorCode()==0){
						db.ResultData rData = (db.ResultData)result.getResults()[0];
						String[] colNames = rData.getCollumName();
						cw = rData.getDatas();
					}
					return cw;
		}
		
		public Vector<Vector> getDsByOwner(String powner){
					Vector<Vector> cw;
					cw = new Vector<Vector>();
					Object[] p;
					p = null;
					String pp[] = new String[]{powner};
					//p = new Object[]{"select LINGYUBIANMA,LINGYUMINGCHENG,SUOSHUJIAOSHI,LINGYUMIAOSHU,CT from NICWF.V_WF_ds where lingyubianma in (select xmdm from emp.t_kbgl_kebiao where gh = ?)",pp};
					p = new Object[]{"select LINGYUBIANMA,LINGYUMINGCHENG,SUOSHUJIAOSHI,LINGYUMIAOSHU,CT from NICWF.V_WF_ds where lingyubianma in (select kcdm from emp.t_kbgl_kebiao where gh = ?)",pp};
					ServiceResult result = DataProviderClient.getData("system","","","DBConnectionPool","executeQuery",p);
					System.out.println(result.getDescription());
					if (result.getErrorCode()==0){
						db.ResultData rData = (db.ResultData)result.getResults()[0];
						String[] colNames = rData.getCollumName();
						cw = rData.getDatas();
					}
					return cw;
		}
		
		public Vector<Vector> getDsAll(){
					Vector<Vector> cw;
					cw = new Vector<Vector>();
					Object[] p;
					p = null;
					String pp[] = new String[]{};
					p = new Object[]{"select LINGYUBIANMA,LINGYUMINGCHENG,SUOSHUJIAOSHI,LINGYUMIAOSHU,CT from NICWF.V_WF_ds order by LINGYUBIANMA",pp};
					ServiceResult result = DataProviderClient.getData("system","","","DBConnectionPool","executeQuery",p);
					System.out.println(result.getDescription());
					if (result.getErrorCode()==0){
						db.ResultData rData = (db.ResultData)result.getResults()[0];
						String[] colNames = rData.getCollumName();
						cw = rData.getDatas();
					}
					return cw;
		}
		
		
		
		public Vector<Vector> formListTopic(String dssn,String topicsn,int startsn,int endsn){
					Vector<Vector> cw;
					cw = new Vector<Vector>();
					Object[] p;
					p = null;
					if(topicsn.equals("")){
						String pp[] = new String[]{dssn};
						if(dssn.equals("9")){
							p = new Object[]{"SELECT ZHUTIMINGCHENG,FAQIREN,ZHUTILEIBIE,FAQISHIJIAN,ZHUTISN,FLAG,SFLAG,nvl(ESTAT,'UNKNOWN'),SASSIGNTO FROM NICWF.T_WF_ZHUTI WHERE FLAG = 'D'  and LINGYUBIANMA = ? ORDER BY to_number(LASTHUIFU) DESC,ZHUTISN DESC",pp};	
						}else{
							p = new Object[]{"SELECT ZHUTIMINGCHENG,FAQIREN,ZHUTILEIBIE,FAQISHIJIAN,ZHUTISN,FLAG,SFLAG,nvl(ESTAT,'UNKNOWN'),SASSIGNTO FROM NICWF.T_WF_ZHUTI WHERE FLAG = 'T'  and LINGYUBIANMA = ? ORDER BY to_number(LASTHUIFU) DESC,ZHUTISN DESC",pp};	
						}
					}else{
						String pp[] = new String[]{topicsn};
						//p = new Object[]{"SELECT ZHUTIMINGCHENG,FAQIREN,ZHUTILEIBIE,ZHUTINEIRONG,FAQISHIJIAN,ZHUTISN,LINGYUBIANMA FROM NICWF.T_WF_ZHUTI WHERE ZHUTIMINGCHENG IS NOT NULL  and ZHUTISN = ?",pp};	
						p = new Object[]{"SELECT ZHUTIMINGCHENG,FAQIREN,ZHUTILEIBIE,null,FAQISHIJIAN,ZHUTISN,LINGYUBIANMA,LINGYUMINGCHENG,SUOSHUJIAOSHI,DUIYINGZHUTI,NTYPE,IPADDR,FLAG,AN,SUSER,SPHONE,SDATE,SPLACE,STYPE,SGIVENBY,LASTMODIFY,LASTMODIFYBY,SFLAG,ESTAT,SASSIGNTO FROM NICWF.V_WF_ALLNOTES WHERE FLAG='T' and DUIYINGZHUTI = ? AND NTYPE = 'T'",pp};	
					}
					ServiceResult result = DataProviderClient.getData("system","","","DBConnectionPool","executeQuery",p);
					System.out.println(result.getDescription());
					if (result.getErrorCode()==0){
						db.ResultData rData = (db.ResultData)result.getResults()[0];
						String[] colNames = rData.getCollumName();
						cw = rData.getDatas();
					}
					return cw;
		}
		
		public String getTopicMainBlob(String topicsn){
			String t = "";
			try {
							Connection conn;
							String sip = "210.42.24.100";
							String ssid = "dbeleven";
							String dbDriver = "oracle.jdbc.driver.OracleDriver";
							String strUrl = "jdbc:oracle:thin:@"+sip+":1521:"+ssid;
							Class.forName(dbDriver);
							conn = DriverManager.getConnection(strUrl, "nicwf", "nicwf");
							Statement stmt1 = conn.createStatement(); 
							ResultSet rst1 = stmt1.executeQuery("SELECT ZHUTINEIRONG FROM NICWF.T_WF_ZHUTI WHERE ZHUTISN = "+topicsn); 
							rst1.next();
							//OutputStream fout;
							InputStream ins;
							oracle.sql.BLOB BLOB =(oracle.sql.BLOB)rst1.getBlob("ZHUTINEIRONG");
							ins = BLOB.getBinaryStream();								
							ByteArrayOutputStream   baos   =   new   ByteArrayOutputStream(); 
							int   i=-1; 
							while((i=ins.read())!=-1){ 
								baos.write(i);
							} 
							t = baos.toString();
							conn.close();
	  					//fout.close();
	  					ins.close();
		}catch(Exception e){
			System.out.println(e);
		}
		return t;
	}
		public String getReplyMainBlob(String topicsn){
			String t = "";
			try {
							Connection conn;
							String sip = "210.42.24.100";
							String ssid = "dbeleven";
							String dbDriver = "oracle.jdbc.driver.OracleDriver";
							String strUrl = "jdbc:oracle:thin:@"+sip+":1521:"+ssid;
							Class.forName(dbDriver);
							conn = DriverManager.getConnection(strUrl, "nicwf", "nicwf");
							Statement stmt1 = conn.createStatement(); 
							ResultSet rst1 = stmt1.executeQuery("SELECT HUIFUNEIRONG FROM NICWF.T_WF_HUIFU WHERE HUIFUSN = "+topicsn); 
							rst1.next();
							//OutputStream fout;
							InputStream ins;
							oracle.sql.BLOB BLOB =(oracle.sql.BLOB)rst1.getBlob("HUIFUNEIRONG");
							ins = BLOB.getBinaryStream();								
							ByteArrayOutputStream   baos   =   new   ByteArrayOutputStream(); 
							int   i=-1; 
							while((i=ins.read())!=-1){ 
								baos.write(i);
							} 
							t = baos.toString();
							conn.close();
	  					//fout.close();
	  					ins.close();
		}catch(Exception e){
			System.out.println(e);
		}
		return t;
	}

public String getADMainBlob(String topicsn){
			String t = "";
			try {
							Connection conn;
							String sip = "210.42.24.100";
							String ssid = "dbeleven";
							String dbDriver = "oracle.jdbc.driver.OracleDriver";
							String strUrl = "jdbc:oracle:thin:@"+sip+":1521:"+ssid;
							Class.forName(dbDriver);
							conn = DriverManager.getConnection(strUrl, "nicwf", "nicwf");
							Statement stmt1 = conn.createStatement(); 
							ResultSet rst1 = stmt1.executeQuery("SELECT ADNEIRONG FROM NICWF.T_WF_ASSIGNDESCRIBE WHERE ZHUTISN = "+topicsn); 
							rst1.next();
							//OutputStream fout;
							InputStream ins;
							oracle.sql.BLOB BLOB =(oracle.sql.BLOB)rst1.getBlob("ADNEIRONG");
							ins = BLOB.getBinaryStream();								
							ByteArrayOutputStream   baos   =   new   ByteArrayOutputStream(); 
							int   i=-1; 
							while((i=ins.read())!=-1){ 
								baos.write(i);
							} 
							t = baos.toString();
							conn.close();
	  					//fout.close();
	  					ins.close();
		}catch(Exception e){
			System.out.println(e);
		}
		return t;
	}
					
		
		public Vector<Vector> formListReply(String topicsn,String t){
					Vector<Vector> cw;
					cw = new Vector<Vector>();
					String pp[] = new String[]{topicsn};
					Object[] p;
					p = null;
					if(t.equals("0")){
						p = new Object[]{"SELECT ZHUTIMINGCHENG,FAQIREN,ZHUTILEIBIE,LINGYUBIANMA,null,FAQISHIJIAN,DUIYINGZHUTI,LINGYUMINGCHENG,SUOSHUJIAOSHI,LINGYUBIANMA,FLAG,SUSER,SPHONE,SDATE,SPLACE,STYPE,SGIVENBY,LASTMODIFY,LASTMODIFYBY,SFLAG FROM NICWF.V_WF_ALLNOTES WHERE ZHUTISN = ?",pp};
					}else if (t.equals("1")){
						p = new Object[]{"SELECT HUIFUZHUTI,null,HUIFUREN,HUIFUSHIJIAN,HUIFUSN,FLOOR,HUIFULEIBIE,IPADDR,FLAG FROM NICWF.T_WF_HUIFU WHERE ZHUTISN = ? ORDER BY FLOOR",pp};
					}else if (t.equals("2")){
						String pp1[] = new String[]{};
						p = new Object[]{"SELECT LINGYUBIANMA,LINGYUMINGCHENG,nvl(SUOSHUJIAOSHI,'目前尚未有负责人'),LINGYUMIAOSHU FROM NICWF.T_WF_DOMAINSPACE WHERE LINGYUBIANMA IS NOT NULL AND ZHUANGTAI = 'T' ORDER BY SN",pp1};
					}else if (t.equals("3")){
						p = new Object[]{"SELECT HUIFUZHUTI,HUIFUREN,HUIFULEIBIE,LINGYUBIANMA,null,HUIFUSHIJIAN FROM NICWF.T_WF_HUIFU WHERE HUIFUSN = ?",pp};
					}
					ServiceResult result = DataProviderClient.getData("system","","","DBConnectionPool","executeQuery",p);
					System.out.println(result.getDescription());
					if (result.getErrorCode()==0){
						db.ResultData rData = (db.ResultData)result.getResults()[0];
						String[] colNames = rData.getCollumName();
						cw = rData.getDatas();
					}
					return cw;
		}
		
		public Vector<Vector> formListReplyPg(String topicsn,int startsn,int endsn){
					Vector<Vector> cw;
					cw = new Vector<Vector>();
					String pp[] = new String[]{topicsn};
					Object[] p;
					p = new Object[]{"SELECT HUIFUZHUTI,null,HUIFUREN,HUIFUSHIJIAN,HUIFUSN,FLOOR,HUIFULEIBIE,IPADDR,FLAG,LASTMODIFY,LASTMODIFYBY FROM (select * from NICWF.T_WF_HUIFU WHERE ZHUTISN = ? AND rownum < "+endsn+") a WHERE a.HUIFUSN NOT IN (select huifusn from NICWF.T_WF_HUIFU where rownum < "+startsn+") ORDER BY FLOOR",pp};
					ServiceResult result = DataProviderClient.getData("system","","","DBConnectionPool","executeQuery",p);
					System.out.println(result.getDescription());
					if (result.getErrorCode()==0){
						db.ResultData rData = (db.ResultData)result.getResults()[0];
						String[] colNames = rData.getCollumName();
						cw = rData.getDatas();
					}
					return cw;
		}
		
		public Vector<Vector> formListReplyFloor(String topicsn,String floor){
					Vector<Vector> cw;
					cw = new Vector<Vector>();
					String pp[] = new String[]{topicsn,floor};
					Object[] p;
					p = new Object[]{"SELECT HUIFUZHUTI,null,HUIFUREN,HUIFUSHIJIAN,HUIFUSN,FLOOR FROM NICWF.T_WF_HUIFU WHERE ZHUTISN = ? AND FLOOR = ? ORDER BY FLOOR ",pp};
					ServiceResult result = DataProviderClient.getData("system","","","DBConnectionPool","executeQuery",p);
					System.out.println(result.getDescription());
					if (result.getErrorCode()==0){
						db.ResultData rData = (db.ResultData)result.getResults()[0];
						String[] colNames = rData.getCollumName();
						cw = rData.getDatas();
					}
					return cw;
		}
		
		public String sortString(String input){
					/*if(input == null){
							return "无内容";
					}
					StringBuffer   filtered   =   new   StringBuffer(input.length());   
          char   c;   
          for(int   i=0;   i<input.length();   i++)   {   
              c   =   input.charAt(i);   
              if   (c   ==   '<')   {   
                  filtered.append("&lt;");   
              }   else   if   (c   ==   '>')   {   
                  filtered.append("&gt;");   
              }   else   if   (c   ==   '"')   {   
                  filtered.append("&quot;");   
              }   else   if   (c   ==   '&')   {   
                  filtered.append("&amp;");   
              }   else   if   (c   ==   ' ')   {   
                  filtered.append("&nbsp;");   
              }   else   {   
                  filtered.append(c);   
              }   
          }   
			String txmain = filtered.toString();
			//txmain = txmain.replace("\n","<br>");
			return txmain.replace(" ","&nbsp;");*/
			return input;
		}
		
		public String desortString(String input){
					if(input == null){
							return "无内容";
					}
						String txm;
						txm = input.replaceAll("&lt;img&nbsp;","<img ");
						txm = txm.replaceAll("&nbsp;&gt;"," >");
						txm = txm.replaceAll("&lt;","<");
						txm = txm.replaceAll("&gt;",">");
						txm = txm.replaceAll("&quot;","\"");
						txm = txm.replaceAll("&nbsp;"," ");
						txm = txm.replace("\n","<br>");
						
						return txm;
		}
		
		public String edesortString(String input){
					if(input == null){
							return "无内容";
					}
						String txm;
						txm = input.replaceAll("&lt;","<");
						txm = txm.replaceAll("&gt;",">");
						txm = txm.replaceAll("&quot;","\"");
						txm = txm.replaceAll("&nbsp;"," ");
						txm = txm.replace("<br>","\n");
						return txm;
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
		
		public boolean saveIMGRef(String imgref,String filename,String filelocal,String filetype,String filesize,String nid,String fileurl,String user){
				String pp[] = new String[]{filelocal,imgref,filename,filetype,filesize,nid,fileurl,user};
				Object[] p = new Object[]{"INSERT INTO NICWF.T_WF_IMGREF(SN,IMGLOCAL,IMGREF,IMGNAME,IMGTYPE,IMGSIZE,NOTEID,IMGURL,OWNER) VALUES( emp.seq_img.nextval,?,?,?,?,?,?,?,?)",pp};
				ServiceResult result = DataProviderClient.getData("system","","","DBConnectionPool","execute",p);
				System.out.println(result.getDescription());
				db.ResultData rData = (db.ResultData)result.getResults()[0];
				return 	rData.isExecuteOk();
		}
		
		public Vector<Vector> getImg(String id){
					Vector<Vector> cw;
					cw = new Vector<Vector>();
					Object[] p;
					p = null;
					String pp[] = new String[]{id};
					p = new Object[]{"SELECT SN,IMGNAME,IMGLOCAL,IMGREF,IMGTYPE,IMGSIZE,NOTEID,IMGURL FROM NICWF.T_WF_IMGREF WHERE NOTEID = ? ORDER BY SN DESC",pp};
					ServiceResult result = DataProviderClient.getData("system","","","DBConnectionPool","executeQuery",p);
					System.out.println(result.getDescription());
					if (result.getErrorCode()==0){
						db.ResultData rData = (db.ResultData)result.getResults()[0];
						String[] colNames = rData.getCollumName();
						cw = rData.getDatas();
					}
					return cw;
		}
		
		
		public boolean getIsImg(String ftype){
				if(ftype.equals("img/x-png")){
					return true;
				}
				if(ftype.equals("img/x-bmp")){
					return true;
				}
				if(ftype.equals("image/pjpeg")){
					return true;
				}
				if(ftype.equals("image/gif")){
					return true;
				}
				return false;
		}
		
		public boolean removeImgFile(String imgsn){
					String imglocal = "";
					Vector row;
					Vector<Vector> cw;
					cw = new Vector<Vector>();
					String pp[] = new String[]{imgsn};
					Object[] p = new Object[]{"SELECT IMGLOCAL FROM NICWF.T_WF_IMGREF WHERE SN = ?",pp};
					ServiceResult result = DataProviderClient.getData("system","","","DBConnectionPool","executeQuery",p);
					System.out.println(result.getDescription());
					if (result.getErrorCode()==0){
						db.ResultData rData = (db.ResultData)result.getResults()[0];
						String[] colNames = rData.getCollumName();
						cw = rData.getDatas();
						if (cw.size() > 0){
							row = (java.util.Vector)cw.get(0);
							if (row.get(0) != null){
								imglocal = row.get(0).toString();
							}
						}
					}
					if (removeImgRef(imgsn)){
							File tfile = new File(imglocal);
							return tfile.delete();
					}
					return false;
		}
	
		public boolean removeImgRef(String imgsn){
				String pp[] = new String[]{imgsn};
				Object[] p = new Object[]{"DELETE FROM NICWF.T_WF_IMGREF WHERE SN = ?",pp};
				ServiceResult result = DataProviderClient.getData("system","","","DBConnectionPool","execute",p);
				System.out.println(result.getDescription());
				db.ResultData rData = (db.ResultData)result.getResults()[0];
				return 	rData.isExecuteOk();
		}		
		
		public boolean removeNotesRef(String id,String ntype){
				String sn = getSeq();
				String pp[] = new String[]{id};
				Object[] p;
				if (ntype.equals("t")){
					p = new Object[]{"UPDATE NICWF.T_WF_ZHUTI SET FLAG = 'D',LINGYUBIANMA='9' WHERE ZHUTISN = ?",pp};
				}else{
					p = new Object[]{"UPDATE NICWF.T_WF_HUIFU SET FLAG = 'D',LINGYUBIANMA='9' WHERE HUIFUSN = ?",pp};
				}
				ServiceResult result = DataProviderClient.getData("system","","","DBConnectionPool","execute",p);
				System.out.println(result.getDescription());
				db.ResultData rData = (db.ResultData)result.getResults()[0];
				return 	rData.isExecuteOk();
		}
		
		public boolean CheckDisabled(String st)throws Exception{
				int blength;
				byte[] bt= st.getBytes();
				blength = st.length();
				for (int i=0;i<blength ;i++ ){
		 				if (((bt[i]<47)&&(bt[i]>33))||(bt[i]== 96)||(bt[i] == 63)){ // '?
								return false;
						}
				}
				return true;
  }
  
  public boolean CheckConclusionRight(String user,String zhutisn){
  		Vector<Vector> cw;
			cw = new Vector<Vector>();
  		String pp[] = new String[]{zhutisn,user,user};
			Object[] p = new Object[]{"SELECT * FROM NICWF.T_WF_DOMAINSPACEOWNER WHERE ((LINGYUBIANMA = (select lingyubianma from nicwf.v_wf_allnotes where zhutisn = ?) and ACCT = ? and AUTH = 2)) OR (ACCT = ? and AUTH = 9)",pp};
			ServiceResult result = DataProviderClient.getData("system","","","DBConnectionPool","executeQuery",p);
			System.out.println(result.getDescription());
			db.ResultData rData = (db.ResultData)result.getResults()[0];
			cw = rData.getDatas();
			//System.out.println("**"+cw.size());
			if(cw.size()>0){
				return true;
			}else{
				return false;	
			}
  }

	public boolean CheckModifyRight(String user,String zhutisn){
  		Vector<Vector> cw;
			cw = new Vector<Vector>();
  		String pp[] = new String[]{zhutisn,user,user};
			Object[] p = new Object[]{"SELECT * FROM NICWF.T_WF_DOMAINSPACEOWNER WHERE ((LINGYUBIANMA = (select lingyubianma from nicwf.v_wf_allnotes where zhutisn = ?) and ACCT = ? and AUTH = 2)) OR (ACCT = ? and AUTH = 9)",pp};
			ServiceResult result = DataProviderClient.getData("system","","","DBConnectionPool","executeQuery",p);
			System.out.println(result.getDescription());
			db.ResultData rData = (db.ResultData)result.getResults()[0];
			cw = rData.getDatas();
			//System.out.println("**"+cw.size());
			if(cw.size()>0){
				return true;
			}else{
				return false;	
			}
  }
  
  	public boolean CheckADRight(String user,String zhutisn){
  		Vector<Vector> cw;
			cw = new Vector<Vector>();
  		String pp[] = new String[]{user,zhutisn};
			Object[] p = new Object[]{"SELECT zhutisn FROM NICWF.T_WF_ZHUTI WHERE SASSIGNTO=(SELECT ACCTNAME FROM CA.TDACCT WHERE ACCT = ?) AND ZHUTISN = ?",pp};
			ServiceResult result = DataProviderClient.getData("system","","","DBConnectionPool","executeQuery",p);
			System.out.println(result);
			db.ResultData rData = (db.ResultData)result.getResults()[0];
			cw = rData.getDatas();
			//System.out.println("*>*"+cw.size());
			if(cw.size()>0){
				return true;
			}else{
				return false;	
			}
  }
    
  public boolean CheckNewRight(String user,String dsid){
  		Vector<Vector> cw;
			cw = new Vector<Vector>();
  		String pp[] = new String[]{dsid,user,user};
			Object[] p = new Object[]{"SELECT * FROM NICWF.T_WF_DOMAINSPACEOWNER WHERE (LINGYUBIANMA = ? and ACCT = ?) OR (ACCT = ? and AUTH = 9)",pp};
			ServiceResult result = DataProviderClient.getData("system","","","DBConnectionPool","executeQuery",p);
			System.out.println(result.getDescription());
			db.ResultData rData = (db.ResultData)result.getResults()[0];
			cw = rData.getDatas();
			//System.out.println("**"+cw.size());
			if(cw.size()>0){
				return true;
			}else{
				return false;	
			}
  }
  
  public boolean CheckDeleteRight(String user,String zhutisn){
  		Vector<Vector> cw;
			cw = new Vector<Vector>();
  		String pp[] = new String[]{zhutisn,user,user};
			//Object[] p = new Object[]{"SELECT * FROM NICWF.T_WF_DOMAINSPACEOWNER WHERE (LINGYUBIANMA = ? and ACCT = ? and AUTH = 2) OR (ACCT = ? and AUTH = 9)",pp};
			Object[] p = new Object[]{"SELECT * FROM NICWF.T_WF_DOMAINSPACEOWNER WHERE (LINGYUBIANMA = (select lingyubianma from nicwf.v_wf_allnotes where zhutisn = ?) and ACCT =  ? and AUTH = 2) OR (ACCT = ? and AUTH = 9)",pp};
			ServiceResult result = DataProviderClient.getData("system","","","DBConnectionPool","executeQuery",p);
			System.out.println(result.getDescription());
			db.ResultData rData = (db.ResultData)result.getResults()[0];
			cw = rData.getDatas();
			//System.out.println("**"+cw.size());
			if(cw.size()>0){
				return true;
			}else{
				return false;	
			}
  }
  
  public String GetComplete(String dsid){
  		Vector<Vector> cw;
			cw = new Vector<Vector>();
  		String pp[] = new String[]{dsid};
			Object[] p = new Object[]{"SELECT COUNT(*) FROM NICWF.T_WF_ZHUTI WHERE SFLAG= 'c' AND FLAG='T' AND LINGYUBIANMA = ? ",pp};
			ServiceResult result = DataProviderClient.getData("system","","","DBConnectionPool","executeQuery",p);
			System.out.println(result.getDescription());
			db.ResultData rData = (db.ResultData)result.getResults()[0];
			cw = rData.getDatas();
			Vector iii = (Vector)cw.get(0);
			String ii = iii.get(0).toString();
			//String ii = new Integer((Object)iii.get(0)).toString();
			//System.out.println("^^^"+ii);
			return ii;
			
  }
    public String GetComplete1(String dsid){
  		String ret="";
			try {
							Connection conn;
							String sip = "210.42.24.100";
							String ssid = "dbeleven";
							String dbDriver = "oracle.jdbc.driver.OracleDriver";
							String strUrl = "jdbc:oracle:thin:@"+sip+":1521:"+ssid;
							Class.forName(dbDriver);
							conn = DriverManager.getConnection(strUrl, "nicwf", "nicwf");
							Statement stmt1 = conn.createStatement(); 
							String sql = "SELECT count(*) a FROM NICWF.T_WF_ZHUTI WHERE SFLAG='c' AND LINGYUBIANMA ='"+dsid+"'";
							ResultSet rst1 = stmt1.executeQuery(sql);
							//System.out.println("$$!!$$$$$"+sql);
	  					//fout.close();
	  					//System.out.println("$$$$$$$$$$$$$$$"+dsid);
	  					rst1.next();
	  					ret = rst1.getString("a");
	  					//System.out.println("$$$$$$$$$$$$$$$"+ret);
	  					conn.close();
			}catch(Exception e){
				System.out.println(e);
			}
					
			return ret;
  }
  public Vector<Vector> GetPersonalTask(String acct,String type,String stype){
					Vector<Vector> cw;
					cw = new Vector<Vector>();
					Object[] p;
					p = null;
					String pp[]=null;
					if(type.equals("out")){							
							 pp = new String[]{acct};
							p = new Object[]{"SELECT ZHUTIMINGCHENG,FAQIREN,ZHUTILEIBIE,LINGYUBIANMA,FAQISHIJIAN,DUIYINGZHUTI,LINGYUMINGCHENG,SUOSHUJIAOSHI,FLAG,SFLAG,ZHUTISN,ESTAT,SASSIGNTO FROM NICWF.V_WF_ALLNOTES WHERE NTYPE='T' and FAQIREN = ? order by zhutisn desc",pp};
					}else{
							if(! stype.equals("")){
								if(stype.equals("c")){
										//stype="已解决";
										stype="c";
								}
								if(stype.equals("w")){
										stype="申请完成";
										stype="w";
								}
								if(stype.equals("p")){
										stype="进行中";
										stype="p";
								}
								if(stype.equals("a")){
									pp = new String[]{acct};
									p = new Object[]{"SELECT ZHUTIMINGCHENG,FAQIREN,ZHUTILEIBIE,LINGYUBIANMA,FAQISHIJIAN,DUIYINGZHUTI,LINGYUMINGCHENG,SUOSHUJIAOSHI,FLAG,SFLAG,ZHUTISN,ESTAT,SASSIGNTO FROM NICWF.V_WF_ALLNOTES WHERE NTYPE='T' and SASSIGNTO = (select acctname from ca.tdacct where acct = ?) order by zhutisn desc",pp};
								}else{
									pp = new String[]{stype,acct};
									p = new Object[]{"SELECT ZHUTIMINGCHENG,FAQIREN,ZHUTILEIBIE,LINGYUBIANMA,FAQISHIJIAN,DUIYINGZHUTI,LINGYUMINGCHENG,SUOSHUJIAOSHI,FLAG,SFLAG,ZHUTISN,ESTAT,SASSIGNTO FROM NICWF.V_WF_ALLNOTES WHERE NTYPE='T' and SFLAG = ? and SASSIGNTO = (select acctname from ca.tdacct where acct = ?) order by zhutisn desc",pp};	
								}
							}else{
								p = new Object[]{"SELECT ZHUTIMINGCHENG,FAQIREN,ZHUTILEIBIE,LINGYUBIANMA,FAQISHIJIAN,DUIYINGZHUTI,LINGYUMINGCHENG,SUOSHUJIAOSHI,FLAG,SFLAG,ZHUTISN,ESTAT,SASSIGNTO FROM NICWF.V_WF_ALLNOTES WHERE NTYPE='T' and SASSIGNTO = (select acctname from ca.tdacct where acct = ?) order by zhutisn desc",pp};						
							}
					}
					
					ServiceResult result = DataProviderClient.getData("system","","","DBConnectionPool","executeQuery",p);
					System.out.println(result.getDescription());
					if (result.getErrorCode()==0){
						db.ResultData rData = (db.ResultData)result.getResults()[0];
						String[] colNames = rData.getCollumName();
						cw = rData.getDatas();
					}
					return cw;
		}
		
	public Vector<Vector> GetMembers(){
					Vector<Vector> cw;
					cw = new Vector<Vector>();
					String pp[] = new String[]{};
					Object[] p;
					p = null;
					p = new Object[]{"SELECT DISTINCT(ACCT),ACCTNAME FROM NICWF.V_WF_DSOWNER where acct <>'root' order by ACCT",pp};
					ServiceResult result = DataProviderClient.getData("system","","","DBConnectionPool","executeQuery",p);
					System.out.println(result.getDescription());
					if (result.getErrorCode()==0){
						db.ResultData rData = (db.ResultData)result.getResults()[0];
						String[] colNames = rData.getCollumName();
						cw = rData.getDatas();
					}
					return cw;
		}
		
	public Vector<Vector> GetAD(String zhutisn){
					Vector<Vector> cw;
					cw = new Vector<Vector>();
					String pp[] = new String[]{zhutisn};
					Object[] p;
					p = null;
					p = new Object[]{"SELECT ADSN,ADREN,ADSHIJIAN,LINGYUBIANMA,IPADDR,LASTMODIFY,LASTMODIFYBY,ADTYPE FROM NICWF.T_WF_ASSIGNDESCRIBE where zhutisn=?",pp};
					ServiceResult result = DataProviderClient.getData("system","","","DBConnectionPool","executeQuery",p);
					System.out.println(result.getDescription());
					if (result.getErrorCode()==0){
						db.ResultData rData = (db.ResultData)result.getResults()[0];
						String[] colNames = rData.getCollumName();
						cw = rData.getDatas();
					}
					return cw;
		}

		public Vector<Vector> GetAchievement(){
					Vector<Vector> cw;
					cw = new Vector<Vector>();
					String pp[] = new String[]{};
					Object[] p;
					p = null;
					p = new Object[]{"SELECT DISTINCT(ACCT),ACCTNAME FROM NICWF.V_WF_DSOWNER where acct <>'root' order by ACCT",pp};
					ServiceResult result = DataProviderClient.getData("system","","","DBConnectionPool","executeQuery",p);
					System.out.println(result.getDescription());
					if (result.getErrorCode()==0){
						db.ResultData rData = (db.ResultData)result.getResults()[0];
						String[] colNames = rData.getCollumName();
						cw = rData.getDatas();
					}
					return cw;
		}
		
		public Vector<Vector> GetTaskStatisticInOut(String acct,String starttime,String endtime){
					Vector<Vector> cw;
					cw = new Vector<Vector>();
					String pp[] = new String[]{acct,acct,acct,acct};
					Object[] p;
					p = null;
					p = new Object[]{"select a.ca,b.cb,c.cc,d.cd from (select count(*) ca  from nicwf.t_wf_zhuti where faqiren=? and flag='T') a,(select count(*) cb  from nicwf.t_wf_zhuti where flag='T' and sassignto=(select acctname from ca.tdacct where acct=?)) b,(select count(*) cc  from nicwf.t_wf_zhuti where flag='T' and sassignto=(select acctname from ca.tdacct where acct=?) and sflag='c') c,(select count(*) cd from nicwf.t_wf_zhuti where sassignto =(select acctname from ca.tdacct where acct = ?) and flag = 'T' and sflag = 'w') d",pp};		
					//select a.ca,b.cb from (select count(*) ca  from nicwf.t_wf_zhuti where faqiren='wangyu' and flag='T' and faqishijian > to_date('2008-12-02','yyyy-mm-dd') and faqishijian < to_date('2008-12-04')) a,(select count(*) cb  from nicwf.t_wf_zhuti where flag='T' and sassignto=(select acctname from ca.tdacct where acct='wangyu')) b
					ServiceResult result = DataProviderClient.getData("system","","","DBConnectionPool","executeQuery",p);
					System.out.println("[GetTaskStatisticInOut]"+result.getDescription());
					if (result.getErrorCode()==0){
						db.ResultData rData = (db.ResultData)result.getResults()[0];
						String[] colNames = rData.getCollumName();
						cw = rData.getDatas();
					}
					return cw;
		}
		
		public Vector<Vector> GetTasksForConclusion(String acct){
					Vector<Vector> cw;
					cw = new Vector<Vector>();
					String pp[] = new String[]{acct};
					Object[] p;
					p = null;
					p = new Object[]{"select lingyubianma from nicwf.t_wf_domainspaceowner where acct = ? and auth = 2",pp};		
					ServiceResult result = DataProviderClient.getData("system","","","DBConnectionPool","executeQuery",p);
					System.out.println(result.getDescription());
					if (result.getErrorCode()==0){
						db.ResultData rData = (db.ResultData)result.getResults()[0];
						cw = rData.getDatas();
					}
					String 	scopestr = " AND ( lingyubianma = ";
					boolean inflag = false;
						for (int t=0;t<cw.size();t++){
							Vector crow = (java.util.Vector)cw.get(t);
							if (t == 0){
								scopestr = scopestr+(String)crow.get(t);
								inflag = true;
							}else{
								scopestr = scopestr+" OR lingyubianma = "+(String)crow.get(0);
								inflag = true;
							}
						}
						scopestr = scopestr + ")";
						if(! inflag){
							return new Vector<Vector>();
						}
					
					Vector<Vector> cw1;
					cw1 = new Vector<Vector>();
					String pp1[] = new String[]{};
					Object[] p1;
					p1 = null;
					p1 = new Object[]{"SELECT ZHUTIMINGCHENG,FAQIREN,ZHUTILEIBIE,LINGYUBIANMA,FAQISHIJIAN,DUIYINGZHUTI,LINGYUMINGCHENG,SUOSHUJIAOSHI,FLAG,SFLAG,ZHUTISN,ESTAT FROM NICWF.V_WF_ALLNOTES WHERE NTYPE='T' and SFLAG='w' "+scopestr+" order by zhutisn desc",pp1};		
					ServiceResult result1 = DataProviderClient.getData("system","","","DBConnectionPool","executeQuery",p1);
					//System.out.println("####"+scopestr);
					System.out.println(result1.getDescription());
					if (result1.getErrorCode()==0){
						db.ResultData rData1 = (db.ResultData)result1.getResults()[0];
						cw1 = rData1.getDatas();
					}
					return cw1;
		}
		
		public boolean DoMigrate(String topicsn,String dsid){
  		String pp[] = new String[]{dsid,topicsn};
			//Object[] p = new Object[]{"SELECT * FROM NICWF.T_WF_DOMAINSPACEOWNER WHERE (LINGYUBIANMA = ? and ACCT = ? and AUTH = 2) OR (ACCT = ? and AUTH = 9)",pp};
			Object[] p = new Object[]{"UPDATE NICWF.T_WF_ZHUTI SET LINGYUBIANMA = ? WHERE ZHUTISN = ?",pp};
			ServiceResult result = DataProviderClient.getData("system","","","DBConnectionPool","execute",p);
			System.out.println(result.getDescription());
  		Object[] p1 = new Object[]{"UPDATE NICWF.T_WF_HUIFU SET LINGYUBIANMA = ? WHERE ZHUTISN = ?",pp};
			ServiceResult result1 = DataProviderClient.getData("system","","","DBConnectionPool","execute",p1);
			System.out.println(result1.getDescription());
			return true;
		}
		
		public Vector<Vector> getTopicType(){
			String pp[] = new String[]{};
			Vector<Vector> cw;
			cw = new Vector<Vector>();
			Object[] p;
			p = null;
			p = new Object[]{"select name,cname from nicwf.t_wf_ttype",pp};		
			ServiceResult result = DataProviderClient.getData("system","","","DBConnectionPool","executeQuery",p);
			System.out.println("[get topic type]: "+result.getDescription());
			if (result.getErrorCode()==0){
				db.ResultData rData = (db.ResultData)result.getResults()[0];
				cw = rData.getDatas();
			}
			return cw;
			
		}
	
	
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
		//add on Dec 2009 for statistic by Eric
		public Vector<Vector> getCaseByType(String acct,String ctype,String startdate,String enddate){
			String pp[] = new String[]{"紧急",acct,acct,startdate,enddate,"特别重要",acct,acct,startdate,enddate,"一般",acct,acct,startdate,enddate,"计划性",acct,acct,startdate,enddate};
			Vector<Vector> cw;
			cw = new Vector<Vector>();
			Object[] p;
			p = null;
			//p = new Object[]{"select ZHUTILEIBIE,count(*) from nicwf.t_wf_zhuti where (FAQIREN = ? or SASSIGNTO in (select acctname from ca.tdacct where acct=?)) and faqishijian > to_date(?,'YYYY-MM-DD') and faqishijian < to_date(?,'YYYY-MM-DD') group by ZHUTILEIBIE order by ZHUTILEIBIE",pp};
			p = new Object[]{"select aa.zhutileibie,nvl(a.cstat,0),nvl(b.cstat,0),nvl(c.cstat,0),nvl(d.cstat,0) from (select distinct(zhutileibie) from nicwf.t_wf_zhuti) aa left join (select count(*) cstat,zhutileibie from nicwf.t_wf_zhuti where estat = ?  and (FAQIREN = ? or SASSIGNTO in (select acctname from ca.tdacct where acct=?)) and faqishijian > to_date(?,'YYYY-MM-DD') and faqishijian < to_date(?,'YYYY-MM-DD') GROUP BY zhutileibie) a on aa.zhutileibie = a.zhutileibie left join (select count(*) cstat,zhutileibie from nicwf.t_wf_zhuti where estat= ?  and (FAQIREN = ? or SASSIGNTO in (select acctname from ca.tdacct where acct=?)) and faqishijian > to_date(?,'YYYY-MM-DD') and faqishijian < to_date(?,'YYYY-MM-DD') GROUP BY zhutileibie) b on aa.zhutileibie = b.zhutileibie left join (select count(*) cstat,zhutileibie from nicwf.t_wf_zhuti where estat= ? and (FAQIREN = ? or SASSIGNTO in (select acctname from ca.tdacct where acct=?)) and faqishijian > to_date(?,'YYYY-MM-DD') and faqishijian < to_date(?,'YYYY-MM-DD') GROUP BY zhutileibie) c on aa.zhutileibie = c.zhutileibie left join (select count(*) cstat,zhutileibie from nicwf.t_wf_zhuti where estat= ? and (FAQIREN = ? or SASSIGNTO in (select acctname from ca.tdacct where acct=?)) and faqishijian > to_date(?,'YYYY-MM-DD') and faqishijian < to_date(?,'YYYY-MM-DD') GROUP BY zhutileibie) d on aa.zhutileibie = d.zhutileibie order by aa.ZHUTILEIBIE",pp};
			ServiceResult result = DataProviderClient.getData("system","","","DBConnectionPool","executeQuery",p);
			System.out.println("[Get Case Count For Statistic]: "+result.getDescription());
			if (result.getErrorCode()==0){
				db.ResultData rData = (db.ResultData)result.getResults()[0];
				cw = rData.getDatas();
			}
			return cw;
			
		}
		
		//add on Dec 2009 for statistic by Eric
		public Vector<Vector> getStatCaseByType(String acct,String ctype,String startdate,String enddate){
			String pp[] = new String[]{acct,acct,startdate,enddate,ctype};
			Vector<Vector> cw;
			cw = new Vector<Vector>();
			Object[] p;
			p = null;
			p = new Object[]{"SELECT ZHUTIMINGCHENG,FAQIREN,ZHUTILEIBIE,LINGYUBIANMA,FAQISHIJIAN,DUIYINGZHUTI,LINGYUMINGCHENG,SUOSHUJIAOSHI,FLAG,SFLAG,ZHUTISN,ESTAT,SASSIGNTO FROM NICWF.V_WF_ALLNOTES WHERE FLAG='T'and NTYPE='T' and (FAQIREN = ? or SASSIGNTO in (select acctname from ca.tdacct where acct=?)) and faqishijian > to_date(?,'YYYY-MM-DD') and faqishijian < to_date(?,'YYYY-MM-DD') and ZHUTILEIBIE=?",pp};		
			ServiceResult result = DataProviderClient.getData("system","","","DBConnectionPool","executeQuery",p);
			System.out.println("[Get Case List For Statistic]: "+result.getDescription());
			if (result.getErrorCode()==0){
				db.ResultData rData = (db.ResultData)result.getResults()[0];
				cw = rData.getDatas();
			}
			return cw;
		}
		
		public Vector<Vector> searchCaseByKeywords(String acct,String ctype,String startdate,String enddate,String keywords){
			String pp[] = new String[]{acct,acct,startdate,enddate,"%"+keywords+"%"};
			Vector<Vector> cw;
			cw = new Vector<Vector>();
			Object[] p;
			p = null;
			p = new Object[]{"SELECT ZHUTIMINGCHENG,FAQIREN,ZHUTILEIBIE,LINGYUBIANMA,FAQISHIJIAN,DUIYINGZHUTI,LINGYUMINGCHENG,SUOSHUJIAOSHI,FLAG,SFLAG,ZHUTISN,ESTAT,SASSIGNTO FROM NICWF.V_WF_ALLNOTES WHERE NTYPE='T' and (FAQIREN = ? or SASSIGNTO in (select acctname from ca.tdacct where acct=?)) and faqishijian > to_date(?,'YYYY-MM-DD') and faqishijian < to_date(?,'YYYY-MM-DD') and ZHUTIMINGCHENG like ?",pp};		
			ServiceResult result = DataProviderClient.getData("system","","","DBConnectionPool","executeQuery",p);
			System.out.println("[Get Case List For Search]: "+result.getDescription());
			if (result.getErrorCode()==0){
				db.ResultData rData = (db.ResultData)result.getResults()[0];
				cw = rData.getDatas();
			}
			return cw;
			
		}
		
		public String getRealName(String acct){
			String value="";
			String pp[] = new String[]{acct};
			Object[] p = new Object[]{"SELECT acctname FROM ca.tdacct where acct=?",pp};
			ServiceResult result = DataProviderClient.getData("system","","","DBConnectionPool","executeQuery",p);
			if (result.getErrorCode()==0){
				db.ResultData rData = (db.ResultData)result.getResults()[0];
				String[] colNames = rData.getCollumName();
				java.util.Vector<java.util.Vector> datas = rData.getDatas();
				if (datas!=null){
					for (int i=0;i<datas.size();i++){
						java.util.Vector row = (java.util.Vector)datas.get(i);
						for (int j=0;j<colNames.length;j++){
							value = row.get(j).toString();
						}
					}
				}else System.out.println(rData.getDescription());
			}
			return 	value;
		}
		
		public Vector<Vector> getLatestTen(){
			String pp[] = new String[]{};
			Vector<Vector> cw;
			cw = new Vector<Vector>();
			Object[] p;
			p = null;
			p = new Object[]{"select duiyingzhuti,zhutisn,zhutimingcheng,faqiren,faqishijian,ntype from (select * from nicwf.v_wf_allnotes where FLAG='T' and NTYPE='T' order by ZHUTISN desc) a where rownum < 16",pp};	
			ServiceResult result = DataProviderClient.getData("system","","","DBConnectionPool","executeQuery",p);
			System.out.println("[Get Case List For Today]: "+result.getDescription());
			if (result.getErrorCode()==0){
				db.ResultData rData = (db.ResultData)result.getResults()[0];
				cw = rData.getDatas();
			}
			return cw;
		}
		
		//Add by Eric @ 2010 Jan
		//To find avaliable domainspace and make a  direct access when add a new case, in NIC Today
		public Vector<Vector> getDsByUser(String acct){
				Vector<Vector> cw;
				cw = new Vector<Vector>();
				Object[] p;
				p = null;
				String pp[] = new String[]{acct};
				p = new Object[]{"select LINGYUBIANMA,LINGYUMINGCHENG from nicwf.t_wf_domainspace where ZHUANGTAI = 'T' and LINGYUBIANMA in (select LINGYUBIANMA from nicwf.t_wf_domainspaceowner where acct = ?)",pp};
				ServiceResult result = DataProviderClient.getData("system","","","DBConnectionPool","executeQuery",p);
				System.out.println(result.getDescription());
				if (result.getErrorCode()==0){
					db.ResultData rData = (db.ResultData)result.getResults()[0];
					String[] colNames = rData.getCollumName();
					cw = rData.getDatas();
				}
				return cw;
		}
			
		
}