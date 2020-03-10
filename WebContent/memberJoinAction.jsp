<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="sec01.MemberDAO"%>
<%@ page import="java.io.PrintWriter"%>
<%@ page import="java.awt.Toolkit" %>
<%
	request.setCharacterEncoding("UTF-8");
%>
<jsp:useBean id="member" class="sec01.Member" scope="page" />
<jsp:setProperty name="member" property="userID" />
<jsp:setProperty name="member" property="userPassword" />
<jsp:setProperty name="member" property="userName" />
<jsp:setProperty name="member" property="userGender" />
<jsp:setProperty name="member" property="userEmail" />
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>코비를 추모하며</title>
</head>
<body>
	<%
		if (member.getUserID() == null || member.getUserPassword() == null || member.getUserName() == null
				|| member.getUserGender() == null || member.getUserEmail() == null) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('입력이 안된 사항이 있습니다.')");
			script.println("history.back()");
			script.println("</script>");

		} else {

			MemberDAO memberdao = MemberDAO.getInstance();
			Toolkit toolkit = Toolkit.getDefaultToolkit();

			int result = memberdao.memberJoin(member);
			if (result == -1) {
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('동일한 데이터가 존재합니다.')");
				toolkit.beep();
				script.println("history.back()");
				script.println("</script>");
			}

			else {
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('회원가입이 완료되었습니다.')");
				toolkit.beep();
				script.println("location.href='login.jsp'");
				script.println("</script>");
			}

		}
	%>
</body>
</html>