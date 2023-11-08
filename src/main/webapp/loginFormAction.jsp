<%@page import="java.net.URLEncoder"%>
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
	
	Customer customer = new Customer();
	customer.setCustomerId(customerId);	
	customer.setCustomerPw(customerPw);	
	
	CustomerDao customerDao = new CustomerDao();
	ResultSet rs = customerDao.customerLogin(customer);
   if(rs.next()) { // 로그인 성공
	   session.setAttribute("loginId", rs.getString("customerId"));
		response.sendRedirect(request.getContextPath()+"/privateHome.jsp");
   } else { // 로그인 실패
	   	String msg = URLEncoder.encode("아이디 비밀번호를 확인하세요");
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp?msg="+msg);
   }
%>