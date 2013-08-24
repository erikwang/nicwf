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
	String keywords="";
	
	statstarttime = request.getParameter("statdate1");
	stattilltime = request.getParameter("statdate2");
	
	
	if(request.getParameter("tfkeywords") != null){
		if(! request.getParameter("tfkeywords").equals("")){
			keywords = "%"+new String(request.getParameter("tfkeywords").getBytes("iso8859-1"),"gb2312")+"%";
			
		}
	}
	
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
<title>[NICWF]Personal Cases Search</title>


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
</head>
<body>

<form action="search.jsp" method="post" name="statform" id="form_n">
<table width="100%" border="0" cellspacing="1" cellpadding="1">
  <tr>
    <td class="tfblock" height="25" colspan="2" bgcolor="#FFCC99">事务统计 Statistic</td>
  </tr>
  <tr bgcolor="#FF9966" class="txmainnew">
    <td height="25" class="tfblock">From
      <input name="statdate1" type="text" id="statdate1" size="20" readonly="readonly" />
      <input type="button" value="Show Calendar" onclick="showCalendar(this,document.all.statdate1)" /></td>
    <td height="25" class="tfblock">Till
      <input name="statdate2" type="text" id="statdate2" size="20" readonly="readonly" />
      <input type="button" value="Show Calendar" onclick="showCalendar(this,document.all.statdate2)" /></td>
  </tr>
  <tr bgcolor="#FF9966" class="txmainnew">
    <td height="25" colspan="2" class="tfblock">Key Words in Title
      <input name="tfkeywords" type="text" id="tfkeywords" size="40" />
      <input type="submit" name="button" id="button" value="提交" /></td>
    </tr>
   <tr>
    <td class="txmainnew1" height="25" bgcolor="#FFCC99">从<%=statstarttime%> 至 <%=stattilltime%>的事务统计报告<br />
Statistics from <%=statstarttime%> to <%=stattilltime%></td>
    <td class="txmainnew1" height="25" bgcolor="#FFCC99">&nbsp;</td>
   </tr>
   <tr>
    <td height="25" colspan="2" bgcolor="#FFCC99" class="txmainnew1">&nbsp;</td>
    </tr>
 <% 
	Vector<Vector> statdatas;
	statdatas = new Vector<Vector>();
	statdatas = FORMS.searchCaseByKeywords(username,"",statstarttime,stattilltime,keywords);
	 for(int ttt = 0; ttt< statdatas.size();ttt++){
	  	Vector statrow = (java.util.Vector)statdatas.get(ttt);
%>
  <tr bgcolor="#FFFFFF">
    <td width="50%" height="25" class="txmain"><%=statrow.get(0)%></td>
    <td height="25" class="txmain">&nbsp;</td>
  </tr>
<%}%>
</table>
</form>

</body>
</html>
