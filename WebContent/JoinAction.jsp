<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="sec01.UserDAO"%>
<%@ page import="java.io.PrintWriter"%>
<%
	request.setCharacterEncoding("UTF-8");
%>
<jsp:useBean id="player" class="sec01.Player" scope="page" />
<jsp:setProperty name="player" property="name" />
<jsp:setProperty name="player" property="num" />
<jsp:setProperty name="player" property="age" />
<jsp:setProperty name="player" property="avg" />
<jsp:setProperty name="player" property="pos" />
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>코비를 추모하며</title>
</head>
<body>
	<%
		if (player.getName() == null || player.getNum() == null || player.getAge() == null
				|| player.getPos() == null || player.getAvg() == null) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('입력이 안된 사항이 있습니다.')");
			script.println("history.back()");
			script.println("</script>");

		} else {

			UserDAO userDAO = UserDAO.getInstance();

			int result = userDAO.playerJoin(player);
			if (result == -1) {
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('동일한 데이터가 존재합니다.')");
				script.println("history.back()");
				script.println("</script>");
			}

			else {
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('선수등록이 완료되었습니다.')");
				script.println("location.href='join.jsp'");
				script.println("</script>");
			}

		}
	%>
</body>
</html>