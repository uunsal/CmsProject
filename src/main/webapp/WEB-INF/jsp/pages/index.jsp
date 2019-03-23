<%--
  Created by IntelliJ IDEA.
  User: ufukunsal
  Date: 2019-03-16
  Time: 12:35
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html lang="en">

<head>

    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="">
    <meta name="author" content="">

    <title>Simple Sidebar - Start Bootstrap Template</title>

    <!-- Bootstrap core CSS -->
    <link href="${pageContext.request.contextPath}/css/bootstrap.min.css" rel="stylesheet">
    <!-- Angular Library -->
    <script src="https://ajax.googleapis.com/ajax/libs/angularjs/1.7.7/angular.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/angular-sanitize/1.7.8/angular-sanitize.js" ></script>
    <!-- Custom styles for this template -->
    <link href="${pageContext.request.contextPath}/css/simple-sidebar.css" rel="stylesheet">
    <script>
        var app = angular.module('myApp', ['ngSanitize']);
        app.controller('myAppcntrl', function ($scope, $http, $log,$location,$timeout,$window,$sce) {
            $scope.init = function(contentdata){
                $scope.myHTML =$sce.trustAsHtml(contentdata);
            }

        })

    </script>
</head>

<body ng-app="myApp" ng-controller="myAppcntrl" ng-init="init()">

<div class="d-flex" id="wrapper">

    <!-- Sidebar -->
    <div class="bg-dark border-right" id="sidebar-wrapper">
        <div class="sidebar-heading text-light" style="">Start Bootstrap</div>
        <div class="list-group list-group-flush" style="text-align: center" >
            <a href="#" class="list-group-item list-group-item-action bg-dark text-light">Dashboard</a>
            <a href="#" class="list-group-item list-group-item-action bg-dark text-light">Shortcuts</a>
            <a href="#" class="list-group-item list-group-item-action bg-dark text-light">Overview</a>
            <a href="#" class="list-group-item list-group-item-action bg-dark text-light">Events</a>
            <a href="#" class="list-group-item list-group-item-action bg-dark text-light">Profile</a>
            <a href="#" class="list-group-item list-group-item-action bg-dark text-light">Status</a>
        </div>
    </div>
    <!-- /#sidebar-wrapper -->

    <!-- Page Content -->
    <div id="page-content-wrapper">
        ${page.title}
        <div class="container-fluid">
            ${page.contents}
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
    $("#menu-toggle").click(function(e) {
        e.preventDefault();
        $("#wrapper").toggleClass("toggled");
    });
</script>

</body>

</html>

