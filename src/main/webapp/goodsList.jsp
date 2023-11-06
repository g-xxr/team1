<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %>
<%@ page import = "java.util.*" %>
<%@ page import = "vo.*" %>  

<!-- 유정 -->
    <%
	int currentPage = 1;
	if(request.getParameter("currentPage") != null){
		currentPage = Integer.parseInt(request.getParameter("currentPage"));
	}
	
	int rowPerPage = 8;
	
	// DB goods 테이블 & goodsimg 테이블에 입력하기
	Class.forName("org.mariadb.jdbc.Driver");
	String url = "jdbc:mariadb://localhost:3306/mall";
	String dbuser = "root";
	String dbpw = "java1234";
	Connection conn = DriverManager.getConnection(url, dbuser, dbpw);

	// 쿼리 2개 들어감
	String sql1 = "SELECT COUNT(*) FROM goods";   
	PreparedStatement stmt1 = conn.prepareStatement(sql1);
	ResultSet rs1 = stmt1.executeQuery();
	int totalRow = 0;
	if(rs1.next()){
		totalRow = rs1.getInt("COUNT(*)");    // "COUNT(*)" 대신 1을 사용
	}
	
	int lastPage = totalRow / rowPerPage;
	if(totalRow % rowPerPage != 0){
		lastPage = lastPage +1;
	}
	
	int beginRow = (currentPage-1)*rowPerPage;
	
	/*
		SELECT g.goods_no goodsNo, g.goods_title goodsTitle, g.goods_price goodsPrice, g.soldout soldout, g.goods_memo memo, i.filename filename
		FROM goods g INNER JOIN goods_img i ON g.goods_no = i.goods_no
		ORDER BY g.goods_no DESC
		LIMIT ?,?;
	*/
	
	String sql2 = "SELECT g.goods_no goodsNo, g.goods_title goodsTitle, g.goods_price goodsPrice, g.soldout soldout, g.goods_memo goodsMemo, i.filename filename FROM goods g INNER JOIN goods_img i ON g.goods_no = i.goods_no ORDER BY g.goods_no DESC LIMIT ?,?";
	PreparedStatement stmt2 = conn.prepareStatement(sql2);
	stmt2.setInt(1, beginRow);
	stmt2.setInt(2, rowPerPage);
	ResultSet rs2 = stmt2.executeQuery();
	
	ArrayList<Goods> list = new ArrayList<Goods>();
	while(rs2.next()){	// 여러행을 받으니까 while
		Goods g = new Goods();
		GoodsImg i = new GoodsImg();
		g.setGoodsNo(rs2.getInt("goodsNo"));
		g.setGoodsTitle(rs2.getString("goodsTitle"));
		g.setGoodsPrice(rs2.getInt("goodsPrice"));
		g.setSoldout(rs2.getString("soldout"));
		g.setGoodsMemo(rs2.getString("goodsMemo"));
		g.setFilename(rs2.getString("filename"));
		list.add(g);
	}
	
	rs1.close();
	stmt1.close();
	conn.close();
	
	rs2.close();
	stmt2.close();

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
			
	<!-- 페이징 -->
	<div class="d-flex justify-content-center">
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