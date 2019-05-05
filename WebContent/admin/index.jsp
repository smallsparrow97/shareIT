<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ include file="/templates/admin/inc/header.jsp" %>
<%@ include file="/templates/admin/inc/leftbar.jsp" %>
<div id="page-wrapper">
    <div id="page-inner">
        <div class="row">
            <div class="col-md-12">
                <h2>TRANG QUẢN TRỊ WEBSITE TIN TỨC SHAREIT</h2>
            </div>
        </div>
        <!-- /. ROW  -->
        <hr />
        <%
	        int countCat = (Integer)request.getAttribute("countCat");
	        int countNew = (Integer)request.getAttribute("countNew");
        	int countUser = (Integer)request.getAttribute("countUser");
        	int countSlide = (Integer)request.getAttribute("countSlide");
        	int countCmt = (Integer)request.getAttribute("countCmt");
        %>
        <div class="row">
            <div class="col-md-4 col-sm-4 col-xs-4">
                <div class="panel panel-back noti-box">
                    <span class="icon-box bg-color-green set-icon">
                    <i class="fa fa-bars"></i>
                </span>
                    <div class="text-box">
                        <p class="main-text"><a href="<%=request.getContextPath() %>/admin/cat/index" title="">Quản lý danh mục</a></p>
                        <p class="text-muted">Có <%=countCat %> danh mục</p>
                    </div>
                </div>
            </div>
            <div class="col-md-4 col-sm-4 col-xs-4">
                <div class="panel panel-back noti-box">
                    <span class="icon-box bg-color-blue set-icon">
                    <i class="fa fa-bell-o"></i>
                </span>
                    <div class="text-box">
                        <p class="main-text"><a href="<%=request.getContextPath() %>/admin/new/index" title="">Quản lý tin tức</a></p>
                        <p class="text-muted">Có <%=countNew %> tin tức</p>
                    </div>
                </div>
            </div>
            <div class="col-md-4 col-sm-4 col-xs-4">
                <div class="panel panel-back noti-box">
                    <span class="icon-box bg-color-brown set-icon">
                    <i class="fa fa-rocket"></i>
                </span>
                    <div class="text-box">
                        <p class="main-text"><a href="<%=request.getContextPath() %>/admin/user/index" title="">Quản lý người dùng</a></p>
                        <p class="text-muted">Có <%=countUser %> người dùng</p>
                    </div>
                </div>
            </div>
            <div class="col-md-4 col-sm-4 col-xs-4">
                <div class="panel panel-back noti-box">
                    <span class="icon-box bg-color-brown set-icon">
                    <i class="fa fa-rocket"></i>
                </span>
                    <div class="text-box">
                        <p class="main-text"><a href="<%=request.getContextPath() %>/admin/comments" title="">Quản lý bình luận</a></p>
                        <p class="text-muted">Có <%=countCmt %> bình luận</p>
                    </div>
                </div>
            </div>
            <div class="col-md-4 col-sm-4 col-xs-4">
                <div class="panel panel-back noti-box">
                    <span class="icon-box bg-color-green set-icon">
                    <i class="fa fa-bars"></i>
                </span>
                    <div class="text-box">
                        <p class="main-text"><a href="<%=request.getContextPath() %>/admin/slide/index" title="">Quản lý slide</a></p>
                        <p class="text-muted">Có <%=countSlide %> slide</p>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<script>
    document.getElementById("index").classList.add('active-menu');
</script>
<!-- /. PAGE WRAPPER  -->
<%@ include file="/templates/admin/inc/footer.jsp" %>