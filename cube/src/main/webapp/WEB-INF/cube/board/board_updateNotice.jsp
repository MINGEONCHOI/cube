<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <title>게시글 수정</title>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <script src="/webjars/jquery/3.6.0/dist/jquery.min.js"></script>
</head>
<body>
<header class="index_header">
		<jsp:include page="../layout/header.jsp" />
	</header>
      <label for="nboardTitle">제목</label>
      <input type="text" class="form-control" id="nboardTitle"  name="nboardTitle" value="${NoticeBoard.nboardTitle}">
      
      <label for="nboardWriter">작성자</nboardWriter>    
     <input type="text" class="form-control" id="nboardWriter" name="nboardWriter" value = ${login_user.userName} readonly="readonly" />
     
     <label for="nboardContent">내용</label>
      <input type="text" class="form-control" id="nboardContent" " name="nboardContent" value="${NoticeBoard.nboardContent}">
  		
  	 <input type="hidden" id="nboardId" value = "${NoticeBoard.nboardId}" >
   
 
    <button id="btn-updateNotice" class="btn btn-primary">글 수정</button>
  <script src="/js/nb.js"></script>
</body>
</html>
