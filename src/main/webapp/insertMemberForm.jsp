<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>


 <div class="container text-center">
<h1> 지금 회원 가입 하신 후
<br> 다양한 서비스를 만나보세요!</h1>


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Form Selection</title>
</head>
<body>
  <div class="radio">
    <label><input type="radio" name="optradio" id="option1">고객 가입</label>
  </div>
  <div class="radio">
    <label><input type="radio" name="optradio" id="option2">관리자 가입</label>
  </div>

  <form id="form1" action="insertCustomerForm.jsp" method="post" style="display: none;">
    <!-- Form 1 fields and controls -->
    <button type="submit" class="btn btn-primary">다음</button>
  </form>

  <form id="form2" action="insertManagerForm.jsp" method="post" style="display: none;">
    <!-- Form 2 fields and controls -->
    <button type="submit" class="btn btn-danger">다음</button>
  </form>

  <script>
    let option1 = document.getElementById("option1");
    let option2 = document.getElementById("option2");
    let form1 = document.getElementById("form1");
    let form2 = document.getElementById("form2");

    option1.addEventListener("click", () => {
      form1.style.display = "block";
      form2.style.display = "none";
    });

    option2.addEventListener("click", () => {
      form1.style.display = "none";
      form2.style.display = "block";
    });
  </script>
</body>
</html>

</div>
</body>
</html>