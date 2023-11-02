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
	PreparedStatement stmt = conn.prepareStatement(sql);
	stmt.setString(1, customerId);
	stmt.setString(2, customerPw);
	System.out.println(stmt+" <--stmt");
	int row = stmt.executeUpdate();
	if (row==1) {
		System.out.println("입력성공");
	}  else {
		System.out.println("입력실패");
	}
	// db관련 프로세스 END -> DB자원을 해제 <-- 모델 레이어
	stmt.close();
	conn.close();
	// 리다이렉션 <-- 컨티롤러 레이어
	response.sendRedirect(request.getContextPath()+"/publichome.jsp");
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