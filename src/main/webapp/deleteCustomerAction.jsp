<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %>

<%
	if(session.getAttribute("loginId") == null){
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
		return;
	}

	String customerId = (String)(session.getAttribute("loginId"));
	
	String customerPw = request.getParameter("customerPw");
	
	Class.forName("org.mariadb.jdbc.Driver");  
	String url = "jdbc:mariadb://localhost:3306/mall";  
	String dbuser = "root";                             
	String dbpw = "java1234";
	Connection conn = DriverManager.getConnection(url, dbuser, dbpw);

	String sql = "DELETE FROM customer WHERE customer_id =? AND customer_pw=PASSWORD(?)";
	PreparedStatement stmt = conn.prepareStatement(sql);
	stmt.setString(1, customerId);
	stmt.setString(2, customerPw);
	
	int row = stmt.executeUpdate();
	if(row == 1) {
		System.out.println("성공");
		session.invalidate();
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
	} else {
		response.sendRedirect(request.getContextPath()+"/deleteCustomerForm.jsp?");
	}
	
	stmt.close(); 
	conn.close();
	
	
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