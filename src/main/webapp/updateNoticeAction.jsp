<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="vo.*" %>
<%@ page import="dao.*" %>
<%
	NoticeDao no = new NoticeDao();
	
	int managerNo = Integer.parseInt(request.getParameter("managerNo"));
	String noticeTitle = request.getParameter("noticeTitle");
	String noticeContent = request.getParameter("noticeContent");
	
	Notice notice = new Notice();
	notice.setManagerNo(managerNo);
	notice.setNoticeTitle(noticeTitle);
	notice.setNoticeContent(noticeContent);
	
	int row = no.insertNotice(notice);
		if(row == 1){
			System.out.println("추가성공");
			
		}
	
		response.sendRedirect(request.getContextPath()+"/notice.jsp");

%>
