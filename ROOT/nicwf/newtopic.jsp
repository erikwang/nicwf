<%@ page contentType="text/html; charset=gb2312" language="java" import="java.sql.*,java.text.*" %>
<%@ page import="sshd.*,java.util.*"%>
<%@ page import="client.*" %>
<%
	String tdsid = request.getParameter("dsid");
	session.setAttribute("xdsid",tdsid);
	java.util.Date tdate ;
	tdate = new java.util.Date();
	String imgtemp = request.getParameter("imgid");
	String newtitle = "���¼���¼@"+new SimpleDateFormat("yy-MM-dd HH:mm:ss").format(tdate);
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
		out.println("�޷�ȷ��������ݣ��������ȵ�¼");
		return; 	
	}
	boolean flag1 = FORMS.CheckNewRight(username,xdsid);
	if(! flag1){
		out.println("����Ȩ�޲���������������,��Ϊ��û�в����ڱ�����Ĺ�����");
		return;
	}
	/*String rwflag = user.getParameterValue("readOnly");
	if (rwflag.equals("1")){
		out.println("����Ȩ�޲���������������");
		return;
	}
	String stuflag = user.getParameterValue("sfUserGroup");
	if (stuflag.equals("student") || stuflag == null){
		out.println("Ŀǰѧ����ݲ������ԣ���������");
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
    <td class="txmainnew1">�¼�����:      
      <input name="tf_topic" type="text" id="tf_topic" value="<%=newtitle%>" size="40" />
      �¼�����:
      <select name="se_level" id="se_level">
        <option value="һ��" selected="selected">һ��</option>
        <option value="����">����</option>
        <option value="�ƻ���">�ƻ���</option>
        <option value="�ر���Ҫ">�ر���Ҫ</option>
      </select>
       ָ����:
       <select name="se_assignto" id="se_assignto">
	   <!-- option value="<%=lusername%>" selected="selected" disabled="disabled">�Լ�</option -->
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
    <td class="txmainnew1">�¼����:      
      <select name="se_topictype" id="se_topictype">
        <option value="Ӳ����������ʩ">Ӳ����������ʩ</option>
        <option value="�����ϵͳ">�����ϵͳ</option>
        <option value="��ѯ">��ѯ</option>
        <option value="����">����</option>
        <option value="�˺� ��������">�˺� ��������</option>
        <option value="�ճ�����">�ճ�����</option>
        <option value="(��)������ʩ">(��)������ʩ</option>
        <option value="(��)�������">(��)�������</option>
        <option value="(��)�ܹ����">(��)�ܹ����</option>
        <option value="(��)�������">(��)�������</option>
        <option value="(��)�������">(��)�������</option>
        </select>
      ��������:
      <select name="se_submitby" id="se_submitby">
        <option value="�û�����">�û�����</option>
        <option value="��������">��������</option>
        <option value="�ƻ�����">�ƻ�����</option>
        <option value="����̽��">����̽��</option>
        <option value="�ճ�����">�ճ�����</option>
      </select>      </td>
    </tr>
  <tr>
    <td class="txmainnew1">�����û�:
      <input name="tf_submituser" type="text" id="tf_submituser" />
      ��ϵ�绰:
      <input name="tf_submitphone" type="text" id="tf_submitphone" />
      ����ʱ��:
      <input name="tf_submittime" type="text" id="tf_submittime" value="<%=new SimpleDateFormat("yy-MM-dd-HH:mm:ss").format(tdate)%>" /></td>
    </tr>
	<tr>
    <td class="txmainnew1">�ص�:
      <input name="tf_submitplace" type="text" id="tf_submitplace" size="60" /></td>
	</tr>
  <tr>
    <td class="txmainnew1"><p>�û�����:
        <select name="se_submittype" id="se_submittype">
        <option value="��·�ж�" selected="selected">��·�ж�</option>
        <option value="�ֲ�����ַ">�ֲ�����ַ</option>
        <option value="���ʲ���ĳ��ҳ">���ʲ���ĳ��ҳ</option>
        <option value="���ֹ�������">���ֹ�������</option>
        <option value="�����豸">�����豸</option>
        <option value="�ճ�����">�ճ�����</option>
        <option value="�˺Ź���">�˺Ź���</option>
        <option value="�������">�������</option>
        <option value="����">����</option>
          </select></p>      </td>
  </tr>
  <tr>
    <td height="20">      ����ʽ:</td>
  </tr>
  <tr>
    <td><textarea name="tfmain" style="display:none"></textarea>
	<iframe ID="Editor" name="Editor" src="./HtmlEditor/index.html?ID=tfmain" frameBorder="0" marginHeight="0" marginWidth="0" scrolling="no" style="height:220px;width:99%"></iframe></td>
	
  </tr>
  <tr>
    <td> <img src="../img/imgfolder.gif" />
      <input type="button" class="btn"  onclick="openUpload('newimg.jsp?id=<%=imgtemp%>&amp;dsid=<%=request.getParameter("dsid")%>')" value="��������"/>
      <input name="imgid" type="hidden" value="<%=imgtemp%>" /> <a href="showimg.jsp?imgtemp=<%=imgtemp%>" target="imgframe">ˢ��</a> </td>
  </tr>
   <tr><td><iframe name="imgframe" width="99%" scrolling="auto"  height="300" src="showimg.jsp?imgtemp=<%=imgtemp%>"></iframe></td></tr>
  <tr>
    <td><input type="submit" name="Submit" value="��¼�¼�" /></td>
  </tr>
  <tr>
    <td>&nbsp;</td>
  </tr>
</table>
</form>
  <jsp:include page="bottom.jsp"/>
</body>
</html>
