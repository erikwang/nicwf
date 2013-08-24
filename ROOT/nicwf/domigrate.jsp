<%@ page contentType="text/html; charset=gb2312" language="java" import="sshd.*,java.io.*" errorPage="" %>
<%@ include file="top.jsp"%>
<%
	Forms FORMS;
	FORMS = new Forms();
	String topicsn="";
	String mdsid="";
	topicsn = request.getParameter("id");	
	mdsid = request.getParameter("dsid");

	
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>[NICWF] do migrate</title>
<link href="../css1.css" rel="stylesheet" type="text/css" />
</head>
<body>

			<% String username = user.getUserName();
			   if (username.equals("public")){
				out.println("无法确认您的身份，发言请先登录");
				return; 	
			   }
			   if (FORMS.DoMigrate(topicsn,mdsid)){
			//FORMS.saveTopicBlob(topicname,topictype,txmain,txowner,dsid,uip,imgid);
	}else{
		out.println("!!!Exceptions!!!");
	}

%>
<table width="50%" border="0" cellpadding="1" cellspacing="1" class="txmain">
  <tr>
    <td height="20" class="txmainnew1"><p>&nbsp;</p>        </td>
  </tr>
  <tr>
    <td><p align="center">事件&nbsp;[<font size="+1" color="#FF0000"><%=topicsn%></font>]&nbsp;已成功转移</p>
      <p align="center"><img src="../img/okIcon.jpg" width="32" height="32" /></p>
    <p align="center"><a href="showsingleds.jsp?dsid=<%=mdsid%>&amp;pg=0">查看所有事件</a></p></td>
  </tr>
</table>
</body>

</html>
