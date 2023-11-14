<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="vo.*" %>
<%@ page import="java.util.*" %>
<%@ page import="dao.*" %> 
<%
	int noticeNo = Integer.parseInt(request.getParameter("noticeNo"));
	
	NoticeDao nd = new NoticeDao();
	int row = nd.deleteNotice(noticeNo);
	
	if(row != 0){
		System.out.println("삭제성공");
		response.sendRedirect(request.getContextPath()+"/managerNotice.jsp");
	}else{
		System.out.println("삭제실패");
		response.sendRedirect(request.getContextPath()+"/managerNotice.jsp");
	}

%>




