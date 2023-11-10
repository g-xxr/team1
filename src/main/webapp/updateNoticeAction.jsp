<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="vo.*" %>
<%@ page import="dao.*" %>
<%
	NoticeDao no = new NoticeDao();
	
	int managerNo = 108;
	int noticeNo = Integer.parseInt(request.getParameter("noticeNo"));
	System.out.println("\n"+ noticeNo + "<--noticeNo");
	String noticeTitle = request.getParameter("noticeTitle");
	String noticeContent = request.getParameter("noticeContent");
	
	Notice notice = new Notice();
	notice.setManagerNo(managerNo);
	notice.setNoticeTitle(noticeTitle);
	notice.setNoticeContent(noticeContent);
	
	int row = no.insertNotice(notice);
		if(row == 1){
			System.out.println("수정완료");
			
		}
	
		response.sendRedirect(request.getContextPath()+"/managerNotice.jsp");

%>
