<%@ page contentType="text/html; charset=gb2312" language="java" import="java.sql.*" errorPage="" %>
<%@ page import="sshd.*,java.util.*"%>
<%
	Forms FORMS;
	FORMS = new Forms();
	Vector<Vector> datas;
	datas = new Vector<Vector>();
	String id;
	id = request.getParameter("id");
	if(id.length() < 1){
		out.println("Not a avaliable id!");
		return;
	}
	datas = FORMS.getImg(id);
	String dsid = request.getParameter("dsid");
	session.setAttribute("id",id);
	session.setAttribute("dsid",dsid);
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<title>upload new img for a note</title>
<link href="../css1.css" rel="stylesheet" type="text/css" />
<style type="text/css">
<!--
body {
	background-color: #FFFFCC;
}
-->
</style></head>

<body>
<form name="myform" action="doimg.jsp"  method="post" enctype="multipart/form-data">
<table width="50%" border="0" cellpadding="1" cellspacing="1" class="tfblock">
  <tr class="tfblockbg">
    <td height="30" colspan="2" bgcolor="#FFCC00">为发言添加图片</td>
  </tr>
  
  
  <tr>
    <td>选择上传图片      </td>
    <td><input type="file" name="file" /></td>
  </tr>
  <tr>
    <td>图片描述:</td>
    <td><textarea name="tf_imgref" cols="50" rows="5" id="tf_imgref"></textarea></td>
  </tr>
  <tr>
    <td colspan="2"><input type="submit" name="Submit" value="上传图片" /></td>
  </tr>
  <tr>
    <td colspan="2"><a href="newreply.jsp?imgid=<%=id%>&dsid=<%=dsid%>">结束回复上传图片</a></td>
  </tr>
</table>
</form>
<table width="50%" border="1">

  <tr>
    <td bgcolor="#000000">&nbsp;</td>
  </tr>
  <%for (int i=0;i<datas.size();i++){
  	Vector row = (java.util.Vector)datas.get(i);
  %>
  <tr>
    <td><%=row.get(0)%> | <%=row.get(3)%> | <a href="<%=row.get(7)%>"><img src="<%=row.get(7)%>" width="60" height="60" /><%=row.get(1)%></a> | &lt;img src=&quot;<%=row.get(7)%>&quot; &gt;</td>
  </tr>
  <%}%>
</table>
<p>&nbsp;</p>
</body>
</html>
