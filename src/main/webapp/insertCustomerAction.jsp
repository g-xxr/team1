<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import ="vo.*" %>
<%@ page import ="dao.*" %>

<%
	// 한글 깨짐 방지
	request.setCharacterEncoding("UTF-8");

	// 사용자로부터 입력받은 값 가져오기
	String customerId = request.getParameter("customerId");
	String customerPw = request.getParameter("customerPw");	
	String customerName = request.getParameter("customerName");
	String customerPhone = request.getParameter("customerPhone");
	String customerAddress = request.getParameter("customerAddress");
	
	// DAO 객체 생성
	CustomerDao customerDao = new CustomerDao();

	// 클래스 객체 생성
	Customer customer = new Customer();
	CustomerDetail customerdetail = new CustomerDetail();
	CustomerAddr customeraddr = new CustomerAddr();
	CustomerPwHistory customerpwhistory = new CustomerPwHistory();
	
	// 입력받은 값들을 해당 객체에 설정
	customer.setCustomerId(customerId);
	customer.setCustomerPw(customerPw);	
	customerdetail.setCustomerName(customerName);
	customerdetail.setCustomerPhone(customerPhone);
	customeraddr.setAddress(customerAddress);
	customerpwhistory.setCustomerPw(customerPw);
	
	// DAO의 insertCustomer 메소드를 호출해서 DB에 등록
	customerDao.insertCustomer(customer, customerdetail, customeraddr, customerpwhistory);

	response.sendRedirect(request.getContextPath()+"/privateHome.jsp");

%>
