<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="pageTitle" value="게시물 리스트" />
<%@ include file="../part/head.jspf"%>
<style>
a {
	color: inherit;
	text-decoration: none;
}

a:hover {
	color: red;
}
</style>
<c:if test="${param.searchKeyword.length() != 0 }">
	<h2>${param.searchKeyword }에대한 검색 결과</h2>
</c:if>

<c:if test="${articles.size() != 0 }">
	<c:forEach var="i" begin="${(page-1)*5 }" end="${page*5-1}" step="1">
		<c:if test="${articles[size-i-1].id != null}">
			<div>
				${articles[i].id} / ${articles[i].regDate} / <a
					href="./detail?id=${articles[i].id}">${articles[i].title}</a>
			</div>
		</c:if>
	</c:forEach>
	<!-- 페이징 -->
	<div>
		<c:forEach var="i" begin="1" end="${fullPage}" step="1">
			<c:if test="${param.page == i }">
				<span> <a
					href="?searchKeyword=${param.searchKeyword}&page=${i}"
					style="color: red; font-weight: bold;">[${i }]</a>
				</span>
			</c:if>
			<c:if test="${param.page != i }">
				<span> <a
					href="?searchKeyword=${param.searchKeyword}&page=${i}">[${i }]</a>
				</span>
			</c:if>
		</c:forEach>
	</div>
	<!-- 페이징 끝 -->
</c:if>

<c:if test="${articles.size() == 0 }">
	<div>검색 결과가 없습니다.</div>
</c:if>

<c:if
	test="${param.searchKeyword.length() != 0 || articles.size() == 0 }">
	<div>
		<a href="/article/list?searchKeyword=&page=1">처음으로 돌아가기</a>
	</div>
</c:if>

<a href="./write" class="write-article">글쓰기</a>
<!-- 검색 시작 -->
<div style="margin-top: 30px;">
	<form action="/article/list">
		<input type="text" name="searchKeyword" value="${param.searchKeyword}" />
		<input type="hidden" name="page" value="1" />
		<button type="submit">검색</button>
	</form>

</div>
<!-- 검색 끝 -->
<%@ include file="../part/foot.jspf"%>