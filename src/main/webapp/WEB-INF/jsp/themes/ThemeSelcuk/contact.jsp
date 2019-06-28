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
    <script src="https://ajax.googleapis.com/ajax/libs/angularjs/1.7.7/angular.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/angular-sanitize/1.7.8/angular-sanitize.js" ></script>
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
<script>
    var app = angular.module('myApp', ['ngSanitize']);
    app.controller('myAppcntrl', function ($scope, $http, $log,$location,$timeout,$window,$sce) {
        $scope.init = function(contentdata){
            $scope.myHTML =$sce.trustAsHtml(contentdata);
            $scope.alertShow=false;
            $scope.yukle=false;

        }
        $scope.formu_gonder3=function(){
            if($scope.ad==""|$scope.soyad==""|$scope.email==""|$scope.mesaj==""){
                $scope.alertFunct(true,"danger","Boş alanlar olamaza..");
                return;
            }
            if($scope.ad==undefined|$scope.soyad==undefined|$scope.email==undefined|$scope.mesaj==undefined){
                $scope.alertFunct(true,"danger","Boş alanlar olamaz..");
                return;
            }
            $http({
                method: 'GET',
                url: 'emailinfo',
            }).then(function successCallback(response) {
                console.log(response.data);
                $scope.emails = response.data.mailgonderilecek;
                //alert($scope.emails)
                $scope.yukle=true;
                $scope.finals($scope.emails)
            }, function errorCallback(response) {
                console.log(response.data);
                // called asynchronously if an error occurs
                // or server returns response with an error status.
            })

        }
        $scope.finals = function (mail) {
            //alert(mail);
            $scope.data={ad:$scope.ad,soyad:$scope.soyad,email:$scope.email,mesaj:$scope.mesaj,mailgonderilecek:mail}
            $http({
                method: 'POST',
                url: '/contact/sendMail',
                data: $scope.data
            }).then(function successCallback(response) {
                $scope.alertFunct(true,"success","Mesajınız gönderildi..");
            }, function errorCallback(response) {
                console.log(response.data);
                // called asynchronously if an error occurs
                // or server returns response with an error status.
            })
        }
        $scope.alertFunct = function(gelen,type,message){
            $scope.alertContent=message;
            $scope.alert_type=type;
            $scope.alertShow=gelen;
            $scope.yukle=false;
            $timeout(function() {
                $scope.alertShow=false;
            }, 3600);
        }

    })

</script>
<body ng-app="myApp" ng-controller="myAppcntrl" ng-init="init()">

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
    <div class="container-fluid" style="padding: 40px;min-height: 700px;">
        <div ng-show="alertShow" class="alert alert-{{alert_type}} alert-dismissible fade show" role="alert">
            {{alertContent}}

        </div>
        <form style="padding: 10px;" ng-submit="formu_gonder3()">
            <div class="row" style="margin-bottom: 20px; margin-top:20px;">
                <div class="col">
                    <input type="text" ng-model="ad" class="form-control" placeholder="Adınız">
                </div>
                <div class="col">
                    <input type="text" ng-model="soyad" class="form-control" placeholder="Soyadınız">
                </div>
            </div>
            <div class="form-group">
                <label for="exampleFormControlInput1">Email addresiniz</label>
                <input ng-model="email" type="email" class="form-control" id="exampleFormControlInput1" placeholder="isim@domain.com">
            </div>
            <label for="exampleFormControlTextarea1">Göndermek İstediğiniz Mesajınız</label>
            <textarea class="form-control" ng-model="mesaj" id="exampleFormControlTextarea1" rows="5"></textarea>
            <button class="btn btn-primary" type="submit" style="margin-top: 10px;">Gönder</button>

        </form>
        <div class="loader" style="padding-left:5px;" ng-show="yukle">
            <div class="spinner-grow text-primary" role="status">
                <span class="sr-only">Loading...</span>
            </div>
            <div class="spinner-grow text-secondary" role="status">
                <span class="sr-only">Loading...</span>
            </div>
            <div class="spinner-grow text-success" role="status">
                <span class="sr-only">Loading...</span>
            </div>
            <div class="spinner-grow text-danger" role="status">
                <span class="sr-only">Loading...</span>
            </div>
            <div class="spinner-grow text-warning" role="status">
                <span class="sr-only">Loading...</span>
            </div>
            <div class="spinner-grow text-info" role="status">
                <span class="sr-only">Loading...</span>
            </div>
            <div class="spinner-grow text-light" role="status">
                <span class="sr-only">Loading...</span>
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
