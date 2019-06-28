<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!doctype html>
<html lang="tr" class="h-100">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="">
    <meta name="author" content="Mark Otto, Jacob Thornton, and Bootstrap contributors">
    <meta name="generator" content="Jekyll v3.8.5">
    <title>${page.title}</title>

    <link rel="canonical" href="https://getbootstrap.com/docs/4.3/examples/sticky-footer-navbar/">

    <!-- Bootstrap core CSS -->
    <link href="https://getbootstrap.com/docs/4.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
    <script src="https://ajax.googleapis.com/ajax/libs/angularjs/1.7.7/angular.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/angular-sanitize/1.7.8/angular-sanitize.js" ></script>
    <!-- Custom styles for this template -->
    <link href="${pageContext.request.contextPath}/css/simple-sidebar.css" rel="stylesheet">
    <script>
        var app = angular.module('myApp', ['ngSanitize']);
        app.controller('myAppcntrl', function ($scope, $http, $log,$location,$timeout,$window,$sce) {
            $scope.init = function(contentdata){
                $scope.myHTML =$sce.trustAsHtml(contentdata);
                $scope.alertShow=false;

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
                $timeout(function() {
                    $scope.alertShow=false;
                }, 3600);
            }

        })

    </script>

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
    </style>
    <style>
        .capitalize {
            text-transform: capitalize;
        }
        ${setting.customCss}
    </style>
    <!-- Custom styles for this template -->
    <link href="sticky-footer-navbar.css" rel="stylesheet">
</head>
<body class="d-flex flex-column h-100" ng-app="myApp" ng-controller="myAppcntrl" ng-init="init()">
<div style="height:10px;background-color: rgb(181, 37, 37); display: block;padding:5px;" class="fixed-top"></div>
<jsp:include page="theme/header.jsp" />


<!-- Begin page content -->
<main role="main" class="flex-shrink-0">
    <div class="container">
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
    </div>
    </div>
</main>

<footer class="footer mt-auto py-3">
    <div class="container">
        <span class="text-muted">Konya Teknik Üniversitesi</span>
    </div>
</footer>
<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
<script>window.jQuery || document.write('<script src="/docs/4.3/assets/js/vendor/jquery-slim.min.js"><\/script>')</script><script src="/docs/4.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-xrRywqdh3PHs8keKZN+8zzc5TX0GRTLCcmivcbNJWm2rs5C8PRhcEn3czEjhAO9o" crossorigin="anonymous"></script></body>
</html>
