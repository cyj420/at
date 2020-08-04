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


				<div>
					<div>
					<a href="./modify?id=${article.id}">수정</a>
					/
					<a onclick="if ( confirm('삭제하시겠습니까?') == false ) return false;" href="./doDelete?id=${article.id}">삭제</a>
					</div>
				</div>	

				<!-- 이전글 / 다음글 -->
				<div style="margin-top: 20px; margin-bottom: 20px;">
					<c:if test="${articles[size-1].id != param.id}">
						<c:forEach var="i" begin="0" end="${articles.size()-1 }" step="1">
						<c:if test="${articles[i].id == param.id }">
							<div>
								<a href="./detail?id=${articles[i+1].id }">이전글</a>
							</div>
						</c:if>
						</c:forEach>
					</c:if>
					
					<c:if test="${articles[0].id != param.id}">
						<c:forEach var="i" begin="0" end="${articles.size()-1 }" step="1">
						<c:if test="${articles[i].id == param.id }">
							<div>
								<a href="./detail?id=${articles[i-1].id }">다음글</a>
							</div>
						</c:if>
						</c:forEach>
					</c:if>
				</div>
				<a href="./list?page=1">게시물 리스트로 돌아가기</a>
			</div>
		</c:if>
	</c:forEach>
</body>
</html>