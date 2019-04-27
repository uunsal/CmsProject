<%--
  Created by IntelliJ IDEA.
  User: ufukunsal
  Date: 2019-04-25
  Time: 19:24
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="en">

<head>

    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="">
    <meta name="author" content="">

    <title>${page.title}</title>

    <!-- Bootstrap core CSS -->
    <link href="${pageContext.request.contextPath}/css/bootstrap.min.css" rel="stylesheet">
    <!-- Angular Library -->
    <script src="https://ajax.googleapis.com/ajax/libs/angularjs/1.7.7/angular.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/angular-sanitize/1.7.8/angular-sanitize.js"></script>
    <!-- Custom styles for this template -->
    <link href="${pageContext.request.contextPath}/css/simple-sidebar.css" rel="stylesheet">
    <script>
        var app = angular.module('myApp', ['ngSanitize']);
        app.controller('myAppcntrl', function ($scope, $http, $log, $location, $timeout, $window, $sce) {
            $scope.init = function (contentdata) {
                $scope.myHTML = $sce.trustAsHtml(contentdata);
            }

        })

    </script>

    <style>
        .capitalize {
            text-transform: capitalize;
        }

        ${setting.customCss}
    </style>
</head>

<body ng-app="myApp" ng-controller="myAppcntrl" ng-init="init()">

<div class="d-flex" id="wrapper">

    <!-- Sidebar -->
    <div class="bg-dark border-right" id="sidebar-wrapper">
        <div class="sidebar-heading text-light" style="">Başlık</div>
        <div class="text-center" style="margin-bottom: 20px;"><img
                src="data:image/svg+xml;charset=UTF-8,%3Csvg%20width%3D%22200%22%20height%3D%22200%22%20xmlns%3D%22http%3A%2F%2Fwww.w3.org%2F2000%2Fsvg%22%20viewBox%3D%220%200%20200%20200%22%20preserveAspectRatio%3D%22none%22%3E%3Cdefs%3E%3Cstyle%20type%3D%22text%2Fcss%22%3E%23holder_16a185748c4%20text%20%7B%20fill%3Argba(255%2C255%2C255%2C.75)%3Bfont-weight%3Anormal%3Bfont-family%3AHelvetica%2C%20monospace%3Bfont-size%3A10pt%20%7D%20%3C%2Fstyle%3E%3C%2Fdefs%3E%3Cg%20id%3D%22holder_16a185748c4%22%3E%3Crect%20width%3D%22200%22%20height%3D%22200%22%20fill%3D%22%23777%22%3E%3C%2Frect%3E%3Cg%3E%3Ctext%20x%3D%2273.6015625%22%20y%3D%22104.359375%22%3E200x200%3C%2Ftext%3E%3C%2Fg%3E%3C%2Fg%3E%3C%2Fsvg%3E"
                class="rounded-circle img-thumbnail"></div>
        <div class="list-group list-group-flush" style="text-align: center">
            <c:forEach items="${pages}" var="page_item" varStatus="status">
                <c:if test='${page_item.url=="/"}'>
                    <a href="${pageContext.request.contextPath}${page_item.url}"
                       class="list-group-item list-group-item-action bg-dark text-light capitalize">${page_item.title}</a>
                </c:if>
                <c:if test='${page_item.url!="/"}'>
                    <a href="${pageContext.request.contextPath}/pages${page_item.url}"
                       class="list-group-item list-group-item-action bg-dark text-light capitalize">${page_item.title}</a>
                </c:if>

            </c:forEach>


        </div>
    </div>
    <!-- /#sidebar-wrapper -->

    <!-- Page Content -->
    <div id="page-content-wrapper">

        <nav class="navbar navbar-expand-lg navbar-light bg-light border-bottom">
            <a class="capitalize" style="font-weight: bold;"><span class="badge badge-secondary"
                                                                   style="font-size:17px;"> ${page.title}</span></a>
        </nav>

        <div class="container-fluid" style="padding: 40px;">
            ${page.contents}
            <c:forEach items="${blogs}" var="blog">
                <div style="margin-bottom: 50px; " class="card">
                    <h5 class="card-header">${blog.title}</h5>
                    <div class="card-body">
                        <p class="card-text" style="margin-top: -22px">${blog.content}</p>
                        <a href="#" class="btn btn-secondary">Devamını okuyun</a>
                    </div>
                </div>
            </c:forEach>

            <nav aria-label="Page navigation example">
                <ul class="pagination justify-content-center">
                    <li class="page-item disabled">
                        <a class="page-link" href="#" tabindex="-1" aria-disabled="true">Geri</a>
                    </li>
                    <c:forEach var = "i" begin = "0" end = "${pagenumbers}" >
                        <li class="page-item"><a class="page-link" href="${pageContext.request.contextPath}/pages${page.url}/${i}">${i+1}</a></li>
                    </c:forEach>
                    <li class="page-item">
                        <a class="page-link" href="#">İleri</a>
                    </li>
                </ul>
            </nav>
        </div>
    </div>
    <!-- /#page-content-wrapper -->

</div>
<!-- /#wrapper -->

<!-- Bootstrap core JavaScript -->
<script src="${pageContext.request.contextPath}/vendor/jquery/jquery.min.js"></script>
<script src="${pageContext.request.contextPath}/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>

<!-- Menu Toggle Script -->
<script>
    $("#menu-toggle").click(function (e) {
        e.preventDefault();
        $("#wrapper").toggleClass("toggled");
    });
</script>

</body>

</html>

