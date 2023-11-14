<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="vo.*" %>
<%@ page import="dao.*" %>
<%
	
	
	int noticeNo = Integer.parseInt(request.getParameter("noticeNo"));
	
	String noticeTitle = request.getParameter("noticeTitle");
	String noticeContent = request.getParameter("noticeContent");
	
	Notice notice = new Notice();	
	notice.setNoticeNo(noticeNo);
	notice.setNoticeTitle(noticeTitle);
	notice.setNoticeContent(noticeContent);
	
	NoticeDao no = new NoticeDao();
	int row = no.updateNotice(notice);
		
	response.sendRedirect(request.getContextPath()+"/noticeOne.jsp");

%>
