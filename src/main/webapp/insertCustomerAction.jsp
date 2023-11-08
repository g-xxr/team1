<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import ="vo.*" %>
<%@ page import ="dao.*" %>

<%
	request.setCharacterEncoding("UTF-8");

	String customerId = request.getParameter("customerId");
	String customerPw = request.getParameter("customerPw");	
	String customerName = request.getParameter("customerName");
	String customerPhone = request.getParameter("customerPhone");

	CustomerDao customerDao = new CustomerDao();

	Customer customer = new Customer();
	CustomerDetail customerdetail = new CustomerDetail();

	customer.setCustomerId(customerId);
	customer.setCustomerPw(customerPw);	
	customerdetail.setCustomerName(customerName);
	customerdetail.setCustomerPhone(customerPhone);
	
	customerDao.insertCustomer(customer, customerdetail);

	response.sendRedirect(request.getContextPath()+"/privateHome.jsp");
	/*
	INSERT into customer_id c.customerId, customer_pw, c.customerPw
	SELECT(ad.customer_no, ad.address, ad.createdate, ad.updatedate
	FROM address ad inner join customer c on ad.customer_no = c.customer_no
    */
	/*
	String address = request.getParameter("address");
	String sql2 = "INSERT INTO customer_addr(customer_no, address, createdate, updatedate) SELECT(ad.customer_no, ad.address, ad.createdate, ad.updatedate FROM address ad inner join customer c on ad.customer_no = c.customer_no VALUES(?,?, NOW(), NOW()) ";
	PreparedStatement stmt2 = conn.prepareStatement(sql2);
	stmt2.setString(1, address);
	int row2 = stmt2.executeUpdate();
	if (row2==1){
		System.out.println("입력성공");
	}  else {
		System.out.println("입력실패");
	}
	*/
	
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