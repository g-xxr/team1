<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="vo.*" %>
<%@ page import="java.util.*" %>
<%@ page import="dao.*" %>      
<%
	
	//페이징
	//현재 페이지
	int currentPage = 1;
	//페이지네이션을 구현하고 사용자가 원하는 페이지로 이동
	if(request.getParameter("currentPage") != null) {
		currentPage = Integer.parseInt(request.getParameter("currentPage"));
	}	
	//페이지당 보여줄행
	int rowPerPage = 8;
	
	//noticeDao 호출 코드
	NoticeDao nd = new NoticeDao();
	int totalRow = nd.noticePaging();
	//마지막 페이지
	int lastPage = totalRow / rowPerPage;
	// 딱 나누어 떨어지지 않으면 마지막 페이지 추가하기
    if(totalRow % rowPerPage != 0){
			lastPage = lastPage +1;
			}
 	// 시작 공지사항의 번호
 	int beginRow = (currentPage-1)*rowPerPage;
 	
 	
	ArrayList<HashMap<String, Object>> list = nd.selectNotice(beginRow, rowPerPage);	

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
	<jsp:include page="/managerMenu.jsp"></jsp:include>
	
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
        	<br>
        	<a class="btn btn-outline-dark mt-auto" style="float:right" href="<%=request.getContextPath()%>/insertNoticeForm.jsp">공지사항 추가</a>      	     	    
        	  <table class="table table-hover">
       		
        		<tr>
        			<th class="col-sm-1">번호</th>    			
        			<th class="col-sm-7">제목</th>
        			<th class="col-sm-1">작성자</th>        			
        			<th class="col-sm-1">작성일</th>	
        		</tr>		
        	<%	
        		for(HashMap<String, Object> n : list){
        	%>
        		 <tr>
        		  <td><%=n.get("noticeNo")%></td>
        		  <td>
        		  	<a href="<%=request.getContextPath()%>/noticeOne.jsp?noticeNo=<%=n.get("noticeNo")%>"><%=n.get("noticeTitle")%></a>
        		  </td>        							        		         	     							
        		  <td><%=n.get("managerNo")%></td>
        		  <td><%=n.get("createdate")%></td>				  
        	     </tr>  
        	<%
        		}
        	%>        		
        	  </table>	
        </div>
        <!-- 페이지네이션 -->
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