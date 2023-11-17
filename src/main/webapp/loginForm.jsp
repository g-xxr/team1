<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	// 로그인 전
	String msg = request.getParameter("msg");
	if(session.getAttribute("customerNo") != null) { // 로그인한 기록이 있으면 -> privateHome.jsp로 이동
		response.sendRedirect(request.getContextPath()+"/privateHome.jsp");
		return;
	}
%>    

<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <meta name="description" content="">
        <meta name="author" content="">
        <title>로그인 화면</title>
        <!-- Favicon-->
        <link rel="icon" type="image/x-icon" href="assets/favicon.ico">
        <!-- Bootstrap icons-->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.5.0/font/bootstrap-icons.css" rel="stylesheet">
        <!-- Core theme CSS (includes Bootstrap)-->
        <link href="css/styles.css" rel="stylesheet">
    </head>

<body>

	<!-- 메뉴 시작 (절대주소 적으세요)-->
	<jsp:include page="/inc/menu.jsp"></jsp:include>
	
	<!-- 헤드 배너 부분 -->
	<header class="bg-dark py-1">
	    <div class="container px-4 px-lg-5 my-5">
	        <div class="text-center text-white">
	            <h1 class="display-4 fw-bolder">환영합니다</h1>
	            <p class="lead fw-normal text-white-50 mb-0">로그인하고 더 큰 혜택을 누리세요</p>
	        </div>
	    </div>
	</header>
	<!-- 
	로그인 폼 만들기 (로그인 시 고객에게 보여지는 홈페이지 (productList)
	매니저는 바로 (managerHome : 여기에서는 상품 관리(상품 추가, 수정, 삭제), 공지사항, 문의(답변) 게시판으로 바로 갈 수 있는 폼 만들기)
	-->
	<br>
<section>

<div class="container">
    <div class="row">
	    <!-- 고객 로그인 부분 -->
	    <div class="col-md-6 mt-3 mx-auto">
		<h2>고객 로그인</h2>
		  <div class="card" style="width:80%;">
		<form method="post" action="<%=request.getContextPath()%>/customerLoginAction.jsp">
		
		    <div class="card-body">
		    
		    <div class="mb-3 mt-3">
		    <label for="customerId" class="form-label">아이디</label>
		    <input type="text" class="form-control" id="customerId" placeholder="아이디를 입력하세요" name="customerId">
		  	</div>
		    
		    <div class="mb-3">
		    <label for="customerPw" class="form-label">비밀번호</label>
		    <input type="password" class="form-control" id="customerPw" placeholder="비밀번호를 입력하세요" name="customerPw">
		  	</div>
			<button type="submit" class="btn btn-primary">로그인</button>
		    <div>회원이 아니시라면?🚹<a href="<%=request.getContextPath()%>/insertCustomerForm.jsp" class="text-primary">회원가입</a>🚹</div>
		    </div>
		   </form>
		  </div>
		</div>

		<!-- 매니저 로그인 부분 -->
	    <div class="col-md-6 mt-3 mx-auto">
		<h2>매니저 로그인</h2>
		  <div class="card" style="width:80%;">
		<form method="post" action="<%=request.getContextPath()%>/managerLoginAction.jsp">
		
		    <div class="card-body">
		    
		    <div class="mb-3 mt-3">
		    <label for="managerId" class="form-label">아이디</label>
		    <input type="text" class="form-control" id="managerId" placeholder="아이디를 입력하세요" name="managerId">
		  	</div>
		    
		    <div class="mb-3">
		    <label for="managerPw" class="form-label">비밀번호</label>
		    <input type="password" class="form-control" id="managerPw" placeholder="비밀번호를 입력하세요" name="managerPw">
		  	</div>
			<button type="submit" class="btn btn-primary">로그인</button>
		    <div>회원이 아니시라면?🚹<a href="<%=request.getContextPath()%>/insertManagerForm.jsp" class="text-primary">회원가입</a>🚹</div>
		    </div>
		   </form>
		  </div>
		</div>
	</div>
</div>
	
</section>

        
        <% if(msg != null) { %>
            <div><%=msg%></div>
        <% } %>
        
 	<br>
	<br>
	<!-- 맨 아래 배너 -->
	<footer class="py-3 bg-dark">
	<div class="container"><p class="m-0 text-center text-white"> Copyright &copy; 유정 도헌 유섭</p></div>
	</footer>
	   
	<!-- Bootstrap core JS-->
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
	   
	<!-- Core theme JS-->
	<script src="js/scripts.js"></script>	
</body>
</html>