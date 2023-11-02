<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!-- 메뉴 네비게이션 바 -->
<nav class="navbar navbar-expand-lg navbar-light bg-light">
    <div class="container px-4 px-lg-5">
        <a class="navbar-brand" href="<%=request.getContextPath()%>/privateHome.jsp">👻SHOP👽</a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation"><span class="navbar-toggler-icon"></span></button>
        <div class="collapse navbar-collapse" id="navbarSupportedContent">
            <ul class="navbar-nav me-auto mb-2 mb-lg-0 ms-lg-4">
                <li class="nav-item"><a class="nav-link active" aria-current="page" href="<%=request.getContextPath()%>/productList.jsp">베스트</a></li>
                <li class="nav-item"><a class="nav-link" href="<%=request.getContextPath()%>/notice.jsp">공지사항</a></li>
                <li class="nav-item dropdown">
	            	<a class="nav-link dropdown-toggle" id="navbarDropdown" href="<%=request.getContextPath()%>/question.jsp" role="button" data-bs-toggle="dropdown" aria-expanded="false">문의사항</a>
	            	<ul class="dropdown-menu" aria-labelledby="navbarDropdown">
		            <li><a class="dropdown-item" href="<%=request.getContextPath()%>/questionForm.jsp">문의남기기</a></li>
	            	</ul>
        		</li>
                <li class="nav-item dropdown">
	            	<a class="nav-link dropdown-toggle" id="navbarDropdown" href="<%=request.getContextPath()%>/review.jsp" role="button" data-bs-toggle="dropdown" aria-expanded="false">리뷰</a>
	            	<ul class="dropdown-menu" aria-labelledby="navbarDropdown">
		            <li><a class="dropdown-item" href="<%=request.getContextPath()%>/insertReviewForm.jsp">리뷰남기기</a></li>
	            	</ul>
        		</li>
            </ul>
           
           <!-- 여기 공백 넣고싶은데 -->
           
            <form class="d-flex">
                <button class="btn btn-outline-dark" type="submit">
                    <i class="bi-cart-fill me-1"></i>
                    장바구니
                    <span class="badge bg-dark text-white ms-1 rounded-pill">여기에 장바구니 수량 링크 들어감</span>
                </button>
            </form>
             <ul class="navbar-nav me-auto mb-2 mb-lg-0 ms-lg-4">
            	<li class="nav-item"><a class="nav-link" href="<%=request.getContextPath()%>/customerOne.jsp">마이페이지</a></li>
                <li class="nav-item"><a class="nav-link" href="<%=request.getContextPath()%>/customerLogoutAction.jsp">로그아웃</a></li>
            </ul>
        </div>
    </div>
</nav>