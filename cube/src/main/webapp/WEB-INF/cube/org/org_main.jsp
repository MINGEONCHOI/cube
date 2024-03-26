<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>조직도 메인</title>
</head>
<body id="page-top">
<header class="index_header">
	<jsp:include page="../layout/header.jsp" />
</header>
	<div class="container-fluid">
		<div class="card shadow mb-4">
			<div class="card-header py-3">
			<h6 class="m-0 text-primary">
					조직도
				</h6>
			</div>
			<div class="card-body">
	<table>
		<c:forEach var="team" items="${getAllUsers}" varStatus="loop">
			<tr align="center">
				<th colspan="5" class="team-name" onclick="toggleTeam(this)">${teamList[loop.index].teamName}
					팀</th>
			</tr>
			<tr class="collaps">
				<td colspan="5"><c:choose>
						<c:when test="${not empty team}">
							<table>
								<c:forEach var="user" items="${team}">
									<tr>
										<c:choose>
											<c:when test="${user.userStatus eq '활성화'}">
												<td>이름: ${user.userName} 님</td>
												<td>사번: ${user.userNum}</td>
												<td><a href="/mail_send/${user.userEmail} ">이메일:
														${user.userEmail}</a></td>
												<td>팀: ${user.userTeamId.teamName}</td>
												<td>직책: ${user.userPosition}</td>
												<td style="color: blue">${user.userStatus}</td>
											</c:when>
										</c:choose>
									</tr>
								</c:forEach>
							</table>
						</c:when>
						<c:otherwise>
							<div>팀 구성원 없음</div>
						</c:otherwise>
					</c:choose></td>
			</tr>
		</c:forEach>
	</table>
</div>
</div>
</div>
	<script>
		function toggleTeam(element) {
			var teamMembers = element.parentNode.nextElementSibling;
			if (teamMembers.style.display === 'none'
					|| teamMembers.style.display === '') {
				teamMembers.style.display = 'table-row';
			} else {
				teamMembers.style.display = 'none';
			}
		}
	</script>

</body>
</html>
