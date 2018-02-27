<link rel="stylesheet"
	href="https://cdn.bootcss.com/bootstrap/3.3.7/css/bootstrap.min.css"
	integrity="sha384-BVYiiSIFeK1dGmJRAkycuHAHRg32OmUcww7on3RYdg4Va+PmSTsz/K68vbdEjh4u"
	crossorigin="anonymous">
<link href="css/justified-nav.css" rel="stylesheet">
<style>
th, td {
	text-align: center;
}
</style>
<!-- 遮罩层 -->
<div class="modal fade" id="div_zhezhao" tabindex="-1" role="dialog"
	aria-labelledby="myModalLabel">
	<div class="modal-dialog" role="document">
		<div class="modal-content">
			<div class="modal-body">
				加载中...
				<button type="button" class="btn btn-default" data-dismiss="modal"
					id="btn_close_zhezhao" style="display: none;"></button>
			</div>
		</div>
	</div>
</div>
<script>
	function showShade() {
		$('#div_zhezhao').modal({
			keyboard : false,
			backdrop : 'static'
		});
	}

	function hideShade() {
		$('#div_zhezhao').modal('hide');
	}
</script>

<div class="container">
	<div class="masthead">
		<h3 class="text-muted">王牌大肉串</h3>
		<nav>
			<ul id="nav_ul" class="nav nav-justified">
				<li id="li_order"><a
					href="<%=request.getContextPath()%>/order.jsp">点餐</a></li>
				<li id="li_product"><a
					href="<%=request.getContextPath()%>/product.jsp">商品管理</a></li>
				<li id="li_category"><a
					href="<%=request.getContextPath()%>/category.jsp">类别管理</a></li>
				<li id="li_report"><a
					href="<%=request.getContextPath()%>/report.jsp">报表</a></li>
				<li><a href="<%=request.getContextPath()%>/login/logout.do">退出</a></li>
			</ul>
		</nav>
	</div>