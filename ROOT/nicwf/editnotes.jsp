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
		out.println("�÷����Ѿ���ɾ�����޷��޸ģ�");
		return;
	}
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<title>�޸ķ���</title>
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
		out.println("�޷�ȷ��������ݣ��������ȵ�¼");
		return; 	
	}
	/*String sfUserGroup = user.getParameterValue("sfUserGroup");
	if (! username.equals(nrow.get(1).toString()) && (! sfUserGroup.equals("depAdministrator")) ){
		out.println("���޷��޸Ĵ˷��ԣ�ԭ���Ǵ˷�������"+nrow.get(1)+" �����");
		return; 	
	}*/
	boolean flag1=false;;
	if(! username.equals((String)nrow.get(1)) ){
		if(notetype.equals("a")){
			flag1 = FORMS.CheckADRight(username,id);
		}else{
			flag1 = FORMS.CheckModifyRight(username,id);
		if(! flag1){
			out.println("���Ȩ�޲�������������������Ϊ���¼������˲����㣬�����㲻�Ǳ�����ĸ����ˡ�");
			return;
		}
		}
	}
	
	
	
	/*String rwflag = user.getParameterValue("readOnly");
	if (rwflag.equals("1")){
		out.println("����Ȩ�޲���������������");
		return;
	}*/
%>
<form action="updatenote.jsp" method="post">
<table width="70%" border="0" cellpadding="1" cellspacing="3" class="tfblock">
  <tr >
    <td class="txmaintitle" colspan="3">Modify a Case</td>
  </tr>
  <tr>
    <td colspan="3" class="txmainnew1">����:
      <input name="tf_title" type="text" id="tf_title" value="<%=nrow.get(0)%>" size="40" /></td>
    </tr>
  <tr>
    <td width="22%" class="txmainnew1">�޸���:<%=nrow.get(1)%></td>
    <td width="43%" class="txmainnew1">��¼ʱ��:<%=nrow.get(5)%></td>
    <td width="35%" class="txmainnew1">�¼�����:<%=nrow.get(3)%></td>
  </tr>
   <%if(! notetype.equals("a")){%>
  <tr>
    <td colspan="2" class="txmainnew1">(*ѡ���ѱ����ã�������ѡ��)<br />
      <br />
      �¼����:
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
	  
��������:
<select name="se_submitby" id="se_submitby">
  <option value="�û�����">�û�����</option>
  <option value="��������">��������</option>
  <option value="�ƻ�����">�ƻ�����</option>
  <option value="����̽��">����̽��</option>
  <option value="�ճ�����">�ճ�����</option>
</select>
<br />
<br />

�û�����:
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
</select></td>
    <%if(notetype.equals("t")){%>
	<td class="txmainnew1"><p>ָ�������:
	  <select name="se_assignto" id="se_assignto">
	    <!-- option value="<%=lusername%>" selected="selected" disabled="disabled">�Լ�</option -->
	    <%
		   for (int tt = 0;tt<memberdatas.size();tt++){
		   		Vector mrow = (java.util.Vector)memberdatas.get(tt); %>
	    <option value="<%=mrow.get(1)%>"><%=mrow.get(1)%></option>
	    <%   }
	   %>
	      </select>
	</p>
	  <p>�¼�����
        <select name="se_level" id="se_level">
          <option value="һ��" selected="selected">һ��</option>
          <option value="����">����</option>
          <option value="�ƻ���">�ƻ���</option>
          <option value="�ر���Ҫ">�ر���Ҫ</option>
        </select>
</p></td><%}%>
  </tr>
  <%if (notetype.equals("t")){%>
  <tr>
    <td colspan="3" class="txmainnew1">������:
      <input name="tf_submituser" type="text" id="tf_submituser" value="<%=nrow.get(11)%>" />
      ����ʱ��:
      <input name="tf_submittime" type="text" id="tf_submittime" value="<%=nrow.get(13)%>" />
      ��ϵ�绰:
<input name="tf_submitphone" type="text" id="tf_submitphone" value="<%=nrow.get(12)%>" /></td>
  </tr>
  <tr>
    <td colspan="3" class="txmainnew1">���ϵص�:      
      <input name="tf_submitplace" type="text" id="tf_submitplace" value="<%=nrow.get(14)%>" size="60" />
      (*ѡ���ѱ����ã�������ѡ��)</td>
  </tr><%}%>
  <%}%>
	 <%if (notetype.equals("r")){%>
	 <tr>
	   <td colspan="3" bgcolor="#0099FF" class="txmainnew">����:
         <select name="se_replytype" id="se_replytype">
           <option value="c">�ѽ��</option>
           <option value="p">������</option>
         </select>
      (*ѡ���ѱ����ã�������ѡ��)</td>
  </tr>
 <%}%>
 <%if (notetype.equals("a")){%>
	 <tr>
	   <td colspan="3" bgcolor="#0099FF" class="txmainnew">״̬:
         <select name="se_adtype" id="se_adtype">
        <option value="p" selected="selected">������</option>
        <option value="w">�������</option>
            </select>
      (*ѡ���ѱ����ã�������ѡ��)</td>
  </tr>
 <%}%>
  <tr>
    <td height="20" colspan="3">����ʽ</td>
  </tr>
  <tr>
    <td colspan="3" class="txmainnew"><textarea name="tf_main" cols="100" rows="10" class="txmain" id="tf_main"><%=FORMS.edesortString(txmain)%></textarea></td>
  </tr>
 <tr>
    <td colspan="3"> <img src="../img/imgfolder.gif" />
      <input type="button" class="btn"  onclick="openUpload('newimg.jsp?id=<%=id%>&amp;dsid=<%=request.getParameter("dsid")%>')" value="��������"/>
      <input name="imgid" type="hidden" value="<%=id%>" /><input name="ntype" type="hidden" value="<%=notetype%>" /> <a href="showimg.jsp?imgtemp=<%=id%>" target="imgframe">ˢ��</a> </td>
  </tr>
 <tr><td colspan="3"><iframe name="imgframe" width="99%" scrolling="auto"  height="300" src="showimg.jsp?imgtemp=<%=id%>"></iframe></td></tr>
<tr>
  <td colspan="3"><input type="submit" name="Submit" value="�޸��¼�" /></td>
</tr>
 </table>
</form>
</body>
<jsp:include page="bottom.jsp"/>
</html>
