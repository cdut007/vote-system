<%@page contentType="text/html; charset=utf-8" language="java"%>
<%@page import="java.io.File"%>
<%@page import="java.io.IOException"%>

<%@page import="java.util.*"%>
<%@page import="javax.servlet.ServletException"%>
<%@page import="javax.servlet.http.HttpServlet"%>
<%@page import="javax.servlet.http.HttpServletRequest"%>
<%@page import="javax.servlet.http.HttpServletResponse"%>
<%@page import="org.apache.commons.fileupload.disk.DiskFileItem"%>
<%@page import="org.apache.commons.fileupload.FileUploadException"%>
<%@page import="org.apache.commons.fileupload.disk.DiskFileItemFactory"%>
<%@page import="org.apache.commons.fileupload.servlet.ServletFileUpload,org.hibernate.Hibernate"%>
<%
		String ced001 = request.getParameter("ced001");
		String dc0502 = request.getParameter("dc0502");
System.out.println(dc0502+"+=====+=====+"+ced001);
		
		/*try {
			DiskFileItemFactory fac = new DiskFileItemFactory();
			ServletFileUpload upload = new ServletFileUpload(fac);
			upload.setHeaderEncoding("utf-8");
			// 获取多个上传文件
			 List fileList = null;
		            fileList = upload.parseRequest(request);
			Iterator it = fileList.iterator();
			while (it.hasNext()) {
				Object obit = it.next();
				if (obit instanceof DiskFileItem) {
					DiskFileItem item = (DiskFileItem) obit;
					String fileName = item.getName();
					if (fileName != null) {
						byte[] buffer = item.get();
						Blob picture = null;
						picture = Hibernate.createBlob(buffer);
						if (null != picture) {
							if (picture.length() == 0) {
								picture = null;
							}else{
								Dc05 dc05dto = 	new Dc05();
								 //设置建档人，建档日期，建档机构
					        	dc05dto.setAae011(user.getUserid());  
					        	dc05dto.setAae036(DateUtil.getDBDate());
					        	dc05dto.setAae017(cuser.getGroupid());
					        	dc05dto.setBab013(cuser.getOrgDistrict());
					        	//设置其它属性
					        	dc05dto.setCed001(ced001);
					        	dc05dto.setDc0502(dc0502); // 设置类型
					        	dc05dto.setDc0503(picture);
					        	dc05dto.setDc0504(fileName);
								dc05s.add(dc05dto);
							}
						}
					}
				}
			}
			  //获取业务服务接口
            BusinessServiceFactory bsf=new BusinessServiceFactory(
                    config.getServletContext());
            Dc01BS dc01BS=(Dc01BS) bsf.getService("com.start.lemis.apps.dagl.dc01.Dc01BS");
            dc01BS.saveDc05(dc05s);
		} catch (org.apache.commons.fileupload.FileUploadException ex) {
			ex.printStackTrace();
		} catch (ApplicationException e)
        {
          out.write(URLEncoder.encode("上传出错"));
        }
		out.write(URLEncoder.encode("上传成功"));
	*/
%>