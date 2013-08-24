<%@ page contentType="text/html; charset=gb2312" language="java" import="java.sql.*" errorPage="" %>
<%@ page import="sshd.*,java.util.*"%>

<%
	Forms FORMS;
	FORMS = new Forms();
	Vector<Vector> datas;
	datas = new Vector<Vector>();
	datas = FORMS.formList();
	Vector<Vector> rdatas;
	rdatas = new Vector<Vector>();
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<title>All topic list</title>
<link href="../css1.css" rel="stylesheet" type="text/css" />
<style type="text/css">
<!--
.style1 {font-size: 12px}
.style2 {font-size: 16px}
-->
</style>
</head>

<body>
            <p><a href="newtopic.jsp"><img src="../img/newtopic.jpg" width="228" height="89" border="0" class="txmain" /></a>发起新主题 </p>
            <p>
              <%if (datas!=null){
  		for (int i=0;i<datas.size();i++){
			Vector row = (java.util.Vector)datas.get(i);
			rdatas = FORMS.formListReply(row.get(6).toString(),"1");	%>
            </p>
            <table width="50%" border="1" cellspacing="1">
			  <tr class="txmaintitle">
			 	<td colspan="4">主题: <%=row.get(0)%></td>
		      </tr>
			  <tr>
			    <td width="30%">发起人</td>
			    <td width="25%"><%=row.get(1)%></td>
			    <td width="25%">主题类别</td>
			    <td width="50%"><%=row.get(2)%></td>
			  </tr>
			  <tr>
			    <td width="30%" colspan="3">主题领域</td>
			    <td width="50%"><%=row.get(3)%></td>
			  </tr>
			  <tr>
			    <td colspan="4">发起时间:<%=row.get(5)%></td>
		      </tr>
			  <tr>
			    <td colspan="4">
		        <textarea name="textarea" cols="100" rows="6" readonly class="txmain"><%=row.get(4)%></textarea></td>
			  </tr>
			   <tr>
			    <td colspan="4"><p><span class="style1"><a href="newreply.jsp?topicid=<%=row.get(6)%>"><img src="../img/newreply.jpg" width="228" height="89" border="0" /></a> <a href="showsingle.jsp?type=0&amp;id=<%=row.get(6)%>"><img src="../img/Icon_3.gif" width="19" height="16" border="0" />查看详细</a></span></p>
					
					 <% if (rdatas!=null){
			  		for (int ii=0;ii<rdatas.size();ii++){
						Vector rrow = (java.util.Vector)rdatas.get(ii);
						%>
					<p><img src="../img/loading_16x16.gif" width="16" height="16" /><a href="showsingle.jsp?type=3&amp;id=<%=rrow.get(1)%>"><%=rrow.get(0)%></a></p>
						<%}}%>
				</td>
			  </tr>
			</table>
			<hr>
	  	<%}
	}%>
</body>
</html>
