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
        app.controller('myAppcntrl', function ($scope, $http, $log,$location,$timeout,$window,$sce) {

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
            $scope.previewTheme = function (theme) {
                $http({//page information
                    method: 'GET',
                    url: 'admin/previewT?id='+theme.id,
                    data:{id:theme.id}
                }).then(function successCallback(response) {
                    $scope.frmsrc=$sce.trustAsResourceUrl("http://www.selcuk.edu.tr");
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

            $scope.uploadimage = function () {
                $scope.prgrss=true;
                //console.log("yuklenen",globalimage);
                $http({
                    method: 'POST',
                    url: 'dashboard/updateProfilePhoto',
                    data:{profilePhoto:globalimage}
                }).then(function successCallback(response) {
                }, function errorCallback(response) {
                    // called asynchronously if an error occurs
                    // or server returns response with an error status.
                })
                $timeout(function() {
                    for (var i = 0 ;i<101;i++){
                        $scope.progressValue = i+'%';

                    }
                    $scope.yuklenenimg=globalimage;
                    $scope.upcom=true;
                    $scope.init();
                }, 600);



            }

        })
        function encodeImageFileAsURL(element) {
            var file = element.files[0];
            var reader = new FileReader();
            reader.onloadend = function() {
                //console.log('RESULT', reader.result)
                globalimage = reader.result;

            }
            reader.readAsDataURL(file);
        }
        function readURL(input) {
            if (input.files && input.files[0]) {

                var reader = new FileReader();

                reader.onload = function(e) {
                    $('.image-upload-wrap').hide();

                    $('.file-upload-image').attr('src', e.target.result);
                    $('.file-upload-content').show();

                    $('.image-title').html(input.files[0].name);
                };

                reader.readAsDataURL(input.files[0]);
                encodeImageFileAsURL(input)

            } else {
                removeUpload();
            }
        }

        function removeUpload() {
            $('.file-upload-input').replaceWith($('.file-upload-input').clone());
            $('.file-upload-content').hide();
            $('.image-upload-wrap').show();
        }
        $('.image-upload-wrap').bind('dragover', function () {
            $('.image-upload-wrap').addClass('image-dropping');
        });
        $('.image-upload-wrap').bind('dragleave', function () {
            $('.image-upload-wrap').removeClass('image-dropping');
        });

        function myFunction() {
            var copyText = document.getElementById("myInput");
            copyText.select();

            copied = document.execCommand('copy');
            $timeout(function() {
                $scope.myinpuy=false;
            }, 50);

        }
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
    <style>
        .capitalize {
            text-transform: capitalize;
        }
        .file-upload {
            background-color: #ffffff;
            margin: 0 auto;
            padding: 20px;
        }

        .file-upload-btn {
            width: 600px;
            margin: 0;
            color: #fff;
            background: #525252;
            border: none;
            padding: 10px;
            border-radius: 4px;
            border-bottom: 4px solid #333333;
            transition: all .2s ease;
            outline: none;
            text-transform: uppercase;
            font-weight: 700;
        }

        .file-upload-btn:hover {
            background: #444444;
            color: #ffffff;
            transition: all .2s ease;
            cursor: pointer;
        }

        .file-upload-btn:active {
            border: 0;
            transition: all .2s ease;
        }

        .file-upload-content {
            display: none;
            text-align: center;
        }

        .file-upload-input {
            position: absolute;
            margin: 0;
            padding: 0;
            width: 300px;
            height: 100%;
            outline: none;
            opacity: 0;
            cursor: pointer;
        }

        .image-upload-wrap {
            margin-top: 20px;
            border: 2px dashed #666666;
            position: relative;
        }

        .image-dropping,
        .image-upload-wrap:hover {
            border: 2px dashed #444444;
        }

        .image-title-wrap {
            padding: 0 15px 15px 15px;
            color: #222;
        }

        .drag-text {
            text-align: center;
        }

        .drag-text h3 {
            font-weight: 100;
            text-transform: uppercase;
            color: #000000;
            padding: 60px 0;
        }

        .file-upload-image {
            max-height: 200px;
            max-width: 200px;
            margin: auto;
            padding: 20px;
        }

        .remove-image {
            margin: 0;
            color: #fff;
            background: #cd4535;
            border: none;
            padding: 10px;
            border-radius: 4px;
            border-bottom: 4px solid #b02818;
            transition: all .2s ease;
            outline: none;
            text-transform: uppercase;
            font-weight: 700;
        }

        .remove-image:hover {
            background: #c13b2a;
            color: #ffffff;
            transition: all .2s ease;
            cursor: pointer;
        }

        .remove-image:active {
            border: 0;
            transition: all .2s ease;
        }
    </style>
    <!-- Custom styles for this template -->
    <link href="${pageContext.request.contextPath}/css/dashboard.css" rel="stylesheet">
</head>
<body ng-app="myApp" ng-controller="myAppcntrl" ng-init="init()">
<!-- Ust Menu -->
<jsp:include page="theme/header.jsp" />
<div class="modal fade bd-example-modal-xl" tabindex="-1" role="dialog" aria-labelledby="myExtraLargeModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-xl">
        <div class="modal-content">
            <iframe ng-src="{{frmsrc}}" style="zoom:0.60" width="99.6%" height="1050" frameborder="0"></iframe>

        </div>
    </div>
</div>

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
                                <img class="card-img-top" height="200" src={{t.screenShout}} alt="Card image cap">
                                <div class="card-body">
                                    <h5 class="card-title">{{t.name}} Tasarımı</h5>
                                    <p class="card-text">{{t.description}}</p>
                                    <button href="#" ng-click="enableTheme(t)" type="button" ng-disabled="{{t.active==true}}" class="btn btn-outline-secondary">Etkinleştir</button>
                                    <button href="#" ng-click="previewTheme(t)" type="button"  class="btn btn-outline-primary">Önizleme</button>
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
                <div class="tab-pane fade" id="nav-contact" role="tabpanel" aria-labelledby="nav-contact-tab">
                    <div class="card card-body" style="margin-top: 30px;">
                        <div class="file-upload">
                            <button class="file-upload-btn" type="button" onclick="$('.file-upload-input').trigger( 'click' )">Resim Seçiniz</button>

                            <div class="image-upload-wrap">
                                <input class="file-upload-input" type='file' onchange="readURL(this);" accept="image/*" />
                                <div class="drag-text">
                                    <h3>İstediğiniz resmi sürükleyip bırakınız</h3>
                                </div>
                            </div>
                            <div class="file-upload-content">
                                <img class="file-upload-image" src="#" alt="your image" />
                                <div class="image-title-wrap">
                                    <button type="button" onclick="removeUpload()" class="remove-image">Kaldır <span class="image-title">Uploaded Image</span></button>
                                </div>
                            </div>
                            <div ng-show="prgrss" class="progress" style="margin-top:20px;">
                                <div class="progress-bar bg-success" role="progressbar" ng-style="{'width':progressValue}" aria-valuenow="{{progressValue}}" aria-valuemin="0" aria-valuemax="100">{{progressValue}}</div>
                            </div>
                            <div style="margin-top: 20px;" ng-show="upcom">
                                <input type="text" ng-disabled="myinput==false" style="padding:4px;width: 400px;background:#ddd;border:1px solid#ccc;" value={{yuklenenimg}} id="myInput">
                                <button type="button" class="btn btn-outline-primary" style="float: right;height: 30px;padding: 3px;" onclick="myFunction()">Url yi kopyala</button>
                            </div>
                            <button type="button"  style="margin-top: 20px;"  ng-click="uploadimage()" data-toggle="modal" data-target="#imageUpload" class="btn btn-sm btn-outline-secondary">Resim Yükle</button>

                        </div>
                </div>
                </div>
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
