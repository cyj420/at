<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시물 상세보기</title>
</head>
<style>
	/* 폰트 적용 */
@import url(//fonts.googleapis.com/earlyaccess/notosanskr.css);

html {
  font-family: "Noto Sans KR", sans-serif;
}

/* 노말라이즈 */
body,
ul,
li,
h1 {
  margin: 0;
  padding: 0;
  list-style: none;
}

/* 라이브러리 */
.con {
  margin: 0 auto;
}

/* 커스텀 */
.con {
  width: 1200px;
}
.reply-write > form {
  display: block;
  width: 100%;
}
.reply-write > form > table {
  width: 100%;
  border-collapse: collapse;
}
.reply-write > form > table th,
.reply-write > form > table td {
  border: 1px solid black;
  padding: 10px;
}
.reply-write > form > table textarea {
  width: 100%;
  display: block;
  box-sizing: border-box;
  height: 100px;
}
.list > table {
  width: 100%;
  border-collapse: collapse;
}
.list > table th,
.list > table td {
  border: 1px solid black;
  text-align: center;
  padding: 5px 0;
}
.list .reply-body-td {
  text-align: left;
  padding-left: 5px;
  padding-right: 5px;
}
.reply-list > table > tbody > tr[data-modify-mode="N"] .modify-mode-visible {
  display: none;
}
.reply-list > table > tbody > tr[data-modify-mode="Y"] .modify-mode-invisible {
  display: none;
}
.reply-list > table  > tbody  > tr  > .reply-body-td  > .modify-mode-visible  > form {
  width: 100%;
  display: block;
}
.reply-list  > table  > tbody  > tr  > .reply-body-td  > .modify-mode-visible  > form  > textarea {
  width: 100%;
  height: 100px;
  box-sizing: border-box;
  display: block;
}
/* 게시물 본문 내용 */
.article-detail-list
</style>
<script>

	function Article__writeReply(form) {
	  form.body.value = form.body.value.trim();

	  if (form.body.value.length == 0) {
	    form.body.focus();
	    alert("내용을 입력해주세요.");
	    return false;
	  }
	  var $form = $(form);

	  $form.find('input[type="submit"]').val("작성중...");
	  $form.find('input[type="submit"]').prop("disabled", true);
	  $form.find('input[type="reset"]').prop("disabled", true);
	}
	
	/* 
	function Article__deleteReply(el, id) {
	  if (confirm(id + "번 댓글을 삭제하시겠습니까?") == false) {
	    return;
	  }
	  var $tr = $(el).closest("tr");
	}
	 */

	function Article__modifyReply(form) {
	  form.body.value = form.body.value.trim();
	  if (form.body.value.length == 0) {
	    form.body.focus();
	    alert("내용을 입력해주세요.");
	    return;
	  }
	  var $tr = $(form).closest("tr");
	  $tr.attr("data-modify-mode", "N");

	  var newBody = form.body.value;
	  var id = form.id.value;

	  // 임시 테스트용
	  $tr
	    .find(">.reply-body-td>.modify-mode-invisible")
	    .empty()
	    .append(newBody);
	}


	function Article__turnOnModifyMode(el) {
	  var $tr = $(el).closest("tr");

	  var body = $tr
	    .find(">.reply-body-td>.modify-mode-invisible")
	    .html()
	    .trim();

	  $tr.find(">.reply-body-td>.modify-mode-visible>form>textarea").val(body);

	  $tr.attr("data-modify-mode", "Y");
	  $tr.siblings('[data-modify-mode="Y"]').attr("data-modify-mode", "N");
	}
	function Article__turnOffModifyMode(el) {
	  var $tr = $(el).closest("tr");
	  $tr.attr("data-modify-mode", "N");
	}
</script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<body>
	
	<!-- 본문 내용 시작 -->
	<c:forEach items="${articles}" var="article">
		<c:if test="${article.id == param.id}">
			<div class="table-box con">
				<h1 class="article-detail-list-title con">게시물 상세보기</h1>
				<div class="article-detail-list list con">
					<table>
						<colgroup>
							<col width="180">
							<col>
						</colgroup>
						<tbody>
							<tr>
								<th>번호</th>
								<td>${article.id}</td>
							</tr>
							<tr>
								<th>날짜</th>
								<td>${article.regDate}</td>
							</tr>
							<tr>
								<th>작성자id</th>
								<td>${article.memberId}</td>
							</tr>
							<tr>
								<th>제목</th>
								<td>${article.title}</td>
							</tr>
							<tr>
								<th>내용</th>
								<td>${article.body}</td>
							</tr>
							<tr>
								<th>비고</th>
								<td>
								<a href="./doDelete?id=${article.id}"
									onclick="if ( confirm('삭제하시겠습니까?') == false ) { return false; }">삭제</a>
				
									<a href="./modify?id=${article.id}">수정</a></td>
							</tr>
						</tbody>
					</table>
				</div>
			
				<!-- 댓글 -->
				<h1 class="reply-write-title con">댓글 작성</h1>
			    <div class="reply-write con">
			      <form action="./doWriteReply" method="POST" onsubmit="Article__writeReply(this);">
			      <input type="hidden" name="articleId" value="${article.id}" />
			        <table>
			          <colgroup>
			            <col width="100" />
			          </colgroup>
			          <tbody>
			            <tr>
			              <th>내용</th>
			              <td>
			                <div>
			                  <textarea placeholder="댓글을 작성해주세요." name="body" maxlength="300"></textarea>
			                </div>
			              </td>
			            </tr>
			            <tr>
			              <th>작성</th>
			              <td>
			                <input type="submit" value="작성" />
			                <input type="reset" value="취소" />
			              </td>
			            </tr>
			          </tbody>
			        </table>
			      </form>
			    </div>
			    <h1 class="reply-list-title con">댓글 목록</h1>
			    <div class="reply-list list con">
			      <table>
			        <colgroup>
			          <col width="50" />
			          <col width="150" />
			          <col width="100" />
			          <col />
			          <col width="100" />
			        </colgroup>
			        <thead>
			          <tr>
			            <th>번호</th>
			            <th>날짜</th>
			            <th>글쓴이</th>
			            <th>내용</th>
			            <th>비고</th>
			          </tr>
			        </thead>
			        <tbody>
			        
				
					<c:forEach items="${articleReplies}" var="ar">
			          <tr data-modify-mode="N">
			            <td>${ar.id }</td>
			            <td>${ar.regDate }</td>
			            <td>${ar.memberId }</td>
			            <td class="reply-body-td">
			              <div class="modify-mode-invisible">${ar.body }</div>
			              <div class="modify-mode-visible">
			                <form action="./doArticleReplyModify" onsubmit="Article__modifyReply(this);">
			                  <input type="hidden" name="id" value="${ar.id }" />
			                  <input type="hidden" name="articleId" value="${ar.articleId }" />
			                  <textarea maxlength="300" name="body"></textarea>
			                  <input type="submit" value="수정완료" />
			                </form>
			              </div>
			            </td>
			            <td>
			              <a href="./doArticleReplyDelete?articleId=${ar.articleId }&id=${ar.id }" onclick="if ( confirm('삭제하시겠습니까?') == false ) return false;"
			              <%-- <a href="./doArticleReplyDelete?articleId=${ar.articleId }&id=${ar.id }" onclick="Article__deleteReply(this, ${ar.id});" --%>
			                >삭제</a
			              >
			              <a
			                class="modify-mode-invisible"
			                href="javascript:;"
			                onclick="Article__turnOnModifyMode(this);"
			                >수정</a
			              >
			              <a
			                class="modify-mode-visible"
			                href="javascript:;"
			                onclick="Article__turnOffModifyMode(this);"
			                >수정취소</a
			              >
			            </td>
			          </tr>
					</c:forEach>
			        </tbody>
			      </table>
			    </div>
				
				<!-- 이전글 / 다음글 -->
				<div class="another-article">
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
				</div>
				<a href="./list?searchKeyword=&page=1">게시물 리스트로 돌아가기</a>
			</div>
		</c:if>
	</c:forEach>
</body>
</html>