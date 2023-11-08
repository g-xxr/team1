<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="dao.CustomerDao"%>

<%
		String customerName = request.getParameter("customerName");
		String customerPhone = request.getParameter("customerPhone");
	
		int customerNo = (Integer)session.getAttribute("customerNo");
		
		CustomerDao customerDao = new CustomerDao();
		customerDao.updateCustomerOne(customerNo, customerName, customerPhone);
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