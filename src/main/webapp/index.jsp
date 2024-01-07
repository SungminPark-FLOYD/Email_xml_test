<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" type="text/css" href="css/styles.css">
    <title>FLOYD</title>
</head>
<body>
<header>
    <h1>FLOYD</h1>
    <nav>
        <ul>
            <li><a href="#">Home</a></li>
            <li><a href="#">Mail</a></li>
            <!-- 다른 메뉴 추가 가능 -->
        </ul>
    </nav>
</header>

<section id="main-content">
    <!-- 메일 보내기 폼 등의 내용을 추가 -->
    <form action="email/send-mail.jsp" method="post">
        <label for="to">수신자 이메일:</label>
        <input type="email" name="to" id="to" required>
        <br>
        <label for="subject">이메일 제목:</label>
        <input type="text" name="subject" id="subject" required>
        <br>
        <label for="message">이메일 내용:</label>
        <textarea name="message" id="message" cols="30" rows="5" required></textarea>
        <br>
        <button type="submit">Send Mail</button>
    </form>
</section>

<footer>
    <!-- 페이지 푸터 내용 추가 -->
</footer>
</body>
</html>
