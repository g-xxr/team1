<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %>
<%@ page import = "java.net.URLEncoder" %>
<%@page import="vo.*"%>
<%@page import="dao.CustomerDao"%>
<%
 
	// 로그인 전에만 접속이 가능함.
	request.setCharacterEncoding("UTF-8");
	// controller layer
	String customerId = request.getParameter("customerId");
	String customerPw = request.getParameter("customerPw");
	String msg = null;
	
	// 클랙스 객체 생성
	CustomerDao customerDao = new CustomerDao();
	int login = customerDao.ckIdPw(customerId, customerPw);
	
	if(login == 0){
		msg = URLEncoder.encode("아이디 또는 비밀번호를 확인하세요 :( ","UTF-8");
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp?msg="+msg);

	} else { 		
		session.setAttribute("loginId", customerId);
		int customerNo = 0;
		session.setAttribute("customerNo", customerNo);
		response.sendRedirect(request.getContextPath()+"/privateHome.jsp");
		
	}
	
%>