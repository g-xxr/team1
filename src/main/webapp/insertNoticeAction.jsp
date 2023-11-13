<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "dao.*" %>
<%@ page import = "vo.*" %> 
<%	
	
	
	int managerNo = 108;
	String noticeTitle = request.getParameter("noticeTitle");
	String noticeContent = request.getParameter("noticeContent");
	
		
	NoticeDao noticeDao = new NoticeDao();
		
	Notice notice = new Notice();
	notice.setManagerNo(managerNo);
	notice.setNoticeTitle(noticeTitle);
	notice.setNoticeContent(noticeContent);
	
	
	int row = noticeDao.insertNotice(notice);
	if(row != 0) {
		System.out.println("공지사항 추가성공");
		response.sendRedirect(request.getContextPath()+"/managerNotice.jsp");
	}else{
		System.out.println("공지사항 추가실패");
	}
	
	
%>
