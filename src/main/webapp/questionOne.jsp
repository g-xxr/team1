<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="vo.*" %>
<%@ page import="java.util.*" %>
<%@ page import="dao.*" %>   
<%

	boolean isManagerLoggedIn = (session.getAttribute("managerNo") != null);
	String customerId = (String)(session.getAttribute("loginId")); 
	System.out.println(customerId + "<--customerId");

	if(session.getAttribute("loginId") == null){  // 본인 세션에 loginId를 만든적이 없다 -> 로그인 없다
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
		return;
	}
	
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
	<header class="bg-dark py-1">
	    <div class="container px-4 px-lg-5 my-5">
	        <div class="text-center text-white">
	            <h1 class="display-4 fw-bolder">🎊문의사항🎊</h1>
	            <p class="lead fw-normal text-white-50 mb-0">제품에 대한 문의는 언제든 환영입니다</p>
	        </div>
	    </div>
	</header>
        <!-- 문의사항 상세보기-->
        <div class="container mb-3 mt-3">
        	<h2>문의사항</h2>   	     	    
        		<%
        			for(HashMap<String, Object> o : list){
        		%>        			
				<div>
				<!-- 상품 번호를 hidden으로 전달 -->
          	 <input type="hidden" name="goodsNo" value="<%=o.get("goodsNo")%>">
				<div class="form group">
			<label for="goodsTitle">상품명</label>
			<input type="text" style="width:400px" class="form-control" name="goodsTitle" value="<%=o.get("goodsTitle")%>" readonly>
			</div>
			<div class="form group">
			<label for="questionTitle">제목</label>
			<input type="text" style="width:400px" class="form-control" name="questionTitle" value="<%=o.get("questionTitle")%>" readonly>
			</div>
			<div class="form-group">
		    <label for="questionContent"><h4>내용</h4></label>
	 	   <textarea class="form-control" rows="5" name="questionContent"><%=o.get("questionContent")%></textarea>
			</div>

			
        			  	   			
        			  	 <a href="<%=request.getContextPath()%>/updateQuestionForm.jsp?questionNo=<%=o.get("questionNo")%>" class="btn btn-outline-dark mt-auto" style="float:right">수정</a>
			             <a href="<%=request.getContextPath()%>/deleteQuestionAction.jsp?QuestionNo=<%=o.get("questionNo")%>" class="btn btn-outline-dark mt-auto" style="float:right">삭제</a> 
        		
        		  
        
			    <div class="container mb-3 mt-3 " > 
			      <h5>댓글</h5>
			        <form  action="<%=request.getContextPath()%>/qCommentAction.jsp" method="post">	
			          <div>                             	
			      		<textarea class="form-control" rows="3" name="questionAnswer" placeholder="문의사항에 대한 답변을 입력하세요."></textarea>
			          </div>
			      <br>
			    <div>
        	  <% if(isManagerLoggedIn) { %>
        	    <button type="submit" class="btn btn-outline-dark mt-auto" value="">댓글 추가</button>                 
      		   <% } else { %>
      	 	    <button type="button" class="btn btn-outline-dark mt-auto" disabled>매니저로 작성 가능</button>
      		  <% } %>      
        </div>         
	      </form>			  
				</div>      
				
				<%
        			}
        		%> 
				
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