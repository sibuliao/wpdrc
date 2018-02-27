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

								<div class="input-group" id="div_product">
								</div>
							</div>
							<div class="modal-footer">
								<button type="button" class="btn btn-default"
									data-dismiss="modal" id="btn_close">关闭</button>
								<button type="button" class="btn btn-primary"
									onclick="saveProduct(this)">保存</button>
							</div>
						</div>
					</div>
				</div>

				<table class="table table-striped table-bordered"
					style="margin-top: 5px;" id="tb_product">
					<tr>
						<th>订单编号</th>
						<th>下单时间</th>
						<th>桌号</th>
						<th>订单类型</th>
						<th>操作</th>
					</tr>
				</table>
			</div>
		</div>

		<div class="panel panel-primary">
			<div class="panel-heading">历史订单</div>
			<div class="panel-body">
				<table class="table table-striped table-bordered"
					style="margin-top: 5px;" id="tb_product">
					<tr>
						<th>订单编号</th>
						<th>下单时间</th>
						<th>桌号</th>
						<th>订单类型</th>
						<th>操作</th>
					</tr>
				</table>
			</div>
		</div>
	</div>
	<%@ include file="footer.jsp"%>
	<script>
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
 				var productInfo = '';
 				$.each(products, function(index2, product){
 					if(product.categoryId == category.id){
 						productInfo += product.name + 
 						'<div class="input-group number-spinner">'+ 
 						'<span class="input-group-btn data-dwn">'+
 						'<button class="btn btn-primary" data-dir="dwn"><span class="glyphicon glyphicon-minus"></span></button>'+
 						'</span>'+
 						'<input type="text" class="form-control text-center" value="0" min="0">'+
 						'<span class="input-group-btn data-up">'+
 						'<button class="btn btn-primary" data-dir="up"><span class="glyphicon glyphicon-plus"></span></button>'+
 						'</span>'+
 						'</div>';
 					}
 				});
 				
 				$("#div_product").append(
 						'<div class="panel panel-primary" style="float: left;">'+
 						'	<div class="panel-heading">'+category.name+'</div>'+
 						'		<div class="panel-body">'+ productInfo + 
 						'		</div>'+
 						'	</div>'+
 						'</div>'+
 						'<div style="float: left;">&nbsp;</div>');
			});
 			
 			hideShade();
 		}
 	
    	$(document).ready(function(){
    	 	$("#li_order").addClass("active");
    	 	$("#li_order").siblings().removeClass("active");
    	 	
    	 	$("#btn_add").bind('click',function(){
    	 		showShade();
    	 		
    	 		$("#span_orderType").html('&nbsp;');
    	 		$("#span_deskNum").html('&nbsp;');
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
    	 	
    	 	var action;
    	    $(".number-spinner button").on('mousedown', function () {
    	        btn = $(this);
    	        input = btn.closest('.number-spinner').find('input');
    	        btn.closest('.number-spinner').find('button').prop("disabled", false);

    	    	if (btn.attr('data-dir') == 'up') {
    	            action = setInterval(function(){
    	                if ( input.attr('max') == undefined || parseInt(input.val()) < parseInt(input.attr('max')) ) {
    	                    input.val(parseInt(input.val())+1);
    	                }else{
    	                    btn.prop("disabled", true);
    	                    clearInterval(action);
    	                }
    	            }, 50);
    	    	} else {
    	            action = setInterval(function(){
    	                if ( input.attr('min') == undefined || parseInt(input.val()) > parseInt(input.attr('min')) ) {
    	                    input.val(parseInt(input.val())-1);
    	                }else{
    	                    btn.prop("disabled", true);
    	                    clearInterval(action);
    	                }
    	            }, 50);
    	    	}
    	    }).on('mouseup',function(){
    	        clearInterval(action);
    	    });
    	});
    </script>
</body>
</html>
