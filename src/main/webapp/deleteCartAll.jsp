<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dao.*"%>
<%
	int customerNo = Integer.parseInt(request.getParameter("customerNo"));
	
	CartDao cd = new CartDao();
	cd.deleteCartAll(customerNo);
	
	response.sendRedirect(request.getContextPath()+"/ordersComplete.jsp");
%>