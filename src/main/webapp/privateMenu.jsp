<%@page import="java.util.Map"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!-- 메뉴 네비게이션 바 -->
<nav class="navbar navbar-expand-lg navbar-light bg-light">
    <div class="container px-4 px-lg-5">
        <a class="navbar-brand" href="<%=request.getContextPath()%>/privateHome.jsp">👻SHOP👽</a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation"><span class="navbar-toggler-icon"></span></button>
        <div class="collapse navbar-collapse" id="navbarSupportedContent">
            <ul class="navbar-nav me-auto mb-2 mb-lg-0 ms-lg-4">
                <li class="nav-item"><a class="nav-link active" aria-current="page" href="<%=request.getContextPath()%>/goodsList.jsp">베스트 상품</a></li>
                <li class="nav-item"><a class="nav-link" href="<%=request.getContextPath()%>/notice.jsp">공지사항</a></li>
                <li class="nav-item"><a class="nav-link" href="<%=request.getContextPath()%>/question.jsp">문의사항</a></li>
                <li class="nav-item"><a class="nav-link" href="<%=request.getContextPath()%>/review.jsp">리뷰</a></li>
            </ul>
           
           <!-- 여기 공백 넣고싶은데 -->
            <form class="d-flex">
                <a class="btn btn-outline-dark"  href="<%=request.getContextPath()%>/cart.jsp?customerNo.jsp">
                    <i class="bi-cart-fill me-2">장바구니</i>
                    <span class="badge bg-dark text-white ms-1 rounded-pill">수량</span>
                </a>
            </form>
             <ul class="navbar-nav me-auto mb-2 mb-lg-0 ms-lg-4">
            	<li class="nav-item"><a class="nav-link" href="<%=request.getContextPath()%>/customerOne.jsp">마이페이지</a></li>
                <li class="nav-item"><a class="nav-link" href="<%=request.getContextPath()%>/customerLogoutAction.jsp">로그아웃</a></li>
            </ul>
        </div>
    </div>
</nav>

