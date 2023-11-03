<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>회원 가입 선택</title>
    <style>
        body {
            background-color: #f8f9fa;
            text-align: center;
            padding: 20px;
        }

        .container {
            background-color: #ffffff;
            border-radius: 10px;
            padding: 20px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            max-width: 500px;
            margin: 0 auto;
        }

        .radio {
            margin: 10px 0;
        }

        .form {
            display: none;
        }

        .form .btn {
            margin-top: 10px;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>회원 가입 선택</h1>

        <div class="radio">
            <label>
                <input type="radio" name="optradio" id="option1">고객 가입
            </label>
        </div>
        <div class="radio">
            <label>
                <input type="radio" name="optradio" id="option2">관리자 가입
            </label>
        </div>

        <form id="form1" class="form" action="insertCustomerForm.jsp" method="post">
            <!-- Form 1 fields and controls -->
            <button type="submit" class="btn btn-primary btn-block">다음</button>
        </form>

        <form id="form2" class="form" action="insertManagerForm.jsp" method="post">
            <!-- Form 2 fields and controls -->
            <button type="submit" class="btn btn-danger btn-block">다음</button>
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
    </div>
</body>
</html>
