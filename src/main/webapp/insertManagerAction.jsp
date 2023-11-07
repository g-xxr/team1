<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="vo.*"%>
<%@page import="dao.ManagerDao"%>

<%
	request.setCharacterEncoding("UTF-8");
	String managerId = request.getParameter("managerId");
	String managerPw = request.getParameter("managerPw");
	String managerName = request.getParameter("managerName");
	
	ManagerDao managerDao = new ManagerDao();
	Manager manager = new Manager();
	manager.setManagerId(managerId);
	manager.setManagerPw(managerPw);
	manager.setManagerName(managerName);

	int row = managerDao.insertManager(manager);
	if (row==1) {
		System.out.println("입력성공");
	}  else {
		System.out.println("입력실패");
	}

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