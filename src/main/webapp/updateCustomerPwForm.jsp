<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>비밀번호 변경</title>
    <link rel="stylesheet" href="your-stylesheet.css"> <!-- 필요한 스타일시트를 여기에 링크하세요 -->
</head>
<body>
  
    
        <div id="content">
            <h1>비밀번호 변경</h1>
            <form action="<%=request.getContextPath()%>/updateCustomerPwAction.jsp" method="post">
                <div class="form-group">
                    <input type="password" name="oldPw" required placeholder="현재 비밀번호">
                </div>
                <div class="form-group">
                    <input type="password" name="newPw" required placeholder="새 비밀번호">
                </div>
                <button type="submit">비밀번호 변경</button>
            </form>
        </div>
   
   
</body>
</html>
