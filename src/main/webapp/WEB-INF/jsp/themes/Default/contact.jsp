<%--
  Created by IntelliJ IDEA.
  User: ufukunsal
  Date: 2019-03-16
  Time: 12:35
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html lang="en">

<head>

    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="">
    <meta name="author" content="">

    <title>${page.title}</title>

    <!-- Bootstrap core CSS -->
    <link href="${pageContext.request.contextPath}/css/bootstrap.min.css" rel="stylesheet">
    <!-- Angular Library -->
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
                $scope.yukle=false;

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
                    $scope.yukle=true;
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
                $scope.yukle=false;
                $timeout(function() {
                    $scope.alertShow=false;
                }, 3600);
            }

        })

    </script>

    <style>
        .capitalize {
            text-transform: capitalize;
        }
        ${setting.customCss}
    </style>
</head>
<!-- Ust Menu -->
<jsp:include page="admin/adminHeader_other.jsp" />
<body ng-app="myApp" ng-controller="myAppcntrl" ng-init="init()">

<div class="d-flex" id="wrapper">

    <!-- Sidebar -->
    <div class="bg-dark border-right" id="sidebar-wrapper">
        <div class="sidebar-heading text-light" style="">${setting.user.unvan} ${setting.user.firstName} ${setting.user.lastName}</div>
        <div class="text-center" style="margin-bottom: 20px;">
            <c:if test = '${setting.profilePhoto!=null}'>
                <img src=${setting.profilePhoto} height="200" width="200" class="rounded-circle img-thumbnail">
            </c:if>
            <c:if test = '${setting.profilePhoto==null}'>
                <img src="data:image/svg+xml;charset=UTF-8,%3Csvg%20width%3D%22200%22%20height%3D%22200%22%20xmlns%3D%22http%3A%2F%2Fwww.w3.org%2F2000%2Fsvg%22%20viewBox%3D%220%200%20200%20200%22%20preserveAspectRatio%3D%22none%22%3E%3Cdefs%3E%3Cstyle%20type%3D%22text%2Fcss%22%3E%23holder_16a185748c4%20text%20%7B%20fill%3Argba(255%2C255%2C255%2C.75)%3Bfont-weight%3Anormal%3Bfont-family%3AHelvetica%2C%20monospace%3Bfont-size%3A10pt%20%7D%20%3C%2Fstyle%3E%3C%2Fdefs%3E%3Cg%20id%3D%22holder_16a185748c4%22%3E%3Crect%20width%3D%22200%22%20height%3D%22200%22%20fill%3D%22%23777%22%3E%3C%2Frect%3E%3Cg%3E%3Ctext%20x%3D%2273.6015625%22%20y%3D%22104.359375%22%3E200x200%3C%2Ftext%3E%3C%2Fg%3E%3C%2Fg%3E%3C%2Fsvg%3E" class="rounded-circle img-thumbnail">
            </c:if>
        </div>        <div class="list-group list-group-flush" style="text-align: center" >
            <c:forEach items="${pages}" var="page_item" varStatus="status">
                <c:if test = '${page_item.url=="/"}'>
                    <a href="${setting.url}${page_item.url}" class="list-group-item list-group-item-action bg-dark text-light capitalize">${page_item.title}</a>
                </c:if>
                <c:if test = '${page_item.url!="/"}'>
                    <a href="${setting.url}/pages${page_item.url}" class="list-group-item list-group-item-action bg-dark text-light capitalize">${page_item.title}</a>
                </c:if>

            </c:forEach>


        </div>
    </div>
    <!-- /#sidebar-wrapper -->

    <!-- Page Content -->
    <div id="page-content-wrapper">

        <nav class="navbar navbar-expand-lg navbar-light bg-light border-bottom">
            <a class="capitalize" style="font-weight: bold;"><span class="badge badge-secondary" style="font-size:17px;"> ${page.title}</span></a>
        </nav>

        <div class="container-fluid" style="padding: 40px;">
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
            <div class="loader" style="padding-left:5px;" ng-show="yukle">
            <div class="spinner-grow text-primary" role="status">
                <span class="sr-only">Loading...</span>
            </div>
            <div class="spinner-grow text-secondary" role="status">
                <span class="sr-only">Loading...</span>
            </div>
            <div class="spinner-grow text-success" role="status">
                <span class="sr-only">Loading...</span>
            </div>
            <div class="spinner-grow text-danger" role="status">
                <span class="sr-only">Loading...</span>
            </div>
            <div class="spinner-grow text-warning" role="status">
                <span class="sr-only">Loading...</span>
            </div>
            <div class="spinner-grow text-info" role="status">
                <span class="sr-only">Loading...</span>
            </div>
            <div class="spinner-grow text-light" role="status">
                <span class="sr-only">Loading...</span>
            </div>
            </div>
        </div>
    </div>
    <!-- /#page-content-wrapper -->

</div>
<!-- /#wrapper -->

<!-- Bootstrap core JavaScript -->
<script src="${pageContext.request.contextPath}/vendor/jquery/jquery.min.js"></script>
<script src="${pageContext.request.contextPath}/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>

<!-- Menu Toggle Script -->
<script>
    $("#menu-toggle").click(function(e) {
        e.preventDefault();
        $("#wrapper").toggleClass("toggled");
    });
</script>

</body>

</html>

