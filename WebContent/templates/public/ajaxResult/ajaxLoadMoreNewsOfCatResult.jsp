<%@page import="model.bean.New"%>
<%@page import="java.util.ArrayList"%>
<%@page import="util.StringUtil"%>
<%@page import="model.bean.Comment"%>
<%@page import="model.dao.CommentDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
   
<%
	if (request.getAttribute("listNewsLoadMore") != null) {
		ArrayList<New> listNewsLoadMore = (ArrayList<New>) request.getAttribute("listNewsLoadMore");
			if (listNewsLoadMore.size() > 0) {
				for (New objNew : listNewsLoadMore) {
					String urlDetail = request.getContextPath() + "/" + StringUtil.makeSlug(objNew.getTitle()) + "_" + objNew.getId() + ".html";
%> 
 
<!-- Single Blog Post -->
<div class="single-blog-post post-style-4 d-flex align-items-center">
   <!-- Post Thumbnail -->
   <div class="post-thumbnail">
       <img src="<%=request.getContextPath() %>/files/<%=objNew.getPicture() %>" alt="hinhanh">
       <!-- Catagory -->
       <div class="post-cta"><a href="#"><%=objNew.getObjCat().getCatName() %></a></div>
   </div>
   <!-- Post Content -->
   <div class="post-content">
       <a href="<%=urlDetail %>" class="headline">
           <h5><%=objNew.getTitle() %></h5>
       </a>
       <p><% if (objNew.getPreview().length() > 160) out.print(objNew.getPreview().substring(0, 160) + "..."); else out.print(objNew.getPreview()); %></p>
       <!-- Post Meta -->
       <div class="post-meta">
           <p><a href="#" class="post-author">Đăng bởi: <%=objNew.getObjUser().getFullname() %></a> on <a href="#" class="post-date"><%=StringUtil.dateFormat(objNew.getDateCreate()) %></a>
           	 | <img src="<%=request.getContextPath() %>/templates/public/img/core-img/view.png" alt="">&nbsp;<%=objNew.getView() %>
           </p>
       </div>
   </div>
</div>
<% }}} %>
