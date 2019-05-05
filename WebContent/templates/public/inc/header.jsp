<%@page import="util.StringUtil"%>
<%@page import="model.bean.Category"%>
<%@page import="java.util.ArrayList"%>
<%@page import="model.dao.CatDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="description" content="">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <!-- The above 4 meta tags *must* come first in the head; any other head content must come *after* these tags -->

    <!-- Title  -->
    <title>ShareIT - Blog</title>

    <!-- Favicon  -->
    <link rel="icon" href="<%=request.getContextPath()%>/templates/public/img/core-img/circled_s.png">
    
    <!-- Style CSS -->
    <link rel="stylesheet" href="<%=request.getContextPath()%>/templates/public/style.css">

</head>

<body>
    <!-- Preloader Start -->
    <div id="preloader">
        <div class="preload-content">
            <div id="world-load"></div>
        </div>
    </div>
    <!-- Preloader End -->

    <!-- ***** Header Area Start ***** -->
    <header class="header-area">
        <div class="container">
            <div class="row">
                <div class="col-12">
                    <nav class="navbar navbar-expand-lg">
                        <!-- Logo -->
                        <a class="navbar-brand" href="<%=request.getContextPath()%>"><img src="<%=request.getContextPath()%>/templates/public/img/core-img/logo.png" alt="Logo"></a>
                        <!-- Navbar Toggler -->
                        <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#worldNav" aria-controls="worldNav" aria-expanded="false" aria-label="Toggle navigation"><span class="navbar-toggler-icon"></span></button>
                        <!-- Navbar -->
                        <div class="collapse navbar-collapse" id="worldNav">
                            <ul class="navbar-nav ml-auto">
                                <li class="nav-item active">
                                    <a class="nav-link" href="<%=request.getContextPath()%>">HOME <span class="sr-only">(current)</span></a>
                                </li>
                                <%
                                	CatDAO catDAO = new CatDAO();
                                       	ArrayList<Category> listParent = catDAO.getParentItems();
                                       	if (listParent.size() > 0) {
                                       		for (Category objParentCat:listParent) {
                                       			ArrayList<Category> listChildCat = catDAO.getChildCat(objParentCat.getCatId());
                                       			String urlDetailParent = request.getContextPath() + "/" + StringUtil.makeSlug(objParentCat.getCatName()) + "-" + objParentCat.getCatId();
                                %>
                                <li class="nav-item dropdown" id="<%=objParentCat.getCatName() %>">
                                    <a class="nav-link dropdown-toggle" href="<%=urlDetailParent %>" id="navbarDropdown" role="button" data-toggle="dropdown" aria-haspopup=" " aria-expanded="false"><%=objParentCat.getCatName().toUpperCase() %></a>
                                    <% if (listChildCat.size() > 0) { %>
                                    <div class="dropdown-menu" aria-labelledby="navbarDropdown">
                                    	<%
                                    		for (Category objChildCat:listChildCat) {
                                    			String urlDetail = request.getContextPath() + "/" + StringUtil.makeSlug(objChildCat.getCatName()) + "-" + objChildCat.getCatId();
                                    	%>
                                        <a class="dropdown-item" href="<%=urlDetail%>"><%=objChildCat.getCatName()%></a>
                                        <%}%>
                                    </div>
                                    <%}%>
                                </li>
                                <%}}%>
                                <li class="nav-item">
                                    <a class="nav-link" href="<%=request.getContextPath()%>/about">About me</a>
                                </li>
                            </ul>
                            <!-- Search Form  -->
                            <div id="search-wrapper">
                                <form action="#">
                                    <input type="text" id="search" placeholder="Search something...">
                                    <div id="close-icon"></div>
                                    <input class="d-none" type="submit" value="">
                                </form>
                            </div>
                        </div>
                    </nav>
                </div>
            </div>
        </div>
    </header>