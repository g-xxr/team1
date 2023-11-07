<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %>
<%@ page import = "java.util.*" %>
<%@ page import = "vo.*" %>
<%@ page import = "dao.*" %>

<!-- 유정 -->
    <%
    // 페이징 하기
    // 현재 페이지
	int currentPage = 1;
    // 페이지네이션을 구현하고 사용자가 원하는 페이지로 이동
	if(request.getParameter("currentPage") != null){
		currentPage = Integer.parseInt(request.getParameter("currentPage"));
	}
    // 페이지 당 몇개의 항목을 나타내는지 (여기 페이지는 8개 항목)
    int rowPerPage = 8;
    // 시작 상품의 번호
    int beginRow = (currentPage-1)*rowPerPage;
 	// 총 상품 수
    int totalRow = gd.count(*);
    // 마지막 페이지
    int lastPage = totalRow / rowPerPage;
    // 딱 나누어 떨어지지 않으면 마지막 페이지 추가하기
    if(totalRow % rowPerPage != 0){
		lastPage = lastPage +1;
	
    // GoodsDao 호출 코드
    GoodsDao gd = new GoodsDao();
    ArrayList<Goods> list = gd.goodsList(beginRow, rowPerPage);
	
	%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
        <meta name="description" content="" />
        <meta name="author" content="" />
        <title>상품 리스트</title>
        <!-- Favicon-->
        <link rel="icon" type="image/x-icon" href="assets/favicon.ico" />
        <!-- Bootstrap icons-->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.5.0/font/bootstrap-icons.css" rel="stylesheet" />
        <!-- Core theme CSS (includes Bootstrap)-->
        <link href="css/styles.css" rel="stylesheet" />
    </head>
<body>
	<!-- 메뉴 시작 (절대주소 적으세요)-->
	<jsp:include page="/menu.jsp"></jsp:include>
	<!-- 메뉴 끝 -->
	
	<!-- 헤드 배너 부분 -->
	<header class="bg-dark py-4">
	    <div class="container px-4 px-lg-5 my-5">
	        <div class="text-center text-white">
	            <h1 class="display-4 fw-bolder">🎊가을맞이 빅세일🎊</h1>
	            <p class="lead fw-normal text-white-50 mb-0">오늘도 즐거운 하루 되세요</p>
	        </div>
	    </div>
	</header>
	
	<!-- 상품 섹션 -->
		<%
			int i = 1;
			for(Goods g : list){
		%>
		
		<%
		if (i % 4 == 1) { // 한 행의 첫 번째 상품
		%>
		<div class="row gx-4 gx-lg-5">
		<%
		}
		%>
			<div class="col mb-5">
				<div class="card h-100">
	                <!-- 상품 이미지 -->
	                <img class="card-img-top" src="<%=request.getContextPath()%>/upload/<%=g.getFilename()%>" >
	                <!-- 상품 상세정보 -->
	                <div class="card-body p-4">
	                <div class="text-center">
	                <!-- 상품 이름 -->
	                <h5 class="fw-bolder"><%=g.getGoodsTitle()%></h5>
	                <!-- 상품 가격 -->
	                <mark>💰<%=g.getGoodsPrice()%>원💰</mark>
	                </div>
	                </div>
	                <!-- 상품 관련 액션 -->
	                <div class="card-footer p-3 pt-0 border-top-0 bg-transparent text-center">
	            	<a class="btn btn-outline-dark mt-auto" href="<%=request.getContextPath()%>/goodsOne.jsp?goodsNo=<%=g.getGoodsNo()%>">상세보기</a>
	            	<a class="btn btn-outline-dark mt-auto" href="<%=request.getContextPath()%>/cart.jsp?goodsNo=<%=g.getGoodsNo()%>">장바구니</a>
	      			</div>
            	</div>
			</div>
            <%
				if(i%4==0){ // 한 행의 마지막 상품
			%>
			</div>
			<%
				} i=i+1;
			}
			%>
			<%
			// 남은 열을 닫음
			if (i % 4 != 1) {
			for (int j = 0; j < 4 - (i % 4); j = j + 1) {
			%>
			<div class="col mb-5"></div>
			<%
				}
			}
			%>
			<br>
			<br>
			
	<!-- 페이지네이션 -->
	<div class="d-flex justify-content-center">
		<div>
		<%
			if(currentPage > 1){
		%>
			<a class="btn btn-outline-success" href="<%=request.getContextPath()%>/goodsList.jsp?currentPage=<%=currentPage-1%>">이전</a>
		<%
			}
		%>
		
		<%
			if(currentPage < lastPage){
		%>
			<a class="btn btn-outline-success" href="<%=request.getContextPath()%>/goodsList.jsp?currentPage=<%=currentPage+1%>">다음</a>
		<%
			}
		%>
		</div>        
	</div>
	
	
	<!-- 맨 아래 배너 -->
	<footer class="py-5 bg-dark">
	<div class="container"><p class="m-0 text-center text-white"> Copyright &copy; 유정 도헌 유섭 </p></div>
	</footer>
	   
	<!-- Bootstrap core JS-->
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
	   
	<!-- Core theme JS-->
	<script src="js/scripts.js"></script>
</body>
</html>