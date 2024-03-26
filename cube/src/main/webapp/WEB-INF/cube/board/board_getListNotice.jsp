<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<html lang="en">
<head>
<title>게시글 입력</title>
<meta charset="utf-8">
</head>
<body id="page-top">
	<header class="index_header">
		<jsp:include page="../layout/header.jsp" />
	</header>
	<div class="container-fluid">
		<div class="card shadow mb-4">
			<div class="card-header py-3">
                            <h6 class="m-0 font-weight-bold text-primary">게시판<i class="fas fa-chevron-right mx-1"></i>공지사항</h6>
                        </div>
			<div class="card-body">
				<div class="table-responsive">
					<div class="justify-content-end">
						<table class="float-right">
							<tr>
								<td><select
									class="custom-select custom-select-sm form-control form-control-sm"
									name="searchType" id="searchType">
										<option value="userName">이름</option>
										<option value="nboardTitle">제목</option>
								</select></td>
								<td>
									<div class="input-group">
										<input type="text"
											class="form-control bg-light border-0 small"
											placeholder="Search for..." aria-label="Search"
											aria-describedby="basic-addon2" id="searchInput">
										<div class="input-group-append" id="btn-nboardsearch">
											<button class="btn btn-primary" type="button">
												<i class="fas fa-search fa-sm"></i>
											</button>
										</div>
									</div>
								</td>

							</tr>

							<input id="nboardId" type=hidden value="${Board.nboardId}">
						</table>
					</div>
					<table class="table table-bordered" width="100%" cellspacing="0">
						<thead>

							<tr>
								<th>번호</th>
								<th>제목</th>
								<th>작성자</th>
								<th>생성일</th>
								<th>수정 시간</th>


							</tr>
						</thead>
						<tbody>
							<c:forEach var="Board" items="${NoticeBoard}">
								<tr>
									<td>${Board.nboardId}</td>
									<td><a href="getNotice/${Board.nboardId}">${Board.nboardTitle}</a></td>
									<td>${login_user.userName}</td>
									<td>${Board.nboardCreated}</td>
									<td>${Board.nboardUpdated}</td>


								</tr>
							</c:forEach>
						</tbody>
					</table>
				</div>
			</div>
		</div>
	</div>

	<div class="text-center">
		<a href="/insertNotice"><button class="btn btn-primary">
				<i class="fas fa-pen mr-2"></i>글등록
			</button></a>
	</div>



	<!-- Scroll to Top Button-->
	<a class="scroll-to-top rounded" href="#page-top"> <i
		class="fas fa-angle-up"></i>
	</a>

	<script src="/js/nb.js"></script>


</body>
</html>