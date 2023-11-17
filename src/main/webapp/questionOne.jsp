<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="vo.*" %>
<%@ page import="java.util.*" %>
<%@ page import="dao.*" %>   
<%
	String customerId = (String)(session.getAttribute("loginId")); 
	System.out.println(customerId + "<--customerId");

	if(session.getAttribute("loginId") == null){  // 본인 세션에 loginId를 만든적이 없다 -> 로그인 없다
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
		return;
	}
	
	int questionNo = Integer.parseInt(request.getParameter("questionNo"));
	System.out.println(questionNo + "<-- questionNo");
	QuestionDao qd = new QuestionDao();
	Question qo = qd.QuestionOne(questionNo);	

%> 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

<title>홈페이지 팀플</title>	
<!-- 파비콘 코드 -->
<link rel="icon" type="image/x-icon" href="assets/favicon.ico">
	
<!-- 부트스트랩 아이콘 -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.5.0/font/bootstrap-icons.css" rel="stylesheet">
	
<!-- 코어 테마 css -->
<link href="css/styles.css" rel="stylesheet">
</head> 
<body>
	<!-- 메뉴 시작 (절대주소 적으세요)-->
	<jsp:include page="/inc/privateMenu.jsp"></jsp:include>
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
        <!-- 문의사항 상세보기-->
        <div class="container">
        	<h1>문의사항 상세보기</h1>   	     	    
        	  <table class="table table-hover">    	    			
        			  <tr>
        			  	<th>상품번호</th>
 						<td><%=qo.getGoodsNo()%></td> 						        			  				  
        			  </tr>
        			  <tr>
        			  	<th>작성자</th>
 						<td><%=qo.getCustomerNo() %></td>       			  				  
        			  </tr> 
        			  <tr>
        			  	<th>제목</th>
 						<td><%=qo.getQuestionTitle()%></td>       			  				  
        			  </tr> 
        			  <tr>
        			  	<th>내용</th>
 						<td><%=qo.getQuestionContent()%></td>       			  				  
        			  </tr>  
        			  <tr>
        			  	<th>작성일</th>
 						<td><%=qo.getCreatedate()%></td>       			  				  
        			  </tr>  
        			  <tr>
        			  	<th>수정일</th>
 						<td><%=qo.getUpdatedate()%></td>       			  				  
        			  </tr> 
        			  	   			
        			  	 
        		
        		  		
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