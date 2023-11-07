<%@page import="java.net.URLEncoder"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %>
<%@ page import = "java.net.URLEncoder" %>
<%@ page import = "dao.ManagerDao" %>
<%
	// 로그인 전에만 접속이 가능함.
	request.setCharacterEncoding("UTF-8");
	// controller layer
	String managerId = request.getParameter("managerId");
	String managerPw = request.getParameter("managerPw");
	String msg = null;
	
	// 클래스 객체 생성
	ManagerDao managerDao = new ManagerDao();
	
	int login = managerDao.ckIdPw(managerId, managerPw);
	
	if(login == 0){
		msg = URLEncoder.encode("아이디 또는 비밀번호를 확인하세요 :( ","UTF-8");
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp?msg="+msg);

	} else { 		
		session.setAttribute("loginId", managerId);
		response.sendRedirect(request.getContextPath()+"/managerMenu.jsp");
		
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