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
        var globalimage = "";
        var app = angular.module('myApp', []);
        app.controller('myAppcntrl', function ($scope, $http, $log,$location,$timeout,$window) {

            $scope.init = function(){
                $http({//page images
                    method: 'GET',
                    url: 'dashboard/findAllImage'
                }).then(function successCallback(response) {
                        $scope.rsmler = response.data;
                    }
                    , function errorCallback(response) {
                        //error message

                    });
            }

            $scope.uploadimage = function () {
                $scope.prgrss=true;
                //console.log("yuklenen",globalimage);
                $http({
                    method: 'POST',
                    url: 'dashboard/uploadPhoto',
                    data:{imageBase64:globalimage}
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

            $scope.image_modal =function(ıd){
                $scope.secilen_img=ıd;
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

<div class="container-fluid">
    <div class="row">
        <!-- Yan Menu -->
        <jsp:include page="theme/sidebar.jsp" />
        <!-- Modal -->
        <div class="modal fade" id="exampleModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="exampleModalLabel">Resim Bilgileri</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <div style="text-align: center"><img src={{secilen_img.imageBase64}} class="img-fluid" alt="Responsive image"></div>
                        <div style="margin-top: 20px;text-align: center">Yüklenme Tarihi : {{secilen_img.loadDate}}
                            <input type="text" ng-disabled="myinput==false" style="padding:4px;width: 200px;background:#ddd;border:1px solid#ccc;" value={{secilen_img.imageBase64}} id="myInput">
                            <button type="button" class="btn btn-outline-primary" style="height: 30px;padding: 3px;" onclick="myFunction()">Url yi kopyala</button>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-dismiss="modal">Kapat</button>
                        <button type="button" class="btn btn-primary"  ng-click="page_delete()" data-dismiss="modal">Sil</button>
                    </div>
                </div>
            </div>
        </div>
        <main role="main" class="col-md-9 ml-sm-auto col-lg-10 px-4">
            <div class="d-flex justify-content-between flex-wrap flex-md-nowrap align-items-center pt-3 pb-2 mb-3 border-bottom">
                <h2 class="h2">Resim İşlemleri</h2>
                <div class="btn-toolbar mb-2 mb-md-0">

                </div>
            </div>
            <p>
                <a class="btn btn-sm btn-outline-secondary" data-toggle="collapse" href="#collopen" role="button" aria-expanded="false" aria-controls="collapseExample">
                    Resim Yükle
                </a>
            </p>
            <div class="collapse" id="collopen" style="margin-bottom: 20px;">
                <div class="card card-body">
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
            <!-- Page Content -->
            <div class="container">
                <div class="row text-center text-lg-left">
                    <div ng-repeat="rsm in rsmler" class="col-lg-3 col-md-4 col-6">
                        <a href="#" class="d-block mb-4 h-100">
                            <img class="img-fluid img-thumbnail" ng-click = "image_modal(rsm)" data-toggle="modal" data-target="#exampleModal" src={{rsm.imageBase64}} alt="">
                        </a>
                    </div>

                </div>

            </div>
            <!-- /.container -->
        </main>
    </div>
</div>
<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
<script>window.jQuery || document.write('<script src="/docs/4.3/assets/js/vendor/jquery-slim.min.js"><\/script>')</script><script src="/docs/4.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-xrRywqdh3PHs8keKZN+8zzc5TX0GRTLCcmivcbNJWm2rs5C8PRhcEn3czEjhAO9o" crossorigin="anonymous"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/feather-icons/4.9.0/feather.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.7.3/Chart.min.js"></script>
<script src="https://getbootstrap.com/docs/4.3/examples/dashboard/dashboard.js"></script></body>
</html>
