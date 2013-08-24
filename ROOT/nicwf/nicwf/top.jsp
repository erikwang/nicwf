<%@ page contentType="text/html; charset=gb2312"   %>
<%@ page import="java.sql.*,wit.user.*,wit.client.*,module.*" %>
<%  String dsid;
	
	UserInfo user = (UserInfo)session.getAttribute("user");
	if (user==null){
		user = new UserInfo("public","public","");
	}
	String lusername = user.getParameterValue("name");
	String xdsid = (String)session.getAttribute("xdsid");
	session.setAttribute("id",user.getUserName());
%>
<script language="javascript">
  function get_time()
  {
    var date=new Date();
    var year="",month="",day="",week="",hour="",minute="",second="";
    year=date.getYear();
    month=add_zero(date.getMonth()+1);
    day=add_zero(date.getDate());
    week=date.getDay();
    switch (date.getDay()) {
    case 0:val="星期天";break
    case 1:val="星期一";break
    case 2:val="星期二";break
    case 3:val="星期三";break
    case 4:val="星期四";break
    case 5:val="星期五";break
    case 6:val="星期六";break
      }
    hour=add_zero(date.getHours());
    minute=add_zero(date.getMinutes());
    second=add_zero(date.getSeconds());
    timetable.innerText=year+"."+month+"."+day+" "+hour+":"+minute+":"+second+" "+val;
  }
  function add_zero(temp)
  {
    if(temp<10) return "0"+temp;
    else return temp;
  }
setInterval("get_time()",1000);
  </script>

<style type="text/css">
<!--
.style1 {
	font-size: 12px;
	font-family: "Lucida Console";
}
-->
</style>

<link href="../css1.css" rel="stylesheet" type="text/css" />
<style type="text/css">
<!--
.style22 {
	font-family: "Lucida Console";
	font-size: 24px;
}
.style33 {
	font-size: 16px;
	color: #FFFFFF;
}

.style44 {
	font-size: 18px;
	color: #FFFFFF;
}
-->

</style>

<table width="99%" border="0" cellpadding="0" cellspacing="0" >
              <tr>
                <td  align="left"  colspan="3" class="txmainnew1 style22"><span class="style44">W</span><span class="style33">elcome to Nic Workflow &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; | current time: <span id="timetable" align="right"></span></span></td>
             
              </tr>
			  <tr align="left" class="line1">
                <td width="33%" height="25"  background="../img/line1.gif" class="line1"><p align="left" class="style1"><font  color="#00CCCC">欢迎</font> <%=lusername%> <a href="../nicwf/login.jsp"><img src="../img/fav_add.gif" width="16" height="16" border="0" /> </a><a href="../nicwf/login.jsp">登录</a> | <a href="showpersonaltask.jsp">My Tasks</a> | <a href="showfulltask.jsp">Full Tasks</a></p>                </td>
                <td width="19%" height="25"  background="../img/line1.gif" class="line1 style1"><div align="left"><a href="showsingleds.jsp?dsid=<%=xdsid%>&amp;pg=0">返回本领域</a></div></td>
                <td width="48%" height="25"  background="../img/line1.gif" class="line1 style1"><div align="left"><a href="loading.jsp">返回所有领域</a> </div></td>
              </tr>
</table>
<% if (lusername == null){
		out.println("Not a authentic visiter.");
		lusername = "游客";
	}
%>
