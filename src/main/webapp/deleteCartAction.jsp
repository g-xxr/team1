<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dao.*"%>
<%
	int cartNo = Integer.parseInt(request.getParameter("cartNo"));
	CartDao cd = new CartDao();
	cd.deleteCart(cartNo);
	
	response.sendRedirect(request.getContextPath()+"/cart.jsp");
%>