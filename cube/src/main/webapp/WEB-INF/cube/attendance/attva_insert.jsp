<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.time.LocalDate" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<style type="text/css">
textarea{
	resize: none;
}
</style>
</head>
<body id="page-top">
	<header class="index_header">
		<jsp:include page="../layout/header.jsp" />
	</header>
	<div class="container-fluid">
		<div class="card shadow mb-4">
			<div class="card-header py-3">
				<h6 class="m-0 text-secondary">
					근태<i class="fas fa-chevron-right mx-1"></i>휴가<i class="fas fa-chevron-right mx-1"></i>휴가 신청
				</h6>
			</div>
			<div class="card-body">
<h2>휴가 신청</h2>

    <table>
        <tr>
            <th>휴가 시작일:</th>
            <td><input type="date" id="startDate" required min="<%=LocalDate.now()%>"></td>
        </tr>
        <tr>
            <th>휴가 종료일:</th>
            <td><input type="date" id="endDate" required></td>
        </tr>
        <tr>
        <th>휴가기간: </th>
        <td id = "calDate"></td>
        </tr>
        
        <tr>
            <td colspan = 2><div class="form-group">
								<label>휴가사유</label>
								<textarea class="form-control" rows="5" cols= "50" id="vaDes"
									placeholder="휴가 사유 작성" required></textarea></td>
        </tr>
    </table>
		
            <div id = "vaType"></div>

    <button id = "insertVa">휴가 신청 제출</button>
    </div>
    </div>
    </div>
    <script src="/js/att.js"></script>
</body>
</html>