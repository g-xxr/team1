<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dao.OrdersDao" %>
<%@ page import = "vo.*"%>

<%
	
	int ordersNo = (Integer)session.getAttribute("ordersNo");

	// 입력받은 값 가져오기
	String ordersState = request.getParameter("ordersState");

	// ordersDao 호출
	OrdersDao od = new OrdersDao();
	od.updateOrders(ordersNo, ordersState);
	
	// 리다이렉션 ordersList로 
	response.sendRedirect(request.getContextPath()+"/ordersList.jsp");
%>