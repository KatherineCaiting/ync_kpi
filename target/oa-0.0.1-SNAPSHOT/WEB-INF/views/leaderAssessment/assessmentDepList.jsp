<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<html>
<head>
<script src="${ctx }/static/My97/WdatePicker.js"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>部门评价列表</title>
</head>
<body>
	<div class="container-fluid">
		<div class="row-fluid">
			<div class="span2">
			<ul class="nav nav-tabs nav-stacked">
					<li class="nav-header"><h4>历史列表</h4></li>
					<c:forEach items="${pe.getContent()}" var="pc">
						<li><a
							href="${ctx }/leaderAssessment/depList?date=<fmt:formatDate value="${pc.createTime}" pattern="yyyy-MM"/>">${pc.peDateDepartment.replace('_','') }</a></li>
					</c:forEach>
				</ul>
			</div>
			<div class="span10">
				<table class="table table-striped table-bordered table-condensed">
					<tr>
						<td>序号</td>
						<td>名称</td>
						<td>评语</td>
						<td>总分</td>
						<td>操作</td>
					</tr>

					<c:forEach var="list" items="${assessments}" varStatus="status">
						<tr>
							<td>${status.index+1 }</td>
							<td>${list.beEvaluatedName }</td>
							<td>${list.comment }</td>
							<td>${list.totalScore }</td>
							<td><a href="editPage/${list.id }/<fmt:formatDate value="${createTime}" pattern="yyyy-MM"/>	">评价/修改</a></td>
						</tr>
					</c:forEach>
				</table>
			</div>
		</div>
	</div>
</body>

</html>