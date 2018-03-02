<!DOCTYPE html>
<html lang="zh-CN">
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->
<meta name="description" content="">
<meta name="author" content="">
<link rel="icon" href="../../favicon.ico">
<title>登陆</title>
<link rel="stylesheet"
	href="https://cdn.bootcss.com/bootstrap/3.3.7/css/bootstrap.min.css"
	integrity="sha384-BVYiiSIFeK1dGmJRAkycuHAHRg32OmUcww7on3RYdg4Va+PmSTsz/K68vbdEjh4u"
	crossorigin="anonymous">
<link href="css/signin.css" rel="stylesheet">
<script src="https://cdn.bootcss.com/jquery/1.12.4/jquery.min.js"></script>
<script
	src="https://cdn.bootcss.com/bootstrap/3.3.7/js/bootstrap.min.js"
	integrity="sha384-Tc5IQib027qvyjSMfHjOMaLkfuWVxZxUPnCJA7l2mCWNIpG9mGCD8wGNIcPD7Txa"
	crossorigin="anonymous"></script>
<script src="js/md5.js" type="text/javascript"></script>
<script src="js/base64.js" type="text/javascript"></script>
<script>
    	function login(){
    		var b = new Base64();
    		var account = b.encode($("#inputAccount").val());
    		var password = b.encode(hex_md5($("#inputPassword").val()));
    		var result = false;
    		$.ajax({
    			url: '<%=request.getContextPath()%>/login/login.do',
			data : {
				'account' : account,
				'password' : password
			},
			async : false,
			cache : false,
			type : 'POST',
			success : function(data) {
				if (data.status == 0) {
					result = true;
				} else {
					alert('用户名或密码错误');
					result = false;
				}
			},
			error : function() {
				alert('登陆失败');
				result = false;
			}
		});
		return result;
	}
</script>
</head>
<body>
	<div class="container">
		<form class="form-signin" id="form1" onsubmit="return login()"
			action="<%=request.getContextPath()%>/order.jsp" method="post">
			<h2 class="form-signin-heading">王牌大肉串</h2>
			<label for="inputAccount" class="sr-only">账号</label> <input
				type="text" id="inputAccount" class="form-control" placeholder="账号"
				required autofocus style='margin-bottom: 10px;'> <label
				for="inputPassword" class="sr-only">密码</label> <input
				type="password" id="inputPassword" class="form-control"
				placeholder="密码" required>
			<div class="checkbox">
				<label> <input type="checkbox" value="remember-me">
					记住我
				</label>
			</div>
			<button class="btn btn-lg btn-primary btn-block" type="submit">登录</button>
		</form>
	</div>
</body>
</html>
