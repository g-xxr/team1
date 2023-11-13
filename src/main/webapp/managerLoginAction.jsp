<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %>
<%@ page import = "java.net.URLEncoder" %>
<%@ page import = "dao.ManagerDao" %>
<%@ page import = "vo.*" %>
<%
	// 한글 깨짐 방식
	request.setCharacterEncoding("UTF-8");
	// controller layer
	String managerId = request.getParameter("managerId");
	String managerPw = request.getParameter("managerPw");
	String msg = null;
	
	Manager manager = new Manager();
	manager.setManagerId(managerId);
	manager.setManagerPw(managerPw);
	
	// 클래스 객체 생성
	ManagerDao managerDao = new ManagerDao();
	ResultSet rs = managerDao.managerLogin(manager);
	
	// ResultSet에서 결과가 있는 경우 (아이디와 비밀번호 일치할때)
	if(rs.next()){ // 세션에 로그인한 매니저의 managerId & managerNo 저장
		session.setAttribute("loginId", managerId);
		session.setAttribute("managerNo", rs.getInt("managerNo"));
		response.sendRedirect(request.getContextPath()+"/managerHome.jsp");

	} else { // 아이디 또는 비밀번호가 일치하지 않는 경우
		msg = URLEncoder.encode("아이디 또는 비밀번호를 확인하세요 :( ","UTF-8");
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp?msg="+msg);
	}
%>
