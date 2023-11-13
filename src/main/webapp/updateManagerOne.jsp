<%@page import="dao.ManagerDao"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.ArrayList"%>
<%@page import="vo.*"%>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!-- 메뉴 네비게이션 바 -->
<!-- 메뉴 시작 (절대주소 적으세요)-->
<jsp:include page="/privateMenu.jsp"></jsp:include>
<!-- 메뉴 끝 -->

<%
	int managerNo = 0;
	
	if(session.getAttribute("managerNo") == null) {
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
		return;
	} else {
		managerNo = (Integer)session.getAttribute("managerNo");
	}
	ManagerDao managerDao = new ManagerDao();
	ArrayList<Manager> list = managerDao.managerOne(managerNo);
			
%>

<!DOCTYPE html>
<html lang="ko">
<head>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>관리자정보 변경</title>
    <style>
        /* Custom styles can be added here */
        /* Example: body { background-color: #f4f4f4; } */
        /* Add your custom CSS styles below this comment */
    </style>
</head>
<body>
<div class="container mt-5">
    <div class="row justify-content-center">
        <div class="col-md-6">
            <div class="card">
                <div class="card-body">
                    <h2 class="card-title text-center">관리자정보 변경</h2>
                    
                    <%
                    	for(Manager m : list){
                    %>
                    
                    <form action="<%=request.getContextPath()%>/updateManagerOneAction.jsp" method="post">
                        <div class="mb-3">
                            <label for="oldName" class="form-label">관리자명</label>
                            <input type="text" class="form-control" name="newName" required placeholder="변경할 이름" id="oldPw">
                        </div>
                        <div class="text-center">
                            <button type="submit" class="btn btn-primary">정보 변경</button>
                        </div>
                    </form>
                    <%
                    	}
                    %>
                </div>
            </div>
        </div>
    </div>
</div>
</body>
</html>
