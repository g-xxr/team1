<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dao.OrdersDao" %>

<%
	int ordersNo = Integer.parseInt(request.getParameter("ordersNo"));

	OrdersDao od = new OrdersDao();
	od.deleteOrders(ordersNo);
	
	response.sendRedirect(request.getContextPath()+"/ordersList.jsp");
%>