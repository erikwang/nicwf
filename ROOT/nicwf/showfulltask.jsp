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
	//String username = user.getUserName();
	Vector<Vector> mdatas;
	mdatas = new Vector<Vector>();
	mdatas =  FORMS.GetMembers();
	if(mdatas == null){
			out.print( "There is no member in the system!");
			return;
	}
	Vector<Vector> datas;
	datas = new Vector<Vector>();
%>
</p>
<%	
	for(int t=0; t<mdatas.size();t++){
  	Vector mrow = (java.util.Vector)mdatas.get(t);
%>
<table width="90%" border="0" cellpadding="1" cellspacing="3">
  <tr class="txmainnew1">
    <td colspan="7" class="txmainnew1">Member:<%=mrow.get(1)%></td>
  </tr>
  <tr class="txmainnew1">
    <td width="30%" class="txmainnew1"><div align="center">事件名称</div></td>
    <td width="15%" class="txmainnew1"><div align="center">所属领域</div></td>
    <td class="txmainnew1"><div align="center">发起时间</div></td>
    <td width="10%" class="txmainnew1"><div align="center">事件级别</div></td>
    <td width="32" class="txmainnew1"><div align="center">状态</div></td>
    <td class="txmainnew1"><div align="center">记录</div></td>
    <td class="txmainnew1">转移</td>
  </tr>
  <% 	
   datas =  FORMS.GetPersonalTask((String)mrow.get(0),"","a");
   if(datas.size()>0){
   	for(int tt = 0; tt< datas.size();tt++){
	  Vector row = (java.util.Vector)datas.get(tt);
	  zhutisn = row.get(10).toString();
	   if(! row.get(8).equals("D")){dflag = ("可用");}else{dflag = "已删除";}
	   if(! dflag.equals("已删除")){%>
  			<tr class="style1">
			    <td width="30%" class="txmain"><span class="style1"><a href="showsingletopic.jsp?&topicsn=<%=zhutisn%>&pg=0"><%=row.get(0)%></a></span></td>
			    <td width="15%" class="txmain"><span class="style1"><%=row.get(6)%></span></td>
			    <td class="txmain"><span class="style1"><%=row.get(4)%></span></td>
			    <td width="10%" class="txmain"><div align="center"><%=row.get(11)%></div></td>
			    <td width="32" align="center" valign="middle" class="txmain"><div align="center"><span class="style1">
			       <%if(((String)row.get(9)).equals("已解决")){%>
	      				<img src="../img/okIcon.jpg" width="32" height="32" />
			      <%}else{
					   	if (((String)row.get(9)).equals("申请完成")){%>
			      		<img src="../img/customer.jpg" />
					  	<%}else{%>
					      <img src="../img/question.jpg" width="32" height="32" />
					<%}}%>
				    </span></div></td>
		      <td class="txmain"><div align="center"><%=dflag%></div></td>
			    <td class="txmain"><a href="migrateevent.jsp?id=<%=zhutisn%>">migrate</a></td>
  </tr>
	<%}
  }}else{%>
  <tr class="txmainnew1">
    <td colspan="7" class="block"><div align="center">No events yet.</div></td>
  </tr>
  <%}%>
</table>
<hr>
<%}%>
<p>&nbsp;</p>
<jsp:include page="bottom.jsp"/>
</body>
</html>
