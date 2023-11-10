<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "dao.*" %>
<%@ page import = "java.util.*" %>
<%@ page import = "vo.*" %> 
<%	
	
	
	int managerNo = Integer.parseInt(request.getParameter("managerNo"));

	String noticeTitle = request.getParameter("noticeTitle");
	String noticeContent = request.getParameter("noticeContent");
	
	
	System.out.println(request.getParameter("managerNo") + "<--noticeTitle");
	System.out.println(request.getParameter("noticeTitle") + "<--noticeTitle");
	System.out.println(request.getParameter("noticeContent") + "<--noticeContent");
		
	NoticeDao noticeDao = new NoticeDao();
		
	Notice notice = new Notice();
	notice.setManagerNo(managerNo);
	notice.setNoticeTitle(noticeTitle);
	notice.setNoticeContent(noticeContent);
	
	
	int row = noticeDao.insertNotice(notice);
	if(row == 1) {
		System.out.println("공지사항 추가성공");
		response.sendRedirect(request.getContextPath()+"/managerNotice.jsp");
	}else{
		System.out.println("공지사항 추가실패");
	}
	
	
%>
