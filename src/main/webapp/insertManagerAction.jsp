<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="vo.*"%>
<%@page import="dao.ManagerDao"%>

<%
	// 한글 깨짐 방지
	request.setCharacterEncoding("UTF-8");

	// 사용자로부터 입력받은 값 가져오기
	String managerId = request.getParameter("managerId");
	String managerPw = request.getParameter("managerPw");
	String managerName = request.getParameter("managerName");
	
	// DAO 객체 생성
	ManagerDao managerDao = new ManagerDao();
	
	// 클래스 객체 생성
	Manager manager = new Manager();
	ManagerPwHistory managerpwhistory = new ManagerPwHistory();
	
	// 입력받은 값들을 해당 객체에 설정
	manager.setManagerId(managerId);
	manager.setManagerPw(managerPw);
	manager.setManagerName(managerName);
	managerpwhistory.setManagerPw(managerPw);
	
	// DAO의 insertManager 메소드를 호출해서 DB에 등록
	managerDao.insertManager(manager, managerpwhistory);
	
	//  리다이렉션 <-- 컨티롤러 레이어
	response.sendRedirect(request.getContextPath()+"/privateHome.jsp");
%>
