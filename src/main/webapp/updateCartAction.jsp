<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "dao.*"%>
<%@ page import = "java.util.*"%>
<%
	int customerNo = (Integer) session.getAttribute("customerNo");

	CartDao cd = new CartDao();
	ArrayList<Integer> cartsNo = cd.getCartNo(customerNo); // 특정 고객에 대한 모든 장바구니 번호 가져 오기
	
	cd.updateCart(cartsNo, request);
	
	response.sendRedirect(request.getContextPath()+"/cart.jsp");
%>