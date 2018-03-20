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
	<div class="masthead" style="margin-top: 5px">开发中...</div>
	<%@ include file="footer.jsp"%>
	<script>
		$(document).ready(function() {
			$("#li_his_report").addClass("active");
			$("#li_his_report").siblings().removeClass("active");
		});
	</script>
</body>
</html>
