<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.Properties" %>
<%@ page import="java.util.Date" %>
<%@ page import="javax.mail.*" %>
<%@ page import="javax.activation.MailcapCommandMap" %>
<%@ page import="javax.activation.CommandMap" %>
<%@ page import="javax.mail.internet.*" %>

<%
    // 메일 인코딩
    final String bodyEncoding = "UTF-8"; //콘텐츠 인코딩
    //request 인코딩 방식 설정
    request.setCharacterEncoding("UTF-8");
    String subject = request.getParameter("subject");
    String fromEmail = "이메일";
    String fromUsername = "SYSTEM MANAGER";
    String toEmail = request.getParameter("to"); // 콤마(,)로 여러개 나열
    String context = request.getParameter("message");   //내용
    final String username = "이메일";
    final String password = "2차인증 비밀번호";

    // 메일에 출력할 텍스트
    StringBuffer sb = new StringBuffer();
    sb.append(context);
    String html = sb.toString();

    // 메일 옵션 설정
    Properties props = new Properties();
    props.put("mail.transport.protocol", "smtp");
    props.put("mail.smtp.host", "smtp.gmail.com");
    props.put("mail.smtp.port", "465");
    props.put("mail.smtp.auth", "true");

    props.put("mail.smtp.quitwait", "false");
    props.put("mail.smtp.socketFactory.port", "465");
    props.put("mail.smtp.socketFactory.class", "javax.net.ssl.SSLSocketFactory");
    props.put("mail.smtp.socketFactory.fallback", "false");

    try {
        // 메일 서버  인증 계정 설정
        Authenticator auth = new Authenticator() {
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(username, password);
            }
        };

        // 메일 세션 생성
        Session testSession = Session.getInstance(props, auth);

        // 메일 송/수신 옵션 설정
        Message message = new MimeMessage(testSession);
        message.setFrom(new InternetAddress(fromEmail, fromUsername));
        message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(toEmail, false));
        message.setSubject(subject);
        message.setSentDate(new Date());

        // 메일 콘텐츠 설정
        Multipart mParts = new MimeMultipart();
        MimeBodyPart mTextPart = new MimeBodyPart();
        MimeBodyPart mFilePart = null;

        // 메일 콘텐츠 - 내용
        mTextPart.setText(html, bodyEncoding, "html");
        mParts.addBodyPart(mTextPart);

        // 메일 콘텐츠 설정
        message.setContent(mParts);

        // MIME 타입 설정
        MailcapCommandMap MailcapCmdMap = (MailcapCommandMap) CommandMap.getDefaultCommandMap();
        MailcapCmdMap.addMailcap("text/html;; x-java-content-handler=com.sun.mail.handlers.text_html");
        MailcapCmdMap.addMailcap("text/xml;; x-java-content-handler=com.sun.mail.handlers.text_xml");
        MailcapCmdMap.addMailcap("text/plain;; x-java-content-handler=com.sun.mail.handlers.text_plain");
        MailcapCmdMap.addMailcap("multipart/*;; x-java-content-handler=com.sun.mail.handlers.multipart_mixed");
        MailcapCmdMap.addMailcap("message/rfc822;; x-java-content-handler=com.sun.mail.handlers.message_rfc822");
        CommandMap.setDefaultCommandMap(MailcapCmdMap);

        // 메일 발송
        Transport.send( message );

    } catch ( Exception e ) {
        e.printStackTrace();
    }
%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>

</head>
<body>
<h1>메일 전송 성공!</h1>
</body>
</html>
