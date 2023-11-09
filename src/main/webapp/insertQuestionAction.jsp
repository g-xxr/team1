<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="vo.*" %>
<%@ page import="java.util.*" %>
<%@ page import="dao.*" %>  
<%

	int goodsNo = Integer.parseInt(request.getParameter("goodsNo"));
	int customerNo = Integer.parseInt(request.getParameter("customerNo"));
	String questionTitle = request.getParameter("questionTitle");
	String questionContent = request.getParameter("questionContent");
	
	System.out.println(goodsNo + "<--- goodsNo");
	System.out.println(customerNo + "<--- customerNo");
	System.out.println(questionTitle + "<--- questionTitle");
	System.out.println(questionContent+ "<--- questionContent");

	Question question = new Question();
	question.setGoodsNo(goodsNo);
	question.setCustomerNo(customerNo);
	question.setQuestionTitle(questionTitle);
	question.setQuestionContent(questionContent);
	
	QuestionDao qd = new QuestionDao();	
	
	int questionNo = qd.insertQuestion(question);
		if(questionNo != 0){
			System.out.println("문의추가 성공");
			response.sendRedirect(request.getContextPath()+"/question.jsp");
		}
	
%>
