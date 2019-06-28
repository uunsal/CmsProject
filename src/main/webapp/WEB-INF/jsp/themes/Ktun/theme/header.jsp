<%--
  Created by IntelliJ IDEA.
  User: ufuk
  Date: 2019-05-23
  Time: 17:54
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<style>
    .capitalize {
        text-transform: capitalize;
    }
</style>
<html lang="tr" class="h-100">
<%--<jsp:include page="admin/adminHeader.jsp" />--%>

<header style="margin-bottom: 100px;">

    <!-- Fixed navbar -->
    <nav class="navbar navbar-expand-md navbar-light fixed-top" style="background:#fff;margin-top:10px;">
        <div class="container">
            <div class="navbar-brand" href="#">
                <img src="http://ktun.edu.tr/Content/images/logo/logo7.png" width="260"  class="d-inline-block align-top" alt="">

            </div> <div style="margin-right: 25px;font-weight: bold;"> - ${setting.user.unvan} ${setting.user.firstName} ${setting.user.lastName}</div>
        <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarCollapse" aria-controls="navbarCollapse" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarCollapse">
            <ul class="navbar-nav mr-auto capitalize" style="font-weight: bold;">
                <c:forEach items="${pages}" var="page_item" varStatus="status">
                    <c:if test = '${page_item.url=="/"}'>
                        <li class="nav-item active">
                            <a href="${setting.url}${page_item.url}" class="nav-link">${page_item.title}</a>
                        </li>
                    </c:if>
                    <c:if test = '${page_item.url!="/"}'>
                        <li class="nav-item">
                            <a href="${setting.url}/pages${page_item.url}" class="nav-link">${page_item.title}</a>
                        </li>
                    </c:if>

                </c:forEach>
            </ul>

        </div>
            </div>
    </nav>
</header>

<div class="capitalize" style="margin-bottom:25px;background:#f5f5f5;border-bottom:1px solid #ddd;border-top:1px solid #ddd;padding:4px;"><div class="container">
    ${page.title}
</div></div>