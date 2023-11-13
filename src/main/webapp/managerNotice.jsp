<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="vo.*" %>
<%@ page import="java.util.*" %>
<%@ page import="dao.*" %>      
<%
	
request.setCharacterEncoding("utf-8");
	int currentPage = 1;
	if(request.getParameter("currentPage") != null) {
		currentPage = Integer.parseInt(request.getParameter("currentPage"));
	}
	//페이지당 보여줄행
	int rowPerPage = 8;
	
	//noticeDao 호출 코드
	NoticeDao nd = new NoticeDao();
	int totalRow =nd.noticePaging();
	//마지막 페이지
	int lastPage = totalRow / rowPerPage;
	// 딱 나누어 떨어지지 않으면 마지막 페이지 추가하기
    if(totalRow % rowPerPage != 0){
			lastPage = lastPage +1;
			}
 	// 시작 공지사항의 번호
 	int beginRow = (currentPage-1)*rowPerPage;
 	
 	
	ArrayList<HashMap<String, Object>> list = nd.selectNotice(beginRow, rowPerPage);	
	System.out.println("\n"+list.size());
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
	
	<%
		if(session.getAttribute("customerId") == null){
	%>		
		<!-- 비회원으로 접근할 때 보이는 메뉴바 -->
		<jsp:include page="/menu.jsp"></jsp:include>
	<%		
		} else {
	%>
		<!-- 회원으로 접근할 때 보이는 메뉴바-->
		<jsp:include page="/privateMenu.jsp"></jsp:include>
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
		
        <!-- 공지사항 -->
        <div class="container">
        	<h1>공지사항</h1>
        	<br>
        	  <h2>목록</h2>
        	  <form action="<%=request.getContextPath()%>/insertNoticeForm.jsp">
        		<button class="btn btn-outline-dark mt-auto" type="submit" style="float:right">공지사항 추가</button>      	     	    
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
        		  	<a href="<%=request.getContextPath()%>/noticeOne.jsp?noticeNo=<%=n.get("noticeNo")%>"><%=n.get("noticeTitle")%></a></td>        							        		         	     							
        		  <td><%=n.get("managerNo")%></td>
        		  <td><%=n.get("createdate")%></td>				  
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