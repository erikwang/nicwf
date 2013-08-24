<%@ page contentType="text/html; charset=gb2312" language="java" import="java.sql.*" errorPage="" %>
<%@ page import="sshd.*,java.util.*"%>
<%
	Forms FORMS;
	FORMS = new Forms();
	Vector<Vector> memberdatas;
	memberdatas = new Vector<Vector>();
	memberdatas =  FORMS.GetMembers();
	if(memberdatas == null){
			out.print( "There is no avaliable member in system definite!");
			return;
	}
	
	//read topic type from db
	Vector<Vector> topictypes;
	topictypes = new Vector<Vector>();
	topictypes = FORMS.getTopicType();
	
	
	Vector<Vector> datas;
	datas = new Vector<Vector>();
	String notetype;
	notetype = request.getParameter("ntype");
	if(notetype == null){
		out.println("Not a avaliable notetype!");
		return;
	}
	String id;
	id = request.getParameter("id");
	if(id == null){
		out.println("Not a avaliable id!");
		return;
	}
	datas = FORMS.getImg(id);
	Vector<Vector> ndatas;
	ndatas = new Vector<Vector>();
	ndatas = FORMS.formListReply(id,"0");
	String txmain = "";
	if (notetype.equals("r")){
		txmain = FORMS.getReplyMainBlob(id);
	}else{
		if(notetype.equals("a")){
			txmain =FORMS.getADMainBlob(id);
		}else{
			txmain =FORMS.getTopicMainBlob(id);
		}
	}
	Vector nrow = (java.util.Vector)ndatas.get(0);
	if ((nrow.get(10).toString()).equals("D")){
		out.println("该发言已经被删除，无法修改！");
		return;
	}
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<title>修改发言</title>
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
	/*String sfUserGroup = user.getParameterValue("sfUserGroup");
	if (! username.equals(nrow.get(1).toString()) && (! sfUserGroup.equals("depAdministrator")) ){
		out.println("您无法修改此发言，原因是此发言是由"+nrow.get(1)+" 发起的");
		return; 	
	}*/
	boolean flag1=false;;
	if(! username.equals((String)nrow.get(1)) ){
		if(notetype.equals("a")){
			flag1 = FORMS.CheckADRight(username,id);
		}else{
			flag1 = FORMS.CheckModifyRight(username,id);
		if(! flag1){
			out.println("你的权限不允许进行这个操作，因为本事件处理人不是你，或者你不是本领域的负责人。");
			return;
		}
		}
	}
	
	
	
	/*String rwflag = user.getParameterValue("readOnly");
	if (rwflag.equals("1")){
		out.println("您的权限不允许进行这个操作");
		return;
	}*/
