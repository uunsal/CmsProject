<%--
  Created by IntelliJ IDEA.
  User: ufukunsal
  Date: 2019-03-16
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

    <title>Sticky Footer Navbar Template for Bootstrap</title>

    <link rel="canonical" href="https://getbootstrap.com/docs/4.0/examples/sticky-footer-navbar/">

    <!-- Bootstrap core CSS -->
    <link href="https://getbootstrap.com/docs/4.0/dist/css/bootstrap.min.css" rel="stylesheet">

    <!-- Custom styles for this template -->
    <link href="https://getbootstrap.com/docs/4.0/examples/sticky-footer-navbar/sticky-footer-navbar.css" rel="stylesheet">
</head>
<style>
    ${setting.customCss}
</style>
<body>

<header>
    <!-- Fixed navbar -->
    <nav class="navbar navbar-expand-md navbar-dark fixed-top bg-secondary">
        <div class="container">
        <a class="navbar-brand" href="#">Başlık</a>
        <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarCollapse" aria-controls="navbarCollapse" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarCollapse">
            <ul class="navbar-nav mr-auto">
                <c:forEach items="${pages}" var="page_item" varStatus="status">
                    <c:if test = '${page_item.url=="/"}'>
                    <li class="nav-item active">
                    <a href="${pageContext.request.contextPath}${page_item.url}" class="nav-link">${page_item.title}</a>
                    </li>
                    </c:if>
                    <c:if test = '${page_item.url!="/"}'>
                    <li class="nav-item">
                        <a href="${pageContext.request.contextPath}/pages${page_item.url}" class="nav-link">${page_item.title}</a>
                    </li>
                    </c:if>

                </c:forEach>
            </ul>

        </div>
    </div>
    </nav>
</header>

<!-- Begin page content -->

<main role="main" class="container" style="padding-bottom: 50px;">
    <div style="margin-top: 20px;">
    <a class="capitalize" style="font-weight: bold;"><span class="badge badge-secondary" style="font-size:17px;"> ${page.title}</span></a>
    </div>
    <div class="row" style="">
        <div class="col-sm-8" style="margin-top:20px;padding: 30px;border:1px solid #ddd;min-height:1000px;margin-right:15px;">${page.contents}</div>
        <div class="col-sm-3" style="margin-top:20px;padding: 30px;border:1px solid #ddd;min-height:1000px;">
            <div style=""><img src="data:image/svg+xml;charset=UTF-8,%3Csvg%20width%3D%22200%22%20height%3D%22200%22%20xmlns%3D%22http%3A%2F%2Fwww.w3.org%2F2000%2Fsvg%22%20viewBox%3D%220%200%20200%20200%22%20preserveAspectRatio%3D%22none%22%3E%3Cdefs%3E%3Cstyle%20type%3D%22text%2Fcss%22%3E%23holder_16a185748c4%20text%20%7B%20fill%3Argba(255%2C255%2C255%2C.75)%3Bfont-weight%3Anormal%3Bfont-family%3AHelvetica%2C%20monospace%3Bfont-size%3A10pt%20%7D%20%3C%2Fstyle%3E%3C%2Fdefs%3E%3Cg%20id%3D%22holder_16a185748c4%22%3E%3Crect%20width%3D%22200%22%20height%3D%22200%22%20fill%3D%22%23777%22%3E%3C%2Frect%3E%3Cg%3E%3Ctext%20x%3D%2273.6015625%22%20y%3D%22104.359375%22%3E200x200%3C%2Ftext%3E%3C%2Fg%3E%3C%2Fg%3E%3C%2Fsvg%3E" class="img-rounded"></div>
        </div>
    </div>

</main>

<footer class="footer">
    <div class="container">
        <span class="text-muted">Alt Menü.</span>
    </div>
</footer>

<!-- Bootstrap core JavaScript
================================================== -->
<!-- Placed at the end of the document so the pages load faster -->
<script src="https://code.jquery.com/jquery-3.2.1.slim.min.js" integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN" crossorigin="anonymous"></script>
<script>window.jQuery || document.write('<script src="../../assets/js/vendor/jquery-slim.min.js"><\/script>')</script>
<script src="../../assets/js/vendor/popper.min.js"></script>
<script src="../../dist/js/bootstrap.min.js"></script>
</body>
</html>
