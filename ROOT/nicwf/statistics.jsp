<%@ page contentType="text/html; charset=gb2312" language="java" import="java.sql.*" errorPage="" %>
<%@ page import="sshd.*,java.util.*,java.math.BigDecimal" %>
<%@ page import="wit.user.*,wit.client.*,module.*" %>
<%@ page import="client.*" %>
<%
	Forms FORMS;
	FORMS = new Forms();
	String statstarttime="";
	String stattilltime="";
	UserInfo user;
	user = (UserInfo)session.getAttribute("user");
	String username = user.getUserName();
	
	statstarttime = request.getParameter("statdate1");
	stattilltime = request.getParameter("statdate2");
	if(statstarttime == null){
		//out.println("statstarttime is null");
		statstarttime = "2007-12-31";
	}else{
		if(statstarttime.equals("")){
			statstarttime = "2007-12-31";
		}
	}
	
	if(stattilltime == null){
		//out.println("stattilltime is null");
		stattilltime = "2012-12-21";
	}else{
		if(stattilltime.equals("")){
			stattilltime = "2012-12-21";
		}
	}
	
	/*if (statstarttime.length() == 0 ){
		statstarttime = "2007-12-31";
	}
	if(stattilltime.length() == 0){
		stattilltime = "2012-12-21";
	}*/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<title>[NICWF]Personal Cases Statistic</title>


<style type="text/css">
<!--
.style1 {font-family: "Lucida Console"}
.style2 {font-size: 16px}
.style4 {color: #FF0000}
.style5 {font-size: 18px}
.style7 {font-family: "Lucida Console"; font-size: 16px; }
.style8 {font-size: 14px}
.tfblock table tr .tfblock {
	font-size: 14px;
}
#form_n table tr .txmainnew {
	text-align: center;
}
-->
</style>
<script language=javascript src="wpCalendar.js"></script>
<link href="../css1.css" rel="stylesheet" type="text/css" />
<style type="text/css">
<!--
body {
	margin-left: 0px;
	margin-top: 0px;
	background-color: #FFC;
}
-->
</style></head>
<body>

<form action="../servlet/Bar" method="post" name="statform" id="form_n">
<table width="100%" border="0" cellspacing="1" cellpadding="1">
  <tr>
    <td class="tfblock" height="25" colspan="6" bgcolor="#FFCC99"><img src="../img/Developer_Icons_193.png" width="32" height="32" align="absbottom" />事务统计 Statistic</td>
  </tr>
  <tr bgcolor="#FF9966" class="txmainnew">
    <td height="25" colspan="6" class="tfblock">From
      <input name="statdate1" type="text" id="statdate1" size="20" readonly="readonly" />
      <input type="button" value="选择起始日期" onclick="showCalendar(this,document.all.statdate1)" />
      Till
      <input name="statdate2" type="text" id="statdate2" size="20" readonly="readonly" />
      <input type="button" value="选择终止日期" onclick="showCalendar(this,document.all.statdate2)" />
      <label>
        <input type="submit" name="button" id="button" value="开始统计" />
      </label></td>
    </tr>
   <tr>
    <td height="25" bgcolor="#FFCC99" class="txmainnew1">从<%=statstarttime%> 至 <%=stattilltime%>的事务统计报告<br />
Statistics from <%=statstarttime%> to <%=stattilltime%></td>
    <td height="25" colspan="5" bgcolor="#FFCC99" class="txmainnew1">点击统计数字可查看详细记录</td>
    </tr>
<tr bgcolor="#FFFFFF">
    <td height="25" bgcolor="#FFFFFF" class="txmain">事务类别</td>
    <td width="12%" bgcolor="#FFFFFF" class="txmain" style="text-align: center">累计</td>
    <td width="12%" height="25" bgcolor="#FFFFFF" class="txmain" style="text-align: center">紧急</td>
    <td width="12%" bgcolor="#FFFFFF" class="txmain" style="text-align: center">特别重要</td>
    <td width="12%" bgcolor="#FFFFFF" class="txmain" style="text-align: center">一般</td>
    <td width="12%" class="txmain" style="text-align: center">计划性</td>
  </tr>
 <% 
	Vector<Vector> statdatas;
	statdatas = new Vector<Vector>();
	statdatas = FORMS.getCaseByType(username,"",statstarttime,stattilltime);
	if(statdatas != null){
		String hi="hi";
		request.getSession().setAttribute("sdata",statdatas);
		
	}else{
	}
	
	for(int ttt = 0; ttt< statdatas.size();ttt++){
	  	Vector statrow = (java.util.Vector)statdatas.get(ttt);
%>
  <tr bgcolor="#FFFFFF">
    <td width="38%" height="25" class="txmain"><a  target="_blank" href="showpersonaltask.jsp?ctype=<%=statrow.get(0)%>&ttype=st&statdate1=<%=statstarttime%>&statdate2=<%=stattilltime%>"><%=statrow.get(0)%></a></td>
    <td width="12%" height="25" bgcolor="#FFCC99" class="txmain"><a  target="_blank" href="showpersonaltask.jsp?ctype=<%=statrow.get(0)%>&ttype=st&statdate1=<%=statstarttime%>&statdate2=<%=stattilltime%>"><%out.print( ((BigDecimal)statrow.get(1)).intValue()+ ((BigDecimal)statrow.get(2)).intValue() + ((BigDecimal)statrow.get(3)).intValue() + ((BigDecimal)statrow.get(4)).intValue());%>次</a></td>
    <td width="12%" height="25" bgcolor="#CC3333" class="txmain"> <%=statrow.get(1)%>次</td>
    <td width="12%" bgcolor="#FFFF33" class="txmain"><%=statrow.get(2)%>次</td>
    <td width="12%" bgcolor="#33CCFF" class="txmain"><%=statrow.get(3)%>次</td>
    <td width="12%" bgcolor="#66CC99" class="txmain"><%=statrow.get(4)%>次</td>
  </tr>
<%}%>
</table>
<p>
  <label>
    <input type="submit" name="button2" id="button2" value="查看统计图表"/>
  </label>
</p>

</form>
</body>
</html>
