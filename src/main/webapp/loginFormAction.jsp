<%@page import="java.net.URLEncoder"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %>
<%@ page import = "java.net.URLEncoder" %>
<%
	// 로그인 전에만 접속이 가능함.
	request.setCharacterEncoding("UTF-8");
	// controller layer
	String memberId = request.getParameter("memberId");
	String memberPw = request.getParameter("memberPw");
	
	// model 코드
	Class.forName("org.mariadb.jdbc.Driver");
   String url = "jdbc:mariadb://localhost:3306/test";
   String dbuser = "root";
   String dbpw = "java1234";
   Connection conn = DriverManager.getConnection(url, dbuser, dbpw);
   
   String sql = "SELECT member_id memberId FROM member WHERE member_id=? AND member_pw= PASSWORD(?)";
   PreparedStatement stmt = conn.prepareStatement(sql);
   stmt.setString(1, memberId);
   stmt.setString(2, memberPw);
   ResultSet rs = stmt.executeQuery();
	
   if(rs.next()) { // 로그인 성공
	   session.setAttribute("loginId", rs.getString("memberId"));
		response.sendRedirect(request.getContextPath()+"/publichome.jsp");
   } else { // 로그인 실패
	   	String msg = URLEncoder.encode("아이디 비밀번호를 확인하세요");
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp?msg="+msg);
   }
%>