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
		out.println("�޷�ȷ��������ݣ��������ȵ�¼");
		return; 	
	}
	
	/*if (! username.equals(nrow.get(1).toString())){
		out.println("���޷�ɾ�����¼���ԭ���Ǵ��¼�����������(�˺�:"+nrow.get(1)+") ��¼��");
		return; 	
	}*/
	boolean flag1 = FORMS.CheckDeleteRight(username,id);
	if(! flag1){
		out.println("���Ȩ�޲�������������������Ϊ���¼������˲����㣬�����㲻�Ǳ�����ĸ����ˡ�");
		return;
	}
	/*String stuflag = user.getParameterValue("sfUserGroup");
	if (stuflag.equals("student") || stuflag == null){
		out.println("Ŀǰѧ����ݲ�����ɾ������������");
		return;
	}*/
	if (FORMS.removeNotesRef(id,notetype)){
	}else{
		out.println("ɾ������ʱ�������쳣������ϵϵͳ����Ա");
		return;
	}
%>
</p>
<table width="50%" border="0" cellpadding="1" cellspacing="1" class="txmain">
  <tr>
    <td class="txmainnew1"><p>&nbsp;</p>        </td>
  </tr>
  <tr>
    <td><p align="center">�¼������ۣ��ѳɹ�ɾ��</p>
      <p align="center"><img src="../img/okIcon.jpg" width="32" height="32" /></p>
    <p align="center"><a href="showsingleds.jsp?dsid=<%=xdsid%>&amp;pg=0">���ظ�����</a></p></td>
  </tr>
</table>
<p>&nbsp;</p>
</body>
<jsp:include page="bottom.jsp"/>
</html>
