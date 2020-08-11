<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="pageTitle" value="게시물 상세보기" />
<%@ include file="../part/head.jspf"%>
<style>
/* 폰트 적용 */
@import url(//fonts.googleapis.com/earlyaccess/notosanskr.css);

html {
	font-family: "Noto Sans KR", sans-serif;
}

/* 노말라이즈 */
body, ul, li, h1 {
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

.reply-write>form {
	display: block;
	width: 100%;
}

.reply-write>form>table {
	width: 100%;
	border-collapse: collapse;
}

.reply-write>form>table th, .reply-write>form>table td {
	border: 1px solid black;
	padding: 10px;
}

.reply-write>form>table textarea {
	width: 100%;
	display: block;
	box-sizing: border-box;
	height: 100px;
}

.list>table {
	width: 100%;
	border-collapse: collapse;
}

.list>table th, .list>table td {
	border: 1px solid black;
	text-align: center;
	padding: 5px 0;
}

.list .reply-body-td {
	text-align: left;
	padding-left: 5px;
	padding-right: 5px;
}

.reply-list>table>tbody>tr[data-modify-mode="N"] .modify-mode-visible {
	display: none;
}

.reply-list>table>tbody>tr[data-modify-mode="Y"] .modify-mode-invisible
	{
	display: none;
}

.reply-list>table>tbody>tr>.reply-body-td>.modify-mode-visible>form {
	width: 100%;
	display: block;
}

.reply-list>table>tbody>tr>.reply-body-td>.modify-mode-visible>form>textarea
	{
	width: 100%;
	height: 100px;
	box-sizing: border-box;
	display: block;
}
</style>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>

<!-- 본문 내용 시작 -->
<c:forEach items="${articles}" var="article">
	<c:if test="${article.id == param.id}">
		<div class="table-box con">
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
							<th>작성자</th>
							<td>${article.extra.writer}</td>
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
							<td><a href="./doDelete?id=${article.id}"
								onclick="if ( confirm('삭제하시겠습니까?') == false ) { return false; }">삭제</a>

								<a href="./modify?id=${article.id}">수정</a></td>
						</tr>
					</tbody>
				</table>
			</div>

			
			
			<!-- 댓글 -->
			<c:if test="${isLogined}">
				<h2 class="reply-write-title con">댓글 작성</h2>
				<div class="reply-write con">

					<script>
					    function ArticleReply__submitWriteForm(form){
						    form.body.value = form.body.value.trim();
						    if(form.body.value.length == 0){
							    alert('내용을 입력하세요.');
							    form.body.focus();
							    return;
							}
							$.post('./doWriteReplyAjax', {
								articleId : param.id,
								body : form.body.value
							}, function(data){
								alert(data.msg);
							}, 'json');
		
							form.body.value = '';
						}
				    </script>

					<form action=""
						onsubmit="ArticleReply__submitWriteForm(this); return false;">
						<table>
							<colgroup>
								<col width="100" />
							</colgroup>
							<tbody>
								<tr>
									<th>내용</th>
									<td>
										<div>
											<textarea placeholder="댓글을 작성해주세요." name="body"
												maxlength="300"></textarea>
										</div>
									</td>
								</tr>

								<tr>
									<th>작성</th>
									<td><input type="submit" value="작성" /> <input
										type="reset" value="취소" /></td>
								</tr>
							</tbody>
						</table>
					</form>
				</div>
			</c:if>



			<h1 class="reply-list-title con">댓글 목록</h1>

			<%-- 
			<script>
		    	var ArticleReply__lastLoadedArticleReplyId = 0;
			    function ArticleReply__loadList(){
					$.get(
						'./getForPrintArticleRepliesRs',
						{
							id : ${param.id},
							from : ArticleReply__lastLoadedArticleReplyId + 1
						},
						function(data){
							for(var i = 0; i<data.articleReplies.length; i++){
								var articleReply = data.articleReplies[i];
								ArticleReply__drawReply(articleReply);

								ArticleReply__lastLoadedArticleReplyId = articleReply.id;
							}
						},
						'json'
					);
				}

				var ArticleReply__$listTbody;
				
				function ArticleReply__drawReply(articleReply){
					var html = '';

					html = '<tr data-id="'+articleReply.id+'" data-modify-mode="N">';
					html += '<td>' + articleReply.id + '</td>';
					html += '<td>' + articleReply.regDate + '</td>';
					html += '<td>' + articleReply.extra__writer + '</td>';
					html += '<td class="reply-body-td">';
					html += '<div class="modify-mode-invisible">' + articleReply.body + '</div>';
					html += '<div class="modify-mode-visible">';
					html += '<form action="" onclick="Article__modifyReply(this); return false;">';
					html += '<input type="hidden" name="id" value="' + articleReply.id + '" />';
					html += '<input type="hidden" name="articleId" value="' + articleReply.articleId + '" />'; 
					html += '<textarea maxlength="300" name="body"></textarea>';
					/* html += '<button onclick="Article__modifyReply(this);">수정완료</button>'; */
					html += '<input type="submit" value="수정완료" />';
					html += '</form>';
					html += '</div>';
					html += '</td>';
					html += '<td>';
					html += '<button onclick="ArticleReplyList__delete(this,'+ articleReply.id+');">삭제</button>';
					html += '<button onclick="Article__turnOnModifyMode(this);" class="modify-mode-invisible" href="javascript:;">수정</button>';
					html += '<button onclick="Article__turnOffModifyMode(this);" class="modify-mode-visible" href="javascript:;">취소</button>';
					/* 
					html += '<a class="modify-mode-invisible" href="javascript:;" onclick="Article__turnOnModifyMode(this);">수정</a>';
					html += '<a class="modify-mode-visible" href="javascript:;" onclick="Article__turnOffModifyMode(this);">수정취소</a>'; 
					*/
					html += '</td>';
					html += '</tr>';
					
					
					ArticleReply__$listTbody.prepend(html);
				}
				
				<!-- html이 다 완성된 상태에서 부르기 위한 방법  -->
				$(function(){
					ArticleReply__$listTbody = $('.reply-list > table tbody');
					ArticleReply__loadList();
					setInterval(ArticleReply__loadList, 1000);
				});

		    </script>

			
			<div class="reply-list list con">
				<table>
					<colgroup>
						<col width="50" />
						<col width="180" />
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
					</tbody>

				</table>
			</div>
			 --%>
			
			
			<script>
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
			
			<!-- 여기부터 댓글 리스트-->
			<div class="reply-list list table-box con">
				<table>
					<colgroup>
						<col width="80">
						<col width="180">
						<col width="180">
						<col>
						<col width="200">
					</colgroup>
					<thead>
						<tr>
							<th>번호</th>
							<th>날짜</th>
							<th>작성자</th>
							<th>내용</th>
							<th>비고</th>
						</tr>
					</thead>
					<tbody>
			
					</tbody>
				</table>
			</div>
			
			<script>
				var ArticleReplyList__$box = $('.reply-list');
				var ArticleReplyList__$tbody = ArticleReplyList__$box.find('tbody');
				var ArticleReplyList__lastLodedId = 0;

				var ArticleReplyList__submitModifyFormDone = false;

				function ArticleReplyList__submitModifyForm(form) {
				  /* if (ArticleReplyList__submitModifyFormDone) {
					alert('처리중입니다.');
					return;
				  } */
				  
				  form.body.value = form.body.value.trim();
				  if (form.body.value.length == 0) {
				    alert("내용을 입력해주세요.");
				    form.body.focus();
				    return;
				  }

				  var id = form.id.value;
				  var newBody = form.body.value;

				  /* ArticleReplyList__submitModifyFormDone = true; */

				  /* 
				  var $tr = $(form).closest("tr");
	  			  $tr.attr("data-modify-mode", "N");
	  			   */
				  
				  $.post('./doModifyReplyAjax',{
					  id : id,
					  articleId : param.id,
					  body : newBody
				  }, function(data){
					  if(data.resultCode && data.resultCode.substr(0,2)=='S-'){
						  var $tr = $('.reply-list tbody > tr[data-id="'+id+'"] .article-reply-body');
						  $tr.empty().append(body);
					  }
				  }, 'json');
				}
				
				function ArticleReplyList__showModifyFormModal(el){
					$('html').addClass('article-reply-modify-form-modal-actived');
					var $tr = $(el).closest('tr');
					var originBody = $tr.data('data-originBody');

					var id = $tr.attr('data-id');

					var form = $('.article-reply-modify-form-modal form').get(0);

					form.id.value = id;
					form.body.value = originBody;
				}
				
				function ArticleReplyList__hideModifyFormModal(){
					$('html').removeClass('article-reply-modify-form-modal-actived');
				}

				function ArticleReplyList__loadMoreCallback(data){
					if ( data.body.articleReplies && data.body.articleReplies.length > 0 ) {
						ArticleReplyList__lastLodedId = data.body.articleReplies[data.body.articleReplies.length - 1].id;
						ArticleReplyList__drawReplies(data.body.articleReplies);
					}
					setTimeout(ArticleReplyList__loadMore, 2000);
				}
				
				function ArticleReplyList__loadMore() {
					$.get('getForPrintArticleReplies', {
						articleId : param.id,
						from : ArticleReplyList__lastLodedId + 1
					}, ArticleReplyList__loadMoreCallback, 'json');
				}


				/* 
				function ArticleReplyList__delete(el, id) {
				  if (confirm(id + "번 댓글을 삭제하시겠습니까?") == false) {
				    return;
				  }
				  var $tr = $(el).closest("tr");
					$.post('./doDeleteReplyAjax', {
						id:id
					},
					function(){
						$tr.remove();
					}, 'json');
				}
				*/
				
				function ArticleReplyList__delete(el) {
					if (confirm("해당 댓글을 삭제하시겠습니까?") == false) {
				    	return;
					}
					var $tr = $(el).closest('tr');
					var id = $tr.attr('data-id');	//왜 이걸로는 찾을 수 없었던 걸까... > data-id="" 이런 형태여야 하는데 '='을 안 붙였음.
					
					$.post('./doDeleteReplyAjax',{
						id : id
					}, function(data){
						$tr.remove();
					}, 'json');
				} 
				
				
				function ArticleReplyList__drawReplies(articleReplies) {
					for ( var i = 0; i < articleReplies.length; i++ ) {
						var articleReply = articleReplies[i];
						ArticleReplyList__drawReply(articleReply);
					}
				}
				
				function ArticleReplyList__drawReply(articleReply) {
					var html = '';

					// ajax로 하고 싶어서 이걸로 하는 중...
					html = '<tr data-id="'+articleReply.id+'" data-modify-mode="N">';
					html += '<td>' + articleReply.id + '</td>';
					html += '<td>' + articleReply.regDate + '</td>';
					html += '<td>' + articleReply.extra.writer + '</td>';
					html += '<td class="reply-body-td">';
					html += '<div class="modify-mode-invisible">' + articleReply.body + '</div>';
					html += '<div class="modify-mode-visible">';

					html += '<form action="" onclick="ArticleReplyList__submitModifyForm(this); return false;">';
					html += '<input type="hidden" name="id" value="' + articleReply.id + '" />';
					html += '<input type="hidden" name="articleId" value="' + articleReply.articleId + '" />';
					html += '<textarea maxlength="300" name="body"></textarea>';
					html += '<button type="submit">수정완료</button>';
					/* 
					html += '<input type="submit" value="수정완료" />';
					 */
					html += '</form>';
					
					html += '</div>';
					html += '</td>';
					html += '<td>';
					if (articleReply.extra.actorCanDelete) {
					html += '<button onclick="ArticleReplyList__delete(this,'+ articleReply.id+');">삭제</button>';
						html += '<button onclick="Article__turnOnModifyMode(this);" class="modify-mode-invisible" href="javascript:;">수정</button>';
						html += '<button onclick="Article__turnOffModifyMode(this);" class="modify-mode-visible" href="javascript:;">취소</button>';
					}
					/* 
					html += '<a class="modify-mode-invisible" href="javascript:;" onclick="Article__turnOnModifyMode(this);">수정</a>';
					html += '<a class="modify-mode-visible" href="javascript:;" onclick="Article__turnOffModifyMode(this);">수정취소</a>'; 
					*/
					html += '</td>';
					html += '</tr>';

					
					/* 아래 코드로 할 경우 modal로 해야할 듯. 동영상 존재. 
					html += '<tr data-id="'+articleReply.id+'" data-modify-mode="N">';
					html += '<td>' + articleReply.id + '</td>';
					html += '<td>' + articleReply.regDate + '</td>';
					html += '<td>' + articleReply.extra.writer + '</td>';

					html += '<td class="reply-body-td">';
					html += '<div class="modify-mode-invisible article-reply-body">' + articleReply.body + '</div>';
					html += '<div class="modify-mode-visible">';
					html += '<form action="" onclick="Article__modifyReply(this); return false;">';
					html += '<input type="hidden" name="id" value="' + articleReply.id + '" />';
					html += '<input type="hidden" name="articleId" value="' + articleReply.articleId + '" />'; 
					html += '<textarea maxlength="300" name="body"></textarea>';
					html += '<button onclick="Article__modifyReply(this);">수정완료</button>';
					html += '<input type="submit" value="수정완료" />';
					html += '</form>';
					html += '</div>';
					html += '</td>';
					html += '<td>';
					if (articleReply.extra.actorCanDelete) {
						html += '<button type="button" onclick="ArticleReplyList__delete(this);">삭제</button>';
						html += '<button class="article-reply-modify-form-modal" type="button" onclick="ArticleReplyList__showModifyFormModal(this);">수정</button>';
					}
					html += '</td>';
					html += '</tr>';
					*/
					
					var $tr = $(html);
					$tr.data('data-originBody', articleReply.body);
					ArticleReplyList__$tbody.prepend($tr);
				}
				
				ArticleReplyList__loadMore();
			</script>
			<!-- 여기까지 -->

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
<%@ include file="../part/foot.jspf"%>