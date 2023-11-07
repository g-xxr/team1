<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!-- 메뉴 시작 (절대주소 적으세요)-->
<jsp:include page="/menu.jsp"></jsp:include>
<!-- 메뉴 끝 -->

<!DOCTYPE html>
<html>
<head>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
    <meta charset="UTF-8">
    <title>비밀번호 확인</title>
</head>
<body>
<div class="container mt-5">
    <h1>비밀번호 확인</h1>
    <form action="<%=request.getContextPath()%>/deleteCustomerAction.jsp" method="post">
        <div class="mb-3">
            <label for="customerPw" class="form-label">계정 삭제를 위해 비밀번호를 입력하세요.</label>
            <input type="password" class="form-control" name="customerPw" id="customerPw">
        </div>
        <button type="submit" class="btn btn-outline-primary">확인</button>
    </form>
</div>
</body>
</html>
