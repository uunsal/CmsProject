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
    <link href="${pageContext.request.contextPath}/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
    <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js" integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1" crossorigin="anonymous"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script>
    <script src="https://cdn.ckeditor.com/4.11.3/full/ckeditor.js"></script>
    <!-- Angular Library -->
    <script src="https://ajax.googleapis.com/ajax/libs/angularjs/1.7.7/angular.min.js"></script>
    <!-- Bootstrap core CSS -->
    <link href="${pageContext.request.contextPath}/css/bootstrap.min.css"  rel="stylesheet" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
    <script src="${pageContext.request.contextPath}/js/sortable.js"></script>
    <script src="${pageContext.request.contextPath}/js/script.js"></script>

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
    <script>
        var app = angular.module('myApp', []);
        app.controller('myAppcntrl', function ($scope, $http, $log,$location,$timeout,$window) {
            $scope.init = function () {
                $http({//page information
                    method: 'GET',
                    url: 'dashboard/allTheme'
                }).then(function successCallback(response) {
                    $scope.temalar = response.data;
                    console.log($scope.temalar);
                }, function errorCallback(response) {
                    //error message
                });
                $http({//page information
                    method: 'GET',
                    url: 'dashboard/getNotDraftPage'
                }).then(function successCallback(response) {
                    $scope.pages = response.data;
                    console.log($scope.temalar);
                }, function errorCallback(response) {
                    //error message
                });
                $http({//page information
                    method: 'GET',
                    url: 'dashboard/getCustomCss'
                }).then(function successCallback(response) {
                    $scope.customc = response.data;
                    $scope.customcs = $scope.customc.customCss;
                    console.log($scope.customc)
                }, function errorCallback(response) {
                    //error message
                });
            }

            $scope.savepagesort=function(scope,attrs){
                var lis = document.querySelectorAll('#sortable li[id]');

                var arr = [];
                for (var i = 0; i < lis.length; i++) {
                    var a={id:+lis[i].id}
                    arr.push(a);

                }
                console.log(arr);
                $http({//page information
                    method: 'POST',
                    url: 'dashboard/changeMenuSort',
                    data:JSON.stringify(arr)
                }).then(function successCallback(response) {
                    $scope.alertFunct(true,"success","Menü Sıralaması güncellendi");
                    //$scope.init();
                }, function errorCallback(response) {
                    //error message
                });

            }

            $scope.enableTheme = function (theme) {
                $http({//page information
                    method: 'POST',
                    url: 'dashboard/changeTheme',
                    data:{id:theme.id}
                }).then(function successCallback(response) {
                    $scope.alertFunct(true,"success",theme.name+" Tasarımı aktifleşirildi.");
                    $scope.init();
                }, function errorCallback(response) {
                    //error message
                });
            }

            $scope.alertFunct = function(gelen,type,message){
                $scope.alertContent=message;
                $scope.alert_type=type;
                $scope.alertShow=gelen;
                $timeout(function() {
                    $scope.alertShow=false;
                }, 3600);
            }

            $scope.savecustomcss = function () {
                console.log("dneeme",$scope.customcs);
                $http({//page information
                    method: 'POST',
                    url: 'dashboard/setCustomCss',
                    data:$scope.customcs+" "
                }).then(function successCallback(response) {
                    $scope.alertFunct(true,"success","Kişiselleştirilmiş Css Kaydedildi.");
                }, function errorCallback(response) {
                    //error message
                });
            }

        })

        $(function () {
            $('#sortable').sortable({
                tolerance: 'touch',
                drop: function () {
                    alert('delete!');
                }
            });
            $('#item').sortable();
        });

    </script>
    <!-- Custom styles for this template -->
    <link href="${pageContext.request.contextPath}/css/dashboard.css" rel="stylesheet">
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
                <h2 class="h2">Tasarım</h2>
                <div class="btn-toolbar mb-2 mb-md-0">
                    <div class="btn-group mr-2">
                        <button type="button" class="btn btn-sm btn-outline-secondary">menu1</button>
                        <button type="button" class="btn btn-sm btn-outline-secondary">menu2</button>
                    </div>
                </div>
            </div>
            <nav>
                <div class="nav nav-tabs" id="nav-tab" role="tablist">
                    <a class="nav-item nav-link active" id="nav-home-tab" data-toggle="tab" href="#nav-home" role="tab" aria-controls="nav-home" aria-selected="true">Görünüm</a>
                    <a class="nav-item nav-link" id="nav-profile-tab" data-toggle="tab" href="#nav-profile" role="tab" aria-controls="nav-profile" aria-selected="false">Menü Seçenekleri</a>
                    <a class="nav-item nav-link" id="nav-contact-tab" data-toggle="tab" href="#nav-contact" role="tab" aria-controls="nav-contact" aria-selected="false">Menü Resmi</a>
                    <a class="nav-item nav-link" id="nav-color-tab" data-toggle="tab" href="#nav-css" role="tab" aria-controls="nav-css" aria-selected="false">Kişiselleştirilebilir Css</a>
                </div>
            </nav>
            <div class="tab-content" id="nav-tabContent">
                <div class="tab-pane fade show active" style="margin-top:30px;" id="nav-home" role="tabpanel" aria-labelledby="nav-home-tab">
                    <div ng-show="alertShow" class="alert alert-{{alert_type}} alert-dismissible fade show" role="alert">
                        {{alertContent}}

                    </div>
                    <div class="row">
                        <div  ng-repeat="t in temalar" class="col-sm-4" style="margin-bottom: 40px;">
                            <div class="card" style="width: 18rem;">
                                <img class="card-img-top" src={{t.screenShout}} alt="Card image cap">
                                <div class="card-body">
                                    <h5 class="card-title">{{t.name}} Tasarımı</h5>
                                    <p class="card-text">{{t.description}}</p>
                                    <button href="#" ng-click="enableTheme(t)" type="button" ng-disabled="{{t.active==true}}" class="btn btn-outline-secondary">Etkinleştir</button>
                                    <button href="#" type="button" class="btn btn-outline-primary">Önizleme</button>
                                </div>
                            </div>
                        </div>
                    </div>

                </div>

                <div class="tab-pane fade" id="nav-profile" role="tabpanel" aria-labelledby="nav-profile-tab">
                    <h6 style="margin-top:20px;">Menü Sıralaması</h6>
                    <div ng-show="alertShow" class="alert alert-{{alert_type}} alert-dismissible fade show" role="alert">
                        {{alertContent}}

                    </div>
                    <ul my-directive="myList" id="sortable" class="list-group">
                        <li ng-repeat="p in pages" id={{p.id}} class="list-group-item text-capitalize">{{p.title}}</li>
                    </ul>
                    <button href="#" type="button" style="margin-top: 20px;" ng-click="savepagesort()" class="btn btn-outline-secondary">Kaydet</button>
                </div>
                <div class="tab-pane fade" id="nav-contact" role="tabpanel" aria-labelledby="nav-contact-tab">Deneme</div>
                <div class="tab-pane fade" id="nav-css" role="tabpanel" aria-labelledby="nav-contact-tab">
                    <h5 style="margin-top: 10px;">Kişiselleştirilmiş Css</h5>
                    <div ng-show="alertShow" class="alert alert-{{alert_type}} alert-dismissible fade show" role="alert">
                        {{alertContent}}

                    </div>
                    <div class="form-group">
                        <label for="comment">Stil Kodlarınızı Giriniz:</label>
                        <textarea class="form-control" ng-model="customcs" style="background:#e5e5e5 ;font-size:14px;min-height: 300px;"  rows="5" id="comment"></textarea>
                        <button type="button" ng-click = "savecustomcss()" style="margin-top: 20px; " class="btn btn-outline-secondary">Kaydet</button>
                    </div>
                </div>
            </div>
        </main>
    </div>
</div>

<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<script>window.jQuery || document.write('<script src="/docs/4.3/assets/js/vendor/jquery-slim.min.js"><\/script>')</script><script src="/docs/4.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-xrRywqdh3PHs8keKZN+8zzc5TX0GRTLCcmivcbNJWm2rs5C8PRhcEn3czEjhAO9o" crossorigin="anonymous"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/feather-icons/4.9.0/feather.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.7.3/Chart.min.js"></script>
<script src="https://getbootstrap.com/docs/4.3/examples/dashboard/dashboard.js"></script></body>
</html>
