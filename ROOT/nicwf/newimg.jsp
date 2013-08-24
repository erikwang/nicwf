<%@ page contentType="text/html; charset=gb2312" language="java" import="java.sql.*" errorPage="error.jsp" %>
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
<title>[NICWF] Attachments</title>
<link href="../css1.css" rel="stylesheet" type="text/css" />
<style type="text/css">
<!--
body {
	background-color: #FFFFCC;
}
-->
</style>
<script type="text/javascript"> 

function openUpload(URL)
{
    n = window.open(URL,"ImgView","width=560,height=460");
    n.focus();
}

function closeWindow()
{
     window.opener =null; 
     window.open("","_self");
     window.close(); 
}
</script> 
</head>

<body>
<form name="myform" action="doimg.jsp"  method="post" enctype="multipart/form-data">
<table width="99%" border="0" cellpadding="1" cellspacing="1" bgcolor="#DEE7ED" class="tfblock">
  <tr class="tfblockbg">
    <td height="30" colspan="2" bgcolor="#FFCC00">为发言添加文件</td>
  </tr>
  <tr>
    <td width="35%">选择上传文件 (目前环境不支持中文文件名)      </td>
    <td><input type="file" name="file" /></td>
  </tr>
  <tr>
    <td width="35%">附件描述:</td>
    <td><textarea name="tf_imgref" cols="50" rows="2" id="tf_imgref"></textarea></td>
  </tr>
  <tr>
    <td colspan="2"><input type="submit" name="Submit" value="上传附件" /> 
    <input name="button" type="button"  onclick="closeWindow()" value="结束附件管理"/></td>
  </tr>
  <tr>
    <td colspan="2">&nbsp;</td>
  </tr>
</table>
</form>
<table width="99%" border="1">

  
  <%for (int i=0;i<datas.size();i++){
  		Vector row = (java.util.Vector)datas.get(i);
		boolean flag = FORMS.getIsImg((String)row.get(4));
  %>
  <tr>
    <td width="100" rowspan="2" bgcolor="#FFFFFF" class="tfblock"><a href="<%=row.get(7)%>">
	<%if (flag){%>
	<img src="<%=row.get(7)%>" width="80" height="60" border="0" />
	<%}else{%><img src="../img/FileIcon.jpg" border="0" />
	<%}%></a></td>
    <td bgcolor="#FFFFFF" class="tfblock"><%=row.get(0)%> | <%=row.get(3)%> | <a href="<%=row.get(7)%>"><%=row.get(1)%></a> |  <a href="removeimg.jsp?sn=<%=row.get(0)%>">remove</a></td>
  </tr>
  <tr>
    <%if(flag){%><td bgcolor="#FFFFFF" class="tfblock">&lt;img src=&quot;<%=row.get(7)%>&quot; &gt;</td><%}else{%>
	<td bgcolor="#FFFFFF" class="tfblock"><%=row.get(7)%></td><%}%>
  </tr>
  <%}%>
</table>
</body>
</html>