<%@ page contentType="text/html; charset=gb2312" language="java" import="java.sql.*,java.net.*" errorPage="" %>
<%@ page import="sshd.*,java.util.*"%>

<%
	Forms FORMS;
	FORMS = new Forms();
	String topicsn;
	topicsn = request.getParameter("topicsn");
	String dis;
	dis = request.getParameter("dis");
	int maxfloor = FORMS.getFloor(topicsn);
	if(topicsn.equals("")){
		return;
	}
	Vector<Vector> datas;
	datas = new Vector<Vector>();
	datas = FORMS.formListTopic("",topicsn,0,0);
	Vector<Vector> rdatas;
	rdatas = new Vector<Vector>();
	Vector<Vector> adatas;
	adatas = new Vector<Vector>();
	adatas = FORMS.GetAD(topicsn);

	int offset = new Integer(FORMS.getConfigFromDb("offset")).intValue();
	int startsn = 0;
	int endsn = 0;
	int pages;
	pages = 0;
	if(request.getParameter("pg") != null){
		pages = new Integer(request.getParameter("pg")).intValue();
		startsn = pages*offset;
		endsn = startsn + offset;
	}else{
		startsn = new Integer(request.getParameter("topicsn")).intValue();
		startsn = startsn - 2;
		endsn = startsn + 2;
	}
	String adm = "";
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<title>[NICWF] ME Show events</title>
<link href="../css1.css" rel="stylesheet" type="text/css" />
<style type="text/css">
<!--
.style1 {font-size: 12px}
.style5 {
	font-family: "Lucida Console";
	font-size: smaill;
	font-style: italic;
	color:#FF0000;
}
.style4 {
	font-family: "Lucida Console";
	font-size: medium;
}
.style8 {font-weight: bold; font-size: xx-large;}
.style9 {
	font-family: "Lucida Console";
	font-size: 14px;
	font-style: italic;
	color: #FF0000;
}
.style11 {
	font-weight: bold;
	font-size: xx-large;
	font-style: italic;
	color: #FF0000;
}
-->
</style>

</head>

