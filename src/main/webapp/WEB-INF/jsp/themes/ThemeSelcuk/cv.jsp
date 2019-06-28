<%--
  Created by IntelliJ IDEA.
  User: ufukunsal
  Date: 2019-03-16
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
    <script src="https://ajax.googleapis.com/ajax/libs/angularjs/1.7.7/angular.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/angular-sanitize/1.7.8/angular-sanitize.js" ></script>
    <link rel="canonical" href="https://getbootstrap.com/docs/4.0/examples/sticky-footer-navbar/">
    <link href="http://ktun.edu.tr/Content/css/timeline.css" rel="stylesheet">

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
    var htmls;
    var app = angular.module('myApp', ['ngSanitize']);
    app.controller('myAppcntrl', function ($scope, $http, $log,$location,$timeout,$window,$sce) {
        var ids="";
        $scope.init = function(contentdata){
            $http({
                method: 'GET',
                url: 'cvId',
            }).then(function successCallback(response) {
                console.log(response.data.id);
                ids = response.data.id;
                $scope.buttonClick("KisiselBilgiler")

            }, function errorCallback(response) {
                console.log(response.data);
                // called asynchronously if an error occurs
                // or server returns response with an error status.
            })

        }
        $scope.buttonClick=function(url){
            console.log(url)
            $http({
                method: 'POST',
                url: '/cv/post',
                data: {id:ids,url:url}
            }).then(function successCallback(response) {
                console.log(response.data);
                $scope.myText=response.data.content;
                $scope.users =response.data;
                $('#content').html($scope.myText);


            }, function errorCallback(response) {
                console.log(response.data);
                // called asynchronously if an error occurs
                // or server returns response with an error status.
            })
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
    <div class="container" style="margin-top: 50px;margin-bottom:120px;">
        <div class="row"> <img class="img-thumbnail image-text" style="float:left; width:150px; height: 180px;border-radius: 50%;" alt="" src={{users.image}}>
            <div class="col-sm-5 col-md-5 col-xs-12" style="margin-top:15px;">
                <h4 style="color:#c22230">{{users.name}}</h4>
                <h6 style="font-size: 14px;">
                    {{users.unvan}}
                </h6><br />
                <h6>

                    <img src={{users.email}} />
                </h6>
            </div>

        </div>
        <ul class="nav nav-tabs" style="padding: 9px;" id="myTab" role="tablist">
            <li class="nav-item">
                <button class="btn btn-outline-danger"  ng-click="buttonClick('KisiselBilgiler')" style="margin-right:10px; padding: 3px; font-size: 13px;" id="home-tab" data-toggle="tab" href="#" role="tab" aria-controls="home" aria-selected="true">Kişisel Bilgiler</button>
            </li>
            <li class="nav-item">
                <a class="btn btn-outline-danger" ng-click="buttonClick('KitapListesi')" style="margin-right:10px; padding: 3px; font-size: 13px;" id="profile-tab" data-toggle="tab" href="#" role="tab" aria-controls="profile" aria-selected="false">Kitaplar</a>
            </li>
            <li class="nav-item">
                <a class="btn btn-outline-danger" ng-click="buttonClick('MakaleListesi')" style="margin-right:10px; padding: 3px; font-size: 13px;" id="contact-tab" data-toggle="tab" href="#" role="tab" aria-controls="contact" aria-selected="false">Makaleler</a>
            </li>
            <li class="nav-item">
                <a class="btn btn-outline-danger" ng-click="buttonClick('BildiriListesi')" style="margin-right:10px; padding: 3px; font-size: 13px;" id="home-tab" data-toggle="tab" href="#" role="tab" aria-controls="home" aria-selected="true">Bildiriler</a>
            </li>
            <li class="nav-item">
                <a class="btn btn-outline-danger"  ng-click="buttonClick('ProjeListesi')" style="margin-right:10px; padding: 3px; font-size: 13px;" id="profile-tab" data-toggle="tab" href="#" role="tab" aria-controls="profile" aria-selected="false">Projeler</a>
            </li>
            <li class="nav-item">
                <a class="btn btn-outline-danger" ng-click="buttonClick('DersListesi')" style="margin-right:10px; padding: 3px; font-size: 13px;" id="contact-tab" data-toggle="tab" href="#" role="tab" aria-controls="contact" aria-selected="false">Dersler</a>
            </li>
            <li class="nav-item">
                <a class="btn btn-outline-danger" ng-click="buttonClick('TezListesi')" style="margin-right:10px; padding: 3px; font-size: 13px;" id="home-tab" data-toggle="tab" href="#" role="tab" aria-controls="home" aria-selected="true">Yönetilen Tezler</a>
            </li>
            <li class="nav-item">
                <a class="btn btn-outline-danger" ng-click="buttonClick('OdulListesi')" style="margin-right:10px; padding: 3px; font-size: 13px;" id="profile-tab" data-toggle="tab" href="#" role="tab" aria-controls="profile" aria-selected="false">Ödüller</a>
            </li>
            <li class="nav-item">
                <a class="btn btn-outline-danger" ng-click="buttonClick('PatentListesi')" style="margin-right:10px; padding: 3px; font-size: 13px;" id="contact-tab" data-toggle="tab" href="#" role="tab" aria-controls="contact" aria-selected="false">Patentler</a>
            </li>
            <li class="nav-item">
                <a class="btn btn-outline-danger" ng-click="buttonClick('UyelikListesi')" style="margin-right:10px; padding: 3px; font-size: 13px;" id="profile-tab" data-toggle="tab" href="#" role="tab" aria-controls="profile" aria-selected="false">Üyelikler</a>
            </li>
            <li class="nav-item">
                <a class="btn btn-outline-danger" ng-click="buttonClick('IdariGorevListesi')" style="margin-right:10px; padding: 3px; font-size: 13px;" id="contact-tab" data-toggle="tab" href="#" role="tab" aria-controls="contact" aria-selected="false">İdari Görevler</a>
            </li>
            <li class="nav-item">
                <a class="btn btn-outline-danger" ng-click="buttonClick('UniversiteDisiDeneyimListesi')" style="margin-right:10px; padding: 3px; font-size: 13px;" id="contact-tab" data-toggle="tab" href="#" role="tab" aria-controls="contact" aria-selected="false">Üniversite Dışı Deneyim</a>
            </li>
        </ul>
        <br />
        <div class="row"  id="content">
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
