<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="sec01.UserDAO" %>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="java.awt.Toolkit" %>
<% request.setCharacterEncoding("UTF-8"); %>
<jsp:useBean id="user" class="sec01.User" scope="page"/>
<jsp:setProperty name="user" property="userID"/>
<jsp:setProperty name="user" property="userPassword"/>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content = "text/html; charset=UTF-8">
<title>코비를 추모하며</title>
</head>
<body>
	<%
	Toolkit toolkit = Toolkit.getDefaultToolkit();
	
	session.invalidate();
	PrintWriter script = response.getWriter();
	script.println("<script>");
	script.println("alert('로그아웃 되었습니다.')");
	toolkit.beep();
	script.println("</script>");
		
	%>
	<script>
	location.href = 'main.jsp';
	</script>
</body>
</html>