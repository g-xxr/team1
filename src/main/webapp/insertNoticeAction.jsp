<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="vo.*" %>
<%@ page import="dao.*" %>  
<%	
/*
	//세션관리자만 들어올수있게
	if(session.getAttribute("loginEmpId1") == null && session.getAttribute("loginEmpId2") == null){
		response.sendRedirect(request.getContextPath()+"/notice.jsp");
		return;
	}
*/	

	String notice_title = request.getParameter("noticeTitle");
	String notice_content = request.getParameter("noticeContent");
	
	
	NoticeDao no = new NoticeDao();
	
	
	Notice notice = new Notice();
	notice.setNoticeTitle(notice_title);
	notice.setNoticeContent(notice_content);

	
	int row = no.insertNotice(notice);
	if(row == 1) {
		System.out.println("공지사항 추가성공");
		response.sendRedirect(request.getContextPath()+"/notice.jsp");
	}else{
		System.out.println("공지사항 추가실패");
		response.sendRedirect(request.getContextPath()+"/insertNoticeForm.jsp");
	}
	
	
%>
