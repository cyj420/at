<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="pageTitle" value="게시물 수정" />
<%@ include file="../part/head.jspf"%>
<style>
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
.con>div {
	display: flex;
}

form>div>div {
	margin-left: auto;
	margin-right: auto;
}
form {
	display: block;
	width: 100%;
}

form>table {
	width: 100%;
	border-collapse: collapse;
}

form>table th, form>table td {
	border: 1px solid black;
	padding: 10px;
}

form>table textarea {
	width: 100%;
	display: block;
	box-sizing: border-box;
	height: 100px;
}
th {
	word-break:keep-all;
}
</style>
<script>
	function Article__submitModifyForm(form) {
		form.title.value = form.title.value.trim();
		if (form.title.value.length == 0) {
			alert('제목을 입력해주세요.');
			form.title.focus();

			return false;
		}

		form.body.value = form.body.value.trim();
		if (form.body.value.length == 0) {
			alert('내용을 입력해주세요.');
			form.body.focus();

			return false;
		}
		form.submit();
	}

	
	var maxSizeMb = 50;
	var maxSize = maxSizeMb * 1024 * 1024 //50MB
	
	if (form.file__article__0__common__attachment__1.value) {
		if ( form.file__article__0__common__attachment__1.files[0].size > maxSize ) {
			alert(maxSizeMb + "MB 이하의 파일을 업로드 해주세요.");
			return;
		} 
	}
	if (form.file__article__0__common__attachment__2.value) {
		if ( form.file__article__0__common__attachment__2.files[0].size > maxSize ) {
			alert(maxSizeMb + "MB 이하의 파일을 업로드 해주세요.");
			return;
		} 
	}
	var startUploadFiles = function(onSuccess) {
		if ( form.file__article__0__common__attachment__1.value.length == 0 && form.file__article__0__common__attachment__2.value.length == 0 ) {
			onSuccess();
			return;
		}
		var fileUploadFormData = new FormData(form); 
		$.ajax({
			url : './../file/doUploadAjax',
			data : fileUploadFormData,
			processData : false,
			contentType : false,
			dataType:"json",
			type : 'POST',
			success : onSuccess
		});
	}
	/*
	ArticleModifyForm__submitDone = true;
	*/
	startUploadFiles(function(data) {
		var fileIdsStr = '';
		if ( data && data.body && data.body.fileIdsStr ) {
			// data.body는 무엇이고, data.body.fileIdsStr은 무엇인지.
			fileIdsStr = data.body.fileIdsStr;
		}
		form.fileIdsStr.value = fileIdsStr;
		form.file__article__0__common__attachment__1.value = '';
		form.file__article__0__common__attachment__2.value = '';
		
		form.submit();
	});
</script>

<div style="text-align: center;">
	<form class="table-box con form1" action="./doModify" method="POST"
		onsubmit="Article__submitModifyForm(this); return false;">
		<input type="hidden" name="id" value="${param.id }"/>
		<input type="hidden" name="fileIdsStr" />
		<input type="hidden" name="redirectUri" value="/usr/article/detail?id=#id">
		
		<table>
			<colgroup>
				<col width="100">
			</colgroup>
			<tbody>
				<tr>
					<th>제목</th>
					<td>
						<div class="form-control-box">
							<textarea maxlength="300" name="title" style="height: 50px;" 
							autofocus="autofocus" autocomplete="off">${article.title}</textarea>
						</div>
					</td>
				</tr>
				<tr>
					<th>내용</th>
					<td>
						<div class="form-control-box">
							<textarea name="body" placeholder="내용" autocomplete="off">${article.body}</textarea>
						</div>
					</td>
				</tr>
				
				<tr>
					<th>첨부1 비디오</th>
					<td>
						<div class="form-control-box">
							<c:if test="${article.extra.file__common__attachment['1'] == null}">
							<input type="file" accept="video/*"
								name="file__article__0__common__attachment__1">
							</c:if>
							<c:if test="${article.extra.file__common__attachment['1'] != null}">
							<div>동영상 파일 존재</div>
							</c:if>
						</div>
					</td>
				</tr>
				<tr>
					<th>첨부2 비디오</th>
					<td>
						<div class="form-control-box">
							<c:if test="${article.extra.file__common__attachment['2'] == null}">
							<input type="file" accept="video/*"
								name="file__article__0__common__attachment__2">
							</c:if>
							<c:if test="${article.extra.file__common__attachment['2'] != null}">
							<div>동영상 파일 존재</div>
							</c:if>
						</div>
					</td>
				</tr>
				
				<tr>
					<th>작성</th>
					<td>
						<input type="submit" value="수정">
						<input type="reset" value="취소" onclick="history.back();">
					</td>
				</tr>
			</tbody>
		</table>
	</form>
</div>
<%@ include file="../part/foot.jspf"%>