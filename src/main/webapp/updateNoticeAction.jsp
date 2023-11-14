<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="vo.*" %>
<%@ page import="dao.*" %>
<%
	request.setCharacterEncoding("UTF-8");
	
	int noticeNo = Integer.parseInt(request.getParameter("noticeNo"));
	int managerNo = Integer.parseInt(request.getParameter("managerNo"));
	String noticeTitle = request.getParameter("noticeTitle");
	String noticeContent = request.getParameter("noticeContent");
	
	Notice notice = new Notice();	
	notice.setNoticeNo(noticeNo);
	notice.setNoticeTitle(noticeTitle);
	notice.setNoticeContent(noticeContent);
	
	NoticeDao no = new NoticeDao();
	no.updateNotice(noticeNo, noticeContent, managerNo);
		
	response.sendRedirect(request.getContextPath()+"/managerNotice.jsp");

%>
