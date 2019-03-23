<%--
  Created by IntelliJ IDEA.
  User: ufukunsal
  Date: 2019-03-15
  Time: 17:06
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html lang="tr">
<head>
    <title>Yönetici Paneli</title>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <link rel="icon" type="image/png" href="images/icons/favicon.ico" />

    <link rel="stylesheet" type="text/css" href="https://colorlib.com/etc/lf/Login_v15/vendor/bootstrap/css/bootstrap.min.css">

    <link rel="stylesheet" type="text/css" href="https://colorlib.com/etc/lf/Login_v15/fonts/font-awesome-4.7.0/css/font-awesome.min.css">

    <link rel="stylesheet" type="text/css" href="https://colorlib.com/etc/lf/Login_v15/fonts/Linearicons-Free-v1.0.0/icon-font.min.css">

    <link rel="stylesheet" type="text/css" href="https://colorlib.com/etc/lf/Login_v15/vendor/animate/animate.css">

    <link rel="stylesheet" type="text/css" href="https://colorlib.com/etc/lf/Login_v15/endor/css-hamburgers/hamburgers.min.css">

    <link rel="stylesheet" type="text/css" href="https://colorlib.com/etc/lf/Login_v15/vendor/animsition/css/animsition.min.css">

    <link rel="stylesheet" type="text/css" href="https://colorlib.com/etc/lf/Login_v15/vendor/select2/select2.min.css">

    <link rel="stylesheet" type="text/css" href="https://colorlib.com/etc/lf/Login_v15/vendor/daterangepicker/daterangepicker.css">

    <link rel="stylesheet" type="text/css" href="https://colorlib.com/etc/lf/Login_v15/css/util.css">
    <link rel="stylesheet" type="text/css" href="https://colorlib.com/etc/lf/Login_v15/css/main.css">
    <style>
        .login100-form-title::before{
            background-color: #222222;
        }
    </style>

</head>
<body>
<div class="limiter">
    <div class="container-login100">
        <div class="wrap-login100">
            <div class="login100-form-title" style="height:100px;background:#222222;">
<span class="login100-form-title-1">
Yönetici Paneli
</span>
            </div>
            <center style="margin-top: 10px">
            <font color="red"><c:if test="${not empty param.loginFailed}">
                <c:out value="Kullanıcı adınız veya şifreniz yanlış.."></c:out>
            </c:if>
            </font>
            </center>
            <form class="user login100-form validate-form" action="login" method="post">
                <div class="wrap-input100 validate-input m-b-26" data-validate="Kullanıcı adı alanı boş olamaz">
                    <span class="label-input100">Kullanıcı Adı</span>
                    <input class="input100" type="text" name="username" placeholder="Kullanıcı adınızı giriniz">
                    <span class="focus-input100"></span>
                </div>
                <div class="wrap-input100 validate-input m-b-18" data-validate="Parola alanı boş olamaz">
                    <span class="label-input100">Şifre</span>
                    <input class="input100" type="password" name="password" placeholder="Şifrenizi giriniz">
                    <span class="focus-input100"></span>
                </div>
                <div class="flex-sb-m w-full p-b-30">
                    <div class="contact100-form-checkbox">
                        <input class="input-checkbox100" id="ckb1" type="checkbox" name="remember-me">
                        <label class="label-checkbox100" for="ckb1">
                            Beni Hatırla
                        </label>
                    </div>
                    <div>
                        <a href="#" class="txt1">
                            Şifremi Unuttum?
                        </a>
                    </div>
                </div>
                <div class="container-login100-form-btn">
                    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
                    <input class="login100-form-btn" type="submit" value="Giriş">
                </div>
            </form>
        </div>
    </div>
</div>

<script src="https://colorlib.com/etc/lf/Login_v15/vendor/jquery/jquery-3.2.1.min.js" type="ed2dede3aad463c66a28c7ba-text/javascript"></script>

<script src="https://colorlib.com/etc/lf/Login_v15/vendor/animsition/js/animsition.min.js" type="ed2dede3aad463c66a28c7ba-text/javascript"></script>

<script src="https://colorlib.com/etc/lf/Login_v15/vendor/bootstrap/js/popper.js" type="ed2dede3aad463c66a28c7ba-text/javascript"></script>
<script src="https://colorlib.com/etc/lf/Login_v15/vendor/bootstrap/js/bootstrap.min.js" type="ed2dede3aad463c66a28c7ba-text/javascript"></script>

<script src="https://colorlib.com/etc/lf/Login_v15/vendor/select2/select2.min.js" type="ed2dede3aad463c66a28c7ba-text/javascript"></script>

<script src="https://colorlib.com/etc/lf/Login_v15/vendor/daterangepicker/moment.min.js" type="ed2dede3aad463c66a28c7ba-text/javascript"></script>
<script src="https://colorlib.com/etc/lf/Login_v15/vendor/daterangepicker/daterangepicker.js" type="ed2dede3aad463c66a28c7ba-text/javascript"></script>

<script src="https://colorlib.com/etc/lf/Login_v15/vendor/countdowntime/countdowntime.js" type="ed2dede3aad463c66a28c7ba-text/javascript"></script>

<script src="https://colorlib.com/etc/lf/Login_v15/js/main.js" type="ed2dede3aad463c66a28c7ba-text/javascript"></script>

<script async src="https://www.googletagmanager.com/gtag/js?id=UA-23581568-13" type="ed2dede3aad463c66a28c7ba-text/javascript"></script>
<script type="ed2dede3aad463c66a28c7ba-text/javascript">
	  window.dataLayer = window.dataLayer || [];
	  function gtag(){dataLayer.push(arguments);}
	  gtag('js', new Date());

	  gtag('config', 'UA-23581568-13');
	</script>
<script src="https://ajax.cloudflare.com/cdn-cgi/scripts/a2bd7673/cloudflare-static/rocket-loader.min.js" data-cf-settings="ed2dede3aad463c66a28c7ba-|49" defer=""></script></body>
</html>

