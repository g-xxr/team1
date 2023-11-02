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
	NoticeDao nd = new NoticeDao();
	ArrayList<Notice> list = nd.selectNoticeList(beginRow, rowPerPage);							
%>       
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
	<!-- Latest compiled and minified CSS -->
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
	<!-- Latest compiled JavaScript -->
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
 <meta charset="utf-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
        <meta name="description" content="" />
        <meta name="author" content="" />
        <title>Shop Homepage - Start Bootstrap Template</title>
        <!-- Favicon-->
        <link rel="icon" type="image/x-icon" href="assets/favicon.ico" />
        <!-- Bootstrap icons-->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.5.0/font/bootstrap-icons.css" rel="stylesheet" />
        <!-- Core theme CSS (includes Bootstrap)-->
        <link href="css/styles.css" rel="stylesheet" />
</head>
<body>
	<!-- 메뉴 시작 (절대주소 적으세요)-->
	<jsp:include page="/menu.jsp"></jsp:include>
	<!-- 메뉴 끝 -->
<!-- Header-->
        <header class="bg-dark py-5">
            <div class="container px-4 px-lg-5 my-5">
                <div class="text-center text-white">
                    <h1 class="display-4 fw-bolder">Shop in style</h1>
                    <p class="lead fw-normal text-white-50 mb-0">With this shop hompeage template</p>
                </div>
            </div>
        </header>
        <!-- 공지사항 -->
        <div class="container">
        	<h1>공지사항</h1>
        	<hr>
        	<form action="./noticeForm.jsp">
        	  <h4>목록</h4>	
        	  <button type="submit" style="float:right;">글 작성</button>   	 
        	  <table class="table table-hover">
        	  	<thead>
        		<tr>
        			<th>NO</th>    			
        			<th>제목</th>       			
        			<th>작성일</th>
        		</tr>
        		<thead>
        		<%
        			for(Notice n : list){
        		%>
        			  <tr>
        			  	<td><%=n.getNoticeNo()%></td>
        			  	<td><%=n.getNoticeTitle()%></td>
        			    <td><%=n.getCreatedate()%></td>
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