<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="dao.*" %>
<%@ page import="vo.*" %> 
<%
    
    int noticeNo = Integer.parseInt(request.getParameter("noticeNo"));
	NoticeDao no = new NoticeDao();
    
	int row = no.deleteNotice(noticeNo);
    
	if(row == 1){
		System.out.println("삭제 성공");
		response.sendRedirect(request.getContextPath()+"/notice.jsp");	
	}else{
		System.out.println("삭제 실패");
		response.sendRedirect(request.getContextPath()+"/noticeOne.jsp");
	}
	
	
	
	
%>    
