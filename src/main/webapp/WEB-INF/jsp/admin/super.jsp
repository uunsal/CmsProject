<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
    <link href="${pageContext.request.contextPath}/css/bootstrap.min.css" rel="stylesheet"
          integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">

    <script src="https://ajax.googleapis.com/ajax/libs/angularjs/1.7.7/angular.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script>
    <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>

    <script>
        var app = angular.module('myApp', []);
        app.controller('myAppcntrl', function ($scope, $http, $log, $location, $timeout, $window) {
            $scope.init = function () {
                $http({//page information
                    method: 'GET',
                    url: 'dashboard/getAllUser'
                }).then(function successCallback(response) {
                        $scope.users = response.data;
                    },
                    function errorCallback(response) {
                        //error message
                    });
            }

            $scope.userClick = function (User) {
                $scope.user = User;
            }

        });
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

        @media (max-width: 991.98px) {
            .offcanvas-collapse {
                position: fixed;
                top: 56px; /* Height of navbar */
                bottom: 0;
                left: 100%;
                width: 100%;
                padding-right: 1rem;
                padding-left: 1rem;
                overflow-y: auto;
                visibility: hidden;
                background-color: #343a40;
                transition: visibility .3s ease-in-out, -webkit-transform .3s ease-in-out;
                transition: transform .3s ease-in-out, visibility .3s ease-in-out;
                transition: transform .3s ease-in-out, visibility .3s ease-in-out, -webkit-transform .3s ease-in-out;
            }

            .offcanvas-collapse.open {
                visibility: visible;
                -webkit-transform: translateX(-100%);
                transform: translateX(-100%);
            }
        }

        .nav-scroller {
            position: relative;
            z-index: 2;
            height: 2.75rem;
            overflow-y: hidden;
        }

        .nav-scroller .nav {
            display: -ms-flexbox;
            display: flex;
            -ms-flex-wrap: nowrap;
            flex-wrap: nowrap;
            padding-bottom: 1rem;
            margin-top: -1px;
            overflow-x: auto;
            color: rgba(255, 255, 255, .75);
            text-align: center;
            white-space: nowrap;
            -webkit-overflow-scrolling: touch;
        }

        .nav-underline .nav-link {
            padding-top: .75rem;
            padding-bottom: .75rem;
            font-size: .875rem;
            color: #6c757d;
        }

        .nav-underline .nav-link:hover {
            color: #007bff;
        }

        .nav-underline .active {
            font-weight: 500;
            color: #343a40;
        }

        .text-white-50 {
            color: rgba(255, 255, 255, .5);
        }

        .bg-purple {
            background-color: #b52525;
        }
    </style>
    <!-- Custom styles for this template -->
    <link href="${pageContext.request.contextPath}/css/dashboard.css" rel="stylesheet">
</head>
<body class="bg-light" ng-app="myApp" ng-controller="myAppcntrl" ng-init="init()">
<!-- Ust Menu -->
<nav class="navbar navbar-dark  bg-dark flex-md-nowrap p-0 shadow">
    <a class="navbar-brand col-sm-3 col-md-2 mr-0" href="#">Kullanıcı - ${user}</a>
    <input class="form-control form-control-dark w-100" type="text" placeholder="Arama" aria-label="Search">
    <ul class="navbar-nav px-3">
        <li class="nav-item text-nowrap">
            <form action="${pageContext.request.contextPath}/admin/logout" method="post">
                <input class="btn btn-success" type="submit" value="Çıkış"> <input type="hidden"
                                                                                   name="${_csrf.parameterName}"
                                                                                   value="${_csrf.token}">
            </form>
        </li>
    </ul>
</nav>
<div class="nav-scroller bg-white shadow-sm">
    <nav class="nav nav-underline">
        <a class="nav-link active" href="#">İşlemler</a>
        <a class="nav-link" href="#">
            Kullanıcılar
            <span class="badge badge-danger  align-text-bottom">{{users.length}}</span>
        </a>
        <a class="nav-link" href="${pageContext.request.contextPath}/admin/users">Kullanıcı İşlemleri</a>
        <a class="nav-link" href="#">Sistem İşlemleri</a>
        <a class="nav-link" href="#">Duyuru İşlemleri</a>
        <a class="nav-link" href="#">Tema İşlemleri</a>
    </nav>
