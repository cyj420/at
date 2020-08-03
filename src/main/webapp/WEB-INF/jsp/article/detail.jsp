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


				<div class="btns con">
					<a href="./list">게시물 리스트</a>
					<a href="./modify?id=${article.id}">게시물 수정</a>
					<a onclick="if ( confirm('삭제하시겠습니까?') == false ) return false;" href="./doDelete?id=${article.id}">게시물 삭제</a>
				</div>	

				<!-- 이전글 / 다음글 -->
				<c:if test="${1 != param.id}">
					<div>
						<a href="./detail?id=${article.id-1 }">이전글</a>
					</div>
				</c:if>
				<c:if test="${articles[0].id != param.id}">
					<div>
						<a href="./detail?id=${article.id+1 }">다음글</a>
					</div>
				</c:if>
			</div>
		</c:if>
	</c:forEach>
</body>
</html>