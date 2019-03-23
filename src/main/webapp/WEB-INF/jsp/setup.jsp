<%--
  Created by IntelliJ IDEA.
  User: ufukunsal
  Date: 2019-03-15
  Time: 15:41
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>

    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="Colorlib Templates">
    <meta name="author" content="Colorlib">
    <meta name="keywords" content="Colorlib Templates">

    <title>Yapılandırma Ayarları</title>

    <link href="vendor/mdi-font/css/material-design-iconic-font.min.css" rel="stylesheet" media="all">
    <link href="vendor/font-awesome-4.7/css/font-awesome.min.css" rel="stylesheet" media="all">

    <link href="https://fonts.googleapis.com/css?family=Open+Sans:300,300i,400,400i,600,600i,700,700i,800,800i" rel="stylesheet">

    <link href="vendor/select2/select2.min.css" rel="stylesheet" media="all">
    <link href="vendor/datepicker/daterangepicker.css" rel="stylesheet" media="all">

    <link href="css/main.css" rel="stylesheet" media="all">

    <!-- Angular Library -->
    <script src="https://ajax.googleapis.com/ajax/libs/angularjs/1.7.7/angular.min.js"></script>

    <script>
        var app = angular.module('myApp', []);
        app.controller('myAppcntrl', function ($scope, $http, $log,$location,$timeout,$window) {
            $scope.myhostname = $location.host();
            $scope.formu_gonder = function () {
                $http({
                    method: 'POST',
                    url: 'user/initalize',
                    data: {user:{username:$scope.kullanici_adi,
                            password:$scope.sifre,email:$scope.email,unvan:$scope.unvan,firstName:$scope.first_name,lastName:$scope.last_name},isAdmin:$scope.adminknt,url:$scope.url}
                }).then(function successCallback(response) {
                    $scope.load_effect=true;
                    $timeout(function() {
                        $window.location.href = '/'+$scope.url+'/';
                    }, 26000);
                    //$scope.person=response.data;
                }, function errorCallback(response) {
                    // called asynchronously if an error occurs
                    // or server returns response with an error status.
                })
                console.log("deneme");
                //alert("deneme");
            };

        })

    </script>

</head>
<body ng-app="myApp" ng-controller="myAppcntrl">
<div class="page-wrapper p-t-45 p-b-50">
    <div class="wrapper wrapper--w790">
        <div class="card card-5">
            <div class="card-heading">
                <h2 class="title">Yapılandırma Ayarları</h2>
            </div>
            <div class="card-body">
                    <div class="form-row m-b-55">
                        <div class="name">İsim Bilgileri</div>
                        <div class="value">
                            <div class="row row-space">
                                <div class="col-2">
                                    <div class="input-group-desc">
                                        <input class="input--style-5" type="text"  ng-model="first_name" name="first_name">
                                        <label class="label--desc">adınız</label>
                                    </div>
                                </div>
                                <div class="col-2">
                                    <div class="input-group-desc">
                                        <input class="input--style-5" type="text" ng-model="last_name" name="last_name">
                                        <label class="label--desc">soyadınız</label>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="form-row">
                        <div class="name">Ünvan</div>
                        <div class="value">
                            <div class="input-group">
                                <input class="input--style-5" type="text" ng-model="unvan" name="unvan">
                            </div>
                        </div>
                    </div>
                    <div class="form-row">
                        <div class="name">Email</div>
                        <div class="value">
                            <div class="input-group">
                                <input class="input--style-5" type="email" ng-model="email" name="email">
                            </div>
                        </div>
                    </div>
                    <div class="form-row">
                        <div class="name">Sitenizin Başlığı</div>
                        <div class="value">
                            <div class="input-group">
                                <input class="input--style-5" type="text" ng-model="title" name="title" placeholder="Title">
                            </div>
                        </div>
                    </div>
                    <div class="form-row">
                        <div class="name">Çalışma Url /</div>
                        <div class="value">
                            <div class="input-group">
                                <input class="input--style-5" type="text" ng-model="url" name="url" placeholder="örneğin /isminiz gibi">
                            </div>
                        </div>
                    </div>
                    <div class="form-row">
                        <div class="name">Kullanıcı Adınız</div>
                        <div class="value">
                            <div class="input-group">
                                <input class="input--style-5" type="text" ng-model="kullanici_adi" name="kullanıcı_adı">
                            </div>
                        </div>
                    </div>

                    <div class="form-row">
                        <div class="name">Şifreniz</div>
                        <div class="value">
                            <div class="input-group">
                                <input class="input--style-5" type="password" ng-model="sifre" name="sifre">
                            </div>
                        </div>
                    </div>

                    <div class="form-row p-t-20">
                        <label class="label label--block">Kullanıcıyı admin yetkilerinde kaydet?</label>
                        <div class="p-t-15">
                            <label class="radio-container m-r-55">Evet
                                <input ng-model="adminknt" ng-value=1 type="radio" checked="checked" name="exist">
                                <span class="checkmark"></span>
                            </label>
                            <label class="radio-container">Hayır
                                <input ng-model="adminknt" ng-value=0 type="radio" name="exist">
                                <span class="checkmark"></span>
                            </label>
                        </div>
                    </div>
                    <div ng-show="load_effect" class="loading-container">
                        <div class="loading"></div>
                        <div id="loading-text">Web Sayfanız Hazırlanıyor</div>
                    </div>
                    <div>
                        <button class="btn btn--radius-2 btn--red" ng-click="formu_gonder()" data-toggle="modal" data-target="#exampleModal" type="submit">Gönder</button>
                    </div>
            </div>
        </div>
    </div>

</div>

<script src="vendor/jquery/jquery.min.js" type="6d266df4bd433f1283fbdd17-text/javascript"></script>

<script src="vendor/select2/select2.min.js" type="6d266df4bd433f1283fbdd17-text/javascript"></script>
<script src="vendor/datepicker/moment.min.js" type="6d266df4bd433f1283fbdd17-text/javascript"></script>
<script src="vendor/datepicker/daterangepicker.js" type="6d266df4bd433f1283fbdd17-text/javascript"></script>

<script src="js/global.js" type="6d266df4bd433f1283fbdd17-text/javascript"></script>

<script async src="https://www.googletagmanager.com/gtag/js?id=UA-23581568-13" type="6d266df4bd433f1283fbdd17-text/javascript"></script>
<script type="6d266df4bd433f1283fbdd17-text/javascript">
  window.dataLayer = window.dataLayer || [];
  function gtag(){dataLayer.push(arguments);}
  gtag('js', new Date());

  gtag('config', 'UA-23581568-13');
</script>
<script src="https://ajax.cloudflare.com/cdn-cgi/scripts/a2bd7673/cloudflare-static/rocket-loader.min.js" data-cf-settings="6d266df4bd433f1283fbdd17-|49" defer=""></script></body>
</html>
