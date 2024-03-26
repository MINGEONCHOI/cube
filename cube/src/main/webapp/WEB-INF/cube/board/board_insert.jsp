<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <title>팀 게시글 입력</title>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <script src="/webjars/jquery/3.6.0/dist/jquery.min.js"></script>
</head>
<body>
<header class="index_header">
		<jsp:include page="../layout/header.jsp" />
	</header>
      <label for="boardTitle">제목</label>
      <input type="text" class="form-control" id="boardTitle" placeholder="제목 입력하세요" name="boardTitle">
      
      <label for="boardWriter">작성자</label>
      <input type="text" class="form-control" id="boardWriter" name="boardWriter" value = ${login_user.userName} readonly="readonly" />

      <label for="boardContent">내용</label>
      <input type="text" class="form-control" id="boardContent" placeholder="내용을 입력하세요" name="boardContent">
  	  <input type="hidden" class="form-control" id="team" value = "${team.teamId}">
  	  
   
    <button id="btn-insertBoard" class="btn btn-primary">글등록</button>

  <script src="/js/tb.js"></script>
</body>
</html>
