<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!-- 메뉴 네비게이션 바 -->
<nav class="navbar navbar-expand-lg navbar-light bg-light">
    <div class="container px-4 px-lg-5">
        <a class="navbar-brand" href="<%=request.getContextPath()%>/publicHome.jsp">👻SHOP👽</a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation"><span class="navbar-toggler-icon"></span></button>
        <!-- 메뉴목록 -->
        <div class="collapse navbar-collapse" id="navbarSupportedContent">
            <ul class="navbar-nav me-auto mb-2 mb-lg-0 ms-lg-4">
                <li class="nav-item"><a class="nav-link active" aria-current="page" href="<%=request.getContextPath()%>/goodsList.jsp">베스트 상품</a></li>
                <li class="nav-item"><a class="nav-link" href="<%=request.getContextPath()%>/notice.jsp">공지사항</a></li>
                <li class="nav-item"><a class="nav-link" href="<%=request.getContextPath()%>/question.jsp">문의사항</a></li>
                <li class="nav-item"><a class="nav-link" href="<%=request.getContextPath()%>/review.jsp">리뷰</a></li>
            </ul>
        </div>
        <!-- 장바구니 -->   
        <div>   
           <form class="d-flex">
                <a class="btn btn-outline-dark"  href="<%=request.getContextPath()%>/cart.jsp?customerNo.jsp">
                    <i class="bi-cart-fill me-2">장바구니</i>
                    <span class="badge bg-dark text-white ms-1 rounded-pill">0</span>
                </a>
            </form>
        </div>
        <!-- 마이페이지/로그인 -->
         <div>
             <ul class="navbar-nav me-auto mb-2 mb-lg-0 ms-lg-4">
            	<li class="nav-item"><a class="nav-link" href="<%=request.getContextPath()%>/loginForm.jsp">로그인</a></li>
                <li class="nav-item"><a class="nav-link" href="<%=request.getContextPath()%>/insertMemberForm.jsp">회원가입</a></li>
            </ul>
        </div>
    </div>
</nav>