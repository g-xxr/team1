<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %>
<%@ page import = "java.net.URLEncoder" %>
<%@page import="vo.*"%>
<%@page import="dao.CustomerDao"%>
<%
 
	// 로그인 전에만 접속이 가능함.
	request.setCharacterEncoding("UTF-8");
	// controller layer
	String customerId = request.getParameter("customerId");
	String customerPw = request.getParameter("customerPw");
	String msg = null; 
	
	Customer customer = new Customer();
	customer.setCustomerId(customerId);
	customer.setCustomerPw(customerPw);
	
	// 클랙스 객체 생성
	CustomerDao customerDao = new CustomerDao();
	ResultSet rs = customerDao.customerLogin(customer, request, response, session);
	
	

	if(rs.next()) {	
		session.setAttribute("loginId", customerId);
		session.setAttribute("customerNo", rs.getInt("customerNo"));
	response.sendRedirect(request.getContextPath()+"/privateHome.jsp");
		
		return;
	} else {
		msg = URLEncoder.encode("아이디, 비밀번호 확인하세요","UTF-8");
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp?msg="+msg);
		System.out.println("로그인 실패");
		
	}
	
%>