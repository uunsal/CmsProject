<%--
  Created by IntelliJ IDEA.
  User: ufukunsal
  Date: 2019-05-09
  Time: 20:25
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<script src="https://cdn.ckeditor.com/4.11.3/full/ckeditor.js"></script>
<!-- Angular Library -->
<style>
    /*
 * Navbar
 */

    .navbar-brand {
        padding-top: .75rem;
        padding-bottom: .75rem;
        font-size: 1rem;
        /*background-color: rgba(0, 0, 0, .25);*/
        /*box-shadow: inset -1px 0 0 rgba(0, 0, 0, .25);*/
    }

    .navbar .form-control {
        padding: .75rem 1rem;
        border-width: 0;
        border-radius: 0;

    }

    .form-control-dark {
        color: #fff;
        background-color: rgba(255, 255, 255, .1);
        border-color: rgba(255, 255, 255, .1);
    }

    .form-control-dark:focus {
        border-color: transparent;
        box-shadow: 0 0 0 3px rgba(255, 255, 255, .25);
    }
    .dropdown-item{
        background: #222222;
    }
    .dropdown-menu{
        background: #222222;
    }
</style>
<script>
    var app = angular.module('myApp', []);
    app.controller('myAppcntrl', function ($scope, $http, $log,$location,$timeout,$window) {

        $scope.page_select = function (data) {
            $http({
                method: 'POST',
                url: '/admin/dashboard/getPage',
                data: {id:data}
            }).then(function successCallback(response) {
                $scope.page_selected_value=response.data;
                console.log($scope.page_selected_value.draft);
                $scope.global_secilen_page=$scope.page_selected_value.id;
                CKEDITOR.instances.editor1.setData($scope.page_selected_value.contents+"\n");
                $scope.goster_url=$scope.page_selected_value.url;

            }, function errorCallback(response) {
                // called asynchronously if an error occurs
                // or server returns response with an error status.
            })
        }

        $scope.formu_gonder = function (data) {
            $scope.page_data = CKEDITOR.instances.editor1.getData();
            console.log($scope.page_data)
            $http({
                method: 'POST',
                url: '/admin/dashboard/updatePage',
                data: {contents:$scope.page_data,id:data}
            }).then(function successCallback(response) {
                //$scope.person=response.data;
                $scope.alertFunct(true,"success","Sayfa kaydedildi!");

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
                $window.location.reload();
            }, 3600);
        }
    })
</script>
<c:if test="${auth==true}">
    ${auth}
<nav class="navbar navbar-dark fixed-top bg-dark flex-md-nowrap p-0 shadow" style="">
    <a class="navbar-brand col-sm-3 col-md-3 mr-0" href="#">
        Kullanıcı - ${user}
    </a>
    <img src="http://ktun.edu.tr/Content/images/logo/logo4.png" height="30px" width="100px" style="background: #fff;border: 1px solid #ddd;" alt="..." class="rounded">

    <ul class="navbar-nav px-3">
        <div class="btn-group" role="group" aria-label="Button group with nested dropdown">
            <a type="" href="/admin" class="btn btn-secondary bg-dark">Admin Sayfası</a>
            <button type="button" ng-click="page_edit()" class="btn btn-secondary bg-dark"  data-toggle="modal" data-target=".bd-example-modal-xl" style="margin-right: 10px">Sayfayı Düzenle</button>
            <form action="${pageContext.request.contextPath}/admin/logout" method="post">
                <input class="btn btn-success" type="submit" value="Çıkış"> <input type="hidden"
                name="${_csrf.parameterName}" value="${_csrf.token}">
            </form>


        </div>

        <%--<li class="nav-item text-nowrap">--%>

        <%--</li>--%>
    </ul>
</nav>
<div style="height: 20px;"></div>
    <div  ng-app="myApp" ng-controller="myAppcntrl" ng-init="page_select('${page.id}')" class="modal fade bd-example-modal-xl" tabindex="-1" role="dialog" aria-labelledby="myExtraLargeModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-xl">
            <div class="modal-content" style="padding: 10px;">
                    <div class="col-sm-12">
                        <div ng-show="alertShow" class="alert alert-{{alert_type}} alert-dismissible fade show" role="alert">
                            {{alertContent}}

                        </div>
                        <center><span style="font-weight: bold; border-bottom: 2px solid #a00;padding:5px;" class="text-capitalize">{{page_selected_value.title}}</span></center>
                        </br>
                        <form  method="post" ng-submit="formu_gonder('${page.id}')" data-sample-short>
                            <textarea name="editor1" id="editor1" rows="10" cols="80">
                                    <%--This is my textarea to be replaced with CKEditor.--%>
                            </textarea>
                            <script>
                                // Replace the <textarea id="editor1"> with a CKEditor
                                // instance, using default configuration.
                                CKEDITOR.replace('editor1', {
                                    height: 400,
                                });

                            </script>
                            <p><input class="btn btn-primary" style="margin-top: 15px;margin-right:17px;" type="submit" value="Kaydet">


                        </form>

                    </div>
            </div>
        </div>
    </div>

</c:if>