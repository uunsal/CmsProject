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


</c:if>