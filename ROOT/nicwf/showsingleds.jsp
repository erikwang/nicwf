<%@ page contentType="text/html; charset=gb2312" language="java" import="java.sql.*" errorPage="" %>
<%@ page import="sshd.*,java.util.*"%>

<%
	Forms FORMS;
	FORMS = new Forms();
	String dsid = request.getParameter("dsid");
	if(dsid.equals("")){
		return;
	} 
	int pages = new Integer((request.getParameter("pg"))).intValue();
	int offset = new Integer(FORMS.getConfigFromDb("offset")).intValue();
	int startsn = pages*offset;
	int endsn = startsn + offset;

	Vector<Vector> dsdatas;
	dsdatas = new Vector<Vector>();
	dsdatas =  FORMS.getDs(dsid);
	if(dsdatas == null){
			out.print( "There is not a avaliable Domain Space identified!");
			return;
	}
	Vector<Vector> odsdatas;
	odsdatas = new Vector<Vector>();
	session.setAttribute("xdsid",dsid);
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<title>[NICWF] Events</title>
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
			<table width="99%" border="0" cellpadding="1" cellspacing="1" class="tfblock">
			<% 
				int osize = 0;
				for (int t=0;t<dsdatas.size();t++){
				Vector dsrow = (java.util.Vector)dsdatas.get(t);
				odsdatas =  FORMS.getDsOwner((String)dsrow.get(0));
				if(odsdatas == null){
					out.print( "no Domain Space owner!");
					osize = 0;
				}else{
					osize = odsdatas.size();
				}
			%>
		    <tr class="txmaintitle">
			    <td colspan="7">主题领域：<font size="+1"><%=dsrow.get(1)%></font>&nbsp;|&nbsp;当前负责:
				<%=dsrow.get(2)%>&nbsp;&nbsp;参与人员:【
				<% for (int tt=0;tt<osize;tt++){
					Vector odsrow = (java.util.Vector)odsdatas.get(tt); 
					out.print(" "+odsrow.get(2)+"("+odsrow.get(1)+")");
				}%>】</td>
	          </tr>
			  <tr>
			    <td colspan="7"><img src="../img/Icon_2.gif" alt="领域描述" width="19" height="16" />领域空间描述:<%=dsrow.get(3)%></td>
	          </tr>
			  <tr>
			    <td colspan="7"><a href="newtopic.jsp?dsid=<%=dsrow.get(0)%>"><img src="../img/Icon_3.gif" alt="发起新主题" width="19" height="16" border="0" />记录新事件</a></td>
	          </tr>
			  <tr class="tfblockbg">
			 	<td width="10%" height="25" class="tfblock"><div align="center">类型</div></td>
				<td width="30%" height="25" class="tfblock"><div align="center">事件名称</div></td>
		        <td class="tfblock"><div align="center">受理人->分配给</div></td>
		        <td height="25" class="tfblock"><div align="center">处理时间</div>		          <div align="center"></div></td>
		        <td width="20%" height="25" class="tfblock"><div align="center">最新结论</div></td>
		        
			    <td width="5%" height="25" class="tfblock"><div align="center">事件级别</div></td>
			    <td width="7%" class="tfblock"><div align="center">状态</div></td>
			  </tr>
			 <%
				
				Vector<Vector> datas;
				datas = new Vector<Vector>();
				datas = FORMS.formListTopic(dsrow.get(0).toString(),"",startsn,endsn);
				Vector<Vector> rdatas;
				rdatas = new Vector<Vector>();
			 	String replys = "";
				String replysn = "";
				int countreplys = 0;
				if (datas.size() > 0){
							if (endsn >= datas.size()){
								endsn = datas.size();
							}
						
	  			//out.print("!!!"+startsn+" "+" "+endsn+" "+loops);
	  				for (int i=startsn;i<endsn;i++){
						Vector row = (java.util.Vector)datas.get(i);
						int pg = 0;
						//int floor = FORMS.getFloor(row.get(4).toString());   NO PG USE IN NICWF BUT EMP SSHD
						//int pg = floor / offset;
						rdatas = FORMS.formListReply(row.get(4).toString(),"1");
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
			 	<td width="10%" height="25" class="tfblock"><div align="center"><%=row.get(2)%></div></td>
				<td width="30%" height="25" class="tfblock"><a href="showsingletopic.jsp?&amp;topicsn=<%=row.get(4)%>&pg=0"><img src="../img/icon_01.gif" width="10" height="12" border="0" /><%=row.get(0)%></a></td>
				<td class="tfblock"><div align="center"><%=row.get(1)%> -> <%=row.get(8)%></div></td>
		        <td height="25" class="tfblock"><div align="center"><%=row.get(3)%></div>		          <div align="center"></div></td>
		        <td width="20%" height="25" class="tfblock"><div align="left"><%if (! replysn.equals("")){%><a href="showsingle.jsp?type=3&amp;id=<%=replysn%>"></a><a href="showsingletopic.jsp?&amp;topicsn=<%=row.get(4)%>&pg=<%=pg%>#<%=replysn%>"><%=replys%></a><%}else{%><%=replys%><%}%></div></td>
		        
			    <td width="5%" height="25" class="tfblock"><div align="center"><span class="style1"><a href="newreply.jsp?topicid=<%=row.get(4)%>"></a><%=row.get(7)%> </span></div></td>
			    <td width="7%" height="25" class="tfblock"><div align="center">
				<%if (((String)row.get(6)).equals("c")){%>
				<img src="../img/okIcon.jpg" />
				<%}else{
					if(((String)row.get(6)).equals("w")){%>
				<img src="../img/customer.jpg" width="32" height="32" />
				<%}else{%><img src="../img/question.jpg" /><%}}%></div></td>
			  </tr>
			   
	  		<%}}else{out.print("<tr ><td colspan=\"7\" class=\"tfblock\"><br><p>暂时没有任何主题</p></td></tr>");}%>
			<tr><td colspan="6"><p>每页显示10条 分页<%
					int pgs = 0;
					pgs = datas.size()/offset;
					if(datas.size()%offset == 0){
						pgs --;
					}	
					for(int pp=0;pp<=pgs;pp++){
						%>
						<a href ="showsingleds.jsp?dsid=<%=dsid%>&pg=<%=pp%>"><%=pp+1%></a>
					<%}%></p></td></tr>
			<%}%>
</table>
            <br />
           <jsp:include page="bottom.jsp"/>
</body>
</html>
