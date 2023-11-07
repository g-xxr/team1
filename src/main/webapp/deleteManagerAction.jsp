<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %>
<%@page import="vo.*"%>
<%@page import="dao.ManagerDao"%>

<%
	if(session.getAttribute("loginId") == null) {
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
	return;
	}
	ManagerDao managerDao = new ManagerDao();
	Manager manager = new Manager();
	manager.setManagerId((String)(session.getAttribute("loginId")));
	manager.setManagerPw(request.getParameter("managerPw"));
	
	
	int row = managerDao.deleteManager(manager);
	if(row == 1) {
		System.out.println("성공");
		session.invalidate();
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
	} else {
		response.sendRedirect(request.getContextPath()+"/deleteManagerForm.jsp?");
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