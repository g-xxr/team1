<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import ="dao.*"%>
<%@ page import ="vo.*"%>

<%
	int goodsNo = Integer.parseInt(request.getParameter("goodsNo"));
	int customerNo = (Integer)session.getAttribute("customerNo");
	
	Cart c = new Cart();
	c.setGoodsNo(goodsNo);
	c.setCustomerNo(customerNo);
	
	CartDao cd = new CartDao();
	cd.insertCart(c);
	
	response.sendRedirect(request.getContextPath()+"/cart.jsp");
%>