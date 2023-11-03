<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입</title>
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.3/dist/umd/popper.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>

<style>
    body {
        display: flex;
        justify-content: center;
        align-items: center;
        height: 100vh;
        margin: 0;
    }
</style>
</head>
<body>
    <div class="container">
        <form method="post" action="<%=request.getContextPath()%>/insertCustomerAction.jsp">
            <div class="card">
                <div class="card-body">
                    <h1 class="card-title">회원등록</h1>
                    <div class="form-group">
                        <label for="customerId">아이디</label>
                        <input type="text" class="form-control" id="customerId" name="customerId" required placeholder="아이디를 입력하세요.">
                    </div>
                    <div class="form-group">
                        <label for="customerPw">비밀번호</label>
                        <input type="password" class="form-control" id="customerPw" name="customerPw" required placeholder="비밀번호를 입력하세요.">
                    </div>
                    
                    <!--  
                    
                   <div class="form-group">
                        <label for="address">주소</label>
                        <input type="text" class="form-control" id="address" name="address" required placeholder="비밀번호를 입력하세요.">
                    </div>
                   <div class="form-group">
                        <label for="customerPhone">전화번호</label>
                        <input type="tel" class="form-control" id="customerPhone" name="customerPhone" required placeholder="비밀번호를 입력하세요.">
                    </div>
                    
                    -->
                    
                    <div class="form-group">
                        <button type="submit" class="btn btn-primary">가입하기</button>
                    </div>
                </div>
            </div>
        </form>
    </div>
	<script>
	</script>

</body>
</html>
