<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter"%>
<%@ page import="sec01.UserDAO" %>
<%@ page import="java.awt.Toolkit" %>
<%@ page import="sec01.Player" %>
<%@ page import="java.util.ArrayList" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width" , initial-scale="1">
<link rel="stylesheet" href="css/bootstrap.min.css">
<title>코비를 추모하며</title>
</head>
<body>
	<%
		String userID = null;
	if (session.getAttribute("userID") != null) {
		userID = (String) session.getAttribute("userID");
	}
	
	int pageNumber = 1;
	
	if(request.getParameter("pageNumber") != null) {
		pageNumber = Integer.parseInt(request.getParameter("pageNumber"));
	}
	%>
	<nav class="navbar navbar-default">
		<div class="navbar-header">
			<button type="button" class="navbar-toggle collapsed"
				data-toggle="collapse" data-target="#bs-example-navbar-collapse-1"
				aria-expanded="false">
				<span class="icon-bar"></span> <span class="icon-bar"></span> <span
					class="icon-bar"></span>
			</button>
			<a class="navbar-brand" href="main.jsp">NBA player 웹사이트</a>
		</div>
		<div class="collapse navbar-collapse"
			id="bs-example-navbar-collapse-1">
			<ul class="nav navbar-nav">
				<li><a href="main.jsp">메인</a></li>
				<li class="active"><a href="bbs.jsp">게시판</a></li>
			</ul>
			<%
			if(userID == null) {
		%>
			<ul class="nav navbar-nav navbar-right">
				<li class="dropdown"><a href="#" class="dropdown-toggle"
					data-toggle="dropdown" role="button" aria-haspopup="ture"
					aria-expanded="false">접속하기<span class="caret"></span></a>
					<ul class="dropdown-menu">
						<li><a href="login.jsp">로그인</a>
					</ul></li>
			</ul>

			<%
			} else {
		%>
			<ul class="nav navbar-nav navbar-right">
				<li class="dropdown"><a href="#" class="dropdown-toggle"
					data-toggle="dropdown" role="button" aria-haspopup="ture"
					aria-expanded="false">MENU<span class="caret"></span></a>
					<ul class="dropdown-menu">
						<li><a href="join.jsp">선수등록</a></li>
						<li><a href="logoutAction.jsp">로그아웃</a>
					</ul></li>
			</ul>
			<% 
			}
		%>
		</div>
	</nav>

	<div class="container">
		<div class="raw">
			<table class="table table-striped"
				style="text-align: center; border: 1px solid #dddddd">
				<thead>
					<tr>
						<th style="backgroudn-color: #eeeeee; text-align: center;">등번호</th>
						<th style="backgroudn-color: #eeeeee; text-align: center;">이름</th>
						<th style="backgroudn-color: #eeeeee; text-align: center;">나이</th>
						<th style="backgroudn-color: #eeeeee; text-align: center;">포지션</th>
						<th style="backgroudn-color: #eeeeee; text-align: center;">평균득점</th>

					</tr>
				</thead>
				<tbody>
					<%
						UserDAO userdao = UserDAO.getInstance();
						ArrayList<Player> list = userdao.getList(pageNumber);
						for(int i=0; i<list.size(); i++) {
					%>
					<tr>
						<td><%= list.get(i).getNum() %></td>
						<td><%= list.get(i).getName() %></td>
						<td><%= list.get(i).getAge() %></td>
						<td><%= list.get(i).getPos() %></td>
						<td><%= list.get(i).getAvg() %></td>
					</tr>
					<%
						}
					%>
					
				</tbody>
			</table>
			<%
				if(pageNumber != 1) {
			%>
			<a href = "bbs.jsp?pageNumber=<%=pageNumber - 1 %>" class="btn btn-success btn-arraw-left">이전</a>
			
			<% 
				} if(userdao.nextPage(pageNumber + 1)) {
			
			%>
				<a href = "bbs.jsp?pageNumber=<%=pageNumber+1 %>" class="btn btn-success btn-arraw-left">다음</a>
			<%
				}
			%>
			<%
				if (session.getAttribute("userID") != null) {
					userID = (String) session.getAttribute("userID");
			%>
			<a href="join.jsp" class="btn btn-primary pull-right">선수등록</a>
			<%
				} else {
			%>

			<a href="bbs.jsp" class="btn btn-primary pull-right">선수등록</a>

			<%
			Toolkit toolkit = Toolkit.getDefaultToolkit();
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('로그인이 필요합니다.')");
			toolkit.beep();
			script.println("location.href='login.jsp'");
			script.println("</script>");
			}
			%>
		</div>
	</div>
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="js/bootstrap.js"></script>
</body>
</html>