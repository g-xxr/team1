<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="vo.*" %>
<%@ page import="java.util.*" %>
<%@ page import="dao.*" %>  
<%
	request.setCharacterEncoding("UTF-8");

	int managerNo =0;
	managerNo = (Integer)session.getAttribute("mangerNo");
	System.out.println(managerNo + "<--managerNo"); // 디버깅을 통해 managerNo를 확인
	String comment = request.getParameter("comment"); 
	
	QuestionDao questiondao = new QuestionDao();
	
	QuestionComment questionComment = new QuestionComment();
	questionComment.setQuestionNo(questionNo);
	questionComment.setManagerNo(managerNo);
	questionComment.setComment(comment);
	
	int row = questiondao.insertComment(questionComment);
	if(row != 0) {
		System.out.println("댓글 추가성공");		
		response.sendRedirect(request.getContextPath()+"/question.jsp");
	}else{
		System.out.println("댓글 추가실패");
	
%>
    