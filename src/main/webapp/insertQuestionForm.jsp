<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="vo.*" %>
<%@ page import="dao.*" %> 
<%@ page import="java.util.*" %>   
<%
	String customerId = (String)(session.getAttribute("loginId")); 
	System.out.println(customerId + "<--customerId");
	
	if(session.getAttribute("loginId") == null){  // 본인 세션에 loginId를 만든적이 없다 -> 로그인 없다
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
		return;
	}
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

		
	<!-- 헤드 배너 부분 -->
	<header class="bg-dark py-5">
	    <div class="container px-4 px-lg-5 my-5">
	        <div class="text-center text-white">
	            <h1 class="display-4 fw-bolder">🎊가을맞이 빅세일🎊</h1>
	            <p class="lead fw-normal text-white-50 mb-0">오늘도 즐거운 하루 되세요</p>
	        </div>
	    </div>
	</header>
        	
    <div class="container mb-3 mt-3 " > 
      <h2>문의사항 작성</h2>
        <form  action="<%=request.getContextPath()%>/insertQuestionAction.jsp">	
          <div>                             	
			  <!-- 상품 번호를 hidden으로 전달 -->
             <input type="hidden" name="goodsNo" value="<%=getgoodsNo%>">
		     <label for="comment">제목:</label>
			 <input type="text" style="width:400px" class="form-control" name="questionTitle">
		  	
		  	<label for="comment">내용:</label>
      		<textarea class="form-control" rows="5" name="questionContent"></textarea>
          </div>
          <br>
          <button type="submit" class="btn btn-outline-dark mt-auto" value="">공지추가</button>                 
        </form>			  
	</div>      
	  
	 <!-- Footer-->
	 <br>   
        <footer class="py-5 bg-dark">
            <div class="container"><p class="m-0 text-center text-white">Copyright &copy; Your Website 2023</p></div>
        </footer>
        <!-- Bootstrap core JS-->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
        <!-- Core theme JS-->
        <script src="js/scripts.js"></script>
</body>
</html>