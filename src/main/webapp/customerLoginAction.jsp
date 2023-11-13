<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %>
<%@ page import = "java.net.URLEncoder" %>
<%@page import="vo.*"%>
<%@page import="dao.CustomerDao"%>
<%
 
	// 한글 깨짐 방지
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
	
	// ResultSet에서 결과가 있는 경우 (아이디와 비밀번호 일치할때)
	if(rs.next()) {	
		session.setAttribute("loginId", customerId);
		session.setAttribute("customerNo", rs.getInt("customerNo"));
	response.sendRedirect(request.getContextPath()+"/privateHome.jsp");
		return;
	} else { // 아이디 또는 비밀번호가 일치하지 않는 경우
		msg = URLEncoder.encode("아이디, 비밀번호 확인하세요","UTF-8");
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp?msg="+msg);
		System.out.println("로그인 실패");
		
	}
	
%>