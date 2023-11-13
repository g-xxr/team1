<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %>
<%@page import="vo.*"%>
<%@page import="dao.CustomerDao"%>

<%
	if(session.getAttribute("loginId") == null){  // 로그인을 한 기록이 없으면 -> loginForm.jsp로 이동
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
		return;
	}

	// DAO 객체 생성
	CustomerDao customerDao = new CustomerDao();
	
	// 클래스 객체 생성
	Customer customer = new Customer();
	
	customer.setCustomerId((String)(session.getAttribute("loginId")));
	customer.setCustomerPw(request.getParameter("customerPw"));
	
	// DAO의 deleteCustomer 메소드를 호출하여 회원 삭제
	int row = customerDao.deleteCustomer(customer);
	if(row == 1) {  // 삭제가 성공되면 세션을 무효화하고 로그인 페이지로 이동
		System.out.println("성공");
		session.invalidate();
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
	} else {
		response.sendRedirect(request.getContextPath()+"/deleteCustomerForm.jsp?");
	}
	
%>