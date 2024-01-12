<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.Properties" %>
<%@ page import="javax.mail.Session" %>
<%@ page import="javax.mail.Transport" %>
<%@ page import="javax.mail.internet.MimeMessage" %>
<%@ page import="javax.mail.internet.InternetAddress" %>

<%
    // 폼 데이터 받아오기
    String to = request.getParameter("to");
    String subject = request.getParameter("subject");
    String messageText = request.getParameter("message");

    // 발신자 이메일 주소 및 인증 정보
    String from = ""; // 네이버 이메일 주소
    String username = ""; // 네이버 아이디
    String password = ""; // 네이버 비밀번호

    // 네이버 SMTP 서버 설정
    String host = "smtp.naver.com";
    int port = 465;

    // 메일 속성 설정
    Properties properties = new Properties();
    properties.put("mail.smtp.host", host);
    properties.put("mail.smtp.port", port);
    properties.put("mail.smtp.auth", "true");
    properties.put("mail.smtp.starttls.enable", "true");

    // 세션 생성
    Session mySession = Session.getDefaultInstance(properties, new javax.mail.Authenticator() {
        protected javax.mail.PasswordAuthentication getPasswordAuthentication() {
            return new javax.mail.PasswordAuthentication(username, password);
        }
    });

    try {
        // 메시지 생성
        MimeMessage message = new MimeMessage(mySession);
        message.setFrom(new InternetAddress(from));
        message.setRecipient(MimeMessage.RecipientType.TO, new InternetAddress(to));
        message.setSubject(subject);
        message.setText(messageText);

        // 메일 전송
        Transport.send(message);
        response.getWriter().print("Mail sent successfully!");
    } catch (Exception e) {
        response.getWriter().print("Error sending mail: " + e.getMessage());
    }
%>
<html>
<head><title>메일전송완료</title></head>
<body>
메일을 전송하였습니다.
</body>
</html>