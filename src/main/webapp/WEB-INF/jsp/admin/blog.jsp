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
            $scope.init = function(){
                $scope.alertShow=false;
                $http({//page information
                    method: 'GET',
                    url: 'dashboard/initPages'
                }).then(function successCallback(response) {

                }, function errorCallback(response) {
                    //error message
                });


            }
            $scope.formu_gonder2 = function () {
                $scope.page_data = CKEDITOR.instances.editor1.getData();
                console.log($scope.page_data)
                $http({
                    method: 'POST',
                    url: 'dashboard/createBlog',
                    data: {content:$scope.page_data,title:$scope.blogTitle}
                }).then(function successCallback(response) {
                    //$scope.person=response.data;
                    $scope.alertFunct(true,"success","Yazınız kaydedildi!");
                }, function errorCallback(response) {
                    // called asynchronously if an error occurs
                    // or server returns response with an error status.
                })
                console.log("deneme"+$scope.page_data);
                //alert("deneme");
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
                <h1 class="h2">Yazılarım</h1>
                <div class="btn-toolbar mb-2 mb-md-0">
                    <div class="btn-group mr-2">
                        <button type="button"  data-toggle="modal" data-target="#exampleModal" class="btn btn-sm btn-outline-danger">Sayfayı Sil</button>
                        <button type="button" data-toggle="modal" ng-click="page_info()" data-target="#exampleModal2" class="btn btn-sm btn-outline-secondary">Sayfayı Düzenle</button>
                        <button type="button"  data-toggle="modal" data-target="#imageUpload" class="btn btn-sm btn-outline-primary">Resim Yükle</button>
                        <button type="button" ng-click="page_view()" class="btn btn-sm btn-outline-secondary">Sayfayı Görüntüle</button>
                    </div>
                </div>
            </div>
            <c:if test="${blogcontrol==false}">Blog sayfanız oluşturulmamış oluşturmak istermisiniz? <a href="pages">tıklayınız</a> </c:if>
            <c:if test="${blogcontrol==true}">
                <ul class="nav nav-tabs" id="myTab" role="tablist">
                    <li class="nav-item">
                        <a class="nav-link active" id="home-tab" data-toggle="tab" href="#new" role="tab" aria-controls="home" aria-selected="true">Yeni Yazı</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" id="profile-tab" data-toggle="tab" href="#writes" role="tab" aria-controls="profile" aria-selected="false">Yazılarım</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" id="contact-tab" data-toggle="tab" href="#contact" role="tab" aria-controls="contact" aria-selected="false">..</a>
                    </li>
                </ul>
                <div class="tab-content" id="myTabContent">
                    <div class="tab-pane fade show active" id="new" role="tabpanel" aria-labelledby="home-tab">
                        <div style="margin-top: 20px;" ng-show="alertShow" class="alert alert-{{alert_type}} alert-dismissible fade show" role="alert">
                            {{alertContent}}

                        </div>
                        <div class="input-group mb-3" style="margin-top: 30px;">

                            <div class="input-group-prepend">
                                <span class="input-group-text" id="inputGroup-sizing-default">Başlık</span>
                            </div>
                            <input ng-model="blogTitle" type="text" class="form-control" aria-label="Sizing example input" aria-describedby="inputGroup-sizing-default">
                        </div>
                        <form  style="margin-top: 30px;" method="post" ng-submit="formu_gonder2()" data-sample-short>
                            <textarea name="editor1" id="editor1" rows="10" cols="80">
                                    <%--This is my textarea to be replaced with CKEditor.--%>
                            </textarea>
                            <script>
                                // Replace the <textarea id="editor1"> with a CKEditor
                                // instance, using default configuration.
                                CKEDITOR.replace('editor1', {
                                    height: 500,
                                });

                            </script>
                            <p><input class="btn btn-primary" style="margin-top: 15px;margin-right:17px;" type="submit" value="Kaydet">
                                <button type="button" ng-disabled = "taslakbutton==false" ng-click="updateDraftPage()" style="margin-top: 15px;" class="btn btn-success">Taslaklara Kaydet</button></p>


                        </form>
                    </div>
                    <div class="tab-pane fade" id="writes" role="tabpanel" aria-labelledby="profile-tab">...</div>
                    <div class="tab-pane fade" id="contact" role="tabpanel" aria-labelledby="contact-tab">...</div>
                </div>
            </c:if>
        </main>
    </div>
</div>
<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
<script>window.jQuery || document.write('<script src="/docs/4.3/assets/js/vendor/jquery-slim.min.js"><\/script>')</script><script src="/docs/4.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-xrRywqdh3PHs8keKZN+8zzc5TX0GRTLCcmivcbNJWm2rs5C8PRhcEn3czEjhAO9o" crossorigin="anonymous"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/feather-icons/4.9.0/feather.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.7.3/Chart.min.js"></script>
<script src="https://getbootstrap.com/docs/4.3/examples/dashboard/dashboard.js"></script></body>
</html>
