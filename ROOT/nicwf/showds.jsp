<%@ page contentType="text/html; charset=gb2312" language="java" import="java.sql.*" errorPage="" %>
<%@ page import="sshd.*,java.util.*" %>
<%
	Forms FORMS;
	FORMS = new Forms();
	//int offset = new Integer(FORMS.getConfigFromDb("offset")).intValue();
	Vector<Vector> dsdatas;
	dsdatas = new Vector<Vector>();
	dsdatas =  FORMS.formListReply("","2");
	if(dsdatas == null){
			out.print( "There is not a avaliable Domain Space identified!");
			return;
	}
	Vector<Vector> odsdatas;
	odsdatas = new Vector<Vector>();
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<title>[NICWF] All events domain</title>
<link href="../css1.css" rel="stylesheet" type="text/css" />
</head>

<body>
<%@ include file="top.jsp"%> 
			<% String username = user.getUserName();
			   if (username.equals("public")){
				out.println("无法确认您的身份，发言请先登录");
				return; 	
			   }%>
			<table width="99%" border="0" cellpadding="1" cellspacing="1" class="tfblock">
			<%int osize = 0;
				for (int t=0;t<dsdatas.size();t++){
				Vector dsrow = (java.util.Vector)dsdatas.get(t);
				odsdatas =  FORMS.getDsOwner((String)dsrow.get(0));
				if(odsdatas == null){
					out.print( "no Domain Space owner!");
					osize = 0;
				}else{
					osize = odsdatas.size();
				}
				String aaa = (String)dsrow.get(0);
				Vector<Vector> datas;
				datas = new Vector<Vector>();
				datas = FORMS.formListTopic(dsrow.get(0).toString(),"",1,10);
			%><br><table width="99%" border="0" cellpadding="1" cellspacing="1" class="tfblock">
		    <tr class="txmaintitle">
			    <td colspan="7">事件主题领域：<font size="+1"><a href="showsingleds.jsp?dsid=<%=dsrow.get(0)%>&pg=0"><%=dsrow.get(1)%></a></font>&nbsp;|&nbsp;当前负责:
				<%=dsrow.get(2)%>&nbsp;&nbsp;参与人员【
				<% 
				
				for (int tt=0;tt<osize;tt++){
				Vector odsrow = (java.util.Vector)odsdatas.get(tt); 
					out.print(" "+odsrow.get(2)+"("+odsrow.get(1)+")");
				}%>】</td>
	          </tr>
			  <tr>
			    <%if (datas == null){%>
				<td  bgcolor="#CCCCCC" colspan="7"><img src="../img/Icon_2.gif" alt="领域描述" width="19" height="16" />领域空间描述:<%=dsrow.get(3)%> | <a href="newtopic.jsp?dsid=<%=dsrow.get(0)%>"><img src="../img/Icon_3.gif" alt="记录新事件" width="19" height="16" border="0" />记录新事件</a>&nbsp;|&nbsp;本类主题尚未有人参与</td>
				<%}else{%>
				<td colspan="7"><img src="../img/Icon_2.gif" alt="领域描述" width="19" height="16" />领域空间描述:<%=dsrow.get(3)%>
				<%
					int ctoday = 0;
					int cyesterday = 0;
					for(int x=0;x<datas.size();x++){
						Vector row = (java.util.Vector)datas.get(x); 
						Calendar c = Calendar.getInstance(); 
						long now = c.getTimeInMillis(); 
						c.setTime((java.util.Date)row.get(3)); 
						long lastly = c.getTimeInMillis(); 
						if((now-lastly)<86400000){
							ctoday++;
						}
						if(((now-lastly)<86400000) && ((now-lastly)>172800000)){
							cyesterday++;
						}
					}
				%>
				<br>本类型累计事件数: <img src="../img/icon_01.gif" /> <strong><font color="#000000" size="+1" ><%=datas.size()%></font></strong> | 已处理:<img src="../img/okIcon.jpg" /><strong><font color="#336CC" size="+1"> <%String completed=FORMS.GetComplete((String)dsrow.get(0));out.print(completed);%></font></strong> | 未完成:<img src="../img/question.jpg" /><strong><font color="#FF0000" size="+1"> <%=(new Integer(datas.size()).intValue())-(new Integer(completed).intValue())%></font></strong> | percentages <img src="../img/pie20Iconsm.jpg" />
				<%
				int percent = 0;
				if(new Integer(datas.size()).intValue()!=0){
					percent=new Float(((new Integer(completed).floatValue())/new Integer(datas.size()).floatValue()*100)).intValue();
				}
				if((new Integer(datas.size()).intValue())-(new Integer(completed).intValue()) == 0){
					out.print(" All clear!");
				}else{
					out.print(" "+percent+" done");
				} %> | 最近24小时内事件: <img src="../img/chat_rd.gif" /> <strong><font color="#003399"><%=ctoday%></font></strong> | 24-48小时前事件: <img src="../img/chat_rd.gif" /><strong><font color="#003399"><%=cyesterday%></font></strong>
				 | <a href="newtopic.jsp?dsid=<%=dsrow.get(0)%>"><img src="../img/addsm.jpg" border=0/> 记录新事件</a></td><%}%>
	          </tr>
	  		</table><%}%>
</table>
 <jsp:include page="bottom.jsp"/>
</body>
</html>
