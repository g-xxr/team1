<%@page import="dao.ManagerDao"%>
<%@page import="java.net.URLEncoder"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="vo.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
<title>Insert title here</title>
</head>
<body>

<%

	if(session.getAttribute("loginId") == null){  // 본인 세션에 loginId를 만든적이 없다 -> 로그인 없다
	response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
	return;}

	ManagerDao managerDao = new ManagerDao();
	Manager manager = new Manager();
	manager.setNewPw(request.getParameter("newPw"));
	manager.setManagerId((String)(session.getAttribute("loginId")));
	manager.setManagerPw(request.getParameter("oldPw"));


	int row = managerDao.updateManagerPw(manager);
	
	if (row==1){
		System.out.println("입력성공");
		response.sendRedirect(request.getContextPath()+"/managerOne.jsp");
		System.out.println("비번 변경 완료"); 
	}  else {
		System.out.println("입력실패");
		response.sendRedirect(request.getContextPath()+"/updateManagerPwForm.jsp");

	}
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