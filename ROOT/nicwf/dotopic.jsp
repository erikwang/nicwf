<%@ page contentType="text/html; charset=gb2312" language="java" import="sshd.*,java.io.*" errorPage="" %>
<%@ include file="top.jsp"%>
<%
	
	String rwflag = user.getParameterValue("readOnly");
	/*if (rwflag.equals("1")){
		out.println("您的权限不允许进行这个操作");
		return;
	}*/
	String topicname;
	String topictype;
	String txmain="";
	String txowner;
	String imgid;
	String susername;
	String suserphone;
	String sdate;
	String splace;
	String stype;
	String sgivenby;
	String sassignto;
	String estat;
	topicname = new String(request.getParameter("tf_topic").getBytes("iso8859-1"),"gb2312");
	topictype = new String(request.getParameter("se_topictype").getBytes("iso8859-1"),"gb2312");
	txmain = new String(request.getParameter("tfmain").getBytes("iso8859-1"),"gb2312");
	txowner = new String(request.getParameter("tf_owner").getBytes("iso8859-1"),"gb2312");
	susername = new String(request.getParameter("tf_submituser").getBytes("iso8859-1"),"gb2312");
	splace = new String(request.getParameter("tf_submitplace").getBytes("iso8859-1"),"gb2312");
	stype = new String(request.getParameter("se_submittype").getBytes("iso8859-1"),"gb2312");
	sgivenby = new String(request.getParameter("se_submitby").getBytes("iso8859-1"),"gb2312");
	estat = new String(request.getParameter("se_level").getBytes("iso8859-1"),"gb2312");
	sassignto = new String(request.getParameter("se_assignto").getBytes("iso8859-1"),"gb2312");;
	suserphone = request.getParameter("tf_submitphone");
	sdate = request.getParameter("tf_submittime");
	dsid = request.getParameter("tf_dsid");
	imgid = request.getParameter("imgid");
	String uip = request.getRemoteAddr();
	Forms FORMS;
	FORMS = new Forms();
	if(txmain.length() == 0 ){
		out.println("无法结论，请给予结论描述.");
		return;
	}
	
	
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>[NICWF] ME New event post successfully</title>
<link href="../css1.css" rel="stylesheet" type="text/css" />
</head>
<body> 

			<% String username = user.getUserName();
			   if (username.equals("public")){
				out.println("无法确认您的身份，发言请先登录");
				return; 	
			   }
			   if (FORMS.saveTopicBlob(topicname,topictype,txmain,txowner,dsid,uip,imgid,susername,suserphone,sdate,splace,stype,sgivenby,sassignto,estat)){
			//FORMS.saveTopicBlob(topicname,topictype,txmain,txowner,dsid,uip,imgid);
	}else{
		out.println("!!!Exceptions!!!");
	}

%>
<table width="50%" border="0" cellpadding="1" cellspacing="1" class="txmain">
  <tr>
    <td class="txmainnew1"><p>&nbsp;</p>        </td>
  </tr>
  <tr>
    <td><p align="center">新事件&nbsp;[<font size="+1" color="#FF0000"><%=topicname%></font>]&nbsp;已成功发表</p>
      <p align="center"><img src="../img/okIcon.jpg" width="32" height="32" /></p>
    <p align="center"><a href="showsingleds.jsp?dsid=<%=dsid%>&amp;pg=0">查看所有事件</a></p></td>
  </tr>
</table>
</body>

</html>
