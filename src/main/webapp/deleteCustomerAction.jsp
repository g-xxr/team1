<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %>
<%@page import="vo.*"%>
<%@page import="dao.CustomerDao"%>

<%
	if(session.getAttribute("loginId") == null){
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
		return;
	}


	CustomerDao customerDao = new CustomerDao();
	Customer customer = new Customer();
	customer.setCustomerId((String)(session.getAttribute("loginId")));
	customer.setCustomerPw(request.getParameter("customerPw"));
	
	
	int row = customerDao.deleteCustomer(customer);
	if(row == 1) {
		System.out.println("성공");
		session.invalidate();
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
	} else {
		response.sendRedirect(request.getContextPath()+"/deleteCustomerForm.jsp?");
	}
	
	
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

</body>
</html>