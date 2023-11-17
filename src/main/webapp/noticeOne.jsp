<%@page import="java.sql.PreparedStatement"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import = "java.util.*" %>
<%@ page import="dao.*" %>
<%@ page import="vo.*" %>
<%	
	int noticeNo = 0;
	noticeNo = Integer.parseInt(request.getParameter("noticeNo"));
	System.out.println(noticeNo + "<--noticeNo");


	NoticeDao nd = new NoticeDao();
	Notice n = nd.noticeOne(noticeNo);
%>

<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <meta name="description" content="">
        <meta name="author" content="">
        <title>공지사항 상세보기</title>
        <!-- Favicon-->
        <link rel="icon" type="image/x-icon" href="assets/favicon.ico">
        <!-- Bootstrap icons-->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.5.0/font/bootstrap-icons.css" rel="stylesheet">
        <!-- Core theme CSS (includes Bootstrap)-->
        <link href="css/styles.css" rel="stylesheet">
    </head>

<body>
	<!---- 로그인 시 보여지는 메뉴와 로그아웃 시 보여지는 메뉴 ---->
	<%
			if(session.getAttribute("customerNo") != null) {
			// 고객이 로그인한 상태라면
	%>
			<jsp:include page="/inc/privateMenu.jsp"></jsp:include>
	<% 	
			} else {
			// 고객이 로그아웃한 상태라면
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
	
        <!-- 공지사항 상세보기-->
	<div class="container mt-3">
	  <h2>공지사항</h2>
	  <div class="card">
	    <div class="card-header">제목 : <%=n.getNoticeTitle()%></div>
	    <div class="card-body"><%=n.getNoticeContent()%></div> 
	    <div class="card-footer"><%=n.getCreatedate()%></div>
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