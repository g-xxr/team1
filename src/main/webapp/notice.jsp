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
	// model 호출 코드(cotroller code)
	NoticeDao no = new NoticeDao();
	ArrayList<Notice> list = no.selectNoticeList(beginRow, rowPerPage);							
%>       
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

<title>홈페이지 팀플</title>
<!-- Latest compiled and minified CSS -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">

<!-- Latest compiled JavaScript -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
	
<!-- 파비콘 코드 -->
<link rel="icon" type="image/x-icon" href="assets/favicon.ico">
	
<!-- 부트스트랩 아이콘 -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.5.0/font/bootstrap-icons.css" rel="stylesheet">
	
<!-- 코어 테마 css -->
<link href="css/styles.css" rel="stylesheet">
</head>
<body>
	
	<!-- 메뉴 시작 (절대주소 적으세요)-->
	<jsp:include page="/privateMenu.jsp"></jsp:include>
	<!-- 메뉴 끝 -->
	
	<!-- 헤드 배너 부분 -->
	<header class="bg-dark py-5">
	    <div class="container px-4 px-lg-5 my-5">
	        <div class="text-center text-white">
	            <h1 class="display-4 fw-bolder">🎊가을맞이 빅세일🎊</h1>
	            <p class="lead fw-normal text-white-50 mb-0">오늘도 즐거운 하루 되세요</p>
	        </div>
	    </div>
	</header>
		
        <!-- 공지사항 -->
        <div class="container">
        	<h1>공지사항</h1>
        	<hr>
        	  <h2>목록</h2>      	     	    
        	  <table class="table table-hover">
        	  	<thead>
        		<tr>
        			<th class="col-sm-1">번호</th>    			
        			<th class="col-sm-7">제목</th>
        			<th class="col-sm-1">작성자</th>        			
        			<th class="col-sm-1">작성일</th>	
        		</tr>	
        		<thead>        	
        		<%
        			for(Notice n : list){
        		%>
        			  <tr>
        			  	<td><%=n.getNoticeNo()%></td>
        			  	<td><%=n.getNoticeTitle()%></td>
        			  	<td><%=n.getManagerNo()%></td>
        			    <td><%=n.getCreatedate()%></td>			  
        			  </tr>  
        		<%
        			}
        		%>        		
        	  </table>	         
        	
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