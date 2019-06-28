<%--
  Created by IntelliJ IDEA.
  User: ufuk
  Date: 2019-05-27
  Time: 18:14
  To change this template use File | Settings | File Templates.
--%>
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
    <script src="https://ajax.googleapis.com/ajax/libs/angularjs/1.7.7/angular.min.js"></script>


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

    <script>
        var app = angular.module('myApp', []);
        app.controller('myAppcntrl', function ($scope, $http, $log,$location,$timeout,$window) {
            $scope.init = function () {
                $http({
                    method: 'GET',
                    url: 'dashboard/settingsinit',
                }).then(function successCallback(response) {
                    $scope.settings = response.data;
                    $scope.check_fl=false;
                    $scope.check_e = false;
                    $scope.mails = response.data.user.email;
                    $scope.fname = response.data.user.firstName;
                    $scope.lname = response.data.user.lastName;
                    $scope.bcount = response.blogcount;

                }, function errorCallback(response) {
                    // called asynchronously if an error occurs
                    // or server returns response with an error status.
                    console.log(response.data);

                })
            }

            $scope.but1 = function () {
                if($scope.passwd=="" || $scope.passwd == undefined){
                    $scope.alertFunct(true,"danger","parolanız  boş olamaz..");
                    return;
                }
                $http({
                    method: 'POST',
                    url: 'dashboard/updatepass',
                    data: {password:$scope.passwd}
                }).then(function successCallback(response) {
                    //$scope.person=response.data;
                    $scope.alertFunct(true,"success","Parolanız Güncellendi..");

                }, function errorCallback(response) {
                    // called asynchronously if an error occurs
                    // or server returns response with an error status.
                })
            }

            $scope.but2 = function () {
                if($scope.lname=="" || $scope.fname==""||$scope.fname==undefined||$scope.lname == undefined){
                    $scope.alertFunct(true,"danger","İsminiz Soyisminiz boş olamaz..");
                    return;
                }
                $http({
                    method: 'POST',
                    url: 'dashboard/updatenamelast',
                    data: {firstName:$scope.fname,lastName:$scope.lname}
                }).then(function successCallback(response) {
                    //$scope.person=response.data;
                    $scope.alertFunct(true,"success","İsminiz Soyisminiz Güncellendi..")

                }, function errorCallback(response) {
                    // called asynchronously if an error occurs
                    // or server returns response with an error status.
                })

            }

            $scope.but3 = function () {
                if($scope.mails=="" || $scope.mails == undefined){
                    $scope.alertFunct(true,"danger","email adresiniz boş olamaz..");
                    return;
                }
                $http({
                    method: 'POST',
                    url: 'dashboard/updateemail',
                    data: {email:$scope.mails}
                }).then(function successCallback(response) {
                    //$scope.person=response.data;
                    $scope.alertFunct(true,"success","Email adresiniz Güncellendi..")

                }, function errorCallback(response) {
                    // called asynchronously if an error occurs
                    // or server returns response with an error status.
                })

            }

            $scope.but_blog = function () {
                if($scope.bcount=="" || $scope.bcount == undefined){
                    $scope.alertFunct(true,"danger","blog sayısı boş olamaz..");
                    return;
                }
                $http({
                    method: 'POST',
                    url: 'dashboard/updateBlogCount',
                    data: {blogcount:$scope.bcount}
                }).then(function successCallback(response) {
                    //$scope.person=response.data;
                    $scope.alertFunct(true,"success","Blog-Makale sayınız Güncellendi..")

                }, function errorCallback(response) {
                    $scope.alertFunct(true,"success","Blog-Makale sayınız Güncellendi..")

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
        });
    </script>
</head>
<body ng-app="myApp" ng-controller="myAppcntrl" ng-init="init()">
<!-- Ust Menu -->
<jsp:include page="theme/header.jsp" />

<div class="container-fluid">
    <div class="row">
        <!-- Yan Menu -->
        <jsp:include page="theme/sidebar.jsp" />

        <main role="main" class="col-md-9 ml-sm-auto col-lg-10 px-4">
            <div class="d-flex justify-content-between flex-wrap flex-md-nowrap align-items-center pt-3 pb-2 mb-3 border-bottom">
                <h1 class="h2">Ayarlar</h1>
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
            <div class="accordion" id="accordionExample">
                <div class="card">
                    <div class="card-header" id="headingOne">
                        <h2 class="mb-0">
                            <button class="btn" type="button" data-toggle="collapse" data-target="#collapseOne" aria-expanded="true" aria-controls="collapseOne">
                                <span data-feather="user"></span>
                                Kullanıcı Ayarları
                            </button>
                        </h2>
                    </div>

                    <div id="collapseOne" class="collapse show" aria-labelledby="headingOne" data-parent="#accordionExample">
                        <div class="card-body">
                            <div ng-show="alertShow" class="alert alert-{{alert_type}} alert-dismissible fade show" role="alert">
                                {{alertContent}}

                            </div>
                            <h6>Parola Değişikliği</h6>
                            <div class="input-group mb-3">
                                <input type="password" class="form-control" ng-model="passwd" aria-label="Text input with checkbox">
                                    <div class="input-group-append">
                                        <button class="btn btn-outline-primary"  type="button" ng-click="but1()" id="button-addon2">Kaydet</button>
                                    </div>
                                </div>
                            <hr>
                            <h6>İsim Soyisim Değişikliği</h6>
                            <div class="input-group mb-3">
                                <div class="input-group-prepend">
                                    <div class="input-group-text">
                                        <input type="checkbox" ng-model="check_fl" aria-label="Checkbox for following text input">
                                    </div>
                                </div>
                                <div class="input-group-prepend">
                                    <span class="input-group-text">İsim ve Soy isim</span>
                                </div>
                                <input type="text" aria-label="First name" ng-model="fname" ng-disabled="check_fl==false" placeholder="adınız" class="form-control">
                                <input type="text" aria-label="Last name" ng-model="lname" ng-disabled="check_fl==false" placeholder="soyadınız" class="form-control">
                                <div class="input-group-append">
                                    <button class="btn btn-outline-primary" type="button" ng-click="but2()" ng-disabled="check_fl==false" id="button-addon2">Kaydet</button>
                                </div>
                            </div>
                            <hr>
                            <h6>Email Değişikliği</h6>
                            <div class="input-group mb-3">
                                <div class="input-group-prepend">
                                    <div class="input-group-text">
                                        <input type="checkbox" ng-model="check_e" aria-label="Checkbox for following text input">
                                    </div>
                                </div>
                                <div class="input-group-prepend">
                                    <span class="input-group-text">email</span>
                                </div>
                                <input type="text" aria-label="email" ng-disabled="check_e==false" ng-model="mails" placeholder="email" class="form-control">
                                <div class="input-group-append">
                                    <button class="btn btn-outline-primary" ng-disabled="check_e==false" ng-click="but3()"  type="button" id="button-addon2">Kaydet</button>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="card">
                    <div class="card-header" id="headingTwo">
                        <h2 class="mb-0">
                            <button class="btn collapsed" type="button" data-toggle="collapse" data-target="#collapseTwo" aria-expanded="false" aria-controls="collapseTwo">
                                <span data-feather="settings"></span>
                                Genel Ayarlar
                            </button>
                        </h2>
                    </div>
                    <div id="collapseTwo" class="collapse" aria-labelledby="headingTwo" data-parent="#accordionExample">
                        <div class="card-body">
                            Yapım aşamasında.
                        </div>
                    </div>
                </div>
                <div class="card">
                    <div class="card-header" id="headingTree">
                        <h2 class="mb-0">
                            <button class="btn collapsed" type="button" data-toggle="collapse" data-target="#collapseTree" aria-expanded="false" aria-controls="collapseTwo">
                                <span data-feather="edit"></span>
                                Blog Ayarları
                            </button>
                        </h2>
                    </div>
                    <div id="collapseTree" class="collapse" aria-labelledby="headingTwo" data-parent="#accordionExample">
                        <div class="card-body">
                            <div class="input-group mb-3">
                                <div class="input-group-prepend">
                                    <div class="input-group-text">
                                        <input type="checkbox" ng-model="check_e" aria-label="Checkbox for following text input">
                                    </div>
                                </div>
                                <div class="input-group-prepend">
                                    <span class="input-group-text">Bir sayfada görünecek blog sayısı</span>
                                </div>
                                <input type="text" aria-label="email" ng-disabled="check_e==false" ng-model="bcount" placeholder="sayı giriniz" class="form-control">
                                <div class="input-group-append">
                                    <button class="btn btn-outline-primary" ng-disabled="check_e==false" ng-click="but_blog()"  type="button" id="button-addon2">Kaydet</button>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </main>
    </div>
</div>
<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
<script>window.jQuery || document.write('<script src="/docs/4.3/assets/js/vendor/jquery-slim.min.js"><\/script>')</script><script src="/docs/4.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-xrRywqdh3PHs8keKZN+8zzc5TX0GRTLCcmivcbNJWm2rs5C8PRhcEn3czEjhAO9o" crossorigin="anonymous"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/feather-icons/4.9.0/feather.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.7.3/Chart.min.js"></script>
<script src="https://getbootstrap.com/docs/4.3/examples/dashboard/dashboard.js"></script>
<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js" integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1" crossorigin="anonymous"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script>
</body>
</html>
