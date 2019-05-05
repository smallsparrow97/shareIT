<%@page import="util.StringUtil"%>
<%@page import="util.DefineUtil"%>
<%@page import="model.bean.New"%>
<%@page import="java.util.ArrayList"%>
<%@page import="model.dao.NewDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<div class="col-12 col-md-8 col-lg-4">
                <div class="post-sidebar-area wow fadeInUpBig" data-wow-delay="0.2s">           
                    <!-- Widget Area -->
        <div class="sidebar-widget-area">
            <h5 class="title">Tin xem nhiều</h5>
            <div class="widget-content">
            	<%
            		NewDAO newDAO = new NewDAO();
		           	// danh sách tin xem nhiều
		       		ArrayList<New> listTopNews = newDAO.getTopItems(DefineUtil.NUMBER_TOP_NEWS);
		           	if (listTopNews.size() > 0) {
		           		for (New objNew:listTopNews) {
		           			String urlDetail = request.getContextPath() + "/" + StringUtil.makeSlug(objNew.getTitle()) + "_" + objNew.getId() + ".html";
            	%>
                <!-- Single Blog Post -->
                <div class="single-blog-post post-style-2 d-flex align-items-center widget-post">
                    <!-- Post Thumbnail -->
                    <div class="post-thumbnail">
                        <img src="<%=request.getContextPath() %>/files/<%=objNew.getPicture() %>" alt="hinhanh">
                    </div>
                    <!-- Post Content -->
                    <div class="post-content">
                        <a href="<%=urlDetail %>" class="headline">
                            <h5 class="mb-0"><%=objNew.getTitle() %></h5>
                        </a>
                        <!-- Post Meta -->
	                    <div class="post-meta">
	                    	<p><a href="#" class="post-author"><%=objNew.getObjCat().getCatName() %></a> | <img src="<%=request.getContextPath() %>/templates/public/img/core-img/view.png" alt="">&nbsp;<%=objNew.getView() %> </p>
	                    </div>
                    </div>
                </div>
                <%}} %>
            </div>
        </div>                                   
    </div>
</div>