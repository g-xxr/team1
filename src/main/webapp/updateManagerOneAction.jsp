<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import ="dao.ManagerDao" %>

<%
		int managerNo = (Integer)session.getAttribute("managerNo");
		String managerName = request.getParameter("newName");
		System.out.println("\n" + managerNo + "<---액션폼매니저번호");
		ManagerDao managerDao = new ManagerDao();
		managerDao.updateManagerOne(managerNo, managerName);
		
		response.sendRedirect(request.getContextPath()+"/managerOne.jsp");
		

%>