<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="vo.*" %>
<%@ page import="java.util.*" %>
<%@ page import="dao.*" %>  
<%

	request.setCharacterEncoding("UTF-8");
	
	int customerNo = 0;
	customerNo = (Integer)session.getAttribute("customerNo");
	System.out.println(customerNo + "<--customerNo"); // 디버깅을 통해 managerNo를 확인
	int goodsNo = 0;
	goodsNo = 1;
	System.out.println(goodsNo + "<--goodsNo");// 디버깅을 통해 goodsNo를 확인
	String questionTitle = request.getParameter("questionTitle");
	String questionContent = request.getParameter("questionContent");
	
		
	QuestionDao questionDao = new QuestionDao();
		
	Question question = new Question();
	question.setCustomerNo(customerNo);
	question.setGoodsNo(goodsNo);
	question.setQuestionTitle(questionTitle);
	question.setQuestionContent(questionContent);
	
	
	
	int row = questionDao.insertQuestion(question);
	if(row != 0) {
		System.out.println("공지사항 추가성공");		
		response.sendRedirect(request.getContextPath()+"/question.jsp");
	}else{
		System.out.println("공지사항 추가실패");
	}

	
%>
