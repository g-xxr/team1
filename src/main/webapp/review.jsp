<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="vo.*" %>
<%@ page import="java.util.*" %>
<%@ page import="dao.*" %>
<%
	// 로그인한 고객만 접근 가능
	
	int customerNo = 0;
	if(session.getAttribute("customerNo") == null){  // 현재 세션에 managerNo을 찾을 수 없다 -> 로그인 못함 -> 로그인 폼으로 가세요
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
		return;
	} else {
		customerNo = (Integer)session.getAttribute("customerNo");
	}
	
	// 페이징 하기
	// 현재 페이지
	int currentPage = 1;
	// 피이지네이션을 구현하고 사용자가 원하는 페이지로 이동
	if(request.getParameter("currentPage") != null) {
		currentPage = Integer.parseInt(request.getParameter("currentPage"));		
	}
	// 페이지 당 몇개의 항목을 나타내는지 -> 10개 항목 출력
	int rowPerPage = 10;
	
	reviewDao reviewdao = new reviewDao();
	int totalRow = reviewdao.reviewListPaging();
	
	int lastPage = totalRow/rowPerPage;
	if(totalRow % rowPerPage !=0) {
		lastPage = lastPage + 1;
	}
	// 시작 상품의 번호
	int beginRow = (currentPage-1)*rowPerPage;
	
	ArrayList<HashMap<String, Object>> list = reviewdao.selectReview(beginRow, rowPerPage);
%>

<!DOCTYPE html>
<html>
<meta charset="UTF-8">
	<head>
		<meta charset="utf-8">
		<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
		<meta name="description" content="">
		<meta name="author" content="">
		<title>리뷰게시판</title>
		<!-- 파비콘 코드 -->
		<link rel="icon" type="image/x-icon" href="assets/favicon.ico">
		<!-- 부트스트랩 아이콘 -->
		<link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.5.0/font/bootstrap-icons.css" rel="stylesheet">
		<!-- 코어 테마 css -->
		<link href="css/styles.css" rel="stylesheet">
	</head>
<body>
	<%
		if(session.getAttribute("customerNo") == null){
	%>		
		<!-- 비회원으로 접근할 때 보이는 메뉴바 -->
		<jsp:include page="/inc/menu.jsp"></jsp:include>
	<%		
		} else {
	%>
		<!-- 회원으로 접근할 때 보이는 메뉴바-->
		<jsp:include page="/inc/privateMenu.jsp"></jsp:include>
	<%
		}
	%>
	<!-- 헤드 배너 부분 -->
	<header class="bg-dark py-5">
	    <div class="container px-4 px-lg-5 my-5">
	        <div class="text-center text-white">
	            <h1 class="display-4 fw-bolder">🎊리뷰 리스트🎊</h1>
	            <p class="lead fw-normal text-white-50 mb-0">오늘도 즐거운 하루 되세요</p>
	        </div>
	    </div>
	</header>
	
	<!-- 상품 리스트 테이블 -->
	<div class="container mt-3">
	<br>
	<!-- 리뷰 목록 -->
	<table class="table table-hover" style="text-align:center; vertical-align: middle;">
		<thead>
			<tr>
	        <th class="col-sm-1">리뷰 번호</th>
	        <th class="col-sm-2">상품 이름</th>
	        <th>리뷰 내역</th>
	        <th class="col-sm-1">작성자 ID</th>
	        <th class="col-sm-1">수정</th>
	        <th class="col-sm-1">삭제</th>
	      	</tr>
		</thead>
	<%
		for(HashMap<String, Object> map : list){
	%>
    	<tbody>
     		<tr>
			<td><%=map.get("reviewNo")%></td>
        	<td><%=map.get("goodsTitle")%></td>
        	<td><%=map.get("reviewContent")%></td>
        	<td><%=map.get("customerId")%></td>
        	<td><a class="btn btn-outline-info" href="<%=request.getContextPath()%>/updateReviewForm.jsp?ordersNo=<%=map.get("ordersNo")%>">💡수정💡</a></td>
        	<td><a class="btn btn-outline-danger" href="<%=request.getContextPath()%>/deleteReviewAction.jsp?ordersNo=<%=map.get("ordersNo")%>">🗑️삭제🗑️</a></td>
      		</tr>
    	</tbody>
    <%
       }
	%>
	</table>
	</div>

	<br>	
	<!-- 페이지네이션 -->
	<div class="d-flex justify-content-center">
		<div>
		<%
			if(currentPage > 1){
		%>
			<a class="btn btn-outline-success" href="<%=request.getContextPath()%>/review.jsp?currentPage=<%=currentPage-1%>">이전</a>
		<%
			}
		%>
		
		<%
			if(currentPage < lastPage){
		%>
			<a class="btn btn-outline-success" href="<%=request.getContextPath()%>/review.jsp?currentPage=<%=currentPage+1%>">다음</a>
		<%
			}
		%>
		</div>
	</div>
	
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