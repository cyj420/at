<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시물 상세보기</title>
</head>
<body>
	<h1>게시물 상세보기</h1>
	
	<!-- 본문 내용 시작 -->
	<c:forEach items="${articles}" var="article">
		<c:if test="${article.id == param.id}">
			<div>
				<div>번호 : ${article.id}</div>
				<div>제목 : ${article.title}</div>
				<div>생성날짜 : ${article.regDate}
				<c:if test="${article.regDate != article.updateDate }">
					(수정날짜 : ${article.regDate})
				</c:if>
				</div>
				<div>내용 : ${article.body}</div>
			</div>
		</c:if>
	</c:forEach>
	<!-- 본문 내용 끝 -->
	

	<div class="btns con">
		<a href="./list">게시물 리스트</a>
		<a href="./add">게시물 추가</a>
		<a href="./modify?id=${article.id}">게시물 수정</a>
		<a onclick="if ( confirm('삭제하시겠습니까?') == false ) return false;" href="./doDelete?id=${article.id}">게시물 삭제</a>
	</div>	
	
	<!-- 삭제 시작 -->
	<%-- <form action="/article/doDelete">
		<input type="number" name="id" value="${param.id }" hidden="hidden">
		<input type="submit" value="삭제">
	</form> --%>
	<!-- 삭제 끝 -->

	
	<!-- 이전글 / 다음글 / list -->
	<c:if test="${1 != param.id}">
		<div>
			<a href="./detail?id=${param.id-1 }">이전글</a>
		</div>
	</c:if>
	<c:if test="${articles[0].id != param.id}">
		<div>
			<a href="./detail?id=${param.id+1 }">다음글</a>
		</div>
	</c:if>
	<a href="./list">list로 돌아가기</a>
</body>
</html>