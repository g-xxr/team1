<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<!-- 메뉴 네비게이션 바 -->
	<!-- 메뉴 시작 (절대주소 적으세요)-->
	<jsp:include page="/privateMenu.jsp"></jsp:include>
	<!-- 메뉴 끝 -->
    
<!DOCTYPE html>
<html lang="ko">
<head>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>비밀번호 변경</title>
    <link rel="stylesheet" href="your-stylesheet.css"> <!-- 필요한 스타일시트를 여기에 링크하세요 -->
</head>
<body>
  
    
        <div id="content">
            <h1>비밀번호 변경</h1>
            <form action="<%=request.getContextPath()%>/updateCustomerPwAction.jsp" method="post">
            <table>
                <tr>
                	<td>기존 비밀번호</td>
                	<td>
                   	 	<input type="password" name="oldPw" required placeholder="현재 비밀번호">
                	</td>
                </tr>
                <tr>
               		 <td> 변경할 비밀번호</td>
             	     <td>
                   		 <input type="password" name="newPw" required placeholder="새 비밀번호">
           			</td>
           		</tr>
             </table>
             <button type="submit">비밀번호 변경</button>
          </form>
</body>
</html>
