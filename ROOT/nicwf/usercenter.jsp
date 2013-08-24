<%@ page contentType="text/html; charset=gb2312" language="java" import="java.sql.*" errorPage="" %>
<%@ page import="sshd.*,java.util.*,java.math.BigDecimal" %>
<%@ page import="client.*" %>
<%
	Forms FORMS;
	FORMS = new Forms();
	//int offset = new Integer(FORMS.getConfigFromDb("offset")).intValue();
	String zhutisn="";


%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<title>[NICWF] Personal center</title>
<link href="../css1.css" rel="stylesheet" type="text/css" />
<style type="text/css">
<!--
.style1 {font-family: "Lucida Console"}
.style2 {
	font-size: 12px
}
.style4 {color: #FF0000}
.style5 {
	font-size: 14px
}
.style7 {font-family: "Lucida Console"; font-size: 16px; }
.style8 {font-size: 14px}
.tfblock table tr .tfblock {
	font-size: 14px;
}
body {
	background-image: url();
}
.TitleText {
	font-family: "Lucida Console", Monaco, monospace;
	font-size: 16px;
	text-align: center;
	color: #FFF;
}
.ttttt {
	color: #FFF;
	font-family: "Lucida Sans Unicode", "Lucida Grande", sans-serif;
	text-align: center;
	font-size: 18px;
}
-->
</style>
<script language=javascript src="wpCalendar.js"></script>

</head>

<body>
<%@ include file="top.jsp"%> 
  <%
	String username = user.getUserName();
	if (username.equals("public")){
		out.println("无法确认您的身份，发言请先登录");
	return; 	
	}
%>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td width="80%" rowspan="3"><table width="100%" border="0" cellpadding="1" cellspacing="2">
      <tr>
        <td width="80%" height="48" valign="middle" bgcolor="#FFFFFF" class="tfblockbg2"><span class="style7">用户中心 Welcome to
          User center</span></td>
      </tr>
      <tr>
        <td width="80%" valign="top" bgcolor="#FFFFCC" class="tfblock"><%
	
	Vector<Vector> sdatas;
	sdatas = new Vector<Vector>();
	sdatas = FORMS.GetTaskStatisticInOut(username,"","");
	Vector srow = (java.util.Vector)sdatas.get(0);
	
	
	Vector<Vector> wfcdatas;
	wfcdatas = new Vector<Vector>();
	wfcdatas = FORMS.GetTasksForConclusion(username);
	
%>
          <table width="98%" border="0" cellpadding="1" cellspacing="3">
            <tr>
              <td height="44" bgcolor="#FFCC99" class="tfblock"><img src="../img/Developer_Icons_264.png" alt="" width="32" height="32" align="absbottom" /><span class="style7"><span class="style8">用户名
                user account:</span> <font color="#FF0033"><%=username%></font></span></td>
            </tr>
          </table>
          <br />
          <table width="98%" border="0" cellpadding="1" cellspacing="3">
            <tr>
              <td height="40" colspan="2" bgcolor="#FFCC99" class="tfblock"><img src="../img/Developer_Icons_215.png" alt="" width="32" height="32" align="absbottom" /><span class="style1 style8">我的事务
                My cases archivement:</span></td>
            </tr>
            <tr>
              <td width="25%" class="txmainnewad style1">我分配出去的事务: <font size="+2"><a href="showpersonaltask.jsp?ttype=out"><%=srow.get(0)%></a></font></td>
              <td width="50%" class="txmainnewad style1">我被分配的事务: <font size="+2"> <a href="showpersonaltask.jsp?ttype=in&amp;status=a"><%=srow.get(1)%></a></font>&nbsp;<img src="../img/okIcon.jpg" alt="" width="32" height="32" border="1" />[ <a href="showpersonaltask.jsp?ttype=in&amp;status=c"><%=srow.get(2)%></a> ] <img src="../img/customer.jpg" alt="" border="1" />[ <a href="showpersonaltask.jsp?ttype=in&amp;status=w"><%=srow.get(3)%></a> ] <img src="../img/question.jpg" alt="" width="32" height="32" border="1" />[ <a href="showpersonaltask.jsp?ttype=in&amp;status=p">
              <% out.print(((BigDecimal)(srow.get(1))).intValue() - ((BigDecimal)(srow.get(2))).intValue() - ((BigDecimal)(srow.get(3))).intValue());%>
              </a> ]</td>
            </tr>
          </table>
          <table width="98%">
            <tr>
              <td colspan="2"><form action="showpersonaltask.jsp" target="_blank" method="post" name="seform" id="form_se">
                <table width="100%" border="0" cellspacing="1" cellpadding="1">
                  <tr>
                    <td class="tfblock" height="25" colspan="3" bgcolor="#FFCC99"><img src="../img/Developer_Icons_266.png" alt="" width="32" height="32" align="absbottom" />事务搜索 Search</td>
                  </tr>
                  <tr class="txmainnew">
                    <td width="18%" height="25" bgcolor="#FFFFFF" class="tfblock">Date:</td>
                    <td width="37%" bgcolor="#FFFFFF" class="tfblock">From
                      <input name="statdate1" type="text" id="statdate1" size="10" readonly="readonly" />
                      <input type="button" value="选择起始日期" onclick="showCalendar(this,document.all.statdate1)" /></td>
                    <td width="45%" height="25" bgcolor="#FFFFFF" class="tfblock">Till
                      <input name="statdate2" type="text" id="statdate2" size="10" readonly="readonly" />
                      <input type="button" value="选择终止日期" onclick="showCalendar(this,document.all.statdate2)" />
                      <input type="hidden" name="ttype" id="ttype" value="se" /></td>
                  </tr>
                  <tr class="txmainnew">
                    <td height="25" bgcolor="#FFFFFF" class="tfblock">Key Words in Title </td>
                    <td height="25" bgcolor="#FFFFFF" class="tfblock"><input name="tfkeywords" type="text" id="tfkeywords" size="40" /></td>
                    <td height="25" bgcolor="#FFFFFF" class="tfblock"><input type="submit" name="button" id="button" value="搜索" /></td>
                  </tr>
                </table>
              </form></td>
            </tr>
          </table>
          <% if(((BigDecimal)(srow.get(1))).intValue() - ((BigDecimal)(srow.get(2))).intValue() - ((BigDecimal)(srow.get(3))).intValue() > 0){ %>
          <table width="98%">
            <tr>
              <td valign="middle" bgcolor="#FFCC99" class="tfblock"><div><img src="../img/Developer_Icons_201.png" alt="" width="32" height="32" align="absbottom" />有需要完成的事务，点击查看 | <a href="showpersonaltask.jsp?ttype=in&amp;status=p">Unclosed cases found, click to check</a></div></td>
            </tr>
          </table>
          <%}%>
          <br />
          <table width="98%" border="0" cellpadding="1" cellspacing="3">
            <tr>
              <td bgcolor="#FFCC99" class="tfblock"><img src="../img/Developer_Icons_203.png" alt="" width="32" height="32" align="absbottom" />等待我给予结论的事务
                
                Tasks need to give conclusion by me </td>
            </tr>
          </table>
          <table width="98%" border="0" cellpadding="1" cellspacing="3">
            <tr class="txmainnew1">
              <td width="30%" class="txmainnew1"><div align="center">事务名称</div></td>
              <td width="10%" class="txmainnew1"><div align="center">所属领域</div></td>
              <td width="18%" class="txmainnew1"><div align="center">发起时间</div></td>
              <td width="10%" class="txmainnew1"><div align="center">事务级别</div></td>
              <td width="10%" class="txmainnew1"><div align="center">状态</div></td>
              <td width="6%" class="txmainnew1"><div align="center">记录</div></td>
              <td width="6%" class="txmainnew1"><div align="center">转移</div></td>
            </tr>
            <%
  String dflag = "";
  for(int tt = 0; tt< wfcdatas.size();tt++){
  Vector wfcrow = (java.util.Vector)wfcdatas.get(tt);
  zhutisn = wfcrow.get(10).toString();
  if(! wfcrow.get(8).equals("D")){dflag = ("可用");}else{dflag = "已删除";}
  if(! dflag.equals("已删除")){
 %>
            <tr bgcolor="#FFFFFF" class="style1">
              <td width="30%" class="txmain"><a href="showsingletopic.jsp?&amp;topicsn=<%=zhutisn%>&amp;pg=0"><%=wfcrow.get(0)%></a></td>
              <td width="10%" class="txmain"><%=wfcrow.get(6)%></td>
              <td width="18%" class="txmain"><%=wfcrow.get(4)%></td>
              <td width="10%" class="txmain"><div align="center"><%=wfcrow.get(11)%></div></td>
              <td width="10%" align="center" valign="middle" class="txmain"><div align="center">
                <%if(((String)wfcrow.get(9)).equals("已解决")){%>
                <img src="../img/okIcon.jpg" alt="" width="32" height="32" />
                <%}else{
	   	if (((String)wfcrow.get(9)).equals("申请完成")){%>
                <img src="../img/customer.jpg" alt="" />
                <%}else{%>
                <img src="../img/question.jpg" alt="" width="32" height="32" />
                <%}}%>
              </div></td>
              <td width="6%" class="txmain"><div align="center"><%=dflag%></div></td>
              <td width="6%" class="txmain"><div align="center"><a href="migrateevent.jsp?id=<%=zhutisn%>">migrate</a></div></td>
            </tr>
            <%}}%>
          </table>
          <br />
          <iframe frameborder="no" scrolling="Auto" width="99%" height="520" src="statistics.jsp" ></iframe>
         </td>
      </tr>
    </table></td>
    <td width="20%" valign="top"><div width="99%"><iframe height="800" frameborder="no" scrolling="no" src="twitter.jsp" ></iframe></div></td>
  </tr>
   <tr>
    <td valign="bottom">&nbsp;</td>
  </tr>
</table>

<br />
<jsp:include page="bottom.jsp"/>
</body>
</html>
