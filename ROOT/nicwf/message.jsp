<%@ page contentType="text/html; charset=gb2312" language="java" import="java.sql.*" errorPage="" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%
	String message = new String(request.getParameter("message").getBytes("iso8859-1"),"gb2312");
%>

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<title>[NICWF] System notify</title>
<link href="../css1.css" rel="stylesheet" type="text/css" />
</head>

<body>
<table width="80%" border="1">
  <tr>
    <td class="block">&nbsp;</td>
  </tr>
  <tr>
    <td height="60"><%=message%></td>
  </tr>
  <tr>
    <td class="block">&nbsp;</td>
  </tr>
</table>
</body>
</html>
