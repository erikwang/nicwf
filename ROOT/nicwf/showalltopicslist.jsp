<%@ page contentType="text/html; charset=gb2312" language="java" import="java.sql.*" errorPage="" %>
<%@ page import="sshd.*,java.util.*" %>

<%
	
	Forms FORMS;
	FORMS = new Forms();
	int offset = new Integer(FORMS.getConfigFromDb("offset")).intValue();
	Vector<Vector> dsdatas;
	dsdatas = new Vector<Vector>();
	dsdatas =  FORMS.formListReply("","2");
	if(dsdatas == null){
			out.print( "There is not a avaliable Domain Space identified!");
			return;
	}
	Vector<Vector> odsdatas;
	odsdatas = new Vector<Vector>();
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<title>[EMP] 师生互动 显示主题</title>
<link href="../css1.css" rel="stylesheet" type="text/css" />
<style type="text/css">
<!--
.style1 {font-size: 12px}
.style3 {
	font-family: Verdana, Arial, Helvetica, sans-serif;
	font-size: 12px;
}
-->
</style>
</head>

<body>
			<jsp:include page="top.jsp"/>
			 <p><a href="showds.jsp" class="txmainnew">查看领域信息</a></p>
            <table width="99%" border="0" cellpadding="1" cellspacing="1" class="tfblock">
			<%  for (int t=0;t<dsdatas.size();t++){
				Vector dsrow = (java.util.Vector)dsdatas.get(t);
				odsdatas =  FORMS.getDsOwner((String)dsrow.get(0));
				if(odsdatas == null){
					out.print( "no Domain Space owner!");
				}
				Vector<Vector> datas;
				datas = new Vector<Vector>();
				datas = FORMS.formListTopic(dsrow.get(0).toString(),"",1,10);
				Vector<Vector> rdatas;
				rdatas = new Vector<Vector>();
			%>
		    <tr class="txmaintitle">
			    <td colspan="7">主题领域：<font size="+1"><a href="showsingleds.jsp?dsid=<%=dsrow.get(0)%>&pg=0"><%=dsrow.get(1)%></a></font>&nbsp;|&nbsp;当前负责:
				<%=dsrow.get(2)%>&nbsp;&nbsp;参与教师【
				<% for (int tt=0;tt<odsdatas.size();tt++){
					Vector odsrow = (java.util.Vector)odsdatas.get(tt); 
					out.print(" "+odsrow.get(2)+"("+odsrow.get(1)+")");
				}%>】</td>
	          </tr>
			  <tr>
			    <td colspan="7"><img src="../img/Icon_2.gif" alt="领域描述" width="19" height="16" />领域空间描述:<%=dsrow.get(3)%></td>
	          </tr>
			  <tr>
			    <td colspan="7"><a href="newtopic.jsp?dsid=<%=dsrow.get(0)%>"><img src="../img/Icon_3.gif" alt="发起新主题" width="19" height="16" border="0" />发起新主题</a>&nbsp;|&nbsp;本主题累计主题数:<%=datas.size()%>&nbsp;以下为最新10个主题</td>
	          </tr>
			 
			  <tr class="tfblockbg">
			 	<td width="5%" height="25" class="tfblock"><div align="center">类型</div></td>
				<td width="30%" height="25" class="tfblock"><div align="center">主题名称</div></td>
		        <td width="8%" class="tfblock"><div align="center">发起人</div></td>
		        <td width="13%" class="tfblock"><div align="center">发起时间</div></td>
		        <td width="5%" height="25" class="tfblock"><div align="center">回复数</div></td>
		        <td width="30%" height="25" class="tfblock"><div align="center">最新回复</div></td>
			    <td width="15%" height="25" class="tfblock"><div align="center">操作</div></td>
			  </tr>
			 <%
			 	String replys = "";
				String replysn = "";
				int countreplys = 0;
				int loops = 0;
				if (datas.size() > 0){
	  				if (datas.size() > 10){loops = 10;}else{loops = datas.size();}
					for (int i=0;i<loops;i++){
						Vector row = (java.util.Vector)datas.get(i);
						rdatas = FORMS.formListReply(row.get(4).toString(),"1");
						int floor = FORMS.getFloor(row.get(4).toString());
						int pg = floor / offset;
						if (rdatas.size()!=0 ){
							Vector rrow = (java.util.Vector)rdatas.get(rdatas.size()-1);
							replys = "<img src=\"../img/loading_16x16.gif\" border=\"0\"/>"+(String)rrow.get(0);
							countreplys = rdatas.size();
							replysn = rrow.get(4).toString();
						}else{
							replysn = "";
							replys = "暂时没有任何回复";
							countreplys = 0;
						}
			%>
			  <tr onMouseOver=this.style.backgroundColor="#CCCCCC" onMouseOut=this.style.backgroundColor="">
			 	<td width="5%" height="25" class="tfblock"><div align="center"><%=row.get(2)%></div></td>
				<td width="30%" height="25" class="tfblock"><a href="showsingletopic.jsp?&amp;topicsn=<%=row.get(4)%>&pg=0"><img src="../img/icon_01.gif" width="10" height="12" border="0" /><%=row.get(0)%></a></td>
				<td width="8%" class="tfblock"><div align="center"><%=row.get(1)%></div></td>
		        <td width="13%" class="tfblock"><div align="center"><%=row.get(3)%></div></td>
		        <td width="5%" height="25" class="tfblock"><div align="center"><%=countreplys%></div></td>
		        <td width="30%" height="25" class="tfblock"><div align="left"><%if (! replysn.equals("")){%><a href="showsingletopic.jsp?&amp;topicsn=<%=row.get(4)%>&pg=<%=pg%>#<%=replysn%>"><%=replys%></a><%}else{%><%=replys%><%}%></div></td>
		        
			    <td width="15%" height="25" class="tfblock"><div align="center"><span class="style1"><a href="newreply.jsp?topicid=<%=row.get(4)%>"><img src="../img/Icon_1.gif" width="19" height="16" border="0" />新回复 </a> </span></div></td>
			  </tr>
			   
	  		<%}}else{out.print("<tr ><td colspan=\"7\" class=\"tfblock\"><br><p>暂时没有任何主题</p></td></tr>");}}%>
</table>
            <br />
           <jsp:include page="bottom.jsp"/>
</body>
</html>
