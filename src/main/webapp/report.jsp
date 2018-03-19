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
		<div class="panel panel-primary">
			<div class="panel-heading">今日销售统计</div>
			<div class="panel-body">
				<table class="table table-striped table-bordered"
					style="margin-top: 5px;" id="">
					<tr>
						<td>今日销售总额：<label id="label_sales" style="color: red"></label></td>
						<td>订单总数：<label id="label_order_count" style="color: red"></label></td>
						<td>堂食：<label id="label_tangshi_count" style="color: red"></label></td>
						<td>打包：<label id="label_dabao_count" style="color: red"></label></td>
					</tr>
				</table>
			</div>
		</div>
		<div class="panel panel-primary">
			<div class="panel-heading">今日销售量Top5</div>
			<div class="panel-body">
				<div id="div_sales_num" style="width: 100%; height: 400px;"></div>
			</div>
		</div>
		<div class="panel panel-primary">
			<div class="panel-heading">今日销售额Top5</div>
			<div class="panel-body">
				<div id="div_sales_sum" style="width: 100%; height: 400px;"></div>
			</div>
		</div>
	</div>
	<%@ include file="footer.jsp"%>
	<script src="js/echarts.common.min.js"></script>
	<script>
		function initSalesNumCharts(names, values) {
			// 基于准备好的dom，初始化echarts实例
			var myChart = echarts
					.init(document.getElementById('div_sales_num'));

			// 指定图表的配置项和数据
			var option = {
				title : {
					text : '销量Top5'
				},
				tooltip : {},
				xAxis : {
					data : names
				},
				yAxis : {},
				series : [ {
					name : '销量',
					type : 'bar',
					data : values
				} ]
			};

			// 使用刚指定的配置项和数据显示图表。
			myChart.setOption(option);
		}

		function initSalesSumCharts(names, values) {
			// 基于准备好的dom，初始化echarts实例
			var myChart = echarts
					.init(document.getElementById('div_sales_sum'));

			// 指定图表的配置项和数据
			var option = {
				title : {
					text : '销售额Top5'
				},
				tooltip : {},
				xAxis : {
					data : names
				},
				yAxis : {},
				series : [ {
					name : '销售额',
					type : 'bar',
					data : values
				} ]
			};

			// 使用刚指定的配置项和数据显示图表。
			myChart.setOption(option);
		}

		function initTodayData() {
			$
					.ajax({
						url : contextPath + '/report/getTodayData.do',
						async : false,
						cache : false,
						type : 'get',
						success : function(data) {
							if (data.status == 0) {
								if (null != data.data.salesStatistics) {
									$("#label_sales").html(
											data.data.salesStatistics.sales);
									$("#label_order_count")
											.html(
													data.data.salesStatistics.orderCount);
									$("#label_tangshi_count")
											.html(
													data.data.salesStatistics.orderCountTangshi);
									$("#label_dabao_count")
											.html(
													data.data.salesStatistics.orderCountDabao);
								}

								var names = [];
								var values = [];
								$.each(data.data.salesNumTop, function(index,
										value) {
									names.push(value.productName);
									values.push(value.productNum);
								});
								initSalesNumCharts(names, values);

								names = [];
								values = [];
								$.each(data.data.salesSumTop, function(index,
										value) {
									names.push(value.productName);
									values.push(value.sales);
								});
								initSalesSumCharts(names, values);
							}
						},
						error : function() {
							alert('查询失败');
						}
					});
		}

		$(document).ready(function() {
			$("#li_report").addClass("active");
			$("#li_report").siblings().removeClass("active");

			initTodayData();
		});
	</script>
</body>
</html>
