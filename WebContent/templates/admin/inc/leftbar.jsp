<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<nav class="navbar-default navbar-side" role="navigation">
    <div class="sidebar-collapse">
        <ul class="nav" id="main-menu">
            <li class="text-center">
                <img src="<%=request.getContextPath() %>/templates/admin/assets/img/find_user.png" class="user-image img-responsive" />
            </li>
            <li>
                <a id="index" href="<%=request.getContextPath() %>/admin"><i class="fa fa-dashboard fa-3x"></i> Trang chủ</a>
            </li>
            <li>
                <a id="category" href="<%=request.getContextPath() %>/admin/cat/index"><i class="fa fa-list fa-3x"></i> Quản lý danh mục</a>
            </li>
            <li>
                <a id="new" href="<%=request.getContextPath() %>/admin/new/index"><i class="fa fa-music fa-3x"></i> Quản lý tin tức</a>
            </li>
            <li>
                <a id="user" href="<%=request.getContextPath() %>/admin/user/index"><i class="fa fa-user fa-3x"></i> Quản lý người dùng</a>
            </li>
            <li>
                <a id="cmt" href="<%=request.getContextPath() %>/admin/comments"><i class="fa fa-envelope fa-3x"></i> Quản lý bình luận</a>
            </li>
            <li>
                <a id="slide" href="<%=request.getContextPath() %>/admin/slide/index"><i class="fa fa-music fa-3x"></i> Quản lý slide</a>
            </li>
        </ul>
    </div>
</nav>
<!-- /. NAV SIDE  -->