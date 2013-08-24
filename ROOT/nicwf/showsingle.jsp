<%@ page contentType="text/html; charset=gb2312" language="java" import="java.sql.*,sshd.*,java.util.*" errorPage="error.jsp" %>
<%
	String showtype,id;
	showtype = request.getParameter("type");
	id = request.getParameter("id");
	Forms FORMS;
	FORMS = new Forms();
	Vector<Vector> datas;
	datas = new Vector<Vector>();
	datas = FORMS.formListReply(id,showtype);
	Vector row = (java.util.Vector)datas.get(0);
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<title>查看发言</title>
<link href="../css1.css" rel="stylesheet" type="text/css" />
</head>

<body>
<table width="50%" border="0" cellpadding="1" cellspacing="1" class="tfblock">
  <tr class="txmaintitle">
    <td colspan="2">主题: <%=row.get(0)%></td>
  </tr>
  <tr>
    <td>发起人:<%=row.get(1)%></td>
    <td>主题类别:<%=row.get(2)%></td>
  </tr>
  <tr>
    <td colspan="2">主题领域:<%=row.get(3)%></td>
  </tr>
  <tr>
    <td colspan="2">发起时间:<%=row.get(5)%></td>
  </tr>
  <tr>
    <td colspan="2"><p>&nbsp;</p>
      <p><%=row.get(4)%></p></td>
  </tr>
  <tr><td colspan="2"><iframe name="imgframe" width="99%" scrolling="auto"  height="300" src="showimg.jsp?imgtemp=<%=id%>"></iframe></td></tr>
  <tr>
</table>
<p><a href="showalltopicslist.jsp">返回所有发言</a></p>
</body>
</html>
