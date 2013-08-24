<%@ page contentType="text/html; charset=gb2312" language="java" import="java.sql.*,wit.user.*,wit.client.*,module.*" errorPage="error.jsp" %>
<%	
	String uname;
	String upswd;
	String resultstr = "Welcome. please login";
	uname = request.getParameter("tfusername");
	upswd = request.getParameter("tfpassword");	
	ServiceResult rs = RPCClient.call("http://210.42.24.34:8080/axis2/services/User","http://user.ws","login",new Object[]{new UserInfo("public","public",""),new UserInfo(uname,upswd,"")});
    UserInfo uInfo = new UserInfo();
    if (rs.getErrorCode()==0){
			uInfo = (UserInfo)(rs.getResults()[0]);
			//private_level = uInfo.getParameterValue("private_level");
			session.setAttribute("user",uInfo);
			response.sendRedirect("usercenter.jsp");	
	}else{
		resultstr = "Exception during your login progress with error code:"+rs.getErrorCode();
	}

%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<title>nicwf login</title>
<style type="text/css">
<!--
.style1 {font-family: "Lucida Console"}
-->
</style>
</head>

<body>

<table width="80%" border="1">
  <tr bgcolor="#CCCCCC">
    <td height="25">&nbsp;</td>
  </tr>
  <tr>
    <td><form action="login.jsp" method="post" name="form1" class="style1" id="form1">
  <p align="center">&nbsp;    </p>
  <p align="center">username
    <input name="tfusername" type="text" id="tfusername" />
  </p>
  <p align="center">
    password
    <input name="tfpassword" type="password" id="tfpassword" />
</p>
  <p align="center">
    <input type="submit" name="Submit" value="login" />
  </p>
  <p align="center">Message:<%=resultstr%></p>
    </form></td>
  </tr>
  <tr bgcolor="#CCCCCC">
    <td height="25">&nbsp;</td>
  </tr>
</table>
</body>
</html>
