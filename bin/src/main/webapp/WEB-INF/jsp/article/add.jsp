<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<c:set var="pageName" value="게시물 추가" />
<script>
	function submitAddForm(form) {
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
</script>
<style>
.con>div{
	display: flex;
}

form>div>div{
	margin-left: auto;
	margin-right: auto;
}
</style>
<form class="con common-form" action="./doAdd" method="POST" onsubmit="submitAddForm(this); return false;">
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
