<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="vo.*" %>
<%@ page import="java.util.*" %>
<%@ page import="dao.*" %>     
<%
	int questionNo = Integer.parseInt(request.getParameter("questionNo"));	
	QuestionDao qd = new QuestionDao();
	qd.deleteQuestion(questionNo);
	
	response.sendRedirect(request.getContextPath()+"/question.jsp");
	
	
%>    
    
