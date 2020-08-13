<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<c:set var="pageTitle" value="게시물 추가" />
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
	function Article__submitWriteForm(form) {
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
		ArticleWriteForm__submitDone = true;
		startUploadFiles(function(data) {
			var fileIdsStr = '';
			if ( data && data.body && data.body.fileIdsStr ) {
				fileIdsStr = data.body.fileIdsStr;
			}
			form.fileIdsStr.value = fileIdsStr;
			form.file__article__0__common__attachment__1.value = '';
			form.file__article__0__common__attachment__2.value = '';
			
			form.submit();
		});
	}
</script>

<!-- 추가 시작 -->
<form class="table-box con form1" action="./doWrite" method="POST"
	onsubmit="Article__submitWriteForm(this); return false;">
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
						<textarea maxlength="300" name="title" placeholder="제목을 입력해주세요." style="height: 50px;"></textarea>
					</div>
				</td>
			</tr>
			<tr>
				<th>내용</th>
				<td>
					<div class="form-control-box">
						<textarea maxlength="300" name="body" placeholder="내용을 입력해주세요."></textarea>
					</div>
				</td>
			</tr>
			<tr>
				<th>첨부1 비디오</th>
				<td>
					<div class="form-control-box">
						<input type="file" accept="video/*"
							name="file__article__0__common__attachment__1">
					</div>
				</td>
			</tr>
			<tr>
				<th>첨부2 비디오</th>
				<td>
					<div class="form-control-box">
						<input type="file" accept="video/*"
							name="file__article__0__common__attachment__2">
					</div>
				</td>
			</tr>
			<tr>
				<th>작성</th>
				<td>
					<input type="submit" value="작성">
					<input type="reset" value="취소" onclick="history.back();">
				</td>
			</tr>
		</tbody>
	</table>
</form>
<!-- 추가 끝 -->

<!-- 
	<form class="con common-form" action="./doWrite" method="POST" onsubmit="Article__submitWriteForm(this); return false;">
		<div>
			<div>
				<label>제목</label>
				<input name="title" type="text" placeholder="제목"
					autofocus="autofocus" autocomplete="off" style="width: 300px;">
			</div>
		</div>
	
		<div style="margin-top: 20px; margin-bottom: 20px;">
			<div>
				<label>내용</label>
				<textarea name="body" placeholder="내용" autocomplete="off" style="width: 300px;"></textarea>
			</div>
		</div>
	
		<div class="button">
			<div>
				<input type="submit" value="작성"> 
				<input type="reset" value="취소" onclick="history.back();">
			</div>
		</div>
	</form>
	 -->
<%@ include file="../part/foot.jspf"%>
