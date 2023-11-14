<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!-- 메뉴 네비게이션 바 -->
<nav class="navbar navbar-expand-lg navbar-light bg-light">
    <div class="container px-4 px-lg-5">
        <a class="navbar-brand" href="<%=request.getContextPath()%>/managerHome.jsp">👻SHOP👽</a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation"><span class="navbar-toggler-icon"></span></button>
        <div class="collapse navbar-collapse" id="navbarSupportedContent">
            <ul class="navbar-nav me-auto mb-2 mb-lg-0 ms-lg-4">
                <li class="nav-item"><a class="nav-link active" aria-current="page" href="<%=request.getContextPath()%>/goodsListManager.jsp">상품관리</a></li>
                <li class="nav-item"><a class="nav-link active" aria-current="page" href="<%=request.getContextPath()%>/managerNotice.jsp">공지관리</a></li>
                <li class="nav-item"><a class="nav-link active" aria-current="page" href="<%=request.getContextPath()%>/question.jsp">문의관리</a></li>
                <li class="nav-item"><a class="nav-link active" aria-current="page" href="<%=request.getContextPath()%>/review.jsp">리뷰관리</a></li>
            </ul>
          </div>
           
           <!-- 여기 공백 넣고싶은데 div 태그로 나눠 쓰면 됨 -->
           
          <div>
          <ul class="navbar-nav me-auto mb-2 mb-lg-0 ms-lg-4">
	          <li class="nav-item"><a class="nav-link" href="<%=request.getContextPath()%>/managerOne.jsp">마이페이지</a></li>
	          <li class="nav-item"><a class="nav-link" href="<%=request.getContextPath()%>/managerLogoutAction.jsp">로그아웃</a></li>
          </ul>
          </div>
    </div>
</nav>