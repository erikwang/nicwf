<%@ page contentType="text/html; charset=gb2312"   %>
<%@ page import="java.sql.*,wit.user.*,wit.client.*,module.*" %>
<%  String dsid;
	String lusername = "";
	String xdsid = (String)session.getAttribute("xdsid");
	UserInfo user;
	String remoteuser = request.getParameter("user");
	if(remoteuser == null){
		user = (UserInfo)session.getAttribute("user");
		if(user == null){
			user = new UserInfo("","","");
			System.out.println(">>>>>>>>Cannot find UserInfo object from session");
		}else{
			System.out.println(">>>>>>>>Get UserInfo object from session");
		}
	}else{
		ServiceResult rs2 = RPCClient.call("http://210.42.24.34:8080/axis2/services/User","http://user.ws","checkOnline",new Object[]{remoteuser,"wf"});
		System.out.println(">>>>>>>>Agent logining...");
		if (rs2.getErrorCode()==0){
			user = new UserInfo(remoteuser,"","");
		}else{
			user = new UserInfo("","","");
		}
	}
	session.setAttribute("user",user);
	lusername = user.getUserName();
	session.setAttribute("acct",lusername);
	System.out.println(">>>>>>>>Set UserInfo object to session, with username"+lusername);
	session.setAttribute("id",lusername);
	System.out.println("!!!"+session.getId());
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
<% if (lusername == ""){
		out.println("Not a authentic visiter.");
		lusername = "游客";
		response.sendRedirect("login.jsp");
	}
%>
<table width="99%" border="0" cellpadding="0" cellspacing="0" >
              <tr>
                <td  align="left"  colspan="3" class="txmainnew1 style22"><span class="style44"><img src="../img/Developer_Icons_194.png" width="32" height="32" align="absbottom" />&nbsp;W</span><span class="style33">elcome to Nic Workflow &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<img src="../img/Developer_Icons_202.png" width="32" height="32" align="absbottom" />&nbsp;<span id="timetable" align="right"></span></span></td>
             
              </tr>
			  <tr align="left" class="line1">
                <td width="33%" height="25"  background="../img/line1.gif" class="line1"><p align="left" class="style1"><font  color="#00CCCC">欢迎</font> <%=lusername%> <a href="../nicwf/login.jsp"><img src="../img/fav_add.gif" width="16" height="16" border="0" /> </a><a href="../nicwf/login.jsp">登录</a> | <img src="../img/Xiao20320Icon.jpg" width="16" height="16" align="absbottom" /><a href="usercenter.jsp">User center</a> | <%if(! lusername.equals("游客")){%><a href="showfulltask.jsp">Full Tasks</a><%}%></p>                </td>
                <%if (xdsid != null){%><td width="19%" height="25"  background="../img/line1.gif" class="line1 style1"><div align="left"><a href="showsingleds.jsp?dsid=<%=xdsid%>&amp;pg=0"><img src="../img/watched_n.gif" width="15" height="15" border="0" />返回当前领域</a></div></td><%}%>
                <td width="48%" height="25"  background="../img/line1.gif" class="line1 style1"><div align="left"><a href="loading.jsp"><img src="../img/question.gif" width="18" height="18" border="0" />返回所有领域</a> </div></td>
              </tr>
</table>

