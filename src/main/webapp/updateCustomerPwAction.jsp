<%@page import="dao.CustomerDao"%>
<%@page import="java.net.URLEncoder"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="vo.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

<%

	if(session.getAttribute("customerNo") == null){  // 본인 세션에 loginId를 만든적이 없다 -> 로그인 없다
	response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
	return;}
	
	int customerNo = (Integer)session.getAttribute("customerNo");
	String newPw = request.getParameter("newPw");
	String oldPw = request.getParameter("oldPw");
	
	CustomerDao customerDao = new CustomerDao();
	customerDao.updateCustomerPw(oldPw, newPw, customerNo, request, response);

	
	
	
	
	
	/*

	String msg = null;
	// 새 비밀번호와 확인 번호가 같은지 확인
	if(!request.getParameter("newPw").equals(request.getParameter("checkPw"))){
		msg = URLEncoder.encode("비밀번호가 서로 다릅니다.","utf-8");
		response.sendRedirect(request.getContextPath()+"updateCustomer.jsp?msg="+msg);
	}
			
		int row = stmt.executeUpdate();
		if(row ==1) {

		} else { // 입력한 비번이 다를 경우

		}
*/
		
%>

</body>
</html>