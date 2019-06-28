<%--
  Created by IntelliJ IDEA.
  User: ufukunsal
  Time: 12:35
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!doctype html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="">
    <meta name="author" content="">
    <link rel="icon" href="../../../../favicon.ico">

    <title>${setting.user.unvan} ${setting.user.firstName} ${setting.user.lastName}</title>

    <link rel="canonical" href="https://getbootstrap.com/docs/4.0/examples/sticky-footer-navbar/">

    <!-- Bootstrap core CSS -->
    <link href="https://getbootstrap.com/docs/4.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
    <%@include file="style.css"%>

    </style>
    <!-- Custom styles for this template -->
    <link href="https://getbootstrap.com/docs/4.0/examples/sticky-footer-navbar/sticky-footer-navbar.css" rel="stylesheet">
</head>
<style>
    ${setting.customCss}
</style>
<body>

<header>
    <!-- Fixed navbar -->
    <nav class="navbar navbar-expand-md navbar-dark" style="background:#0088b2;margin-bottom:0px;height:42px;">
        <div class="container" style="">
        <a class="navbar-brand"  style="margin-left:0px;border-right:1px solid #000;padding-right:20px;" href="#">${setting.user.unvan} ${setting.user.firstName} ${setting.user.lastName}</a>
        <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarCollapse" aria-controls="navbarCollapse" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarCollapse">
            <ul class="navbar-nav mr-auto">
                <c:forEach items="${pages}" var="page_item" varStatus="status">
                    <c:if test = '${page_item.url=="/"}'>
                    <li class="nav-item active">
                    <a href="${setting.url}${page_item.url}" class="nav-link">${page_item.title}</a>
                    </li>
                    </c:if>
                    <c:if test = '${page_item.url!="/"}'>
                    <li class="nav-item active" style="border-left:1px solid #000;">
                        <a href="${setting.url}/pages${page_item.url}" class="nav-link">${page_item.title}</a>
                    </li>
                    </c:if>

                </c:forEach>
            </ul>

        </div>
    </div>
    </nav>
</header>

<!-- Begin page content -->
<div style="background:#fff;">

</div>
<main role="main" class="container-fluid" style="padding:0px;padding-bottom: 50px;margin-top:-0px;background:#fff;-webkit-box-shadow: 0 0 10px 1px #000; box-shadow: 0 0 10px 1px #000;">
    <div style="background: url('https://www.selcuk.edu.tr/img/desen.png');height:40px;padding: 10px;">
        <a class="capitalize" style="font-weight: bold;border-bottom:2px solid #000;">${page.title}</a>
    </div>
    <div class="row" style="padding:25px;">
        <div class="col-sm-8" style="overflow:hidden;margin-top:20px;padding: 23px;border:1px solid #ddd;min-height:1000px;margin-right:15px;">${page.contents}</div>
        <div class="col-sm-3" style="left:70px;margin-top:20px;padding: 30px;border:1px solid #ddd;min-height:1000px;background:#ddd;">
            <span class="badge badge-secondary" style="padding: 7px;font-size: 14px;font-weight:bold;padding-bottom: 15px;">${setting.user.unvan} ${setting.user.firstName} ${setting.user.lastName}<div>
            <div style="padding-top:7px;">

            <c:if test = '${setting.profilePhoto!=null}'>
                <img src=${setting.profilePhoto} height="200" width="220" class="img-rounded">
            </c:if>
            <c:if test = '${setting.profilePhoto==null}'>
                <img src="data:image/svg+xml;charset=UTF-8,%3Csvg%20width%3D%22200%22%20height%3D%22200%22%20xmlns%3D%22http%3A%2F%2Fwww.w3.org%2F2000%2Fsvg%22%20viewBox%3D%220%200%20200%20200%22%20preserveAspectRatio%3D%22none%22%3E%3Cdefs%3E%3Cstyle%20type%3D%22text%2Fcss%22%3E%23holder_16a185748c4%20text%20%7B%20fill%3Argba(255%2C255%2C255%2C.75)%3Bfont-weight%3Anormal%3Bfont-family%3AHelvetica%2C%20monospace%3Bfont-size%3A10pt%20%7D%20%3C%2Fstyle%3E%3C%2Fdefs%3E%3Cg%20id%3D%22holder_16a185748c4%22%3E%3Crect%20width%3D%22200%22%20height%3D%22200%22%20fill%3D%22%23777%22%3E%3C%2Frect%3E%3Cg%3E%3Ctext%20x%3D%2273.6015625%22%20y%3D%22104.359375%22%3E200x200%3C%2Ftext%3E%3C%2Fg%3E%3C%2Fg%3E%3C%2Fsvg%3E" class="img-rounded">
            </c:if>            </div>
            </div>
        </div>
    </div>

</main>



<!-- Bootstrap core JavaScript
================================================== -->
<!-- Placed at the end of the document so the pages load faster -->
<script src="https://code.jquery.com/jquery-3.2.1.slim.min.js" integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN" crossorigin="anonymous"></script>
<script>window.jQuery || document.write('<script src="../../assets/js/vendor/jquery-slim.min.js"><\/script>')</script>
<script src="../../assets/js/vendor/popper.min.js"></script>
<script src="../../dist/js/bootstrap.min.js"></script>
</body>
</html>
