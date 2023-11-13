<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import ="dao.ManagerDao" %>

<%
	//한글 깨짐 방지
	request.setCharacterEncoding("UTF-8"); 
	int managerNo = (Integer)session.getAttribute("managerNo");
	
	// 입력받은 값 가져오기
	String managerName = request.getParameter("newName");
	System.out.println("\n" + managerNo + "<---액션폼매니저번호");
	
	// DAO 객체 생성
	ManagerDao managerDao = new ManagerDao();

	// updateManagerOne 메소드 호출하기
	managerDao.updateManagerOne(managerNo, managerName);
		
	response.sendRedirect(request.getContextPath()+"/managerOne.jsp");
		

%>