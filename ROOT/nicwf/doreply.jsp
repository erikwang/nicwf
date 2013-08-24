<%@ page contentType="text/html; charset=gb2312" language="java" import="sshd.*" errorPage="" %>
<%
	String topicid;
	String replytype;
	String replytitle;
	String txmain;
	String rdsid;
	String txowner;
	String imgid;
	String[] achievement;
	replytitle = new String(request.getParameter("tf_replytitle").getBytes("iso8859-1"),"gb2312");
	replytype = new String(request.getParameter("se_replytype").getBytes("iso8859-1"),"gb2312");
	txmain = new String(request.getParameter("tf_main").getBytes("iso8859-1"),"gb2312");
	txowner = new String(request.getParameter("tf_owner").getBytes("iso8859-1"),"gb2312");
	//achievement  = new String(request.getParameterValues("se_achieve").getBytes("iso8859-1"),"gb2312");
	achievement = request.getParameterValues("se_achieve");
	//out.println(achievement);
	/*for(int zz = 0;zz<achievement.length;zz++){
		out.println(achievement[zz]);
	}*/
	//out.println(achievement.length);
	topicid = request.getParameter("hf1");
	rdsid = request.getParameter("tf_dsid");
	imgid = request.getParameter("imgid");
	String uip = request.getRemoteAddr();
	if(txmain.length() == 0){
		out.println("There is nothing to post , please check it out.");
		return;
	}
	Forms FORMS;
	FORMS = new Forms();
	//out.print(topicid);
	String lasthuifu = "";
	int maxfloor = FORMS.getFloor(topicid)+1;
	//out.println(maxfloor);
	
	
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<title>[NICWF] ME Conclusion given</title>
<link href="../css1.css" rel="stylesheet" type="text/css" />
</head>

<body>
<%@ include file="top.jsp"%> 
			<% String username = user.getUserName();
			   if (username.equals("public")){
				out.println("无法确认您的身份，发言请先登录");
				return; 	
			   }
			   if (FORMS.saveReplyBlob(lasthuifu,topicid,replytitle,replytype,txmain,txowner,rdsid,maxfloor,uip,imgid)){
	}else{
		out.println("!!!Exceptions!!!");
		return;
	}

			%>
<table width="50%" border="0" cellpadding="1" cellspacing="1" class="txmain">
  <tr>
    <td class="txmainnew1"><p>&nbsp;</p>    </td>
  </tr>
  <tr>
    <td><p align="center">成功给予结论&nbsp;[<font size="+1" color="#FF0000"><%=replytitle%></font>]&nbsp;</p>
      <p align="center"><img src="../img/okIcon.jpg" width="32" height="32" /></p>
    <p align="center"><a href="showsingletopic.jsp?topicsn=<%=topicid%>&amp;pg=0">查看记录</a> </p></td>
  </tr>
</table>
</body>
</html>
