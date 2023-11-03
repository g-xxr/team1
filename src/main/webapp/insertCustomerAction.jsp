<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "java.sql.Connection" %>
<%@ page import =  "java.sql.DriverManager" %>
<%@ page import = "java.sql.PreparedStatement" %>
<%@ page import = "java.util.*" %>

<%
	request.setCharacterEncoding("UTF-8");
	String customerId = request.getParameter("customerId");
	String customerPw = request.getParameter("customerPw");
	Class.forName("org.mariadb.jdbc.Driver");
	String url = "jdbc:mariadb://localhost:3306/mall";
	String dbuser = "root";
	String dbpw = "java1234";
	
	
	
	
	
	Connection conn = DriverManager.getConnection(url, dbuser, dbpw);
	String sql = "INSERT INTO customer(customer_id, customer_pw, createdate, updatedate) VALUES(?, PASSWORD(?), NOW(), NOW())";
	PreparedStatement stmt1 = conn.prepareStatement(sql);
	stmt1.setString(1, customerId);
	stmt1.setString(2, customerPw);
	System.out.println(stmt1+" <--stmt");
	int row = stmt1.executeUpdate();
	if (row==1) {
		System.out.println("입력성공");
	}  else {
		System.out.println("입력실패");
	}

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
	
	
	// db관련 프로세스 END -> DB자원을 해제 <-- 모델 레이어
	stmt1.close();
	conn.close();
	// 리다이렉션 <-- 컨티롤러 레이어
	
	response.sendRedirect(request.getContextPath()+"/privateHome.jsp");
	
	
	
	
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