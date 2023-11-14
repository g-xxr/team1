<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="vo.*" %>
<%@ page import="java.util.*" %>
<%@ page import="dao.*" %>
<%
	int currentPage = 1;
	if(request.getParameter("currentPage") != null) {
		currentPage = Integer.parseInt(request.getParameter("currentPage"));		
	}
	int rowPerPage = 10;
	int beginRow = (currentPage-1)*rowPerPage;
	
	// model 호출 코드(controller mode)
	reviewDao reviewdao = new reviewDao();
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
	            <h1 class="display-4 fw-bolder">🎊가을맞이 빅세일🎊</h1>
	            <p class="lead fw-normal text-white-50 mb-0">오늘도 즐거운 하루 되세요</p>
	        </div>
	    </div>
	</header>
	
	        <!-- 리뷰사항 -->
        <div class="container">
        	<h2>리뷰 목록</h2>
        	<br>
        	<form action="./insertReviewForm.jsp">
        	<button class="btn btn-outline-dark mt-auto" type="submit" style="float:right;">글 작성</button> 	    
        	  <table class="table table-hover" style="text-align:center;">
        	  	<thead>
        		<tr>
        			<th class="col-sm-1">번호</th> 
        			<th class="col-sm-2">제품명</th>      		        			  			
        			<th class="col-sm-7">리뷰 내용</th>
        			<th class="col-sm-1">작성자ID</th>        			
        			<th class="col-sm-1">작성일</th>	
        		</tr>	
        		<thead>        	
        		<%
        			for(HashMap<String, Object> r : list){
        		%>
        			  <tr>
        			  	<td><%=r.get("reviewNo")%></td>
        			  	<td><%=r.get("ordersNo")%></td>
        			  	<td><%=r.get("reviewContent")%></td>
        			  	<td><%=r.get("createdate")%></td>
        			  	<td><%=r.get("updatedate")%></td>
        			  			  
        			  </tr>  
        		<%
        			}
        		%>        		
        	  </table>	         
        	</form>
        	
        </div>
        <!-- Footer-->
        <footer class="py-5 bg-dark">
            <div class="container"><p class="m-0 text-center text-white">Copyright &copy; Your Website 2023</p></div>
        </footer>
        <!-- Bootstrap core JS-->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
        <!-- Core theme JS-->
        <script src="js/scripts.js"></script>
	
</body>
</html>