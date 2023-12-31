<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!-- 메뉴 네비게이션 바 -->
<!-- 메뉴 시작 (절대주소 적으세요)-->
<jsp:include page="/inc/privateMenu.jsp"></jsp:include>
<!-- 메뉴 끝 -->

<!DOCTYPE html>
<html lang="ko">
<head>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>비밀번호 변경</title>
    <style>
        /* Custom styles can be added here */
        /* Example: body { background-color: #f4f4f4; } */
        /* Add your custom CSS styles below this comment */
    </style>
</head>
<body>
<div class="container mt-5">
    <div class="row justify-content-center">
        <div class="col-md-6">
            <div class="card">
                <div class="card-body">
                    <h2 class="card-title text-center">비밀번호 변경</h2>
                    <form action="<%=request.getContextPath()%>/updateManagerPwAction.jsp" method="post">
                        <div class="mb-3">
                            <label for="oldPw" class="form-label">기존 비밀번호</label>
                            <input type="password" class="form-control" name="oldPw" required placeholder="현재 비밀번호" id="oldPw">
                        </div>
                        <div class="mb-3">
                            <label for="newPw" class="form-label">변경할 비밀번호</label>
                            <input type="password" class="form-control" name="newPw" required placeholder="새 비밀번호" id="newPw">
                        </div>
                        <div class="text-center">
                            <button type="submit" class="btn btn-primary">비밀번호 변경</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>
</body>
</html>
