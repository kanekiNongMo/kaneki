<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="kaneki" uri="http://kaneki.com/common/"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<!DOCTYPE HTML>
<html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>用户角色管理</title>
<!-- 引入css样式文件 -->
<!-- Bootstrap Core CSS -->
<link href="<%=basePath%>resource/css/bootstrap.min.css"
	rel="stylesheet" />
<link href="<%=basePath%>resource/css/erp.css"
	rel="stylesheet" />
</head>
<body>
	<div id="wrapper">
		<div id="page-wrapper-user">
			<div class="row">
				<div class="col-lg-12">
					<div class="panel panel-default">
						<div class="panel-heading">
							<a href="<%=basePath%>/roleList.action" class="btn btn-primary">返回</a>
							${ROLENAME}用户信息列表
							<a href="#" class="btn btn-primary" data-toggle="modal"
								data-target="#newUserRoleDialog"  style="float: right; margin-right: 12%; " >添加</a>
						</div>

						<!-- /.panel-heading -->
						<div class="table-responsive">
						<table class="table table-bordered table-striped table-hover">
							<thead>
								<tr>
									<th>用户角色编号</th>
									<th>用户编号</th>
									<th>用户名称</th>
									<th>操作</th>
								</tr>
							</thead>
							<tbody>
								 <c:forEach items="${page.list}" var="userRole"> 
								<tr>
									<td>${userRole.userRoleId}</td>
									<td>${userRole.user.userId}</td>
									<td>${userRole.user.userName}</td>
									<td> <a href="#"
										class="btn btn-danger btn-xs deleteRes"
										onclick="deleteUserRole(${userRole.userRoleId})">删除</a>
									</td>
								</tr>
							 </c:forEach> 
							</tbody>
							
						</table>
						</div>
						
						<div class="col-md-12 text-right">
							<kaneki:page
								url="${pageContext.request.contextPath }/getUserByRoleId.action" />
						</div>
						<!-- /.panel-body -->
					</div>
					<!-- /.panel -->
				</div>
				<!-- /.col-lg-12 -->
			</div>
		</div>
	</div>
	<div class="modal fade" id="newUserRoleDialog" tabindex="-1"
		role="dialog" aria-labelledby="myModalLabel">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
					<h4 class="modal-title" id="myModalLabel">角色添加用户</h4>
				</div>
				<div class="modal-body">
					<form class="form-horizontal" id="new_userRole_form">
						<input type="hidden" id="roleId" name="role.roleId" value="${ROLEID}"/>
						<div class="form-group">
						<label for="customerFrom" class="col-sm-2 control-label">用户名称</label> 
						<div class="col-sm-10">
						<select	class="form-control" id="userFrom" name="user.userId">
							<option value="">--请选择--</option>
							<c:forEach items="${USER}" var="user">
								<option value="${user.userId}" >
								    ${user.userName}
								</option>
							</c:forEach>
						</select>
						</div>
					</div>
					</form>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
					<button type="button" class="btn btn-primary"
						onclick="createUser()">赋予用户</button>
				</div>
			</div>
		</div>
	</div>
	<!-- 引入js文件 -->
	<!-- jQuery -->
	<script src="<%=basePath%>resource/js/jquery-1.11.3.min.js"></script>
	<!-- Bootstrap Core JavaScript -->
	<script src="<%=basePath%>resource/js/bootstrap.min.js"></script>
	<!-- Metis Menu Plugin JavaScript -->
	<script src="<%=basePath%>resource/js/metisMenu.min.js"></script>
	<!-- DataTables JavaScript -->
	<script src="<%=basePath%>resource/js/jquery.dataTables.min.js"></script>
	<script src="<%=basePath%>resource/js/dataTables.bootstrap.min.js"></script>
	<!-- 编写js代码 -->
	<script type="text/javascript">
	function deleteUserRole(userRoleId){
	if (confirm('确实要删除该角色权限吗?')) {
		$.ajax({
		type:"post",
		url:"<%=basePath%>/deleteUserRole.action",
		data:{"userRoleId":userRoleId},
		success:function(data){
					if (data == "OK") {
							alert("权限删除成功！");
							window.location.reload();
						} else {
							alert("删除权限失败！");
							window.location.reload();
						}
				}
		});
		}
	}
	
	function createUser(){
			if($("#userFrom").val()==''){
				alert("请选择！");
			}else{
				 $.ajax({
					type : "post",
					 async: false,
					url : "<%=basePath%>/addUserRole.action",
					data : $("#new_userRole_form").serialize(),
					success : function(data) {
						if (data == "OK") {
							alert("赋予用户成功！");
							window.location.reload();
						} else {
							alert("赋予用户失败！");
							window.location.reload();
						}
					}
				}); 
			}
	}
	
	</script>
</body>
</html>