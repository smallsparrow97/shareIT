<%@page import="model.bean.User"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">

<head>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>ShareIT | Trang quản trị</title>
    <!-- Favicon  -->
    <link rel="icon" href="<%=request.getContextPath() %>/templates/public/img/core-img/circledd.png">
    
    <!-- BOOTSTRAP STYLES-->
    <link href="<%=request.getContextPath() %>/templates/admin/assets/css/bootstrap.css" rel="stylesheet" />
    <!-- FONTAWESOME STYLES-->
    <link href="<%=request.getContextPath() %>/templates/admin/assets/css/font-awesome.css" rel="stylesheet" />
    <!-- CUSTOM STYLES-->
    <link href="<%=request.getContextPath() %>/templates/admin/assets/css/custom.css" rel="stylesheet" />
    <!-- GOOGLE FONTS-->
    <link href='http://fonts.googleapis.com/css?family=Open+Sans' rel='stylesheet' type='text/css' />
    <!-- JQUERY -->
	<script src="<%=request.getContextPath() %>/templates/admin/assets/js/jquery_3.2.1.js"></script>
	<!-- JValidate-->
    <script src="<%=request.getContextPath() %>/library/js/jquery.validate.min.js"></script>
    <!-- CKEDITOR-->
    <script src="<%=request.getContextPath() %>/library/ckeditor/ckeditor.js"></script>
    <!-- CKFINDER-->
    <script src="<%=request.getContextPath() %>/library/ckfinder/ckfinder.js"></script>
    <!-- JQUERY UI-->
    <link rel="stylesheet" href="<%=request.getContextPath() %>/library/jquery_ui_1.12.1/jquery_ui.css">
  	<script src="<%=request.getContextPath() %>/library/jquery_ui_1.12.1/jquery_ui.js"></script>
    
    <style type="text/css">
    	.error{
    		color: red;
    	}
    </style>
</head>

<body>
    <div id="wrapper">
        <nav class="navbar navbar-default navbar-cls-top " role="navigation" style="margin-bottom: 0">
            <div class="navbar-header">
                <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".sidebar-collapse">
                    <span class="sr-only">Toggle navigation</span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                </button>
                <a class="navbar-brand" href="<%=request.getContextPath() %>/admin">VinaEnter Edu</a>
            </div>
            <% if (session.getAttribute("userInfo") != null) {
            		User objUser = (User) session.getAttribute("userInfo");
            %>
            <div style="color: white;padding: 15px 50px 5px 50px;float: right;font-size: 16px;"> 
            	Xin chào, <b><%=objUser.getFullname() %></b> &nbsp; <a href="<%=request.getContextPath() %>/auth/logout" class="btn btn-danger square-btn-adjust">Đăng xuất</a> 
            </div>
        	<% } %>
        </nav>
        <!-- /. NAV TOP  -->