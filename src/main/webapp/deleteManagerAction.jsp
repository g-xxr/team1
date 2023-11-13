<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %>
<%@page import="vo.*"%>
<%@page import="dao.ManagerDao"%>

<%
	if(session.getAttribute("loginId") == null) {  // 로그인을 한 기록이 없으면 -> loginForm.jsp로 이동
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
	return;
	}

	// DAO 객체 생성
	ManagerDao managerDao = new ManagerDao();

	// 클래스 객체 생성
	Manager manager = new Manager();
	
	manager.setManagerId((String)(session.getAttribute("loginId")));
	manager.setManagerPw(request.getParameter("managerPw"));
	
	// DAO의 deleteManager 메소드를 호출하여 관리자 삭제
	int row = managerDao.deleteManager(manager);
	if(row == 1) {  // 삭제가 성되면 세션을 무효화하고 로그인 페이지로 이동
		System.out.println("성공");
		session.invalidate();
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
	} else {
		response.sendRedirect(request.getContextPath()+"/deleteManagerForm.jsp?");
	}

%>