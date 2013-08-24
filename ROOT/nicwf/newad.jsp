<%@ page contentType="text/html; charset=gb2312" language="java" import="java.sql.*,sshd.*,java.util.*,java.math.*,java.text.*" errorPage="" %>
<%@ page import="client.*" %>
<%
	String topicid;
	String rreplysn;
	rreplysn = request.getParameter("replysn");
	if (rreplysn != null){
		topicid = rreplysn;
	}else{
		topicid = request.getParameter("topicid");
		if (topicid.equals("")){
			out.println("Please read a topic first!");
			return;
		}
	}
	Forms FORMS;
	FORMS = new Forms();
	Vector<Vector> datas;
	datas = new Vector<Vector>();
	datas = FORMS.formListReply(topicid,"0");
	Vector<Vector> rdatas;
	rdatas = new Vector<Vector>();
	

	Vector row;
	row = null;
	if (datas!=null){
		row = (java.util.Vector)datas.get(0);
	}else{
		out.println("Cannot find a topic with sn:"+topicid);
		return;
	}
	if ((row.get(10).toString()).equals("D")){
		out.println("回复对象已被删除，无法回复");
		return;
	}
	String floor = request.getParameter("floor");
	String replysn = request.getParameter("replysn");
	int endindex = 100;
	/*int tfrow = ((((String)row.get(4)).length())/120);
	out.print(((String)row.get(4)).length());*/
	int tfrow = 15;
	
	if (floor != null){
		//out.print(floor);
	}else{
		floor = "处理人";
	}
	
	String strtitle = "";
	String strtopicid = "";
	String strtxmain = "";
	if (replysn != null){
		rdatas = FORMS.formListReplyFloor(row.get(6).toString(),floor);
		Vector rrow = (java.util.Vector)rdatas.get(0);
		strtitle = (String)rrow.get(0);
		strtopicid = replysn;
		//strtxmain = (String)rrow.get(1);
		strtxmain = FORMS.getReplyMainBlob(replysn);
	}else{
		strtitle = (String)row.get(0);
		strtopicid = topicid;
		//strtxmain = (String)row.get(4);
		strtxmain = FORMS.getTopicMainBlob(topicid);
	}
	
	java.util.Date tdate ;
	tdate = new java.util.Date();
	String imgtemp = new SimpleDateFormat("yyMMddHHmmss").format(tdate);
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<title>[NIC] WF new ad</title>
<link href="../css1.css" rel="stylesheet" type="text/css" />
<script type="text/javascript"> 
function openUpload(URL)
{
    n = window.open(URL,"ImgView","width=560,height=460");
    n.focus();
}
</script> 
</head>

<body>
<%@ include file="top.jsp"%>
<% String username = user.getUserName();
	if (username.equals("public")){
		out.println("无法确认您的身份，发言请先登录");
		return; 	
	}

	boolean flag1 = FORMS.CheckADRight(username,topicid);
	if(! flag1){
		out.println("你的权限不允许进行这个操作，因为你不是被指定的处理人。");
		return;
	}
	
	/*String rwflag = user.getParameterValue("readOnly");
	if (rwflag.equals("1")){
		out.println("您的权限不允许进行这个操作");
		return;
	}
	String stuflag = user.getParameterValue("sfUserGroup");
	if (stuflag.equals("student") || stuflag == null){
		out.println("目前学生身份不允许发表回复，请继续浏览");
		return;
	}*/
%>

<form action="doad.jsp" method="post">
<table width="70%" border="0" cellpadding="1" cellspacing="3" class="tfblock">
  <tr class="tfblockbg2">
    <td height="30" colspan="2" bgcolor="#CC9999">Be assigned describe </td>
  </tr>
  <tr>
    <td>故障类型:
      <input name="tf_dsname" type="text" id="tf_dsid" value="<%=row.get(7)%>" readonly/><input type="hidden" name="tf_dsid" value="<%=row.get(9)%>"/></td>
    <td width="53%">负责人:<span class="txmainnew"><%=row.get(8)%></span></td>
  </tr>
  <tr>
    <td>处理人: <font color="#999999"><%=row.get(1)%>&nbsp;&nbsp;<img src="../img/co.gif" width="10" height="10" /> <%=row.get(5)%></font></td>
    <td>处理人:
      <input name="tf_owner" type="text" id="tf_owner" value="<%=username%>" readonly="true"/></td>
  </tr>
  <tr>
    <td width="47%">处理针对记录:<%=strtitle%></td>
    <td>编号: <%=strtopicid%>
    <input type="hidden" name="hf1" value="<%=topicid%>"/></td>
  </tr>
  
  <tr>
    <td colspan="2">结论类别: 
      <select name="se_adtype" id="se_adtype">
        <option value="w">申请完成</option>
        <option value="p" selected="selected">进行中</option>
      </select>      </td>
  </tr>
  <tr>
    <td class="block" colspan="2"><p><%=row.get(1)%>描述:<br>
      <%=strtxmain%>
    </td></tr>
      <tr><td colspan="2"><p>以下是您的处理意见:<br>
          <textarea name="tf_main" style="display:none"></textarea>
					<iframe ID="Editor" name="Editor" src="./HtmlEditor/index.html?ID=tf_main" frameBorder="0" marginHeight="0" marginWidth="0" scrolling="no" style="height:220px;width:680px"></iframe>
      </p> </td>
  </tr>
  <tr>
    <td colspan="2"></td>
    </tr>
  
  
  <tr>
    <td colspan="2">
      <img src="../img/imgfolder.gif" />
      <input name="button" type="button" class="btn"  onclick="openUpload('newimg.jsp?id=<%=imgtemp%>&amp;dsid=<%=request.getParameter("dsid")%>')" value="附件管理"/>      
      <input name="imgid" type="hidden" value="<%=imgtemp%>" /> <a href="showimg.jsp?imgtemp=<%=imgtemp%>" target="imgframe">刷新</a></td>
  </tr>
  <tr><td colspan="2"><iframe name="imgframe" width="99%" scrolling="auto"  height="300" src="showimg.jsp?imgtemp=<%=imgtemp%>"></iframe></td></tr>
  <tr>
    <td colspan="2"><input type="submit" name="Submit" value="给予处理意见" /></td>
  </tr>
</table>
</form>
  <jsp:include page="bottom.jsp"/>
</body>
</html>
