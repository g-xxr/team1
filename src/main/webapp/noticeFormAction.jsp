<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="vo.*" %>
<%@ page import="dao.*" %>  
<%	

	String notice_title = request.getParameter("noticeTitle");
	String notice_content = request.getParameter("noticeContent");
	
	
	NoticeDao nd = new NoticeDao();
	
	
	Notice notice = new Notice();
	notice.setNoticeTitle(notice_title);
	notice.setNoticeContent(notice_content);

	
	int row = nd.insertNotice(notice);
	if(row == 1) {
		System.out.println("입력성공");
	}
	
	response.sendRedirect(request.getContextPath()+"/notice.jsp");
	
%>
