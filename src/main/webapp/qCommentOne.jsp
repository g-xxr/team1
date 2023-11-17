<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="vo.*" %>
<%@ page import="dao.*" %> 
<%@ page import="java.util.*" %>   
<%

	boolean isManagerLoggedIn = (session.getAttribute("managerNo") != null);
	
	if(session.getAttribute("managerNo") == null){  // 본인 세션에 loginId를 만든적이 없다 -> 로그인 없다
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
		return;
	}
	int managerNo = (Integer)session.getAttribute("managerNo");
	String goodsNoParam = request.getParameter("goodsNo");
    int goodsNo;

    if (goodsNoParam != null && !goodsNoParam.isEmpty()) {
        goodsNo = Integer.parseInt(goodsNoParam);
    } else {
        // 기본값 설정 또는 에러 처리
        goodsNo = 0;     // 다른 기본값 설정
    }
	System.out.println(goodsNo + "<--goodsNo");
	System.out.println("\n" + managerNo + "<--managerNo");;
	
	  String questionNoParam = request.getParameter("questionNo");
	  int questionNo;

	  if (questionNoParam != null && !questionNoParam.isEmpty()) {
	    questionNo = Integer.parseInt(questionNoParam);
	  } else {
	    // 처리할 수 있는 기본값을 설정
	    questionNo = 0;
	  }
	  System.out.println(questionNo +"questiono");
	
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
	<header class="bg-dark py-1">
	    <div class="container px-4 px-lg-5 my-5">
	        <div class="text-center text-white">
	            <h1 class="display-4 fw-bolder">🎊가을맞이 빅세일🎊</h1>
	            <p class="lead fw-normal text-white-50 mb-0">오늘도 즐거운 하루 되세요</p>
	        </div>
	    </div>
	</header>
        	
    <div class="container mb-3 mt-3 " > 
      <h2>문의사항</h2>
          <div>                             	
            <!-- 상품 번호를 hidden으로 전달 -->
          	 <input type="hidden" name="goodsNo" value="<%=goodsNo%>">
			<div class="form group">
			<label for="goodsTitle">상품명</label>
			<input type="text" style="width:400px" class="form-control" name="goodsTitle" value="" readonly>
			</div>
			<div class="form group">
			<label for="goodsTitle">제목</label>
			<input type="text" style="width:400px" class="form-control" name="questionTitle" readonly>
       		</div>
			 
		  	<br>
		  	 <h4>내용</h4>
      		<textarea class="form-control" rows="5" name="questionContent"></textarea>
          </div>
          <br>
	</div>      
	
	    <div class="container mb-3 mt-3 " > 
      <h4>댓글</h4>
        <form  action="<%=request.getContextPath()%>/qCommentAction.jsp" method="post">	
          <div>                             	
      		<textarea class="form-control" rows="3" name="questionAnswer" placeholder="문의사항에 대한 답변을 입력하세요."></textarea>
          </div>
          <br>
          <% if(isManagerLoggedIn) { %>
            <button type="submit" class="btn btn-outline-dark mt-auto" value="">댓글 추가</button>                 
         <% } else { %>
          <button type="button" class="btn btn-outline-dark mt-auto" disabled>매니저로 작성 가능</button>
        <% } %>
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