</div>
<!-- Modal -->
<div class="modal fade" id="exampleModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="exampleModalLabel">Kullanıcı Bilgileri - {{user.username}}</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <ul class="list-group list-group-flush">
                    <div style="margin: 0 auto;margin-bottom: 30px;"><svg class="bd-placeholder-img rounded-circle" width="105"
                         height="105" xmlns="http://www.w3.org/2000/svg" preserveAspectRatio="xMidYMid slice"
                         focusable="false" role="img" aria-label="Completely round image: 75x75">
                        <title>Person image</title><rect width="100%" height="100%" fill="#868e96" />
                        <text x="50%" y="50%" fill="#dee2e6" dy=".3em">75x75</text></svg>
                    </div>
                    <li class="list-group-item">İsim bilgileri : {{user.firstName +" "+ user.lastName}}</li>
                    <li class="list-group-item">Email : {{user.email}}</li>
                    <li class="list-group-item">Ünvan : {{user.unvan}}</li>
                    <li class="list-group-item">Web sitesini gör</li>
                </ul>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-dismiss="modal">Kapat</button>
            </div>
        </div>
    </div>
</div>
<div class="container-fluid">
    <div class="row">
        <!-- Yan Menu -->

        <main role="main" class="col-md-9 ml-sm-auto col-lg-12 px-4">
            <div class="d-flex align-items-center p-3 my-3 text-white-50 bg-purple rounded shadow-sm">
                <img class="mr-3 bg-light" src="http://ktun.edu.tr/Content/images/logo/logo3.png" alt="" width="158" height="48">
                <div class="lh-100">
                    <h6 class="mb-0 text-white lh-100">Hoşgeldiniz Süper Admin</h6>
                    <small>Konya Teknik Üniversitesi Web Sayfaları Yönetim Sistemi</small>
                </div>
            </div>

            <div class="my-3 p-3 bg-white rounded shadow-sm">
                <div class="kapsa border-bottom border-gray pb-2 mb-0" style="overflow: hidden;padding: 5px;">
                    <h6 class="" style="float:left;margin-top: 10px">Kullanıcılar</h6>
                    <form class="form-inline my-2 my-lg-0" style="float:right">
                        <input ng-model='searchText' class="form-control mr-sm-1" style="width: 250px;background:#eee;" type="search" placeholder="Ara" aria-label="Ara">
                    </form>
                </div>
                <c:set var = "sayac" scope = "session" value = "0"/>
                <div class="media text-muted pt-3" ng-repeat="u in users | filter:searchText">
                    <c:if test="${sayac%2==0}">
                        <c:set var = "sayac" scope = "session" value = "1"/>
                        <svg class="bd-placeholder-img mr-2 rounded" width="32" height="32"
                             xmlns="http://www.w3.org/2000/svg" preserveAspectRatio="xMidYMid slice" focusable="false"
                             role="img" aria-label="Placeholder: 32x32"><title>Placeholder</title>
                            <rect width="100%" height="100%" fill="#007bff"/>
                            <text x="50%" y="50%" fill="#007bff" dy=".3em">32x32</text>
                        </svg>
                    </c:if>
                    <p class="media-body pb-3 mb-0 small lh-125 border-bottom border-gray">
                        <a href="#" ng-click="userClick(u)" data-toggle="modal" data-target="#exampleModal"><strong class="d-block text-gray-dark" >{{u.username}}</strong></a>
                        {{u.unvan}}
                    </p>
                </div>
                <small class="d-block text-right mt-3">
                    <a href="#">Tüm Kullanıcılar</a>
                </small>
            </div>

        </main>


    </div>
</div>
<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
<script>window.jQuery || document.write('<script src="/docs/4.3/assets/js/vendor/jquery-slim.min.js"><\/script>')</script><script src="/js/bootstrap.bundle.min.js" integrity="sha384-xrRywqdh3PHs8keKZN+8zzc5TX0GRTLCcmivcbNJWm2rs5C8PRhcEn3czEjhAO9o" crossorigin="anonymous"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/feather-icons/4.9.0/feather.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.7.3/Chart.min.js"></script>
<script src="https://getbootstrap.com/docs/4.3/examples/dashboard/dashboard.js"></script>
</body>
</html>
