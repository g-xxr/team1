<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	// 로그인 전
	String msg = request.getParameter("msg");
	if(session.getAttribute("loginId") != null) { // 로그인 되어 있으면 프라이빗.jsp로 가라.
		response.sendRedirect(request.getContextPath()+"/privateHome.jsp");
		return;
}
%>    

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그인폼</title>
<style>
    body {
        display: flex;
        justify-content: center;
        align-items: center;
        height: 100vh;
        margin: 0;
    }
    .container {
        text-align: center;
    }
    .form-container {
        background-color: #007BFF;
        color: white;
        padding: 20px;
        border-radius: 10px;
    }
</style>
</head>
<body>
	
	<!-- 로그인 폼 만들기 (로그인 시 고객에게 보여지는 홈페이지 (productList)
		 매니저는 바로 (managerHome : 여기에서는 상품 관리(상품 추가, 수정, 삭제), 공지사항, 문의(답변) 게시판으로 바로 갈 수 있는 폼 만들기)
	-->
 <div class="container">
        <div class="form-container">
            <h1>로그인</h1>
            <p>ID와 PW를 입력하시오.</p>
            <form method="post" action="<%=request.getContextPath()%>/loginFormAction.jsp">
                <table>
                    <tr>
                        <th>아이디</th>
                        <th><input type="text" name="memberId"></th>
                    </tr>
                    <tr>
                        <th>비밀번호</th>
                        <th><input type="password" name="memberPw"></th>
                    </tr>
                    <tr>
                        <th colspan="2"><button type="submit">로그인</button></th>
                        <a href="<%=request.getContextPath()%>/insertMemberForm.jsp">회원가입</a>
                    </tr>
         </table>
            </form>
        </div>
        <% if(msg != null) { %>
            <div><%=msg%></div>
        <% } %>
        
    </div>
	
</body>
</html>