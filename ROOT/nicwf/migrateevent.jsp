<%@ page contentType="text/html; charset=gb2312" language="java" import="java.sql.*" errorPage="" %>
<%@ page import="sshd.*,java.util.*"%>

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<title>[NICWF] migrate</title>
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
	
	Forms FORMS;
	FORMS = new Forms();
	Vector<Vector> dsdatas;
	dsdatas = new Vector<Vector>();
	dsdatas =  FORMS.formListReply("","2");
	if(dsdatas == null){
			out.print( "There is not a avaliable Domain Space identified!");
			return;
	}
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

	
%>
</p>
<table width="50%" border="0" cellpadding="1" cellspacing="1">
  <tr>
    <td width="33%" class="txmainnew1 style1">���÷���<%=id%>ת����</td>
    <td width="67%"><table width="100%" border="0" cellpadding="1" cellspacing="3">
      <tr>
        <td colspan="4" class="txmainnew"><span class="style1">Migrate to</span></td>
      </tr>
      <tr>
        <td class="txmainnew">����</td>
        <td class="txmainnew">������</td>
        <td width="48" class="txmainnew">ת��</td>
      </tr>
      <%
	 for(int t=0;t<dsdatas.size();t++){
	 	Vector dsrow = (java.util.Vector)dsdatas.get(t);
	%>
      <tr>
        <td class="txmainnew1"><%=dsrow.get(1)%></td>
        <td class="txmainnew1"><%=dsrow.get(2)%></td>
        <td width="48" class="tfblock"><a href="domigrate.jsp?id=<%=id%>&dsid=<%=dsrow.get(0)%>"><img src="../img/accepted.jpg" width="48" height="48" border="0"></a></td>
      </tr>
      <%}%>
    </table></td>
  </tr>
</table>
<p>&nbsp;</p>
<p>&nbsp;</p>
<p>&nbsp;</p>
</body>
<jsp:include page="bottom.jsp"/>
</html>
