<%@ page contentType="text/html; charset=gb2312" import="java.sql.*,org.apache.commons.fileupload.*,org.apache.commons.fileupload.servlet.*,org.apache.commons.fileupload.disk.*,org.apache.commons.io.*" errorPage="" %>
<%@page import="java.util.*,java.io.*,java.text.*"%>
<%@ page import="java.sql.*,sshd.*,wit.user.*,wit.client.*,module.*" %>
<% 
	String useracct;
	//User user = (User)session.getAttribute("user");
	UserInfo user = (UserInfo)session.getAttribute("user");
	if ((user==null) || (user.equals("public"))){
		out.println("not login yet , upload image cannot process , login first");
		return;
	}else{
		useracct = user.getUserName();
	}
	
		
	boolean isMultipart = ServletFileUpload.isMultipartContent(request);
	FileItemFactory factory = new DiskFileItemFactory();
	ServletFileUpload upload = new ServletFileUpload(factory);
	//request.setCharacterEncoding("UTF-8");
	//upload.setHeaderEncoding("UTF-8");
	List items = upload.parseRequest(request);
	Iterator iter = items.iterator();
	String id = (String)session.getAttribute("id");
	String dsid = (String)session.getAttribute("dsid");
	if (id.length() < 1){
		out.println("Not a avaliable id!");
		return;
	}
	String fileDest;
	Forms FORMS;
	FORMS = new Forms();
	String urlprefix = Forms.getConfigFromDb("urlhomelinux");
	long imgsizemax = new Long(Forms.getConfigFromDb("imgmaxsize")).longValue();
	fileDest = Forms.getConfigFromDb("imghomelinux");
	//fileDest = fileDest+"\\"; in windows
	fileDest = fileDest+"/";
	FORMS.makeDir(fileDest);
	String fileName,fcontentType,imgRef;
	imgRef="";
	java.util.Date tdate ;
	tdate = new java.util.Date();
  	String prefix = new SimpleDateFormat("yyMMddHHmmss-").format(tdate);
	imgRef =  null;
	long sizeInBytes;
	fileName = null;
	fcontentType = null;
	sizeInBytes = 0;
	while (iter.hasNext()) {
    	FileItem item = (FileItem) iter.next();
		if (item.isFormField()) {
       		if (item.getFieldName().equals("tf_imgref")){
      			imgRef = item.getString("gb2312");
	      	}
    	}else{
      		String fieldName = item.getFieldName();
    		fileName = item.getName();
			fileName = new String(fileName.getBytes("GBK"),"gb2312");
    		File fullFile  = new File(fileName);   
			fileName = fullFile.getName();
			fileName = FilenameUtils.getName(fileName); //commons.io
    	 	int blength;
			byte[] bt= fileName.getBytes();
			blength = fileName.length();
			for (int i=0;i<blength ;i++ ){
		 		if (((bt[i]<46)&&(bt[i]>33))||(bt[i]== 96)||(bt[i] == 63)){ // '?
						out.println("非法字符,请检查文件名称,不支持中文文件名");
						return;
				}
			}
    	  	if (fileName == null){
      			out.println("There is no avaliable file for upload.");
	      		return;
    	  	}else{
    			fcontentType = item.getContentType();
    			sizeInBytes = item.getSize();
				System.out.println(fcontentType);
				/*if ( ! fcontentType.equals("image/pjpeg")){
					if ( ! fcontentType.equals("image/gif")){
						out.println("文件不是 jpeg  gif格式");
						return;
					}
					if ( ! fcontentType.equals("image/gif")){
						out.println("文件不是 jpeg  gif格式");
						return;
					}
				}*/
				File uploadedFile = new File(fileDest+prefix+fileName);
	      		if (sizeInBytes > imgsizemax){
					out.println("文件尺寸超过"+imgsizemax+"bytes ");
					return;
				}
				item.write(uploadedFile);
				out.println("IMG uploaded!");
				if (imgRef == null){
			    	imgRef = "无详细描述";
				}
				if (FORMS.saveIMGRef(imgRef,prefix+fileName,fileDest+prefix+fileName,fcontentType,((Long)sizeInBytes).toString(),id,urlprefix+prefix+fileName,useracct)){}			
      		}
   		}
	}
	out.println(fileName);
	response.sendRedirect("newimg.jsp?dsid="+dsid+"&id="+id);
 %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html" />
<title>Do img</title>
</head>
<body>
</body>
</html>
