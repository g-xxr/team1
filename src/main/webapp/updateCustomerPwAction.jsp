<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="vo.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

<%

	if(session.getAttribute("loginId") == null){  // 본인 세션에 loginId를 만든적이 없다 -> 로그인 없다
	response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
	return;}

	String customerId = (String)session.getAttribute("loginId");
	String oldPw = request.getParameter("oldPw");
	String newPw = request.getParameter("newPw");
	
	Class.forName("org.mariadb.jdbc.Driver");
	String url = "jdbc:mariadb://localhost:3306/mall";
	String dbuser = "root";
	String dbpw = "java1234";
	Connection conn = DriverManager.getConnection(url, dbuser, dbpw);
	System.out.println("DB접속 성공");

	// 입력한 비밀번호가 예전 번호와 일치하는지 확인.
	String sql = "UPDATE customer SET customer_pw = PASSWORD(?), updatedate = NOW() WHERE customer_id=? AND customer_pw = PASSWORD(?)";
	PreparedStatement stmt = conn.prepareStatement(sql);
	stmt.setString(1, newPw);
	stmt.setString(2, customerId);
	stmt.setString(3, oldPw);
	System.out.println(stmt + "<-- stmt");
			
		int row = stmt.executeUpdate();
		if(row ==1) {
		response.sendRedirect(request.getContextPath()+"/customerOne.jsp");
		System.out.println("비번 변경 완료");
		} else { // 입력한 비번이 다를 경우
			response.sendRedirect(request.getContextPath()+"/publichome.jsp");
		}
		stmt.close();
		conn.close();
		
%>

</body>
</html>