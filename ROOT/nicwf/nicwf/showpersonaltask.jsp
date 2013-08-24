<%@ page contentType="text/html; charset=gb2312" language="java" import="java.sql.*" errorPage="" %>
<%@ page import="sshd.*,java.util.*" %>
<%@ page import="client.*" %>
<%
	Forms FORMS;
	FORMS = new Forms();
	//int offset = new Integer(FORMS.getConfigFromDb("offset")).intValue();
	String dflag = "";
	String zhutisn="";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<title>[NICWF] All events domain</title>
<link href="../css1.css" rel="stylesheet" type="text/css" />
<style type="text/css">
<!--
.style1 {font-family: "Lucida Console"}
-->
</style>
</head>

<body>
<%@ include file="top.jsp"%>        
<p>
  <%
	String username = user.getUserName();
	if (username.equals("public")){
		out.println("无法确认您的身份，发言请先登录");
	return; 	
	}
	Vector<Vector> datas;
	datas = new Vector<Vector>();
	datas =  FORMS.GetPersonalTask(username);
	if(datas == null){
			out.print( "There is not a avaliable Domain Space identified!");
			return;
	}
%>
</p>
<table width="80%" border="0" cellpadding="1" cellspacing="3">
  <tr class="txmainnew1">
    <td class="txmainnew1"><div align="center">事件名称</div></td>
    <td class="txmainnew1"><div align="center">所属领域</div></td>
    <td class="txmainnew1"><div align="center">发起时间</div></td>
    <td class="txmainnew1"><div align="center">状态</div></td>
    <td class="txmainnew1"><div align="center">记录</div></td>
    <td class="txmainnew1"><div align="center">转移</div></td>
  </tr>
  <% for(int t = 0; t< datas.size();t++){
  Vector row = (java.util.Vector)datas.get(t);
  zhutisn = row.get(10).toString();
  if(! row.get(8).equals("D")){dflag = ("可用");}else{dflag = "已删除";}
  if(! dflag.equals("已删除")){%>
  <tr class="style1">
    <td class="txmain"><span class="style1"><a href="showsingletopic.jsp?&topicsn=<%=zhutisn%>&pg=0"><%=row.get(0)%></a></span></td>
    <td class="txmain"><span class="style1"><%=row.get(6)%></span></td>
    <td class="txmain"><span class="style1"><%=row.get(4)%></span></td>
    <td width="30" align="center" valign="middle" class="txmain"><div align="center"><span class="style1">
      <%if(((String)row.get(9)).equals("已解决")){%>
      <img src="../img/okIcon.jpg" width="32" height="32" />
      <%}else{
	  	if (dflag.equals("已删除")){%>
		<img src="../img/cancel.jpg" />
      <%}else{%>
	  <img src="../img/question.jpg" width="32" height="32" />
      <%}}%>
    </span></div></td>
    <td class="txmain"><div align="center"><%=dflag%></div></td>
    <td class="txmain"><div align="center"><a href="migrateevent.jsp?id=<%=zhutisn%>">migrate</a></div></td>
  </tr>
  <%}}%>
</table>
<p>&nbsp;</p>
<jsp:include page="bottom.jsp"/>
</body>
</html>
