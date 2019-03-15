<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>网站后台内容管理系统登录登陆界面</title>
<meta name="keywords" content="后台登陆页面模板,后台登录界面html,后台登录模板,后台登录页面html,后台管理系统后台登录模板">
<meta name="viewport" content="width=device-width">
<link href="public/css/base.css" rel="stylesheet" type="text/css">
<link href="public/css/login.css" rel="stylesheet" type="text/css">
</head>
<body>

<div class="login">
<form action="check.php" method="post" id="form">
	<div class="logo"></div>
    <div class="login_form">
    	<div class="user">
        	<input class="text_value" value="" name="username" type="text" id="username">
            <input class="text_value" value="" name="password" type="password" id="password">
        </div>
        <button class="button" id="submit" type="submit">登录</button>
    </div>
    
    <div id="tip"></div>
    </form>
</div>
</body>
</html>
