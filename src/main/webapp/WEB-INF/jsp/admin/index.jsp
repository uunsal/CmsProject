<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="baseURL" value="${pageContext.request.contextPath}"/>

<!doctype html>
<html lang="tr">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="">
    <meta name="author" content="Mark Otto, Jacob Thornton, and Bootstrap contributors">
    <meta name="generator" content="Jekyll v3.8.5">
    <title>Dashboard</title>

    <!-- Bootstrap core CSS -->
    <link href="${pageContext.request.contextPath}/css/bootstrap.min.css"  rel="stylesheet" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">


    <style>
        .bd-placeholder-img {
            font-size: 1.125rem;
            text-anchor: middle;
            -webkit-user-select: none;
            -moz-user-select: none;
            -ms-user-select: none;
            user-select: none;
        }

        @media (min-width: 768px) {
            .bd-placeholder-img-lg {
                font-size: 3.5rem;
            }
        }

        .bg-purple {
            background-color: #b52525;
        }
    </style>
    <!-- Custom styles for this template -->
    <link href="${pageContext.request.contextPath}/css/dashboard.css" rel="stylesheet">
</head>
<body>
<!-- Ust Menu -->
<jsp:include page="theme/header.jsp" />

<div class="container-fluid">
    <div class="row">
        <!-- Yan Menu -->
        <jsp:include page="theme/sidebar.jsp" />

        <main role="main" class="col-md-9 ml-sm-auto col-lg-10 px-4">
            <div class="d-flex justify-content-between flex-wrap flex-md-nowrap align-items-center pt-3 pb-2 mb-3 border-bottom">
                <h1 class="h2">Ana Sayfa</h1>
                <div class="btn-toolbar mb-2 mb-md-0">
                    <div class="btn-group mr-2">
                        <button type="button" class="btn btn-sm btn-outline-secondary">menu1</button>
                        <button type="button" class="btn btn-sm btn-outline-secondary">menu2</button>
                    </div>
                    <button type="button" class="btn btn-sm btn-outline-secondary dropdown-toggle">
                        <span data-feather="calendar"></span>
                        menu3
                    </button>
                </div>
            </div>
            <div class="d-flex align-items-center p-3 my-3 text-white-50 bg-purple rounded shadow-sm">
                <img class="mr-3 bg-light" src="http://ktun.edu.tr/Content/images/logo/logo3.png" alt="" width="158" height="48">
                <div class="lh-100">
                    <h6 class="mb-0 text-white lh-100">Hoşgeldiniz ${user}</h6>
                    <small>Konya Teknik Üniversitesi Web Sayfaları Yönetim Sistemi</small>
                </div>
            </div>
            <div class="container" style="padding:10px;">
                <div class="row">
                    <div class="col-sm" style="background: #efefef;height: 200px; text-align: center;font-weight:bold;padding-top: 20px;border-bottom: 3px solid #a00;">Sayfalarım<br><div style="color:#2c6ed5;margin-top:20px;font-weight: normal;font-weight: bold;font-size: xx-large;border: 3px solid #ffffff;">${pinfo}</div><br>
                        <a class="nav-link" href="${pageContext.request.contextPath}/admin/pages">
                            <span data-feather="file"></span>
                            Yeni Sayfa Ekle
                        </a>
                    </div>
                    <div class="col-sm" style="background: #ffffff;height: 200px; text-align: center;font-weight:bold;padding-top: 20px;border-bottom: 3px solid #ddd;">Geçerli Tasarım<br>
                        <div style="color:#2c6ed5;margin-top:20px;font-weight: normal;font-weight: bold;font-size: x-large;border: 3px solid #efefef;height: 53px;padding-top: 4px;">${tinfo}</div><br>
                        <a class="nav-link" href="${pageContext.request.contextPath}/admin/design">
                            <span data-feather="eye"></span>
                            Tasarım İşlemleri
                        </a>
                    </div>
                    <div class="col-sm" style="background: #efefef;height: 200px; text-align: center;font-weight:bold;padding-top: 20px;border-bottom: 3px solid #a00;">Yazılarım</div>
                </div>
            </div>
        </main>
    </div>
</div>
<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
<script>window.jQuery || document.write('<script src="/docs/4.3/assets/js/vendor/jquery-slim.min.js"><\/script>')</script><script src="/docs/4.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-xrRywqdh3PHs8keKZN+8zzc5TX0GRTLCcmivcbNJWm2rs5C8PRhcEn3czEjhAO9o" crossorigin="anonymous"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/feather-icons/4.9.0/feather.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.7.3/Chart.min.js"></script>
<script src="https://getbootstrap.com/docs/4.3/examples/dashboard/dashboard.js"></script></body>
</html>
