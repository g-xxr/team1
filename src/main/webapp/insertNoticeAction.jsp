<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="vo.*" %>
<%@ page import="dao.*" %>  
<%	
	
	int managerNo = Integer.parseInt(request.getParameter("managerNo"));
	String noticeTitle = request.getParameter("noticeTitle");
	String noticeContent = request.getParameter("noticeContent");
	
	System.out.println(request.getParameter("managerNo") + "<--managerNO");
	
	
	NoticeDao no = new NoticeDao();
	
	
	Notice notice = new Notice();
	
	notice.setNoticeTitle(noticeTitle);
	notice.setNoticeContent(noticeContent);
	
	
	int row = no.insertNotice(notice);
	if(row == 1) {
		System.out.println("공지사항 추가성공");
		response.sendRedirect(request.getContextPath()+"/notice.jsp");
	}else{
		System.out.println("공지사항 추가실패");
		response.sendRedirect(request.getContextPath()+"/insertNoticeForm.jsp");
	}
	
	
%>
