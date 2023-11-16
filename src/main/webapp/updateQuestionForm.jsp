<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "dao.*" %>
<%@ page import = "vo.*" %>
<%@ page import="java.util.*" %>
<%
	int questionNo = Integer.parseInt(request.getParameter("questionNo"));
	QuestionDao qd = new QuestionDao();
	ArrayList<HashMap<String, Object>> list = qd.QuestionOne(questionNo);



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
        <hr>
    <div class="container" >      				
		   <form action="<%=request.getContextPath()%>/updateQuestionAction.jsp" method = "post">
		   	<input type="hidden" name ="managerNo" value="<%=session.getAttribute("managerNo")%>">
		   		<input type="hidden" name ="questionNo" value="<%=questionNo%>">	  
			<h2>문의사항 수정</h2> 			
     		<div class="mb-3 mt-3">
  
     		  <div>
     			<label for="comment">번호:</label>      		
      			<input class="form-control w-50 p-1" type = "text" name="questionNo" value="<%=questionNo%>" disabled>
      		  </div>
     		  
     		  <div>
     			<label for="comment">제목:</label>      		
      			<input class="form-control w-50 p-1" type="text" name="questionTitle" value="<%=questionTitle%>">
      		  </div>
      		  
      		  <div>
      			<label for="comment">내용:</label>
      			<textarea class="form-control" rows="5" name="questionContent" value="<%=questionContent%>"></textarea>     		
   		      </div>
   		      <br>
           <button class="btn btn-outline-dark mt-auto" type="submit">작성완료</button>    		 
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