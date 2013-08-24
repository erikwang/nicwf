<%@ page contentType="text/html; charset=gb2312" language="java" import="sshd.*" errorPage="" %>

<%
	Forms FORMS;
	FORMS = new Forms();
	int offset;
	offset = new Integer(FORMS.getConfigFromDb("offset")).intValue();
	String ntype;
	ntype = request.getParameter("ntype");
	if(ntype == null){
		out.println("Not a avaliable notetype!");
		return;
	}
	String stype="";
	String sgivenby="";
	String susername="";
	String suserphone="";
	String sdate="";
	String splace="";
	String zhutimingcheng="";
	String estat="";
	String sassignto="";
	String adtype="";
	if(ntype.equals("t")){
		susername = new String(request.getParameter("tf_submituser").getBytes("iso8859-1"),"gb2312");
		splace = new String(request.getParameter("tf_submitplace").getBytes("iso8859-1"),"gb2312");
		suserphone = request.getParameter("tf_submitphone");
		sdate = request.getParameter("tf_submittime");
		stype = new String(request.getParameter("se_submittype").getBytes("iso8859-1"),"gb2312");
		sgivenby = new String(request.getParameter("se_submitby").getBytes("iso8859-1"),"gb2312");
		zhutimingcheng = new String(request.getParameter("tf_title").getBytes("iso8859-1"),"gb2312");
		estat = new String(request.getParameter("se_level").getBytes("iso8859-1"),"gb2312");
		sassignto = new String(request.getParameter("se_assignto").getBytes("iso8859-1"),"gb2312");
	}
	String topicid;
	String txmain = new String(request.getParameter("tf_main").getBytes("iso8859-1"),"gb2312");
	String topictype="";
	String sflag="";
	if(request.getParameter("se_replytype") != null){
		sflag = new String(request.getParameter("se_replytype").getBytes("iso8859-1"),"gb2312");
	}
	if(ntype.equals("t") || ntype.equals("r")){	
		topictype = new String(request.getParameter("se_topictype").getBytes("iso8859-1"),"gb2312");
	}
	topicid = request.getParameter("imgid");
	String uip = request.getRemoteAddr();
	if(ntype.equals("a")){
		adtype = new String(request.getParameter("se_adtype").getBytes("iso8859-1"),"gb2312");
	}
	
	if(txmain == null){
		out.println("There is nothing to post , please check it out.");
		return;
	}
	
	
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<title>[NICWF] Events updated</title>
<link href="../css1.css" rel="stylesheet" type="text/css" />
</head>

<body>
<%@ include file="top.jsp"%>
<%	String username = user.getUserName();
	if (username.equals("public")){
		out.println("无法确认您的身份，发言请先登录");
		return; 	
	}
	if(ntype.equals("r")){
		if (FORMS.updateNoteBlobReply(topicid,txmain,uip,ntype,topictype,username,sflag)){
		}else{
			out.println("!!!Exceptions!!!");
			return;
		}
	}
	if(ntype.equals("t")){
	if (FORMS.updateNoteBlob(topicid,txmain,uip,ntype,susername,suserphone,sdate,splace,stype,sgivenby,topictype,username,zhutimingcheng,estat,sassignto)){
		}else{
			out.println("!!!Exceptions!!!");
			return;
		}
	}
	if(ntype.equals("a")){	
	if (FORMS.updateADBlob(topicid,txmain,uip,username,adtype)){
	  if (FORMS.updateTopicSflagByAD(topicid,adtype)){
	  out.println(adtype);
				}else{
					out.println("!!!Exceptions!!!");
					return;
				}			

		}else{
			out.println("!!!Exceptions!!!");
			return;
		}
	}

	String topicsn = FORMS.getTopicsn(topicid);
	int floor = FORMS.getFloor(topicid);
	int pg = floor / offset;	
%>
<table width="50%" border="0" cellpadding="1" cellspacing="1" class="txmain">
  <tr>
    <td class="txmainnew1"><p>&nbsp;</p>        </td>
  </tr>
  <tr>
    <td><p align="center">发言[<%=topicid%>]已成功修改</p>
      <p align="center"><img src="../img/okIcon.jpg" width="32" height="32" /></p>
    <p align="center"><a href="showsingletopic.jsp?topicsn=<%=topicsn%>&amp;pg=<%=pg%>#<%=topicid%>">查看该条发言</a></p></td>
  </tr>
</table>
</body>
</html>