%>
<form action="updatenote.jsp" method="post">
<table width="70%" border="0" cellpadding="1" cellspacing="3" class="tfblock">
  <tr >
    <td class="txmaintitle" colspan="3">Modify a Case</td>
  </tr>
  <tr>
    <td colspan="3" class="txmainnew1">标题:
      <input name="tf_title" type="text" id="tf_title" value="<%=nrow.get(0)%>" size="40" /></td>
    </tr>
  <tr>
    <td width="22%" class="txmainnew1">修改人:<%=nrow.get(1)%></td>
    <td width="43%" class="txmainnew1">记录时间:<%=nrow.get(5)%></td>
    <td width="35%" class="txmainnew1">事件领域:<%=nrow.get(3)%></td>
  </tr>
   <%if(! notetype.equals("a")){%>
  <tr>
    <td colspan="2" class="txmainnew1">(*选项已被重置，请重新选择)<br />
      <br />
      事件类别:
      <select name="se_topictype" id="se_topictype">
        <%	
			for(int tt=0;tt < topictypes.size();tt++){ 
			Vector tyrow = (java.util.Vector)topictypes.get(tt);
				if((nrow.get(2)).equals(tyrow.get(1))){
					out.print("<option selected value="+tyrow.get(1)+">"+tyrow.get(1)+"</option>");
				}else{
					out.print("<option value="+tyrow.get(1)+">"+tyrow.get(1)+"</option>");
				}
		 	} 
		%>
      </select>
	  
发现类型:
<select name="se_submitby" id="se_submitby">
  <option value="用户反馈">用户反馈</option>
  <option value="主动发现">主动发现</option>
  <option value="计划任务">计划任务</option>
  <option value="技术探索">技术探索</option>
  <option value="日常事务">日常事务</option>
</select>
<br />
<br />

用户描述:
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
</select></td>
    <%if(notetype.equals("t")){%>
	<td class="txmainnew1"><p>指派完成人:
	  <select name="se_assignto" id="se_assignto">
	    <!-- option value="<%=lusername%>" selected="selected" disabled="disabled">自己</option -->
	    <%
		   for (int tt = 0;tt<memberdatas.size();tt++){
		   		Vector mrow = (java.util.Vector)memberdatas.get(tt); %>
	    <option value="<%=mrow.get(1)%>"><%=mrow.get(1)%></option>
	    <%   }
	   %>
	      </select>
	</p>
	  <p>事件级别
        <select name="se_level" id="se_level">
          <option value="一般" selected="selected">一般</option>
          <option value="紧急">紧急</option>
          <option value="计划性">计划性</option>
          <option value="特别重要">特别重要</option>
        </select>
</p></td><%}%>
  </tr>
  <%if (notetype.equals("t")){%>
  <tr>
    <td colspan="3" class="txmainnew1">报告人:
      <input name="tf_submituser" type="text" id="tf_submituser" value="<%=nrow.get(11)%>" />
      报告时间:
      <input name="tf_submittime" type="text" id="tf_submittime" value="<%=nrow.get(13)%>" />
      联系电话:
<input name="tf_submitphone" type="text" id="tf_submitphone" value="<%=nrow.get(12)%>" /></td>
  </tr>
  <tr>
    <td colspan="3" class="txmainnew1">故障地点:      
      <input name="tf_submitplace" type="text" id="tf_submitplace" value="<%=nrow.get(14)%>" size="60" />
      (*选项已被重置，请重新选择)</td>
  </tr><%}%>
  <%}%>
	 <%if (notetype.equals("r")){%>
	 <tr>
	   <td colspan="3" bgcolor="#0099FF" class="txmainnew">结论:
         <select name="se_replytype" id="se_replytype">
           <option value="c">已解决</option>
           <option value="p">进行中</option>
         </select>
      (*选项已被重置，请重新选择)</td>
  </tr>
 <%}%>
 <%if (notetype.equals("a")){%>
	 <tr>
	   <td colspan="3" bgcolor="#0099FF" class="txmainnew">状态:
         <select name="se_adtype" id="se_adtype">
        <option value="p" selected="selected">进行中</option>
        <option value="w">申请完成</option>
            </select>
      (*选项已被重置，请重新选择)</td>
  </tr>
 <%}%>
  <tr>
    <td height="20" colspan="3">处理方式</td>
  </tr>
  <tr>
    <td colspan="3" class="txmainnew"><textarea name="tf_main" cols="100" rows="10" class="txmain" id="tf_main"><%=FORMS.edesortString(txmain)%></textarea></td>
  </tr>
 <tr>
    <td colspan="3"> <img src="../img/imgfolder.gif" />
      <input type="button" class="btn"  onclick="openUpload('newimg.jsp?id=<%=id%>&amp;dsid=<%=request.getParameter("dsid")%>')" value="附件管理"/>
      <input name="imgid" type="hidden" value="<%=id%>" /><input name="ntype" type="hidden" value="<%=notetype%>" /> <a href="showimg.jsp?imgtemp=<%=id%>" target="imgframe">刷新</a> </td>
  </tr>
 <tr><td colspan="3"><iframe name="imgframe" width="99%" scrolling="auto"  height="300" src="showimg.jsp?imgtemp=<%=id%>"></iframe></td></tr>
<tr>
  <td colspan="3"><input type="submit" name="Submit" value="修改事件" /></td>
</tr>
 </table>
</form>
</body>
<jsp:include page="bottom.jsp"/>
</html>
