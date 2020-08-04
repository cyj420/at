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
	<c:forEach var="i" begin="${(page-1)*5 }" end="${page*5-1}" step="1">
		<c:if test="${articles[size-i-1].id != null}">
		<div>
		${articles[i].id} / ${articles[i].regDate} / <a href="./detail?id=${articles[i].id}">${articles[i].title}</a>
		</div>
		</c:if>
	</c:forEach>
	<div>
	</div>
	
	<a href="./add">글쓰기</a>
	
	<!-- 페이징 -->
	<div>
		<c:forEach var="i" begin="1" end="${fullPage}" step="1">
			<span>
				<a href="?searchKeyword=${param.searchKeyword}&page=${i}">[${i }]</a>
			</span>
		</c:forEach>
	</div>
</body>
</html>