<!DOCTYPE html>
<html lang="zh-CN">
<head>
	<meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="https://cdn.bootcss.com/bootstrap/3.3.7/css/bootstrap.min.css" integrity="sha384-BVYiiSIFeK1dGmJRAkycuHAHRg32OmUcww7on3RYdg4Va+PmSTsz/K68vbdEjh4u" crossorigin="anonymous">
    <style>
    	.input-group{
    		margin-bottom: 10px
    	}
    </style>
 </head>
 <body>
	 <%@ include file="head.jsp" %>
	 <div class="container" style="margin-top: 5px">
	 	<div class="masthead">
		 	<!-- Button trigger modal -->
			<button type="button" class="btn btn-primary btn-lg" data-toggle="modal" data-target="#myModal" id="btn_add">
			 添加
			</button>
			
			<!-- Modal -->
			<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
			  <div class="modal-dialog" role="document">
			    <div class="modal-content">
			      <div class="modal-header">
			        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
			        <h4 class="modal-title" id="myModalLabel">添加商品</h4>
			      </div>
			      <div class="modal-body">
			      	<div class="input-group">
  						<input type="text" class="form-control" placeholder="商品名称" aria-describedby="basic-addon1" id="input_name" required>
					</div>
					
					<div class="input-group">
						<input type="text" class="form-control" placeholder="价格" aria-describedby="basic-addon1" id="input_price" required>
					</div>
					
					<div class="input-group">
						<div class="dropdown">
  							<button class="btn btn-default dropdown-toggle" type="button" id="dropdownMenu1" data-toggle="dropdown" aria-haspopup="true" aria-expanded="true">
  								商品类别
    							<span class="caret"></span>
  							</button>
							<ul class="dropdown-menu" aria-labelledby="dropdownMenu1" id="ul_category">
							</ul>
						</div>
						<h4><span class="label label-default" id="span_category"></span></h4>
						<input type="hidden" id="hidden_category_id" />
					</div>
			      </div>
			      
			      <div class="modal-footer">
			        <button type="button" class="btn btn-default" data-dismiss="modal" id="btn_close">关闭</button>
			        <button type="button" class="btn btn-primary" onclick="saveProduct(this)">保存</button>
			      </div>
			    </div>
			  </div>
			</div>
			
			<!-- Button trigger modal -->
			<button type="button" class="btn btn-primary btn-lg" data-toggle="modal" data-target="#myModal3" id="btn_modify" style="display: none;"></button>
			<!-- Modal -->
			<div class="modal fade" id="myModal3" tabindex="-1" role="dialog" aria-labelledby="myModalLabel1">
			  <div class="modal-dialog" role="document">
			    <div class="modal-content">
			      <div class="modal-header">
			        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
			        <h4 class="modal-title" id="myModalLabel1">修改商品</h4>
			      </div>
			      <div class="modal-body">
			      	<div class="input-group">
  						<input type="text" class="form-control" placeholder="商品名称" aria-describedby="basic-addon1" id="modify_input_name" required>
					</div>
					
					<div class="input-group">
						<input type="text" class="form-control" placeholder="价格" aria-describedby="basic-addon1" id="modify_input_price" required>
					</div>
					
					<div class="input-group">
						<div class="dropdown">
  							<button class="btn btn-default dropdown-toggle" type="button" id="dropdownMenu3" data-toggle="dropdown" aria-haspopup="true" aria-expanded="true">
  								商品类别
    							<span class="caret"></span>
  							</button>
							<ul class="dropdown-menu" aria-labelledby="dropdownMenu3" id="modify_ul_category">
							</ul>
						</div>
						<h4><span class="label label-default" id="modify_span_category"></span></h4>
						<input type="hidden" id="modify_hidden_category_id" />
						<input type="hidden" id="modify_hidden_product_id" />
					</div>
			      </div>
			      
			      <div class="modal-footer">
			        <button type="button" class="btn btn-default" data-dismiss="modal" id="modify_btn_close">关闭</button>
			        <button type="button" class="btn btn-primary" onclick="updateProduct(this)">保存</button>
			      </div>
			    </div>
			  </div>
			</div>
			
			<!-- 遮罩层 -->
			<button type="button" class="btn btn-primary btn-lg" data-toggle="modal" data-target="#myModal2" id="btn_zhezhao" style="display: none;"></button>
			
			<!-- Modal -->
			<div class="modal fade" id="myModal2" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
			  <div class="modal-dialog" role="document">
			    <div class="modal-content">
			      <div class="modal-body">
			      	加载中...<button type="button" class="btn btn-default" data-dismiss="modal" id="btn_close_zhezhao" style="display: none;"></button>
			      </div>
			    </div>
			  </div>
			</div>
		 	
		 	<table class="table table-striped table-bordered" style="margin-top: 5px" id="tb_product">
		 		<thead>
		 			<th>名称</th><th>价格</th><th>所属类别</th><th>操作</th>
		 		</thead>
		 	</table>
		 	<nav aria-label="Page navigation">
			  <ul id="ul_pager" class="pagination" style="margin: -5px 0; display: none">
			  </ul>
			</nav>
		</div>
	</div>
 	<%@ include file="footer.jsp" %>
 	<script>
 		var currPage = 1;
 		var pageSize = 15;
 		var startPage = 1;
 		var endPage = 10;
 		var totalPage = 0;
 	
 		function saveProduct(obj){
 			$(obj).attr("disabled","disabled");

 			var name = $("#input_name").val();
 			var price = $("#input_price").val();
 			var categoryId = $("#hidden_category_id").val();
 			if(name == ''){
 				alert('请输入名称');
 				$(obj).removeAttr("disabled");
 				return;
 			}
 			if(price == ''){
 				alert('请输入价格');
 				$(obj).removeAttr("disabled");
 				return;
 			}
 			if(categoryId == ''){
 				alert('请选择类别');
 				$(obj).removeAttr("disabled");
 				return;
 			}
 			
 			$.ajax({
    			url: '<%=request.getContextPath()%>/product/add.do',
    			async: false,
    			cache: false,
    			type: 'post',
    			data: {'name': name, 'price': price, 'categoryId': categoryId},
    			success: function(data){
    				if (data.status == 0) {
    					$(obj).removeAttr("disabled");
    					$('#btn_close').click();
    					goPager(1);
    				} else {
    					alert(data.msg);
    					$(obj).removeAttr("disabled");
    				}
    			},
    			error: function(){
    				alert('添加失败');
    				$(obj).removeAttr("disabled");
    			}
    		});
 		}
 		
 		function updateProduct(obj){
 			$(obj).attr("disabled","disabled");

 			var name = $("#modify_input_name").val();
 			var price = $("#modify_input_price").val();
 			var categoryId = $("#modify_hidden_category_id").val();
 			var productId = $("#modify_hidden_product_id").val();
 			if(name == ''){
 				alert('请输入名称');
 				$(obj).removeAttr("disabled");
 				return;
 			}
 			if(price == ''){
 				alert('请输入价格');
 				$(obj).removeAttr("disabled");
 				return;
 			}
 			if(categoryId == ''){
 				alert('请选择类别');
 				$(obj).removeAttr("disabled");
 				return;
 			}
 			
 			$.ajax({
    			url: '<%=request.getContextPath()%>/product/update.do',
    			async: false,
    			cache: false,
    			type: 'post',
    			data: {'name': name, 'price': price, 'categoryId': categoryId, 'id': productId},
    			success: function(data){
    				if (data.status == 0) {
    					$(obj).removeAttr("disabled");
    					$('#modify_btn_close').click();
    					goPager(1);
    				} else {
    					alert(data.msg);
    					$(obj).removeAttr("disabled");
    				}
    			},
    			error: function(){
    				alert('添加失败');
    				$(obj).removeAttr("disabled");
    			}
    		});
 		}
 		
 		function modifyProduct(id){
 			$("#btn_zhezhao").click();
 			$("#modify_input_name").val('');
 			$("#modify_input_price").val('');
 			$("#modify_hidden_category_id").val('');
 			$("#modify_span_category").html('');
 			$("#modify_ul_category").empty();
 			$("#modify_hidden_product_id").val(id);
 			
 			$.ajax({
    			url: '<%=request.getContextPath()%>/product/find.do?id=' + id,
    			async: false,
    			cache: false,
    			type: 'get',
    			success: function(data){
    				if (data.status == 0) {
    					$("#btn_close_zhezhao").click();
    					$("#btn_modify").click();
    					$("#modify_input_name").val(data.data.name);
    					$("#modify_input_price").val(data.data.price);
    					
    					loadCategoryForModify(data.data.categoryId);
    				} else {
    					alert(data.msg);
    					$("#btn_close_zhezhao").click();
    				}
    			},
    			error: function(){
    				alert('获取失败');
    				$("#btn_close_zhezhao").click();
    			}
    		});
 			
 		}
 	
 		function delProduct(productId){
 			if(confirm('确认删除')){
 				$.ajax({
 	    			url: '<%=request.getContextPath()%>/product/delProduct.do',
 	    			async: true,
 	    			cache: false,
 	    			type: 'post',
 	    			data: {'productId': productId},
 	    			success: function(data){
 	    				if (data.status == 0) {
 	    					goPager(1);
 	    				} else {
 	    					alert(data.msg);
 	    				}
 	    			},
 	    			error: function(){
 	    				alert('删除失败');
 	    			}
 	    		});
 			}
 		}
 	
 		function loadData(){
 			$("#btn_zhezhao").click();
 			$.ajax({
    			url: '<%=request.getContextPath()%>/product/list.do?currPage=' + currPage + '&pageSize=' + pageSize,
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
    					
    					$("#tb_product").find('tbody').find('tr').remove();
    					$.each(data.data.data, function(index, value){
    						$("#tb_product").append('<tr><td>' + value.name + '</td><td>' + value.price + '</td><td>' + value.categoryName + '</td><td><a href=\'#\' onclick=\'modifyProduct(' + value.id + ')\'>修改</a>&nbsp;<a href=\'#\' onclick=\'delProduct(' + value.id + ')\'>删除</a></td></tr>');
    					});
    					
    				} else {
    					alert('查询失败');
    				}
    				
    				$("#btn_close_zhezhao").click();
    			},
    			error: function(){
    				alert('查询失败');
    				$("#btn_close_zhezhao").click();
    			}
    		});
 		}
 		
 		function goPager(targetPage){
 			if(targetPage>=1&&targetPage<=totalPage){
 				currPage = targetPage;
 				loadData();
 			}else if(targetPage == 1 && totalPage == 0){
 				currPage = 1;
 				loadData();
 			}
 		}
 		
 		function loadCategory(){
 			$.ajax({
    			url: '<%=request.getContextPath()%>/category/list.do',
    			async: true,
    			cache: false,
    			type: 'get',
    			success: function(data){
    				if (data.status == 0) {
    					$("#ul_category").empty();
    					$.each(data.data, function(index, value){
    						$("#ul_category").append('<li><a href="#" onclick="choseCategory(' + value.id + ', \'' + value.name + '\')">'+value.name+'</a></li>');
    					});
    				} else {
    					alert('获取失败');
    				}
    			},
    			error: function(){
    				alert('获取失败');
    			}
    		});
 		}
 		
 		function loadCategoryForModify(categoryId){
 			$.ajax({
    			url: '<%=request.getContextPath()%>/category/list.do',
    			async: true,
    			cache: false,
    			type: 'get',
    			success: function(data){
    				if (data.status == 0) {
    					$.each(data.data, function(index, value){
    						$("#modify_ul_category").append('<li><a href="#" onclick="choseCategoryForModify(' + value.id + ', \'' + value.name + '\')">'+value.name+'</a></li>');
    						if(value.id == categoryId){
    							$("#modify_span_category").html(value.name);    							
    						}
    					});
    					
    					$("#modify_hidden_category_id").val(categoryId);
    				} else {
    					alert('获取失败');
    				}
    			},
    			error: function(){
    				alert('获取失败');
    			}
    		});
 		}
 		
 		function choseCategory(id, name){
 			$("#span_category").html(name);
 			$("#hidden_category_id").val(id);
 		}
 		
 		function choseCategoryForModify(id, name){
 			$("#modify_span_category").html(name);
 			$("#modify_hidden_category_id").val(id);
 		}
 		
    	$(document).ready(function(){
    	 	$("#li_product").addClass("active");
    	 	$("#li_product").siblings().removeClass("active");
    	 	loadData();
    	 	
    	 	$("#btn_add").bind('click',function(){
    	 		//获取类别信息
    	 		$("#input_name").val('');
 				$("#input_price").val('');
    	 		$("#span_category").html('');
    	 		$("#hidden_category_id").val('');
    	 		loadCategory();
    	 	});
    	});
    </script>
 </body>
</html>
