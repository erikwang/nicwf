<%@ page contentType="text/html; charset=utf-8" language="java" import="java.sql.*" errorPage="" %>
<%@ page import="sshd.*,java.util.*,java.math.BigDecimal" %>
<%@ page import="wit.user.*,wit.client.*,module.*" %>
<%@ page import="client.*" %>
<%
	Forms FORMS;
	FORMS = new Forms();
	Vector<Vector> datas;
	datas = new Vector<Vector>();
	datas = FORMS.getLatestTen();
	String acct = (String)session.getAttribute("acct");	
	Vector<Vector> dsdatas;
	dsdatas = new Vector<Vector>();
	dsdatas = FORMS.getDsByUser(acct);
	
	int ihour = 0;
	
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="refresh" content="60" />

<title>无标题文档</title>
<style type="text/css">
<!--
.tfblock22 {
	font-family: "Lucida Console", Monaco, monospace;
	
}
.tfblock tr td .TitleText {
	font-family: "Lucida Console", Monaco, monospace;
	color:#FFF;
	text-align: center;
}
-->
</style>
<link href="../css1.css" rel="stylesheet" type="text/css" />
</head>

<body>

<table width="100%" border="0" cellpadding="0" cellspacing="0" class="tfblock">
      <tr>
        <td height="30" bgcolor="#0099CC"><p class="TitleText">Nic Latest</p></td>
  </tr><%
		 	String strhour="";
			for(int ttt = 0; ttt< datas.size();ttt++){
	 		 	Vector row = (java.util.Vector)datas.get(ttt);
				Calendar c = Calendar.getInstance(); 
				long now = c.getTimeInMillis(); 
				c.setTime((java.util.Date)row.get(4));
				long lastly = c.getTimeInMillis(); 
				double hour = Math.floor((new Long((now-lastly)/3600000)).doubleValue());
				ihour = new Double(hour).intValue();
				int iihour = ihour;
				if(ihour == 0){
					ihour = new Double(Math.floor((new Long((now-lastly)/60000)).doubleValue())).intValue();
					strhour=ihour+"分钟前";
				}else{
					strhour = ihour+"小时前";
				}
				String ntype =(String)row.get(5);
			%>
          <tr>
            <td height="30" bgcolor="#CCCCCC"><span class="tfblock22">&nbsp;<%if(iihour < 5){%><img src="img/19.gif" width="22" height="9" border="0"/><%}else{out.print("<img src='../img/small_submit.gif' width='11' height='11' />");}%>
			<%	/*if(ntype.equals("T")){
				out.print("<img src='../img/small_submit.gif' width='11' height='11' />");	
				}
			*/%><%=row.get(3)%> <%=strhour%> <a target="_blank" href="http://210.42.24.62:8888/nicwf/showsingletopic.jsp?&topicsn=<%=row.get(0)%>&pg=0#<%=row.get(0)%>"><%=row.get(2)%></a></span></td>
  </tr>
          <%}%>
</table>
<p>&nbsp;</p>
<table width="100%" border="0" cellpadding="0" cellspacing="0" class="tfblock">
  <tr>
    <td height="30" bgcolor="#0099CC"><p class="TitleText">快速记录</p></td>
  </tr>
<%
	for(int t = 0; t<dsdatas.size();t++){
		Vector dsrow = (java.util.Vector)dsdatas.get(t);
%>
  <tr>
    <td height="25"><a href="newtopic.jsp?dsid=<%=dsrow.get(0)%>" target="_blank"><img src="../img/small_submit.gif" width="11" height="11" /><%=dsrow.get(1)%></a></td>
  </tr>
  <%}%>
</table>
<br>
</body>
</html>