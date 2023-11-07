<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import= "java.sql.*" %>
<%@ page import = "vo.*" %>
<%@ page import = "java.util.ArrayList" %>

	<!-- 메뉴 시작 (절대주소 적으세요)-->
	<jsp:include page="/privateMenu.jsp"></jsp:include>
	<!-- 메뉴 끝 -->

<%
		if(session.getAttribute("loginId") == null){  // 본인 세션에 loginId를 만든적이 없다 -> 로그인 없다
			response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
			return;
		}
		
		String managerId = (String)(session.getAttribute("loginId")); 
		System.out.println(managerId + "<--managerId");
		
		Class.forName("org.mariadb.jdbc.Driver");  
		System.out.println("드라이브 로딩성공");
		String url = "jdbc:mariadb://localhost:3306/mall";  
		String dbuser = "root";                             
		String dbpw = "java1234";
		Connection conn = DriverManager.getConnection(url, dbuser, dbpw);
		
		String sql = "SELECT manager_id managerId, manager_pw managerPw, manager_name managerName, createdate, updatedate FROM manager WHERE manager_id =?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, managerId);
		System.out.print(stmt + "<--stmt");
		ResultSet rs = stmt.executeQuery();
		
		ArrayList<Manager> list = new ArrayList<>();
		Manager manager = new Manager();
		if(rs.next()){
			manager.setManagerId(rs.getString("managerId"));
			manager.setManagerPw(rs.getString("managerPw"));
			manager.setManagerName(rs.getString("managerName"));
			manager.setCreatedate(rs.getString("createdate"));
			manager.setUpdatedate(rs.getString("updatedate"));
		}
		
		rs.close();
		stmt.close();
		conn.close();
		
%>
<!DOCTYPE html>
<html>
<head>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<div class="container">
	<h1>회원 상세정보 &#128203;</h1>
	<form action="">
		<table class="table table-striped table-bordered table-hover">
			<tr>
				<th>매니저 ID</th>
				<td><%=m.getManagerId()%></td>
			</tr>
			<tr>
				<th>매니저명</th>
				<td><%=m.getManagerName()%></td>
			</tr>
			<tr>
				<th>생성일자</th>
				<td><%=m.getCreatedate()%></td>
			</tr>
			<tr>
				<th>변경일자</th>
				<td><%=m.getUpdatedate()%></td>
			</tr>
		</table>
	</form>
	<a href="<%=request.getContextPath()%>/updateManagerPwForm.jsp?" class="btn btn-outline-success">비밀번호수정</a> <!-- 이전 비밀번호와 바꿀 비밀번호 입력 -->
	&nbsp;
	<a href="<%=request.getContextPath()%>/deleteManagerForm.jsp" class="btn btn-outline-success">회원탈퇴</a> <!-- 비밀번호 입력 -->
	&nbsp;
	<a href="<%=request.getContextPath()%>//managerLogoutAction.jsp" class="btn btn-outline-success">로그아웃</a>
</div>
</body>
</html>