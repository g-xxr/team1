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
	QuestionDao qd = new QuestionDao();
	ArrayList<HashMap<String, Object>> list = qd.selectQuestionOne(questionNo);
	

%> 
    
<body>
	<!-- 메뉴 시작 (절대주소 적으세요)-->
	<jsp:include page="/privateMenu.jsp"></jsp:include>
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
        		<%
        			for(HashMap<String, Object> o : list){
        		%>        			
        			  <tr>
        			  	<th>상품번호</th>
 						<td><%=o.get("goodsNo")%></td> 						        			  				  
        			  </tr>
        			  <tr>
        			  	<th>작성자</th>
 						<td><%=o.get("customerNo") %></td>       			  				  
        			  </tr> 
        			  <tr>
        			  	<th>제목</th>
 						<td><%=o.get("noticeTitle")%></td>       			  				  
        			  </tr> 
        			  <tr>
        			  	<th>내용</th>
 						<td><%=o.get("noticeContent")%></td>       			  				  
        			  </tr>  
        			  <tr>
        			  	<th>작성일</th>
 						<td><%=o.get("createdate")%></td>       			  				  
        			  </tr>  
        			  <tr>
        			  	<th>수정일</th>
 						<td><%=o.get("updatedate")%></td>       			  				  
        			  </tr>    			
        			  	 <a href="<%=request.getContextPath()%>/updateQuestionForm.jsp?questionNo=<%=o.get("questionNo")%>" class="btn btn-outline-dark mt-auto">수정</a>
			             <a href="<%=request.getContextPath()%>/deleteQuestionAction.jsp?QuestionNo=<%=o.get("questionNo")%>" class="btn btn-outline-dark mt-auto">삭제</a> 
        		
        		<%
        			}
        		%>  
        		      		
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