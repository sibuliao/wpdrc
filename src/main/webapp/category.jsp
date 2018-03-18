<!DOCTYPE html>
<html lang="zh-CN">
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet"
	href="https://cdn.bootcss.com/bootstrap/3.3.7/css/bootstrap.min.css"
	integrity="sha384-BVYiiSIFeK1dGmJRAkycuHAHRg32OmUcww7on3RYdg4Va+PmSTsz/K68vbdEjh4u"
	crossorigin="anonymous">
</head>
<body>
	<%@ include file="head.jsp"%>
	<div class="masthead" style="margin-top: 5px">
		<!-- Button trigger modal -->
		<button type="button" class="btn btn-primary btn-lg"
			data-toggle="modal" data-target="#myModal" id="btn_add">添加</button>

		<!-- Modal -->
		<div class="modal fade" id="myModal" tabindex="-1" role="dialog"
			aria-labelledby="myModalLabel">
			<div class="modal-dialog" role="document">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal"
							aria-label="Close">
							<span aria-hidden="true">&times;</span>
						</button>
						<h4 class="modal-title" id="myModalLabel">添加类别</h4>
					</div>
					<div class="modal-body">
						<input id="input_name" />
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-default" data-dismiss="modal"
							id="btn_close">关闭</button>
						<button type="button" class="btn btn-primary"
							onclick="saveCategory(this)">保存</button>
					</div>
				</div>
			</div>
		</div>

		<!-- Button trigger modal -->
		<button type="button" class="btn btn-primary btn-lg"
			data-toggle="modal" data-target="#myModal1" id="btn_modify"
			style="display: none;"></button>

		<!-- Modal -->
		<div class="modal fade" id="myModal1" tabindex="-1" role="dialog"
			aria-labelledby="myModalLabel1">
			<div class="modal-dialog" role="document">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal"
							aria-label="Close">
							<span aria-hidden="true">&times;</span>
						</button>
						<h4 class="modal-title" id="myModalLabel1">修改类别</h4>
					</div>
					<div class="modal-body">
						<input id="modify_input_name" /> <input type="hidden"
							id="hidden_id" />
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-default" data-dismiss="modal"
							id="modify_btn_close">关闭</button>
						<button type="button" class="btn btn-primary"
							onclick="updateCategory(this)">保存</button>
					</div>
				</div>
			</div>
		</div>

		<table class="table table-striped table-bordered"
			style="margin-top: 5px" id="tb_category">
			<thead>
				<tr>
					<th>类别名称</th>
					<th>操作</th>
				</tr>
			</thead>
			<tbody></tbody>
		</table>
	</div>
	<%@ include file="footer.jsp"%>
	<script>
		function saveCategory(obj) {
			$(obj).attr("disabled", "disabled");

			var name = $("#input_name").val();
			$.ajax({
				url : contextPath + '/category/add.do',
				async : false,
				cache : false,
				type : 'post',
				data : {
					'name' : name
				},
				success : function(data) {
					if (data.status == 0) {
						$(obj).removeAttr("disabled");
						$('#btn_close').click();
						reloadData();
					} else {
						alert(data.msg);
						$(obj).removeAttr("disabled");
					}
				},
				error : function() {
					alert('添加失败');
					$(obj).removeAttr("disabled");
				}
			});
		}

		function modifyCategory(categoryId) {
			$("#modify_input_name").val('');
			$("#hidden_id").val(categoryId);

			$.ajax({
				url : contextPath + '/category/find.do?id=' + categoryId,
				async : false,
				cache : false,
				type : 'get',
				success : function(data) {
					if (data.status == 0) {
						$("#modify_input_name").val(data.data.name);
						$("#btn_modify").click();
					} else {
						alert(data.msg);
					}
				},
				error : function() {
					alert('信息获取失败');
				}
			});
		}

		function updateCategory(obj) {
			$(obj).attr("disabled", "disabled");

			var name = $("#modify_input_name").val();
			var categoryId = $("#hidden_id").val();
			$.ajax({
				url : contextPath + '/category/update.do',
				async : false,
				cache : false,
				type : 'post',
				data : {
					'name' : name,
					'id' : categoryId
				},
				success : function(data) {
					if (data.status == 0) {
						$(obj).removeAttr("disabled");
						$('#modify_btn_close').click();
						reloadData();
					} else {
						alert(data.msg);
						$(obj).removeAttr("disabled");
					}
				},
				error : function() {
					alert('修改失败');
					$(obj).removeAttr("disabled");
				}
			});
		}

		function delCategory(categoryId) {
			if (confirm('确定删除?')) {
				$.ajax({
					url : contextPath + '/category/delCategory.do?id='
							+ categoryId,
					async : true,
					cache : false,
					type : 'post',
					success : function(data) {
						if (data.status == 0) {
							reloadData();
						} else {
							alert(data.msg);
						}
					},
					error : function() {
						alert('删除失败');
					}
				});
			}
		}

		function reloadData() {
			$("#tb_category").find('tbody').find('tr').remove();
			loadData();
		}

		function loadData() {
			$
					.ajax({
						url : contextPath + '/category/list.do',
						async : true,
						cache : false,
						type : 'get',
						success : function(data) {
							if (data.status == 0) {
								$
										.each(
												data.data,
												function(index, value) {
													$("#tb_category")
															.append(
																	'<tr><td>'
																			+ value.name
																			+ '</td><td><a href=\'#\' onclick=\'modifyCategory('
																			+ value.id
																			+ ')\'>修改</a>&nbsp;<a href=\'#\' onclick=\'delCategory('
																			+ value.id
																			+ ')\'>删除</a></td></tr>');
												});
							} else {
								alert('获取失败');
							}
						},
						error : function() {
							alert('获取失败');
						}
					});
		}

		$(document).ready(function() {
			$("#li_category").addClass("active");
			$("#li_category").siblings().removeClass("active");
			$("#btn_add").bind('click', function() {
				$("#input_name").val('');
			});
			loadData();
		});
	</script>
</body>
</html>
