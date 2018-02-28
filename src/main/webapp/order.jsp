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
<link rel="stylesheet" href="css/jquery.spinner.css">
<style>
.input-group {
	margin-bottom: 10px
}
</style>
</head>
<body>
	<%@ include file="head.jsp"%>
	<div class="masthead" style="margin-top: 5px;">
		<div class="panel panel-primary">
			<div class="panel-heading">当前订单</div>
			<div class="panel-body">
				<!-- Button trigger modal -->
				<button type="button" class="btn btn-primary btn-lg"
					data-toggle="modal" data-target="#myModal" id="btn_add">下单</button>
				<!-- Modal -->
				<div class="modal fade bs-example-modal-lg" id="myModal"
					tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
					<div class="modal-dialog modal-lg" role="document">
						<div class="modal-content">
							<div class="modal-header">
								<button type="button" class="close" data-dismiss="modal"
									aria-label="Close">
									<span aria-hidden="true">&times;</span>
								</button>
								<h4 class="modal-title" id="myModalLabel">下单</h4>
							</div>
							<div class="modal-body">
								<div class="input-group">
									<div class="dropdown">
										<button class="btn btn-default dropdown-toggle" type="button"
											id="dropdownMenu3" data-toggle="dropdown"
											aria-haspopup="true" aria-expanded="true">
											订单类型<span class="caret"></span>
										</button>
										<ul class="dropdown-menu" aria-labelledby="dropdownMenu3">
											<li><a href="#" onclick="choseOrderType(this);">堂食</a></li>
											<li><a href="#" onclick="choseOrderType(this);">打包</a></li>
										</ul>
										<span id="span_orderType" style="margin-left: 5px;">&nbsp;</span>
									</div>
								</div>

								<div class="input-group" id="div_deskNum" style="display: none;">
									<div class="dropdown">
										<button class="btn btn-default dropdown-toggle" type="button"
											id="dropdownMenu4" data-toggle="dropdown"
											aria-haspopup="true" aria-expanded="true">
											桌号<span class="caret"></span>
										</button>
										<ul class="dropdown-menu" aria-labelledby="dropdownMenu4">
											<li><a href="#" onclick="choseDeskNum(this);">1</a></li>
											<li><a href="#" onclick="choseDeskNum(this);">2</a></li>
											<li><a href="#" onclick="choseDeskNum(this);">3</a></li>
											<li><a href="#" onclick="choseDeskNum(this);">4</a></li>
											<li><a href="#" onclick="choseDeskNum(this);">5</a></li>
											<li><a href="#" onclick="choseDeskNum(this);">6</a></li>
											<li><a href="#" onclick="choseDeskNum(this);">7</a></li>
											<li><a href="#" onclick="choseDeskNum(this);">8</a></li>
											<li><a href="#" onclick="choseDeskNum(this);">9</a></li>
											<li><a href="#" onclick="choseDeskNum(this);">10</a></li>
										</ul>
										<span id="span_deskNum" style="margin-left: 5px;">&nbsp;</span>
									</div>
								</div>

								<div class="input-group" id="div_product"></div>
			 					<div class="form-group">
           							<label for="message-text" class="control-label">备注信息</label>
           							<textarea class="form-control" id="message-text"></textarea>
         						</div>
							</div>
							<div class="modal-footer">
								<button type="button" class="btn btn-default"
									data-dismiss="modal" id="btn_close">关闭</button>
								<button type="button" class="btn btn-primary"
									onclick="saveOrder(this)">保存</button>
							</div>
						</div>
					</div>
				</div>

				<table class="table table-striped table-bordered" style="margin-top: 5px;" id="tb_curr_order">
					<thead>
						<tr>
							<th>订单编号</th><th>下单时间</th><th>桌号</th><th>订单类型</th><th>订单状态</th><th>备注</th><th>操作</th>
						</tr>
					</thead>
					<tbody></tbody>
				</table>
			</div>
		</div>

		<div class="panel panel-primary">
			<div class="panel-heading">历史订单</div>
			<div class="panel-body">
				<table class="table table-striped table-bordered"
					style="margin-top: 5px;" id="tb_his_order">
					<thead>
						<tr>
							<th>订单编号</th><th>下单时间</th><th>桌号</th><th>订单类型</th><th>订单状态</th><th>备注</th><th>操作</th>
						</tr>
					</thead>
					<tbody></tbody>
				</table>
				<nav aria-label="Page navigation">
					<ul id="ul_pager" class="pagination" style="margin: -5px 0; display: none">
					</ul>
				</nav>
			</div>
		</div>
	</div>
	<%@ include file="footer.jsp"%>
	<script src="js/jquery.spinner.js" type="text/javascript"></script>
	<script>
		var currPage = 1;
		var pageSize = 15;
		var startPage = 1;
		var endPage = 10;
		var totalPage = 0;
		
		function goPager(targetPage){
 			if(targetPage>=1&&targetPage<=totalPage){
 				currPage = targetPage;
 				loadData();
 			}else if(targetPage == 1 && totalPage == 0){
 				currPage = 1;
 				loadData();
 			}
 		}
		
		function loadHisData(){
			showShade();
			$.ajax({
				url: '<%=request.getContextPath()%>/order/hisList.do?currPage=' + currPage + '&pageSize=' + pageSize,
				async: true,
				cache: false,
				type: 'get',
				success: function(data){
					if (data.status == 0) {
						totalPage=data.data.totalPage;
						if(data.data.totalPage < endPage){
							endPage = data.data.totalPage;
						}
						if(currPage > endPage){
							startPage = currPage;
							
							if(startPage + 9 > data.data.totalPage) {
								endPage = data.data.totalPage;
							} else {
								endPage = startPage + 9;
							}
						}
						
						if(data.data.totalPage>0){
							$("#ul_pager").find('li').remove();
							$("#ul_pager").append('<li><a href="#" aria-label="Previous" onclick="goPager(' + (currPage-1) + ')"><span aria-hidden="true">&laquo;</span></a></li>');
	    					
							for(var i=startPage;i<=endPage;i++){
								if(currPage == i){
									$("#ul_pager").append('<li class=\'active\'><a href="#">' + i + '</a></li>');
								}else{
									$("#ul_pager").append('<li><a href="#" onclick="goPager(' + i + ')">' + i + '</a></li>');
								}
								
							}
							
							$("#ul_pager").append('<li><a href="#" aria-label="Next" onclick="goPager(' + (currPage+1) + ')"><span aria-hidden="true">&raquo;</span></a></li>');
							$("#ul_pager").show();
						}else{
							$("#ul_pager").hide();
						}
						
						$("#tb_his_order").find('tbody').find('tr').remove();
						var content = '';
						$.each(data.data.data, function(index, value){
							content += content += '<tr><td>' + value.id + '</td><td>' + value.createTimeStr + '</td><td>' + (value.deskNum == null?'':value.deskNum) + '</td><td>' + value.orderType + '</td><td>'+value.statusStr+'</td><td>'+value.remarks+'</td><td><a href="#">查看</a></td>';
						});
						$("#tb_his_order").find('tbody').append(content);
					} else {
						alert('查询失败');
					}
					
					hideShade();
				},
				error: function(){
					alert('查询失败');
					hideShade();
				}
			});
		}
		
	
 		function choseOrderType(obj){
 			$("#span_orderType").html($(obj).text());
 			if($(obj).text() == '堂食'){
 				$("#div_deskNum").show();
 			}else{
 				$("#div_deskNum").hide();
 				$("#span_deskNum").html('&nbsp;');
 			}
 		}
 		
 		function choseDeskNum(obj){
 			$("#span_deskNum").html($(obj).text());
 		}
 		
 		function initProductInfo(categorys, products){
 			$("#div_product").empty();
 			
 			$.each(categorys, function(index1, category){
 				var productInfo = '<table>';
 				var index = 1;
 				$.each(products, function(index2, product){
 					if(product.categoryId == category.id){
 						if(index++ % 2 == 0){
 							productInfo += '<td><div style="float: left;">' + product.name + '(' + product.price + '元)</div><div style="float: right;"><input type="text" class="spinner" id="' + product.id + '" /></div></td></tr>';
 						}else{
 							productInfo += '<tr><td><div style="float: left;">' + product.name + '(' + product.price + '元)</div><div style="float: right;"><input type="text" class="spinner" id="' + product.id + '" /></div></td>';
 						}
 					}
 				});
 				
 				if(productInfo.lastIndexOf('</td>') == productInfo.length - 5){
						productInfo += '<td>&nbsp;</td></tr>';
				}
 				productInfo += '</table>'
 				
 				$("#div_product").append(
 						'<div class="panel panel-primary" style="float: left;">'+
 						'	<div class="panel-heading">'+category.name+'</div>'+
 						'		<div class="panel-body">'+ productInfo + 
 						'		</div>'+
 						'	</div>'+
 						'</div>'+
 						'<div style="float: left;">&nbsp;</div>');
			});
 			
 			$('.spinner').spinner();
 			hideShade();
 		}
 		
 		function saveOrder(obj){
 			$(obj).attr("disabled","disabled");
 			var orderType = $("#span_orderType").html();
 			if('' == orderType || '&nbsp;' == orderType){
 				alert('请选择订单类型');
 				return false;
 			}
 			
 			var postData = {};
 			var deskNum = $("#span_deskNum").html();
 			if('堂食' == orderType){
 				if('' == deskNum || '&nbsp;' == deskNum){
 	 				alert('请选择桌号');
 	 				return false;
 	 			}
 				postData.deskNum = deskNum;
 			}
 			
 			var remarks = $("#message-text").val();
 			var detail = [];
 			$('input.spinner').each(function(){
 				detail.push({'productId': $(this).attr('id'), 'productNum': $(this).val()});
 			});
 			
 			postData.orderType = orderType;
 			postData.remarks = remarks;
 			postData.detail = JSON.stringify(detail);
 			
 			$.ajax({
    			url: '<%=request.getContextPath()%>/order/add.do',
    			async: false,
    			cache: false,
    			type: 'post',
    			data: postData,
    			success: function(data){
    				if (data.status == 0) {
    					$(obj).removeAttr("disabled");
    					$("#btn_close").click();
    					
    					loadCurrOrder();
    				} else {
    					alert('下单失败');
    					$(obj).removeAttr("disabled");
    				}
    			},
    			error: function(){
    				alert('下单失败');
    				$(obj).removeAttr("disabled");
    			}
    		});
 		}
 		
 		function loadCurrOrder(){
 			$.ajax({
    			url: '<%=request.getContextPath()%>/order/currList.do',
    			async: true,
    			cache: false,
    			type: 'get',
    			success: function(data){
    				if (data.status == 0) {
    					$('#tb_curr_order').find('tbody').empty();
    					
    					var content = '';
    					$.each(data.data, function(index, value){
    						content += '<tr><td>' + value.id + '</td><td>' + value.createTimeStr + '</td><td>' + (value.deskNum == null?'':value.deskNum) + '</td><td>' + value.orderType + '</td><td>'+value.statusStr+'</td><td>'+value.remarks+'</td><td></td>';
    					});
    					$('#tb_curr_order').find('tbody').append(content);
    				} else {
    					alert('获取当前订单失败');
    				}
    			},
    			error: function(){
    				alert('获取当前订单失败');
    			}
    		});
 		}
 	
    	$(document).ready(function(){
    	 	$("#li_order").addClass("active");
    	 	$("#li_order").siblings().removeClass("active");
    	 	
    	 	loadCurrOrder();
    	 	loadHisData();
    	 	
    	 	$("#btn_add").bind('click',function(){
    	 		showShade();
    	 		
    	 		$("#span_orderType").html('&nbsp;');
    	 		$("#span_deskNum").html('&nbsp;');
    	 		$("#message-text").val('');
    	 		$("#div_deskNum").hide();
    	 		
    	 		$.ajax({
        			url: '<%=request.getContextPath()%>/category/list.do',
        			async: false,
        			cache: false,
        			type: 'get',
        			success: function(data1){
        				if (data1.status == 0) {
        					$.ajax({
        		    			url: '<%=request.getContextPath()%>/product/listAll.do',
        		    			async: false,
        		    			cache: false,
        		    			type: 'get',
        		    			success: function(data2){
        		    				if (data2.status == 0) {
        		    					initProductInfo(data1.data, data2.data);
        		    				} else {
        		    					alert(data2.msg);
        		    					hideShade();
        		    				}
        		    			},
        		    			error: function(){
        		    				alert('获取商品失败');
        		    				hideShade();
        		    			}
        		    		});
        				} else {
        					alert('获取类别失败');
        					hideShade();
        				}
        			},
        			error: function(){
        				alert('获取类别失败');
        				hideShade();
        			}
        		});
    	 	});
    	});
    </script>
</body>
</html>
