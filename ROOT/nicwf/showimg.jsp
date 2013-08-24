<%@ page contentType="text/html; charset=gb2312"  errorPage="error.jsp" %>
<%@ page import="sshd.*,java.util.*"%>
<title>[EMP] showimg</title>
<link href="../css1.css" rel="stylesheet" type="text/css" />

<%
	String imgtemp = request.getParameter("imgtemp");
	Forms FORMS;
	FORMS = new Forms();
	Vector<Vector> datas;
	datas = new Vector<Vector>();
	datas = FORMS.getImg(imgtemp);
%>
  
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<style type="text/css">
<!--
.style1 {font-size: 12px}
-->
</style>
<head>
<title>[NICWF] 新主题发表完成</title>
<link href="../css1.css" rel="stylesheet" type="text/css" />
<style type="text/css">
<!--
body {
	background-color: #FFFFCC;
}

#apDiv1 {
	position:absolute;
	left:352px;
	top:71px;
	width:148px;
	height:87px;
	z-index:1;
	background-color: #FFFFFF;
}
-->
  </style>
<script type="text/javascript"> 
function openUpload(URL)
{
    window.
	window.getSelection();
	n = window.open(URL,"ImgView","width=560,height=460");
    n.focus();
}
function ddd(obj, sType) { 
	var oDiv = document.getElementById(obj); 
	if (sType == 'show') { oDiv.style.display = 'block';} 
	if (sType == 'hide') { oDiv.style.display = 'none';} 
} 

</script> 
</head>
<body>
<p align="center" class="block style1">Tip:当有附件变更时请点击[刷新]</p>
<% for (int i=0;i<datas.size();i++){
  	Vector row = (java.util.Vector)datas.get(i);
	boolean flag = FORMS.getIsImg((String)row.get(4));
%>
<table width="99%">
  <tr>
    <td width="120" height="70" rowspan="2" bgcolor="#FFFFFF" class="tfblock" ><div align="center"><a href="<%=row.get(7)%>"><%if(flag){%>
	<img src="<%=row.get(7)%>" width="80" height="60" border="0" />
	<%}else{%><img src="../img/File20Icon.jpg"  border="0"/><%}%>
	</a></div></td>
    <td height="34" bgcolor="#FFFFFF" class="tfblock" >下载附件:<%=row.get(0)%> | <%=row.get(3)%> |<a href="<%=row.get(7)%>"><%=row.get(1)%></a>  </td>
  </tr>
  <tr>
  <td height="34" bgcolor="#FFFFFF" class="tfblock" >
     <%if(flag){ out.print("引用图片到发言请复制以下内容并粘贴到发言正文中预期的位置"); %>
	 <input name="textfield" type="text" onMouseMove="this.focus();this.select();" value="<%=row.get(7)%>" size="80" readonly="true" <%=row.get(7)%>"></td>
	<%}else{out.print("引用文件下载链接到发言请复制以下内容并粘贴到发言正文中预期的位置");%>
<input name="textfield" type="text" size="80" readonly="true" value="&lt;a href=&quot;<%=row.get(7)%>&quot;&gt;<%=row.get(7)%>&lt;/a&gt;" onMouseMove="this.focus();this.select();" <%=row.get(7)%>"></td>
	<%}%>
  </tr>
  <%}%>
</table>
</body>
</html>