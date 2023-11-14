<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %>
<%@ page import = "java.util.*" %>
<%@ page import = "dao.*" %>

<!-- 유정 -->
	<%
		// 로그인한 매니저만 접근 가능
		int managerNo = 0;

		if(session.getAttribute("managerNo") == null){  // 현재 세션에 managerNo을 찾을 수 없다 -> 로그인 못함 -> 로그인 폼으로 가세요
			response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
			return;
		} else {
			managerNo = (Integer)session.getAttribute("managerNo");
		}
	
		// 페이징 하기
		// 현재 페이지
		int currentPage = 1;
	    // 페이지네이션을 구현하고 사용자가 원하는 페이지로 이동
		if(request.getParameter("currentPage") != null){
			currentPage = Integer.parseInt(request.getParameter("currentPage"));
		}
	    // 페이지 당 몇개의 항목을 나타내는지 (여기 페이지는 8개 항목)
	    int rowPerPage = 10;
	    
	    // GoodsDao 호출 코드
	    GoodsDao gd = new GoodsDao();
	    int totalRow =gd.goodsListPaging();
	   	// 마지막 페이지
	    int lastPage = totalRow / rowPerPage;
	    // 딱 나누어 떨어지지 않으면 마지막 페이지 추가하기
	    if(totalRow % rowPerPage != 0){
			lastPage = lastPage +1;
			}
	    // 시작 상품의 번호
	    int beginRow = (currentPage-1)*rowPerPage;
	    
	    ArrayList<HashMap<String,Object>>list =gd.goodsList(beginRow, rowPerPage);
	%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <meta name="description" content="">
        <meta name="author" content="">
        <title>매니저 상품 목록</title>
        <!-- Favicon-->
        <link rel="icon" type="image/x-icon" href="assets/favicon.ico">
        <!-- Bootstrap icons-->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.5.0/font/bootstrap-icons.css" rel="stylesheet">
        <!-- Core theme CSS (includes Bootstrap)-->
        <link href="css/styles.css" rel="stylesheet">
    </head>
<body>
	<!-- 매니저로 접근할 때 보이는 메뉴바-->
	<jsp:include page="/inc/managerMenu.jsp"></jsp:include>
	
	<!-- 헤드 배너 부분 -->
	<header class="bg-dark py-1">
	    <div class="container px-4 px-lg-5 my-4">
	        <div class="text-center text-white">
	            <h1 class="display-4 fw-bolder">상품 리스트(추가/수정/삭제)</h1>
	            <p class="lead fw-normal text-white mb-0">상품 리스트 추가/수정/삭제 후 관리자 채널에 공유 바랍니다</p>
	        </div>
	    </div>
	</header>
	
	
	<!-- 상품 리스트 테이블 -->
	<div class="container mt-3">
	<!-- 상품 추가 버튼 -->
	<div style="text-align: right;">
		<a class="btn btn-outline-dark btn-lg" href="<%=request.getContextPath()%>/insertGoodsForm.jsp">새로운 상품 추가하기</a>
	</div>
	<br>
	<!-- 상품 목록 -->
	<table class="table table-bordered table-hover" style="text-align:center; vertical-align: middle;">
		<thead>
			<tr>
	        <th>상품 사진</th>
	        <th>상품 이름</th>
	        <th>상품 가격</th>
	        <th>품절 여부</th>
	        <th>상품 설명</th>
	        <th>수정</th>
	        <th>삭제</th>
	      	</tr>
		</thead>
	<%
		for(HashMap<String, Object> map : list){
	%>
    	<tbody>
     		<tr>
        	<td><img src="<%=request.getContextPath()%>/upload/<%=map.get("filename")%>" style="width: 60px; height: 60px;"></td>
        	<td><%=map.get("goodsTitle")%></td>
        	<td><mark><%=map.get("goodsPrice")%>원</mark></td>
        	<td><%=map.get("soldout")%></td>
        	<td><%=map.get("goodsMemo")%></td>
        	<td><a class="btn btn-outline-info" href="<%=request.getContextPath()%>/updateGoodsForm.jsp?goodsNo=<%=map.get("goodsNo")%>">💡수정💡</a></td>
        	<td><a class="btn btn-outline-danger" href="<%=request.getContextPath()%>/deleteGoodsAction.jsp?goodsNo=<%=map.get("goodsNo")%>">🗑️삭제🗑️</a></td>
      		</tr>
    	</tbody>
    <%
       }
	%>
	</table>
	</div>

	<br>	
	<!-- 페이지네이션 -->
	<div class="d-flex justify-content-center">
		<div>
		<%
			if(currentPage > 1){
		%>
			<a class="btn btn-outline-success" href="<%=request.getContextPath()%>/goodsListManager.jsp?currentPage=<%=currentPage-1%>">이전</a>
		<%
			}
		%>
		
		<%
			if(currentPage < lastPage){
		%>
			<a class="btn btn-outline-success" href="<%=request.getContextPath()%>/goodsListManager.jsp?currentPage=<%=currentPage+1%>">다음</a>
		<%
			}
		%>
		</div>
	</div>
	
	<br>
	<br>
	<!-- 맨 아래 배너 -->
	<footer class="py-3 bg-dark">
	<div class="container"><p class="m-0 text-center text-white"> Copyright &copy; 유정 도헌 유섭</p></div>
	</footer>
	   
	<!-- Bootstrap core JS-->
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
	   
	<!-- Core theme JS-->
	<script src="js/scripts.js"></script>
</body>
</html>