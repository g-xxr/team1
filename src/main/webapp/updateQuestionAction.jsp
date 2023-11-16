<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="vo.*" %>
<%@ page import="dao.*" %>    
<%
	request.setCharacterEncoding("UTF-8");
	
	int questionNo = Integer.parseInt(request.getParameter("questionNo"));
	String questionTitle = request.getParameter("questionTitle");
	String questionContent = request.getParameter("questionContent");
	
	Question question = new Question();	
	question.setQuestionNo(questionNo);
	question.setQuestionTitle(questionTitle);
	question.setQuestionContent(questionContent);
	
	QuestionDao qd = new QuestionDao();
	qd.updateQuestion(questionNo, questionTitle, questionContent);
		
	response.sendRedirect(request.getContextPath()+"/question.jsp");

%>
    
    
