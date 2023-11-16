<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dao.*"%>
<%
	int customerNo = (Integer) session.getAttribute("customerNo");
	
	OrdersDao od = new OrdersDao();
	od.orders(customerNo);
	
	response.sendRedirect(request.getContextPath()+"/ordersComplete.jsp");
%>