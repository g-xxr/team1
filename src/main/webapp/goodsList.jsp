<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %>
<%@ page import = "java.util.*" %>
<%@ page import = "vo.*" %>
    
    
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
		totalRow = rs1.getInt("COUNT(*)");    // rs1.getInt(1)
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
	while(rs2.next()){
		Goods g = new Goods();
		g.goodsNo = rs2.getInt("goodsNo");
		g.goodsTitle = rs2.getString("goodsTitle");
		g.goodsPrice = rs2.getInt("goodsPrice");
		g.soldout = rs2.getString("soldout");
		g.goodsMemo = rs2.getString("goodsMemo");
		g.filename = rs2.getString("filename");
		list.add(g);
	}
	
	rs1.close();
	stmt1.close();
	conn.close();

%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<!-- 메뉴 시작 (절대주소 적으세요)-->
	<jsp:include page="/menu.jsp"></jsp:include>
	<!-- 메뉴 끝 -->
	
	<!-- 상품 섹션 -->
	<section class="py-5">
		<%
			int i = 1;
			for(Goods g : list){
		%>
	<section>
	<div class="container px-4 px-lg-5 mt-5">
		<div class="row gx-4 gx-lg-5 row-cols-2 row-cols-md-3 row-cols-xl-4 justify-content-center">
			<div class="col mb-5">
				<div class="card h-100">
					<!-- 베스트 상품 -->
                    <div class="badge bg-dark text-white position-absolute" style="top: 0.5rem; right: 0.5rem">🏅</div>
	                <!-- 상품 이미지 -->
	                <img class="card-img-top" src="https://dummyimage.com/450x300/dee2e6/6c757d.jpg" alt="..." />
	                <!-- 상품 상세정보 -->
	                <div class="card-body p-4">
	                <div class="text-center">
	                <!-- 상품 이름 -->
	                <h5 class="fw-bolder">테스트 상품</h5>
	                <!-- 상품 가격 -->
	                💰59,000원💰
	                </div>
	                </div>
	                <!-- Product actions-->
	                <div class="card-footer p-3 pt-0 border-top-0 bg-transparent text-center">
	            	<a class="btn btn-outline-dark mt-auto" href="#">상세보기</a>
	            	<a class="btn btn-outline-dark mt-auto" href="#">장바구니</a>
	      			</div>
            	</div>
			</div>
		</div>
	</div>
	</section>
             <%
				if(i%4==0){
			%>       
            <%
				}
				i=i+1;
				}
				/* 
				마지막 페이지면서 4로 나누어 떨어지지 않으면
				if(i==(rowPerPage+1))
				마지막 페이지가 아니거나 마지막 페이지이지만 rowPerPage로 나누어 떨어진다 ∴ 4로도 나누어 떨어진다*/
				
				if((i-1) < (rowPerPage)){ // 마지막 페이지면서 rowPerPage로 나누어 떨어지지 않는다
										// 조건에 만족해도 4로 나누어 떨어지면 td는 필요없다
					if((i-1)%4 != 0){	// td가 더 필요하담
						for(int j=0; j<4-((i-1)%4); j=j+1){
			%>
				
			<%		
			  }
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
		
	</section>
</body>
</html>