<body>
			  <%if (datas!=null){
  				for (int i=0;i<datas.size();i++){
					Vector row = (java.util.Vector)datas.get(i);
					//rdatas = FORMS.formListReply(row.get(5).toString(),"1");
					rdatas = FORMS.formListReplyPg(row.get(5).toString(),startsn,endsn);
	                session.setAttribute("xdsid",row.get(6));	%>
			  <%@ include file="top.jsp"%>
            <table width="80%" border="0" cellpadding="1" cellspacing="1" class="tfblock">
			  <tr class="txmaintitle">
			 	<td colspan="4">�¼�����: <font size="+1"><b><%=row.get(0)%></b></font>&nbsp;|&nbsp;�¼����:<%=row.get(2)%> | �¼�����:<%=row.get(23)%></td>
		      </tr>
			  <tr>
			    <td width="50%" colspan="3">��������:<%=row.get(7)%></td>
	            <td><div align="right"> ������:<%=row.get(8)%></div></td>
              </tr>
			    <tr>
			    <td colspan="3"> ��¼��&nbsp;<%=row.get(1)%>&nbsp;&nbsp;�����:<%=row.get(24)%> &nbsp;</td>
                <td valign="bottom"><div align="right"><img src="../img/ip.gif" width="13" height="15" /><font color="#999999"> <%=row.get(11)%></font> | <img src="../img/co.gif" width="10" height="10" /> <font color="#999999"><%=row.get(4)%></font>&nbsp;</div></td>
		      </tr>
			  
			  <tr>
			    <td colspan="4"><p>
			      <%
						String txm;
						if ((row.get(12).toString()).equals("D")){
							txm = ("<br>[ ���¼��Ѿ���ɾ�� ]<br>");
						}else{
							txm = "";
							if(dis == null){
								txm = FORMS.desortString(FORMS.getTopicMainBlob(topicsn));
							}else{
								if(dis.equals("h")){
									txm = FORMS.desortString(FORMS.getTopicMainBlob(topicsn));
								}
								if(dis.equals("c")){
									txm = FORMS.getTopicMainBlob(topicsn);
								}
							}
						}
					%>
		            [<a href="showsingletopic.jsp?&amp;topicsn=<%=topicsn%>&amp;pg=<%=pages%>&dis=h">HTML</a>] [<a href="showsingletopic.jsp?&amp;topicsn=<%=topicsn%>&amp;pg=<%=pages%>&dis=c">CODE</a>] </p>			      </td>
		      </tr>
			  <tr>
			    <td class="txmainnew1">
	            <p>������:<%=row.get(14)%></p>				</td>       
		        <td class="txmainnew1">����ʱ��:<%=row.get(16)%></td>
		        <td class="txmainnew1"> ������:<%=row.get(19)%></td>
		        <td class="txmainnew1"> ��ϵ�绰:<%=row.get(15)%></td>
			  </tr>
			  <tr>
			    <td colspan="3" class="txmainnew1">�ص�:<%=row.get(17)%></td>
		        <td class="txmainnew1">����:<%=row.get(18)%></td>
			  </tr>
			  <tr>
			    <td colspan="4">
				<span class="style5">&nbsp;&nbsp;<span class="style8">Q</span>uest:</span> ������<span class="txmainnew"><%=row.get(1)%></span> ������¼�����������<br>
				<p class="txmainnew"><%=txm%><br><%if ( (row.get(20)!= null) &&(! row.get(20).equals(""))){%><span class="style5"><br><br>--- last modify by <%=row.get(21)%> @ <%=row.get(20)%> ---</span><%}%></p>
				</td></tr>
				<tr>
				  <td colspan="4">
				<% Vector<Vector> atdatas;
					atdatas = new Vector<Vector>();
					atdatas = FORMS.getImg(topicsn);
					for (int ii=0;ii<atdatas.size();ii++){
				  	Vector atrow = (java.util.Vector)atdatas.get(ii);
					boolean flag = FORMS.getIsImg((String)atrow.get(4));
					%>
				<span class="style11">&nbsp;A</span><span class="style9">ttachments(<%=ii%>):</span>
			    <table width="99%">
			  <tr>
			    <td width="48" height="48" rowspan="2" bgcolor="#FFFFFF" class="tfblock" ><div align="center"><a href="<%=atrow.get(7)%>"><%if(flag){%>
	<img src="../img/JpegFileIcon.jpg" border="0" />
	<%}else{%><img src="../img/File20Icon.jpg" border="0" /><%}%>
	</a></div></td>
    <td height="48" bgcolor="#FFFFFF" class="tfblock" >���ظ���:<%=atrow.get(0)%> |<a href="<%=atrow.get(7)%>"><%=atrow.get(1)%></a></td>
  </tr>
</table>
  <%}%>
				</td>
				</tr>
				<tr><td colspan="4"><br>
				
				  <%if(rdatas.size() == 0){ %>
				  <a href="newreply.jsp?topicid=<%=row.get(5)%>" class="txbtn"><img src="../img/Icon_1.gif" width="19" height="16" border="0" />��д�¼��������</a><%}%> 
				  <a href="editnotes.jsp?id=<%=row.get(5)%>&amp;type=0&amp;ntype=t"> <span class="txbtn"><img  src="../img/question.gif" border="0" />�޸��¼���¼</span></a> <a href="removenote.jsp?id=<%=row.get(5)%>&amp;type=0&amp;ntype=t" class="txbtn" onclick="{if(confirm('ȷ��Ҫɾ����?')){return true;}return false;}"><img src="../img/trash.gif" width="18" height="18" border="0" />ɾ���¼���¼</a> <span class="txbtn"><img src="../img/small_submit.gif" width="11" height="11" /><a href="migrateevent.jsp?id=<%=row.get(5)%>">ת��������������</a></span></p>
				 
				  <hr /></td>
		      </tr>
			  <tr><td colspan="4">
				<br><%if (adatas.size() == 0){%><span class="txbtn1"><img src="../img/copydocIcon.jpg" width="32" height="32" border="0" /><a href="newad.jsp?topicid=<%=row.get(5)%>">���д����˼�¼</span></a><br><br>
				  <%}else{%><span class="txbtn1"><img src="../img/editIcon.jpg" width="32" height="32" border="0" /><a href="editnotes.jsp?id=<%=row.get(5)%>&amp;type=0&amp;ntype=a">�޸Ĵ����˼�¼</span></a><br><br>
				  <%}%>
				</td></tr>
			   <% 	if(dis == null){
								adm = FORMS.desortString(FORMS.getADMainBlob(topicsn));
					}else{
								if(dis.equals("h")){
									adm = FORMS.desortString(FORMS.getADMainBlob(topicsn));
								}
								if(dis.equals("c")){
									adm = FORMS.getADMainBlob(topicsn);
								}
					}
					if (adatas.size()!= 0){
						Vector arow = (java.util.Vector)adatas.get(0);%>

				
				<tr>
			    <td class="txmainnew1">������:<%=arow.get(1)%></td>
			    <td class="txmainnew1"><img src="../img/co.gif" width="10" height="10" /><%=arow.get(2)%></td>
			    <td class="txmainnew1"><img src="../img/ip.gif" width="13" height="15" /><%=arow.get(4)%></td>
			    <td class="txmainnew1">����״̬: <%=row.get(22)%></td>
		      </tr>


			   <tr>
			     <td colspan="4">
				 	<span class="style5">&nbsp;&nbsp;<span class="style8">D</span>escribe:</span> ������<span class="txmainnew"><%=row.get(24)%></span> ������¼�����������~~~<br>
                   <td colspan="4" class="txmainnew">!<%=adm%><br />
                       <%if ( (arow.get(5)!= null) &&(! arow.get(5).equals(""))){%>
                     <span class="style5"><br />
                       <br />
                       --- last modify by <%=arow.get(6)%> @ <%=arow.get(5)%> ---</span>
                     <%}%>
                   </td>
                 </td>
		      </tr>
			  <tr>
				  <td colspan="4">
				<% 	Vector<Vector> aatdatas;
					aatdatas = new Vector<Vector>();
					aatdatas = FORMS.getImg(topicsn);
					for (int ii=0;ii<atdatas.size();ii++){
				  	Vector aatrow = (java.util.Vector)aatdatas.get(ii);
					boolean flag = FORMS.getIsImg((String)aatrow.get(4));
					%>
					<span class="style11">&nbsp;A</span><span class="style9">ttachments(<%=ii%>):</span>
			    <table width="99%">
			  <tr>
			    <td width="48" height="48" rowspan="2" bgcolor="#FFFFFF" class="tfblock" ><div align="center"><a href="<%=aatrow.get(7)%>"><%if(flag){%>
	<img src="../img/JpegFileIcon.jpg" border="0" />
	<%}else{%><img src="../img/File20Icon.jpg" border="0" /><%}%>
	</a></div></td>
    <td height="48" bgcolor="#FFFFFF" class="tfblock" >���ظ���:<%=aatrow.get(0)%> |<a href="<%=aatrow.get(7)%>"><%=aatrow.get(1)%></a></td>
  </tr>
</table>
  <%}%>
				</td>
				</tr>
				<%}%>
					
					 <% if (rdatas!=null){
			  				/*if (endsn >= rdatas.size()){
								endsn = rdatas.size();
							}*/
							
							//for (int ii=startsn;ii<endsn;ii++){
							for (int ii=0;ii<rdatas.size();ii++){
							Vector rrow = (java.util.Vector)rdatas.get(ii);
					%>
					<tr><td colspan="3"><tr>
					<td colspan="4">
					<table class="tfblock" width="100%" onMouseOver=this.style.backgroundColor="#C7E5F8" onMouseOut=this.style.backgroundColor="">
					<tr >
					<td ><img src="../img/loading_16x16.gif" width="16" height="16" /><font size="+2"><%=rrow.get(5)%></font>¥&nbsp;<a name="<%=rrow.get(4)%>" href="showsingle.jsp?type=3&amp;id=<%=rrow.get(4)%>"><%=rrow.get(0)%></a><br><img src="../img/fav_add.gif" width="16" height="16" />&nbsp;<font color="#999999"><%=rrow.get(2)%>&nbsp;<img src="../img/ip.gif" width="13" height="15" /><%=rrow.get(7)%></font></td>
					<td valign="bottom"><div align="right"><img src="../img/co.gif" width="10" height="10" /><%=rrow.get(3)%> &nbsp;</div></td>
				    </tr>
					<tr >
					  <td colspan="2">
					  <p><a href="showsingletopic.jsp?&amp;topicsn=<%=topicsn%>&amp;pg=<%=pages%>&dis=h">[HTML]</a> [<a href="showsingletopic.jsp?&amp;topicsn=<%=topicsn%>&amp;pg=<%=pages%>&dis=c">CODE</a>]</p>
					  <span class="style5">&nbsp;&nbsp;<span class="style8">C</span>onclusion:</span>������<span class="txmainnew"><%=rrow.get(2)%></span> ������¼��Ĵ������������<br>
					  <p class="txmainnew">
					  <%
					  	String rtxm;
						if ((rrow.get(8).toString()).equals("D")){
							rtxm = ("<br>[ �˽����Ѿ���ɾ�� ]<br>");
						}else{
							rtxm = "";

							String rsn = rrow.get(4).toString();
							if(dis == null){
								rtxm = FORMS.desortString(FORMS.getReplyMainBlob(rsn));
							}else{
								if(dis.equals("h")){
									rtxm = FORMS.desortString(FORMS.getReplyMainBlob(rsn));
								}
								if(dis.equals("c")){
									rtxm = FORMS.getReplyMainBlob(rsn);
								}
							}
						}
						out.print("<span class=style4>"+rtxm+"</span>");
						%><%if ( (rrow.get(9)!= null) &&(! rrow.get(9).equals(""))){%><br><br><span class="style5">--- last modify by <%=rrow.get(10)%> @ <%=rrow.get(9)%> ---</span><%}%>
						</p>
						<span class="style4">����</span>:
						<%if (rrow.get(6).equals("�ѽ��")){%>
						<font size='+2' color='#00CC00'><%=rrow.get(6)%></font></td>
						<%}else{%>
						<font size='+2' color='#FF0000'><%=rrow.get(6)%></font></td>
						<%}%>
			  </tr>
			  <tr >
			    <td colspan="2">
				<br>
				   <%if(! (row.get(12).toString()).equals("D")){%>
				<p><a href="editnotes.jsp?id=<%=rrow.get(4)%>&amp;type=0&ntype=r" ><span class="txbtn">�޸Ľ���</span></a><a href="removenote.jsp?id=<%=rrow.get(4)%>&amp;type=0&amp;ntype=r" onclick="{if(confirm('ȷ��Ҫɾ����?')){return true;}return false;}"><span class="txbtn">ɾ������</span></a></p><%}%><br></td>
			  </tr>
			  </tr>
			  </table>
					<%}}%>
				 <tr>
			 	<td colspan="4">ÿҳ��ʾ10�� ��ҳ
				<%
					int pgs = 0;
					pgs = maxfloor/offset;
					for(int pp=0;pp<=pgs;pp++){
						%>
						<a href ="showsingletopic.jsp?topicsn=<%=topicsn%>&pg=<%=pp%>"><%=pp+1%></a>
					<%}%></td>
		      </tr>	
</table>
			<p>
			  <%}
	}%>
			  <jsp:include page="bottom.jsp"/>
</body>
</html>
