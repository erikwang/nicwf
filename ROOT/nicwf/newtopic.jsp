<%@ page contentType="text/html; charset=gb2312" language="java" import="java.sql.*,java.text.*" %>
<%@ page import="sshd.*,java.util.*"%>
<%@ page import="client.*" %>
<%
	String tdsid = request.getParameter("dsid");
	session.setAttribute("xdsid",tdsid);
	java.util.Date tdate ;
	tdate = new java.util.Date();
	String imgtemp = request.getParameter("imgid");
	String newtitle = "新事件记录@"+new SimpleDateFormat("yy-MM-dd HH:mm:ss").format(tdate);
	if(imgtemp == null){
		imgtemp = new SimpleDateFormat("yyMMddHHmmss").format(tdate);
	}
	Forms FORMS;
	FORMS = new Forms(); 
	Vector<Vector> memberdatas;
	memberdatas = new Vector<Vector>();
	memberdatas =  FORMS.GetMembers();
	if(memberdatas == null){
			out.print( "There is no avaliable member in system definite!");
			return;
	}
	/*Forms FORMS;
	FORMS = new Forms();
	Vector<Vector> datas;
	datas = new Vector<Vector>();
	datas = FORMS.getImg(imgtemp);*/
	
	
	Vector<Vector> topictypes;
	topictypes = new Vector<Vector>();
	topictypes = FORMS.getTopicType();
	
	
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<title>[NIC] WF new event</title>
<link href="../css1.css" rel="stylesheet" type="text/css" />
<script type="text/javascript"> 

function getimgcode() { 
	var randomnum = Math.random(); 
	var getimagecode = document.getElementById("tf_topic");
	getimagecode.src = randomnum;
	document.getElementById("tf").value=getimagecode.src;
}
function openUpload(URL)
{
    n = window.open(URL,"ImgView","width=560,height=460");
    n.focus();
}
</script> 
</head>
<body>
<%@ include file="top.jsp"%>
<%	
	String username = user.getUserName();
	if (username.equals("public")){
		out.println("无法确认您的身份，发言请先登录");
		return; 	
	}
	boolean flag1 = FORMS.CheckNewRight(username,xdsid);
	if(! flag1){
		out.println("您的权限不允许进行这个操作,因为您没有参与在本领域的工作。");
		return;
	}
	/*String rwflag = user.getParameterValue("readOnly");
	if (rwflag.equals("1")){
		out.println("您的权限不允许进行这个操作");
		return;
	}
	String stuflag = user.getParameterValue("sfUserGroup");
	if (stuflag.equals("student") || stuflag == null){
		out.println("目前学生身份不允许发言，请继续浏览");
		return;
	}
	*/
%>
<form action="dotopic.jsp" method="post">
<table width="70%" border="0" cellpadding="1" cellspacing="3" class="tfblock">
  <tr>
    <td class="tfblockbg" height="30" bgcolor="#FFCC00">New Case</td>
  </tr>
  
  <input name="tf_dsid" type="hidden" id="tf_dsid" value="<%=request.getParameter("dsid")%>" readonly/>
	<input name="tf_owner" type="hidden" id="tf_owner" value="<%=username%>" readonly="true"/>

  <tr>
    <td class="txmainnew1">事件名称:      
      <input name="tf_topic" type="text" id="tf_topic" value="<%=newtitle%>" size="40" />
      事件级别:
      <select name="se_level" id="se_level">
        <option value="一般" selected="selected">一般</option>
        <option value="紧急">紧急</option>
        <option value="计划性">计划性</option>
        <option value="特别重要">特别重要</option>
      </select>
       指定给:
       <select name="se_assignto" id="se_assignto">
	   <!-- option value="<%=lusername%>" selected="selected" disabled="disabled">自己</option -->
	   <%
		   for (int tt = 0;tt<memberdatas.size();tt++){
		   		Vector mrow = (java.util.Vector)memberdatas.get(tt); %>
			<option value="<%=mrow.get(1)%>"><%=mrow.get(1)%></option>
		<%   }
	   %>
       </select>
      </td>
    </tr>
  <tr>
    <td class="txmainnew1">事件类别:      
      <select name="se_topictype" id="se_topictype">
        <option value="硬件、基础设施">硬件、基础设施</option>
        <option value="软件、系统">软件、系统</option>
        <option value="咨询">咨询</option>
        <option value="其他">其他</option>
        <option value="账号 主机管理">账号 主机管理</option>
        <option value="日常事务">日常事务</option>
        <option value="(研)基础设施">(研)基础设施</option>
        <option value="(研)数据相关">(研)数据相关</option>
        <option value="(研)架构相关">(研)架构相关</option>
        <option value="(研)界面相关">(研)界面相关</option>
        <option value="(研)软件工程">(研)软件工程</option>
        </select>
      发现类型:
      <select name="se_submitby" id="se_submitby">
        <option value="用户反馈">用户反馈</option>
        <option value="主动发现">主动发现</option>
        <option value="计划任务">计划任务</option>
        <option value="技术探索">技术探索</option>
        <option value="日常事务">日常事务</option>
      </select>      </td>
    </tr>
  <tr>
    <td class="txmainnew1">报告用户:
      <input name="tf_submituser" type="text" id="tf_submituser" />
      联系电话:
      <input name="tf_submitphone" type="text" id="tf_submitphone" />
      报告时间:
      <input name="tf_submittime" type="text" id="tf_submittime" value="<%=new SimpleDateFormat("yy-MM-dd-HH:mm:ss").format(tdate)%>" /></td>
    </tr>
	<tr>
    <td class="txmainnew1">地点:
      <input name="tf_submitplace" type="text" id="tf_submitplace" size="60" /></td>
	</tr>
  <tr>
    <td class="txmainnew1"><p>用户描述:
        <select name="se_submittype" id="se_submittype">
        <option value="线路中断" selected="selected">线路中断</option>
        <option value="分不到地址">分不到地址</option>
        <option value="访问不了某网页">访问不了某网页</option>
        <option value="发现攻击迹象">发现攻击迹象</option>
        <option value="新增设备">新增设备</option>
        <option value="日常事务">日常事务</option>
        <option value="账号管理">账号管理</option>
        <option value="紧急情况">紧急情况</option>
        <option value="其他">其他</option>
          </select></p>      </td>
  </tr>
  <tr>
    <td height="20">      处理方式:</td>
  </tr>
  <tr>
    <td><textarea name="tfmain" style="display:none"></textarea>
	<iframe ID="Editor" name="Editor" src="./HtmlEditor/index.html?ID=tfmain" frameBorder="0" marginHeight="0" marginWidth="0" scrolling="no" style="height:220px;width:99%"></iframe></td>
	
  </tr>
  <tr>
    <td> <img src="../img/imgfolder.gif" />
      <input type="button" class="btn"  onclick="openUpload('newimg.jsp?id=<%=imgtemp%>&amp;dsid=<%=request.getParameter("dsid")%>')" value="附件管理"/>
      <input name="imgid" type="hidden" value="<%=imgtemp%>" /> <a href="showimg.jsp?imgtemp=<%=imgtemp%>" target="imgframe">刷新</a> </td>
  </tr>
   <tr><td><iframe name="imgframe" width="99%" scrolling="auto"  height="300" src="showimg.jsp?imgtemp=<%=imgtemp%>"></iframe></td></tr>
  <tr>
    <td><input type="submit" name="Submit" value="记录事件" /></td>
  </tr>
  <tr>
    <td>&nbsp;</td>
  </tr>
</table>
</form>
  <jsp:include page="bottom.jsp"/>
</body>
</html>
