<%@ page contentType="text/html; charset=gb2312" language="java" import="java.sql.*" errorPage="" %>
<%@ page import="sshd.*,java.util.*"%>

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<title>[NICWF] Remove a event</title>
<link href="../css1.css" rel="stylesheet" type="text/css">
</head>

<body>
<%@ include file="top.jsp"%>
<p>
  <% 	
	String id;
	id = request.getParameter("id");
	if(id == null){
		out.println("Not a avaliable id!");
		return;
	}
	String notetype;
	notetype = request.getParameter("ntype");
	if(notetype == null){
		out.println("Not a avaliable notetype!");
		return;
	}
	Forms FORMS;
	FORMS = new Forms();
	Vector<Vector> ndatas;
	ndatas = new Vector<Vector>();
	ndatas = FORMS.formListReply(id,"0");
	Vector nrow = (java.util.Vector)ndatas.get(0);
	String username = user.getUserName();
	if (username.equals("public")){
		out.println("无法确认您的身份，发言请先登录");
		return; 	
	}
	
	/*if (! username.equals(nrow.get(1).toString())){
		out.println("您无法删除此事件，原因是此事件是由其他人(账号:"+nrow.get(1)+") 记录的");
		return; 	
	}*/
	boolean flag1 = FORMS.CheckDeleteRight(username,id);
	if(! flag1){
		out.println("你的权限不允许进行这个操作，因为本事件处理人不是你，或者你不是本领域的负责人。");
		return;
	}
	/*String stuflag = user.getParameterValue("sfUserGroup");
	if (stuflag.equals("student") || stuflag == null){
		out.println("目前学生身份不允许删除，请继续浏览");
		return;
	}*/
	if (FORMS.removeNotesRef(id,notetype)){
	}else{
		out.println("删除发言时出现了异常，请联系系统管理员");
		return;
	}
%>
</p>
<table width="50%" border="0" cellpadding="1" cellspacing="1" class="txmain">
  <tr>
    <td class="txmainnew1"><p>&nbsp;</p>        </td>
  </tr>
  <tr>
    <td><p align="center">事件（结论）已成功删除</p>
      <p align="center"><img src="../img/okIcon.jpg" width="32" height="32" /></p>
    <p align="center"><a href="showsingleds.jsp?dsid=<%=xdsid%>&amp;pg=0">返回该领域</a></p></td>
  </tr>
</table>
<p>&nbsp;</p>
</body>
<jsp:include page="bottom.jsp"/>
</html>
