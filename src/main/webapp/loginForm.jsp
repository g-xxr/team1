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
        display: flex; /* 테이블이 세로가 아닌 가로로 정렬*/
    }
    .container2 {
    /* Push the container2 to the bottom */
        text-align: center;

    }
    .form-container {
        background-color: #007BFF;
        color: white;
        padding: 20px;
        border-radius: 10px;
        margin: 20px; /* 테이블 간의 간격을 주는 역할*/
    }
        .form-container2 {
        background-color: #BDBDBD;
        color: black;
        padding: 20px;
        border-radius: 10px;
        margin: 20px; /* 테이블 간의 간격을 주는 역할*/
    }
    
    
</style>
</head>
<body>
	
	<!-- 로그인 폼 만들기 (로그인 시 고객에게 보여지는 홈페이지 (productList)
		 매니저는 바로 (managerHome : 여기에서는 상품 관리(상품 추가, 수정, 삭제), 공지사항, 문의(답변) 게시판으로 바로 갈 수 있는 폼 만들기)
	-->
 <div class="container">
        <div class="form-container">
            <h1>고객 <br> 로그인</h1>
            <p>ID와 PW를 입력하시오.</p>
            <form method="post" action="<%=request.getContextPath()%>/customerLoginAction.jsp">
                <table>
                    <tr>
                        <th>아이디</th>
                        <th><input type="text" name="customerId"></th>
                    </tr>
                    <tr>
                        <th>비밀번호</th>
                        <th><input type="password" name="customerPw"></th>
                    </tr>
                    <tr>
                        <th colspan="2"><button type="submit">로그인</button></th>
                    </tr>
         </table>
            </form>
      </div>
 </div>

 <div class="container">
        <div class="form-container">
            <h1>관리자 로그인<br>(Admin)</h1>
            <p>ID와 PW를 입력하시오.</p>
            <form method="post" action="<%=request.getContextPath()%>/managerLoginAction.jsp">
                <table>
                    <tr>
                        <th>아이디</th>
                        <th><input type="text" name="managerId"></th>
                    </tr>
                    <tr>
                        <th>비밀번호</th>
                        <th><input type="password" name="managerPw"></th>
                    </tr>
                    <tr>
                        <th colspan="2"><button type="submit">로그인</button></th>
                    </tr>
	           </table>
            </form>
      </div>
 </div>
 <div class="container2">
     	<div class="form-container2">
            <h1>회원가입</h1>
           		 <p>회원가입 정보가 없으면 <br> 지금 가입하세요!</p>
            <a href="<%=request.getContextPath()%>/insertMemberForm.jsp">->가입하기<-</a>
    	</div>
</div>

        
        <% if(msg != null) { %>
            <div><%=msg%></div>
        <% } %>
        
 
	
</body>
</html>