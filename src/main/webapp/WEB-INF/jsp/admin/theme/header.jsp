<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<nav class="navbar navbar-dark fixed-top bg-dark flex-md-nowrap p-0 shadow">
    <a class="navbar-brand col-sm-3 col-md-2 mr-0" href="#">Kullanıcı - ${user}</a>
    <img src="http://ktun.edu.tr/Content/images/logo/logo4.png" height="30px" width="100px" style="background: #fff;border: 1px solid #ddd;text-align: center;margin: 0 auto;" alt="..." class="rounded">
    <ul class="navbar-nav px-3">
        <li class="nav-item text-nowrap">
            <form action="${pageContext.request.contextPath}/admin/logout" method="post">
                <input class="btn btn-success" type="submit" value="Çıkış"> <input type="hidden"
                                                            name="${_csrf.parameterName}" value="${_csrf.token}">
            </form>
        </li>
    </ul>
</nav>