<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "java.util.*"%>
<%@ page import = "vo.*"%>
<%@ page import = "dao.*"%>
<%@ page import = "java.net.*"%>

<%
	request.setCharacterEncoding("UTF-8");
	
	int ordersNo = Integer.parseInt(request.getParameter("ordersNo"));
	String loginId = (String)(session.getAttribute("loginId"));
	String reviewContent = request.getParameter("reviewContent");
	
	// DAO 객체 생성
	reviewDao reviewdao = new reviewDao();
	
	// 클래스 객체 생성
	Review review = new Review();
	
	// 입력받은 값들을 해당 객체에 설정
	review.setOrdersNo(ordersNo);
	review.setReviewContent(reviewContent);
	
	// DAO의 insertReview 메소드를 호출해서 DB에 등록
	reviewdao.insertReview(review);	
	
	response.sendRedirect(request.getContextPath()+"/review.jsp");

%>