<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="dao.CustomerDao"%>
<%@page import="vo.*"%>

<%
request.setCharacterEncoding("UTF-8");
    String newName = request.getParameter("newName");
    String newPhone = request.getParameter("newPhone");
    int customerNo = (Integer)session.getAttribute("customerNo");
	System.out.println(newName + "<--newName");
	System.out.println(newPhone + "<--newPhone");
	System.out.println(customerNo + "<--customerNo");
	
    CustomerDao customerDao = new CustomerDao();
    int row = customerDao.updateCustomerOne2(newName, newPhone, customerNo);

		if (row==1){
			System.out.println("수정 성공");
			response.sendRedirect(request.getContextPath()+"/customerOne.jsp");
		}  else {
			System.out.println("입력실패");
			response.sendRedirect(request.getContextPath()+"/updateCustomerOne.jsp");

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