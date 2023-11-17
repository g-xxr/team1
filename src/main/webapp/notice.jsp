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
	int rowPerPage = 10;
	
	NoticeDao nd = new NoticeDao();
	int totalRow =nd.noticePaging();
	
	int lastPage = totalRow / rowPerPage;
	if(totalRow % rowPerPage != 0){
		lastPage = lastPage +1;
		}
	
	int beginRow = (currentPage-1)*rowPerPage;
		
	ArrayList<Notice> list = nd.selectNotice(beginRow, rowPerPage);						

	

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
	
	<!-- 고객 메뉴 시작 (절대주소 적으세요)-->
	<%
			if(session.getAttribute("customerNo") != null) {
			// 고객이 로그인한 상태라면
	%>
			<jsp:include page="/inc/privateMenu.jsp"></jsp:include>
	<% 	
			}else{
			// 로그아웃 상태라면
	%>
			<jsp:include page="/inc/menu.jsp"></jsp:include>
	<%			
			}
	%>
	
	<!-- 헤드 배너 부분 -->
	<header class="bg-dark py-1">
	    <div class="container px-4 px-lg-5 my-5">
	        <div class="text-center text-white">
	            <h1 class="display-4 fw-bolder">공지사항</h1>
	            <p class="lead fw-normal text-white-50 mb-0">😊공지사항 꼭 확인해주세여😊</p>
	        </div>
	    </div>
	</header>
		
        <!-- 공지사항 -->
        <div class="container">
        	<h1>공지사항</h1>
        	<br>
        	  <h2>목록</h2>      	     	    
        	  <table class="table table-hover">
        	  	<thead>
        		<tr>
        			<th class="col-sm-1">번호</th>		
        			<th class="col-sm-7">제목</th>      			
        			<th class="col-sm-1">작성일</th>	
        		</tr>	
        		<thead>        	
        		<%	
        		for(Notice n : list){
        	%>
        		 <tr>
        		  <td><%=n.getNoticeNo()%></td>
        		  <td>
        		  	<a href="<%=request.getContextPath()%>/noticeOne.jsp?noticeNo=<%=n.getNoticeNo()%>"><%=n.getNoticeTitle()%></a>
        		  </td>        							        		         	     							
        		  <td><%=n.getCreatedate()%></td>	
        		  
        	     </tr> 
        	      
        	<%
        		}
        	%>             		
        	  </table>	         
        	
        </div>
         <div class="d-flex justify-content-center">
		 <div>
		<%
			if(currentPage > 1){
		%>
			<a class="btn btn-outline-success" href="<%=request.getContextPath()%>/managerNotice.jsp?currentPage=<%=currentPage-1%>">이전</a>
		<%
			}
		%>
		
		<%
			if(currentPage < lastPage){
		%>
			<a class="btn btn-outline-success" href="<%=request.getContextPath()%>/managerNotice.jsp?currentPage=<%=currentPage+1%>">다음</a>
		<%
			}
		%>
		 </div>
        </div>
    <br>
    <br>
    <!-- 맨 아래 배너 -->
	<footer class="py-3 bg-dark">
	<div class="container"><p class="m-0 text-center text-white"> Copyright &copy; 유정 도헌 유섭 </p></div>
	</footer>
	   
	<!-- Bootstrap core JS-->
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
	   
	<!-- Core theme JS-->
	<script src="js/scripts.js"></script>
    </body>
</html>