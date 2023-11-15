<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="vo.*" %>
<%@ page import="java.util.*" %>
<%@ page import="dao.*" %>      
<%
	int currentPage = 1;
	// 페이지네이션을 구현하고 사용자가 원하는 페이지로 이동
	if(request.getParameter("currentPage") != null){
		currentPage = Integer.parseInt(request.getParameter("currentPage"));
	}
	int rowPerPage = 8;
	
	QuestionDao qd = new QuestionDao();
	int totalRow =qd.questionPaging();
	
	int lastPage = totalRow / rowPerPage;
	if(totalRow % rowPerPage != 0){
		lastPage = lastPage +1;
		}
	
	int beginRow = (currentPage-1)*rowPerPage;
		
	ArrayList<Question> list = qd.selectQuestion(beginRow, rowPerPage);
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
        	<h1>문의사항</h1>
        	<br>     	     	    
        	  <table class="table table-hover">
       		
        		<tr>
        			<th class="col-sm-1">번호</th> 
        			<th class="col-sm-1">상품</th>    			
        			<th class="col-sm-7">제목</th>     
        			<th class="col-sm-1">작성자</th>   			
        			<th class="col-sm-1">작성일</th>	
        		</tr>		
        	<%	
        		for(Question q : list){
        	%>
        		 <tr>
        		  <td><%=q.getQuestionNo()%></td>
        		  <td><%=q.getGoodsNo()%></td>
        		  <td>
        		  	 <a href="<%=request.getContextPath()%>/questionOne.jsp?questionNo=<%=q.getQuestionNo()%>"><%=q.getQuestionTitle()%></a>        		  	
        		  </td>        							        		         	     							
        		  <td><%=q.getCustomerNo()%></td>
        		  <td><%=q.getCreatedate()%></td>	        		  
        	     </tr> 
        	      
        	<%
        		}
        	%>        		       		
        	  </table>
         	  
        </div>
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
       <br>
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