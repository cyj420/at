<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시물 리스트</title>
</head>
<body>
	<h1>게시물 리스트</h1>
	
	<c:forEach items="${articles}" var="article">
	<div>
		${article.id} / ${article.regDate} / <a href="./detail?id=${article.id}">${article.title}</a>
	</div>
	</c:forEach>
</body>
</html>