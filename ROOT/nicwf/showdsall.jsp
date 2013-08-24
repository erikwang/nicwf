<%@ page contentType="text/html; charset=gb2312" language="java" import="java.sql.*" errorPage="" %>
<%@ page import="sshd.*,java.util.*" %>
<%
	Forms FORMS;
	FORMS = new Forms();
	//int offset = new Integer(FORMS.getConfigFromDb("offset")).intValue();
	Vector<Vector> dsdatas;	
	dsdatas = new Vector<Vector>();
	
	Vector<Vector> odsdatas;
	odsdatas = new Vector<Vector>();
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<title>showdsall</title>
<link href="../css1.css" rel="stylesheet" type="text/css" />
</head>

<body>
	<jsp:include page="top.jsp"/>
      <%
      	String userid = (String)session.getAttribute("id");
      	dsdatas =  FORMS.getDsByOwner(userid);
				
				if(dsdatas == null){
					out.print( "There is not a avaliable Domain Space identified!");
					return;
				}
      %>
      <p><a href="loading.jsp"><span class="txmainnew">查看所有领域</span></a></p>
			<table width="99%" border="0" cellpadding="1" cellspacing="1" class="tfblock">
			<%  for (int t=0;t<dsdatas.size();t++){
				Vector dsrow = (java.util.Vector)dsdatas.get(t);
				/*odsdatas =  FORMS.getDsOwner((String)dsrow.get(0));
				if(odsdatas == null){
					out.print( "no Domain Space owner!");
				}*/
			%><br><table width="99%" border="0" cellpadding="1" cellspacing="1" class="tfblock">
		    <tr class="txmaintitle">
			    <td colspan="7">事件主题领域：<font size="+1"><a href="showsingleds.jsp?dsid=<%=dsrow.get(0)%>&pg=0"><%=dsrow.get(1)%></a></font>&nbsp;|&nbsp;当前负责:
				<%=dsrow.get(2)%>&nbsp;&nbsp;
				<%/*%>参与人员【
				<% for (int tt=0;tt<odsdatas.size();tt++){
					Vector odsrow = (java.util.Vector)odsdatas.get(tt); 
					out.print(" "+odsrow.get(2)+"("+odsrow.get(1)+")");
				}%>】<%*/%></td>
	          </tr>
			  <tr>
			    <%if ( new Integer(dsrow.get(4).toString()).intValue() == 0 ){%>
				<td  bgcolor="#CCCCCC" colspan="7"><img src="../img/Icon_2.gif" alt="领域描述" width="19" height="16" />领域空间描述:<%=dsrow.get(3)%> | <a href="newtopic.jsp?dsid=<%=dsrow.get(0)%>"><img src="../img/Icon_3.gif" alt="发起新主题" width="19" height="16" border="0" />发起新主题</a>&nbsp;|&nbsp;本主题尚未有人参与</td><%}else{%>
				<td colspan="7"><img src="../img/Icon_2.gif" alt="领域描述" width="19" height="16" />领域空间描述:<%=dsrow.get(3)%> | <a href="newtopic.jsp?dsid=<%=dsrow.get(0)%>"><img src="../img/Icon_3.gif" alt="发起新主题" width="19" height="16" border="0" />发起新主题</a>&nbsp;|&nbsp;本主题累计主题数:<font color="#FF0000" size="+1"><%=dsrow.get(4)%></font></td><%}%>
	          </tr>
	  		</table><%}%>
</table>
 <jsp:include page="bottom.jsp"/>
</body>
</html>
