<%--
  Created by IntelliJ IDEA.
  User: ufukunsal
  Date: 2019-03-14
  Time: 20:15
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

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

    <script>
        var globalimage = "";
        var app = angular.module('myApp', []);
        app.controller('myAppcntrl', function ($scope, $http, $log,$location,$timeout,$window) {
            $scope.global_secilen_page=0;
            $scope.globa_home_page=-1;
            $scope.init = function(){
                $scope.prgrss=false;
                $scope.upcom=false;
                $http({//page information
                    method: 'GET',
                    url: 'dashboard/initPages'
                }).then(function successCallback(response) {
                    $scope.getContextPath();
                    $scope.taslakbutton = false;
                    $scope.input_title = false;
                    $scope.input_url = false;
                    $scope.alertShow=false;
                    $scope.page_type = "0";
                    $scope.gelismis_secenek=false;
                    console.log(response.data)
                    $scope.getAllpages();//tüm sayfaları menüde listeler
                    var init_index=0;
                    for(var i=0;i<response.data.length;i++){
                        if(response.data[i].pageType=="home"){
                            init_index=i;
                            $scope.globa_home_page=i;
                        }
                    }
                    console.log(init_index);
                    $scope.page_selected_value=response.data[init_index]; // ana sayfa olarak ilerde değiştirlcek
                    $scope.page_value=response.data[init_index]; // is home page olarak değiştirlmesi gerekli
                    $scope.global_secilen_page=$scope.page_value.id;
                    CKEDITOR.instances.editor1.setData($scope.page_value.contents+"\n");
                    $scope.goster_url = $scope.page_selected_value.url;
                }, function errorCallback(response) {
                    //error message
                });

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
            $scope.createPage = function(bool_data){
                var created_page = {title:$scope.page_name,draft:bool_data};
                if($scope.page_name==undefined | $scope.page_name==""){
                    $scope.alertFunct(true,"danger","Boş alanlar olmamalı..");
                    return;
                }
                if($scope.gelismis_secenek==true){
                    if($scope.page_name==undefined | $scope.page_name=="" | $scope.page_url_opt==undefined | $scope.page_type==0){
                        $scope.alertFunct(true,"danger","Boş alanlar olmamalı..");
                        return;
                    }
                    var pagetype;
                    if($scope.page_type==1){
                        pagetype="blog";
                    }
                    if($scope.page_type==2){
                        pagetype="home";
                    }
                    if($scope.page_type==3){
                        pagetype="sample";
                    }
                    if($scope.page_type==4){
                        pagetype="contact";
                    }
                    created_page = {title:$scope.page_name,pageType:pagetype,url:$scope.page_url_opt,draft:bool_data};
                    console.log(created_page);
                }
                $http({
                    method: 'POST',
                    url: 'dashboard/createPage',
                    data: created_page
                }).then(function successCallback(response) {
                    //$scope.person=response.data;
                    console.log(response.data.title)
                    if(response.data.title!=null ||response.data.title!=undefined){
                        $scope.page_select(response.data.id);
                        $scope.getAllpages(); // yan sayfalar menüsü güncellenir
                        console.log("istekatildi");
                        $scope.alertFunct(true,"success",response.data.title+" adlı sayfa oluşturuldu");
                    }
                    else{
                        console.log("hata");
                        $scope.alertFunct(true,"danger","Hata böyle bir sayfa zaten var..");
                    }
                }, function errorCallback(response) {
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
            $scope.page_delete = function(){
                $http({
                    method: 'POST',
                    url: 'dashboard/deletePage',
                    data: {id:$scope.global_secilen_page}
                }).then(function successCallback(response) {
                    //$scope.person=response.data;
                    $scope.getAllpages(); // yan sayfalar menüsü güncellenir
                    console.log("silindi")
                    $scope.delete_message = response.data;
                    $scope.alertFunct(true,"success","Sayfa silindi");
                }, function errorCallback(response) {
                    // called asynchronously if an error occurs
                    // or server returns response with an error status.
                    console.log(response.data);

                })
            }
            $scope.getAllpages = function(){ // tüm sayfaları getiren fonksiyon
                $http({//get all pages
                    method: 'GET',
                    url: 'dashboard/initPages'
                }).then(function successCallback(response) {
                    console.log(response.data)
                    $scope.curr_pages=[]; // taslak olmayan sayfalar
                    $scope.draftPage=[];
                    for(var i=0;i<response.data.length;i++){
                        if(response.data[i].draft){
                            $scope.draftPage.push(response.data[i]);
                        }else{
                            $scope.curr_pages.push(response.data[i]);
                        }
                    }
                    $scope.pages = $scope.curr_pages;
                    console.log($scope.pages);
                }, function errorCallback(response) {
                    //error message
                });
            }
            $scope.page_select = function (data) {
                console.log(data)
                $http({
                    method: 'POST',
                    url: 'dashboard/getPage',
                    data: {id:data}
                }).then(function successCallback(response) {
                    $scope.page_selected_value=response.data;
                    console.log($scope.page_selected_value.draft);
                    if($scope.page_selected_value.draft==false){//seçilen sayfa taslak değilse taslaklara kaydet butonu pasif yapılır
                        console.log("evet")
                        $scope.taslakbutton = false;
                    }
                    else{
                        $scope.taslakbutton = true;
                    }
                    $scope.global_secilen_page=$scope.page_selected_value.id;
                    CKEDITOR.instances.editor1.setData($scope.page_selected_value.contents+"\n");
                    $scope.goster_url=$scope.page_selected_value.url;

                }, function errorCallback(response) {
                    // called asynchronously if an error occurs
                    // or server returns response with an error status.
                })
            }

            $scope.gelismis_secenek_checkbox_event = function(){
                $scope.gelismis_secenek=$scope.gelismis;
            }
            $scope.getContextPath = function(){
                $http({
                    method: 'POST',
                    url: 'dashboard/getContextPath',
                    data:{}
                }).then(function successCallback(response) {
                    console.log(response.data)
                    $scope.contextPath=response.data.contextPath;

                }, function errorCallback(response) {
                    console.log(response)
                })
            }
            $scope.formu_gonder = function () { // update page -- sayfa güncelleme fonksiyonu
                $scope.page_data = CKEDITOR.instances.editor1.getData();
                console.log($scope.page_data)
                $http({
                    method: 'POST',
                    url: 'dashboard/updatePage',
                    data: {contents:$scope.page_data,id:$scope.global_secilen_page}
                }).then(function successCallback(response) {
                    //$scope.person=response.data;
                    $scope.getAllpages();
                    $scope.alertFunct(true,"success","Sayfa kaydedildi!");
                }, function errorCallback(response) {
                    // called asynchronously if an error occurs
                    // or server returns response with an error status.
                })
                console.log("deneme"+$scope.page_data);
                //alert("deneme");
            };
            $scope.updateDraftPage = function(){
                $scope.page_data = CKEDITOR.instances.editor1.getData();
                console.log($scope.page_data)
                $http({
                    method: 'POST',
                    url: 'dashboard/updateDraftPage',
                    data: {contents:$scope.page_data,id:$scope.global_secilen_page}
                }).then(function successCallback(response) {
                    //$scope.person=response.data;
                    $scope.alertFunct(true,"success","Sayfa kaydedildi!");
                }, function errorCallback(response) {
                    // called asynchronously if an error occurs
                    // or server returns response with an error status.
                })
                console.log("deneme"+$scope.page_data);
            }
            $scope.page_view = function(){//sayfayı görüntüle fonksiyonu
                console.log($scope.goster_url);
                $scope.select_sample=true;
                if ($scope.goster_url=="/"){
                    $scope.redirec="/"+$scope.contextPath+$scope.goster_url;
                }
                else{
                    $scope.redirec="/"+$scope.contextPath+"/pages"+$scope.goster_url;
                }
                window.open($scope.redirec);
            }
            $scope.page_info = function(){ // sayfa bilgilerini döndürür.
                $scope.select_Sample=true;
                $http({
                    method: 'POST',
                    url: 'dashboard/getPage',
                    data: {id:$scope.global_secilen_page}
                }).then(function successCallback(response) {
                    $scope.sayfa_duzenleme = response.data;

                }, function errorCallback(response) {
                    // called asynchronously if an error occurs
                    // or server returns response with an error status.
                })
            }
            $scope.page_update_advenced = function () { // gelişmiş sayfa güncellemesi
                var pagetype="";
                if($scope.page_type_advanced==0){
                    pagetype="blog";
                }
                if($scope.page_type_advanced==1){
                    pagetype="home";
                }
                if($scope.page_type_advanced==2){
                    pagetype="sample";
                }
                var page = {id:$scope.global_secilen_page,title:$scope.adv_title,url:$scope.adv_url,pageType:pagetype};
                console.log(page);
                $http({
                    method: 'POST',
                    url: 'dashboard/updatePageAdvanced',
                    data:page
                }).then(function successCallback(response) {
                    $scope.init();
                }, function errorCallback(response) {
                    // called asynchronously if an error occurs
                    // or server returns response with an error status.
                })
            }
            $scope.checkAll = function (checked) {
                if($scope.check1){
                    $scope.input_title = $scope.check1;
                }else if($scope.check1==false){
                    $scope.input_title = $scope.check1;
                }
                if($scope.check2){
                    $scope.input_url = $scope.check2;
                }else if ($scope.check2==false){
                    $scope.input_url = $scope.check2;
                }


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
        .capitalize {
            text-transform: capitalize;
        }
        .file-upload {
            background-color: #ffffff;
            margin: 0 auto;
            padding: 20px;
        }

        .file-upload-btn {
            width: 100%;
            margin: 0;
            color: #fff;
            background: #1FB264;
            border: none;
            padding: 10px;
            border-radius: 4px;
            border-bottom: 4px solid #15824B;
            transition: all .2s ease;
            outline: none;
            text-transform: uppercase;
            font-weight: 700;
        }

        .file-upload-btn:hover {
            background: #1AA059;
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
            width: 100%;
            height: 100%;
            outline: none;
            opacity: 0;
            cursor: pointer;
        }

        .image-upload-wrap {
            margin-top: 20px;
            border: 2px dashed #1FB264;
            position: relative;
        }

        .image-dropping,
        .image-upload-wrap:hover {
            border: 2px dashed #7FB264;
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
            color: #15824B;
            padding: 60px 0;
        }

        .file-upload-image {
            max-height: 200px;
            max-width: 200px;
            margin: auto;
            padding: 20px;
        }

        .remove-image {
            width: 200px;
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

        <main role="main" class="col-md-9 ml-sm-auto col-lg-10 px-4">
            <div class="d-flex justify-content-between flex-wrap flex-md-nowrap align-items-center pt-3 pb-2 mb-3 border-bottom">
                <h1 class="capitalize h2">Sayfalar - {{page_selected_value.title}}</h1>
                <div class="btn-toolbar mb-2 mb-md-0">
                    <div class="btn-group mr-2">
                        <button type="button"  data-toggle="modal" data-target="#exampleModal" class="btn btn-sm btn-outline-danger">Sayfayı Sil</button>
                        <button type="button" data-toggle="modal" ng-click="page_info()" data-target="#exampleModal2" class="btn btn-sm btn-outline-secondary">Sayfayı Düzenle</button>
                        <button type="button"  data-toggle="modal" data-target="#imageUpload" class="btn btn-sm btn-outline-primary">Resim Yükle</button>
                        <button type="button"  data-toggle="modal" data-target="#exampleModalİmgse" class="btn btn-sm btn-outline-secondary">Resimleri Görüntüle</button>
                        <button type="button" ng-click="page_view()" class="btn btn-sm btn-outline-primary">Sayfayı Görüntüle</button>
                    </div>
                    <button type="button" class="btn btn-sm btn-outline-secondary dropdown-toggle">
                        <span data-feather="calendar"></span>
                        Menü
                    </button>
                </div>
            </div>


            <!-- Modal -->
            <div class="modal fade" id="exampleModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
                <div class="modal-dialog" role="document">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title" id="exampleModalLabel">Uyarı</h5>
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                <span aria-hidden="true">&times;</span>
                            </button>
                        </div>
                        <div class="modal-body">
                            Sayfa içeriklerini silmek üzeresiniz onaylıyormusunuz?
                            <%--{{delete_message}}--%>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary" data-dismiss="modal">Kapat</button>
                            <button type="button" class="btn btn-primary"  ng-click="page_delete()" data-dismiss="modal">Sil</button>
                        </div>
                    </div>
                </div>
            </div>
            <!-- Modal Select İmages -->
            <div class="modal fade bd-example-modal-xl" tabindex="-1" role="dialog" id ="exampleModalİmgse" aria-labelledby="myExtraLargeModalLabel" aria-hidden="true">
                <div class="modal-dialog modal-xl">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title" id="exampleModalLabel">Resimler</h5>
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                <span aria-hidden="true">&times;</span>
                            </button>
                        </div>
                        <div class="modal-body">
                            <div class="row" style="margin: 0 auto;">
                                <div class="resim_listele col-sm-2" style="" ng-repeat="r in rsmler">
                                    <img src={{r.imageBase64}} width="150" height="150" alt="..." class="rounded">
                                </div>
                            </div>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary" data-dismiss="modal">Kapat</button>
                            <button type="button" class="btn btn-primary"  ng-click="page_delete()" data-dismiss="modal">Sil</button>
                        </div>
                    </div>
                </div>
            </div>
            <!-- Modal Upload İmage -->
            <div class="modal fade" id="imageUpload" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
                <div class="modal-dialog" role="document">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title" id="exampleModalLabel">Resim yükleme</h5>
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                <span aria-hidden="true">&times;</span>
                            </button>
                        </div>
                        <div class="modal-body">
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
                                    <input type="text" ng-disabled="myinput==false" style="padding:4px;width: 300px;background:#ddd;border:1px solid#ccc;" value={{yuklenenimg}} id="myInput">
                                    <button type="button" class="btn btn-outline-primary" style="float: right;height: 30px;padding: 3px;" onclick="myFunction()">Url yi kopyala</button>
                                </div>
                            </div>

                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary" data-dismiss="modal">Kapat</button>
                            <button type="button" class="btn btn-primary"  ng-click="uploadimage()" >Yükle</button>
                        </div>
                    </div>
                </div>
            </div>
            <!-- Modal Edit Page -->
            <div class="modal fade" id="exampleModal2" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
                <div class="modal-dialog" role="document">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title" id="exampleModalLabel2">Sayfa Düzenleme</h5>
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                <span aria-hidden="true">&times;</span>
                            </button>
                        </div>
                        <div class="modal-body">
                            <b>Sayfa Adı</b>
                            <div class="input-group mb-3">
                                <div class="input-group-prepend">
                                    <div class="input-group-text">
                                        <input type="checkbox" ng-model="check1" ng-change="checkAll(check1)" aria-label="Checkbox for following text input" placeholder="">
                                    </div>
                                </div>
                                <input type="text" ng-disabled="input_title==false" ng-model="adv_title" class="form-control capitalize" aria-label="Text input with checkbox" placeholder="{{sayfa_duzenleme.title}}">
                            </div>
                            <b>Sayfa Url</b>
                            <div class="input-group mb-3">
                                <div class="input-group-prepend">
                                    <div class="input-group-text">
                                        <input type="checkbox" ng-model="check2" ng-change="checkAll(check2)" aria-label="Checkbox for following text input" placeholder="">
                                    </div>
                                </div>
                                <input type="text" class="form-control" ng-disabled="input_url==false" ng-model = "adv_url" aria-label="Text input with checkbox" placeholder="{{sayfa_duzenleme.url}}">
                            </div>
                            <b>Sayfa Türü</b>
                            <div class="input-group mb-3">
                                <select class="form-control" ng-model="page_type_advanced" id="exampleFormControlSelect1">
                                    <option disabled selected value> -- sayfa türünü seçin -- </option>

                                    <option value="0" ng-selected = "select_Sample==true" selected>Boş Sayfa</option>
                                    <option value="1">Blog</option>
                                    <option value="2">Ana Sayfa</option>
                                    <option value="3">İletişim</option>

                                </select>
                            </div>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary" data-dismiss="modal">Kapat</button>
                            <button type="button" class="btn btn-primary"  ng-click="page_update_advenced()" data-dismiss="modal">Kaydet</button>
                        </div>
                    </div>
                </div>
            </div>
            <div ng-show="alertShow" class="alert alert-{{alert_type}} alert-dismissible fade show" role="alert">
                {{alertContent}}

            </div>
            <p>
                <a class="btn btn-sm btn-outline-secondary" data-toggle="collapse" href="#collopen" role="button" aria-expanded="false" aria-controls="collapseExample">
                    Yeni Sayfa Oluştur
                </a>
            </p>
            <div class="collapse" id="collopen">
                <div class="card card-body">
                    <div class="container">
                        <div class="row">
                            <div class="input-group mb-3">
                                <div class="input-group-prepend">
                                    <button class="btn btn-outline-success" ng-click="createPage(false)" type="button">Sayfayı Oluştur</button>
                                    <button class="btn btn-outline-secondary" ng-click="createPage(true)" type="button">Taslak Oluştur</button>

                                </div>
                                <input type="text" class="form-control"  ng-model="page_name" placeholder="Sayfa adını giriniz">
                            </div>
                            <div class="form-check">
                                <input class="form-check-input" type="checkbox" ng-model="gelismis" ng-change="gelismis_secenek_checkbox_event()" value="" id="defaultCheck1">
                                <label class="form-check-label" for="defaultCheck1">
                                    Gelişmiş Seçenekler
                                </label>
                            </div>
                            <div class="w-100"></div>
                            <div class="col-sm">
                                <select  ng-model="page_type" ng-disabled="gelismis_secenek==false" class="custom-select my-1 mr-sm-2" id="inlineFormCustomSelectPref">
                                    <option value="0" selected>Sayfa Türü</option>
                                    <option value="1">Blog</option>
                                    <option value="2">Ana Sayfa</option>
                                    <option value="3">Boş Sayfa</option>
                                    <option value="4">İletişim</option>
                                </select>
                            </div>
                            <div class="col-sm">
                                <div class="input-group flex-nowrap" style="margin-top: 4px;">
                                    <div class="input-group-prepend">
                                        <span class="input-group-text" id="addon-wrapping">/</span>
                                    </div>
                                    <input ng-model="page_url_opt" ng-disabled="gelismis_secenek==false" type="text" class="form-control" placeholder="Sayfa Urlsi Giriniz" aria-label="Url" aria-describedby="addon-wrapping">
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="container" style="margin-top: 20px;">
                <div class="row">
                    <div class="col-sm-9">
                        <form  method="post" ng-submit="formu_gonder()" data-sample-short>
                            <textarea name="editor1" id="editor1" rows="10" cols="80">
                                <%--This is my textarea to be replaced with CKEditor.--%>
                            </textarea>
                            <script>
                                // Replace the <textarea id="editor1"> with a CKEditor
                                // instance, using default configuration.
                                CKEDITOR.replace('editor1', {
                                    height: 600,
                                });

                            </script>
                            <p><input class="btn btn-primary" style="margin-top: 15px;margin-right:17px;" type="submit" value="Kaydet">
                                <button type="button" ng-disabled = "taslakbutton==false" ng-click="updateDraftPage()" style="margin-top: 15px;" class="btn btn-success">Taslaklara Kaydet</button></p>


                        </form>

                    </div>
                    <div class="col-sm-3">
                        <ul class="list-group">
                            <li class="list-group-item" ng-repeat="page in pages | orderBy:'title'"><a class="capitalize" href="" ng-click="page_select(page.id)">{{page.title}}</a></li>
                        </ul>
                        <h3 style="margin-top:50px;text-align:center;">Taslaklar</h3>
                        <ul class="list-group">
                            <li class="list-group-item" ng-repeat="page in draftPage | orderBy:'title'"><a class="capitalize" href="" ng-click="page_select(page.id)">{{page.title}}</a></li>
                        </ul>
                    </div>
                </div>
            </div>
        </main>
    </div>
</div>
<%--<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>--%>
<script>window.jQuery || document.write('<script src="/docs/4.3/assets/js/vendor/jquery-slim.min.js"><\/script>')</script><script src="/js/bootstrap.bundle.min.js" integrity="sha384-xrRywqdh3PHs8keKZN+8zzc5TX0GRTLCcmivcbNJWm2rs5C8PRhcEn3czEjhAO9o" crossorigin="anonymous"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/feather-icons/4.9.0/feather.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.7.3/Chart.min.js"></script>
<script src="https://getbootstrap.com/docs/4.3/examples/dashboard/dashboard.js"></script></body>
</html>

