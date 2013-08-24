<%@ page contentType="text/html; charset=gb2312" language="java" import="java.sql.*" errorPage="" %>
<%@ page import="sshd.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<title>Untitled Document</title>
</head>
<%
	String id = (String)session.getAttribute("id");
	String dsid = (String)session.getAttribute("dsid");
	String imgsn = request.getParameter("sn");
	if (imgsn == null){
		out.println("not a avaliable img sn!");
		return;
	}

	Forms FORMS;
	FORMS = new Forms();
	FORMS.removeImgFile(imgsn);
%>
<body>
<% response.sendRedirect("newimg.jsp?dsid="+dsid+"&id="+id);%>
</body>
</html>
