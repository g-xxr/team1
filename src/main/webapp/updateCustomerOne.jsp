<%@page import="dao.CustomerDao"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.ArrayList"%>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!-- 메뉴 네비게이션 바 -->
<!-- 메뉴 시작 (절대주소 적으세요)-->
<jsp:include page="/inc/privateMenu.jsp"></jsp:include>
<!-- 메뉴 끝 -->

<%
	//한글 깨짐 방지
	request.setCharacterEncoding("UTF-8");
	
	int customerNo = 0;
	if(session.getAttribute("loginId") == null) {  // 로그인을 한 기록이 없으면 -> loginForm.jsp로 이동
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
		return;
	} else {
		customerNo = (Integer)session.getAttribute("customerNo"); // 디버깅을 통해 customerNo를 확인
	}

	// DAO 객체 생성
	CustomerDao customerDao = new CustomerDao();
	
	// customerOne 메소드를 호출하여 customerNo에 대한 정보를 불러옴
	ArrayList<HashMap<String,Object>> list = customerDao.customerOne(customerNo);
	
	// 수정하려는 이름과 전화번호 값을 가져옴
	String customerName = request.getParameter("customerName");
	String customerPhone = request.getParameter("customerPhone");		
	System.out.println(customerNo + "<--customerNo");


%>

<!DOCTYPE html>
<html lang="ko">
<head>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>회원정보 변경</title>
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
                    <h2 class="card-title text-center">회원정보 변경</h2>
                    
                    <%
                    	for(HashMap<String, Object> c : list){ // 받아온 회원정보 테이블에 출력
                    		
                    %>
                    
                    <form action="<%=request.getContextPath()%>/updateCustomerOneAction.jsp" method="post">
                        <div class="mb-3">
                            <label for="oldName" class="form-label">고객명</label>
                            <input type="text" class="form-control" name="newName" required placeholder="변경할 이름" id="oldPw">
                        </div>
                        <div class="mb-3">
                            <label for="oldPhone" class="form-label">새로운 전화번호</label>
                            <input type="tel" class="form-control" name="newPhone" required placeholder="새로운 전화번호" id="newPw">
                        </div>
                            <div class="mb-3">
                            <label for="oldAddr" class="form-label">새로운 주소</label>
                            <input type="text" class="form-control" name="newAddr" required placeholder="새로운 주소" id="newPw">
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
