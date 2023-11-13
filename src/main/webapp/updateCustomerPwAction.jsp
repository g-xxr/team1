<%@page import="dao.CustomerDao"%>
<%@page import="java.net.URLEncoder"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="vo.*"%>
<%

	if(session.getAttribute("customerNo") == null){  // 로그인을 한 기록이 없으면 -> loginForm.jsp로 이동
	response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
	return;}
	
	int customerNo = (Integer)session.getAttribute("customerNo");
	String newPw = request.getParameter("newPw");
	String oldPw = request.getParameter("oldPw");
	
	// DAO 객체 생성
	CustomerDao customerDao = new CustomerDao();
	
	// updateCustomerPw 메소드를 호출하여 customerNo에 대한 정보를 불러옴
	customerDao.updateCustomerPw(oldPw, newPw, customerNo, request, response);

%>
