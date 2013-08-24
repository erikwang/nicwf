<%@ page contentType="text/html; charset=gb2312" language="java" import="java.sql.*" errorPage="" %>
<%@ page import="sshd.*,java.util.*" %>
<%@ page import="client.*" %>
<%
	Forms FORMS;
	FORMS = new Forms();
	//int offset = new Integer(FORMS.getConfigFromDb("offset")).intValue();
	String dflag = "";
	String zhutisn="";
	String tasktype="";
	String taskstatus="";
	String statstarttime="";
	String stattilltime="";
	String ctype="";
	String keywords="";
	statstarttime = request.getParameter("statdate1");
	stattilltime = request.getParameter("statdate2");
	if(request.getParameter("ctype") != null){
		if(! request.getParameter("ctype").equals("")){
			ctype = new String(request.getParameter("ctype").getBytes("iso8859-1"),"gb2312");
		}
	}
	if(request.getParameter("tfkeywords") != null){
		if(! request.getParameter("tfkeywords").equals("")){
			keywords = new String(request.getParameter("tfkeywords").getBytes("iso8859-1"),"gb2312");
			
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
	
	tasktype =request.getParameter("ttype");
	taskstatus = request.getParameter("status");
	
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
.style2 {font-size: 16px}
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

%>
</p>
<% 
  String title;
  Vector<Vector> indatas;
  indatas = new Vector<Vector>();
	if(tasktype.equals("se")){
		indatas = FORMS.searchCaseByKeywords(username,"",statstarttime,stattilltime,keywords);
		title = "搜索事务 Search for cases From "+statstarttime+" TO "+stattilltime+" With keywords: "+keywords;
	}else{
		if(tasktype.equals("st")){
		indatas =  FORMS.getStatCaseByType(username,ctype,statstarttime,stattilltime);
		title = "统计事务 STATISTICS @ "+ctype+" From "+statstarttime+" TO "+stattilltime;
		}else{
			if(tasktype.equals("in")){
			  indatas =  FORMS.GetPersonalTask(username,"in",taskstatus);
			  title = "我被分配的事务 IN";
			}else{
				indatas =  FORMS.GetPersonalTask(username,"out","");
				title = "我分配出去的事务 OUT";
			}
		}
	}
  
	if(indatas == null){
			out.print( "There is not a avaliable Domain Space identified!");
			return;
	}
%>
<table width="90%" border="0" cellpadding="1" cellspacing="3">
  <tr>
    <td colspan="8" class="txmainnew1 style1 style2">My Tasks <%=title%> 累计 <%=indatas.size()%> 条记录</td>
  </tr>
  <tr class="txmainnew1">
    <td width="30%" class="txmainnew"><div align="center">事件名称</div></td>
    <td class="txmainnew"><div align="center">所属领域</div></td>
    <td class="txmainnew"><div align="center">发起时间</div></td>
    <td class="txmainnew"><div align="center">分配</div></td>
    <td width="15%" class="txmainnew"><div align="center">事件级别</div></td>
    <td class="txmainnew"><div align="center">状态</div></td>
    <td class="txmainnew"><div align="center">记录</div></td>
    <td class="txmainnew"><div align="center">转移</div></td>
  </tr>
 <%
  for(int tt = 0; tt< indatas.size();tt++){
  Vector inrow = (java.util.Vector)indatas.get(tt);
  zhutisn = inrow.get(10).toString();
  if(! inrow.get(8).equals("D")){dflag = ("可用");}else{dflag = "已删除";}
  if(! dflag.equals("已删除")){
 %>
  <tr class="style1">
    <td width="30%" class="txmain"><a href="showsingletopic.jsp?&amp;topicsn=<%=zhutisn%>&amp;pg=0"><%=inrow.get(0)%></a></td>
    <td class="txmain"><%=inrow.get(6)%></td>
    <td class="txmain"><%=inrow.get(4)%></td>
    <td class="txmain"><%=inrow.get(1)%> -> <%=inrow.get(12)%></td>
    <td width="15%" class="txmain"><div align="center"><%=inrow.get(11)%></div></td>
    <td width="30" align="center" valign="middle" class="txmain"><div align="center">
   
	  <%if(((String)inrow.get(9)).equals("c")){%>
	      <img src="../img/okIcon.jpg" width="32" height="32" />
      <%}else{
	   	if (((String)inrow.get(9)).equals("w")){%>
      		<img src="../img/customer.jpg" />
	  	<%}else{%>
	      <img src="../img/question.jpg" width="32" height="32" />
		<%}}%>

    </div></td>
    <td class="txmain"><div align="center"><%=dflag%></div></td>
    <td class="txmain"><div align="center"><a href="migrateevent.jsp?id=<%=zhutisn%>">migrate</a></div></td>
  </tr>
  <%}}%>
</table>
<jsp:include page="bottom.jsp"/>
</body>
</html>
