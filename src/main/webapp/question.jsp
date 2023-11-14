<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="vo.*" %>
<%@ page import="java.util.*" %>
<%@ page import="dao.*" %>      
<%
	int currentPage = 1;
	// 페이지네이션을 구현하고 사용자가 원하는 페이지로 이동
	if(request.getParameter("currentPage") != null){
		currentPage = Integer.parseInt(request.getParameter("currentPage"));
	}
	int rowPerPage = 8;
	
	QuestionDao qd = new QuestionDao();
	int totalRow =qd.questionPaging();
	
	int lastPage = totalRow / rowPerPage;
	if(totalRow % rowPerPage != 0){
		lastPage = lastPage +1;
		}
	int beginRow = (currentPage-1)*rowPerPage;
	// model 호출 코드(cotroller code)
	
	ArrayList<Question> list = qd.selectQuestion(beginRow, rowPerPage);				
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
	<jsp:include page="/inc/menu.jsp"></jsp:include>
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
	<br>
        <!-- 공지사항 -->
        <div class="container">
        	<h2>문의사항</h2>
        	<br>
        	<form action="./insertQuestionForm.jsp">
        	<button class="btn btn-outline-dark mt-auto" type="submit" style="float:right;">글 작성</button> 	    
        	  <table class="table table-hover" style="text-align:center;">
        	  	<thead>
        		<tr>
        			<th class="col-sm-1">번호</th> 
        			<th class="col-sm-2">카테고리</th>      		        			  			
        			<th class="col-sm-7">제목</th>
        			<th class="col-sm-1">작성자</th>        			
        			<th class="col-sm-1">작성일</th>	
        		</tr>	
        		<thead>        	
        		<%
        			for(Question q : list){
        		%>
        			  <tr>
        			  	<td><%=q.getQuestionNo()%></td>
        			  	<td><%=q.getGoodsNo()%></td>
        			  	<td><%=q.getCustomerNo()%></td>
        			  	<td><%=q.getQuestionTitle()%></td>
        			  	<td><%=q.getQuestionContent()%></td>
        			  	<td><%=q.getCreatedate()%></td>
        			  	<td><%=q.getUpdatedate()%></td>
        			  			  
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