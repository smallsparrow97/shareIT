<%@page import="model.bean.Slide"%>
<%@page import="util.StringUtil"%>
<%@page import="model.bean.Category"%>
<%@page import="model.bean.New"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
	<%@ include file="/templates/public/inc/header.jsp" %>
	<!-- ***** Header Area End ***** -->
    <!-- ********** Hero Area Start ********** -->
    <div class="hero-area">

        <!-- Hero Slides Area -->
        <div class="hero-slides owl-carousel">
        	<%
        		if (request.getAttribute("listSlideBg") != null) {
        		    			ArrayList<Slide> listSlideBg = (ArrayList<Slide>) request.getAttribute("listSlideBg");
        		    			if (listSlideBg.size() > 0) {
        		    				for (Slide objSlide:listSlideBg) {
        	%>
            <!-- Single Slide -->
            <div class="single-hero-slide bg-img background-overlay" style="background-image: url(<%=request.getContextPath()%>/files/<%=objSlide.getPicture()%>);"></div>
       		<%
       			}}}
       		%>
        </div>

        <!-- Hero Post Slide -->
        <div class="hero-post-area">
            <div class="container">
                <div class="row">
                    <div class="col-12">
                        <div class="hero-post-slide">
                        	<%
                        		int count = 0;
                        	                        		if (request.getAttribute("listSlideNews") != null) {
                        	                        			ArrayList<New> listNews = (ArrayList<New>) request.getAttribute("listSlideNews");
                        	                        			if (listNews.size() > 0) {
                        	                        				for (New objNew:listNews) {
                        	                        					count += 1 ;
                        	                        					String urlDetail  = request.getContextPath() + "/" + StringUtil.makeSlug(objNew.getTitle()) + "_" + objNew.getId() + ".html";
                        	%>
                        
                            <!-- Single Slide -->
                            <div class="single-slide d-flex">
                                <div class="post-number">
                                    <p><%=count%></p>
                                </div>
                                <div class="post-title">
                                	<p><%=StringUtil.dateFormat(objNew.getDateCreate())%></p>
                                    <a href="<%=urlDetail%>"><%=objNew.getTitle()%></a>
                                    <p>Đăng bởi: <%=objNew.getObjUser().getFullname()%></p>
                                </div>
                            </div>
                            <%
                            	}}}
                            %>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!-- ********** Hero Area End ********** -->

    <div class="main-content-wrapper section-padding-50">
        <div class="container">
            <div class="row justify-content-center">
                <!-- ============= Post Content Area Start ============= -->
                <div class="col-12 col-lg-8">
                    <div class="post-content-area mb-50">
                        <!-- Catagory Area -->
                        <div class="world-catagory-area">
                            <ul class="nav nav-tabs" id="myTab" role="tablist"> 
                                <li class="title">Tin mới</li>

                                <li class="nav-item">
                                    <a class="nav-link" id="tab1" data-toggle="tab" href="#world-tab-1" role="tab" aria-controls="world-tab-1" aria-selected="true"></a>
                                </li>
                            </ul>

                            <div class="tab-content" id="myTabContent">

                                <div class="tab-pane fade show active" id="world-tab-1" role="tabpanel" aria-labelledby="tab1">
                                    <div class="row">
                                        <div class="col-12 col-md-6">
                                            <div class="world-catagory-slider owl-carousel wow fadeInUpBig" data-wow-delay="0.1s">
												<%
													if (request.getAttribute("listLatestNews") != null) {
															                        			ArrayList<New> listNews = (ArrayList<New>) request.getAttribute("listLatestNews");
															                        			if (listNews.size() > 0) {
															                        				for (New objNew:listNews) {
															                        					String urlDetail = request.getContextPath() + "/" + StringUtil.makeSlug(objNew.getTitle()) + "_" + objNew.getId() + ".html";
												%>
                                                <!-- Single Blog Post -->
                                                <div class="single-blog-post">
                                                    <!-- Post Thumbnail -->
                                                    <div class="post-thumbnail">
                                                        <img src="<%=request.getContextPath()%>/files/<%=objNew.getPicture()%>" alt="">
                                                        <!-- Catagory -->
                                                        <div class="post-cta"><a href="#"><%=objNew.getObjCat().getCatName()%></a></div>
                                                    </div>
                                                    <!-- Post Content -->
                                                    <div class="post-content">
                                                        <a href="<%=urlDetail%>" class="headline">
                                                            <h5><%=objNew.getTitle()%></h5>
                                                        </a>
                                                        <p><%
                                                        	if (objNew.getPreview().length() > 100) out.print(objNew.getPreview().substring(0, 100) + "..."); else out.print(objNew.getPreview());
                                                        %></p>
                                                        <!-- Post Meta -->
                                                        <div class="post-meta">
                                                        	<p><a href="#" class="post-author"><%=objNew.getObjUser().getFullname()%></a> | <a href="#" class="post-date"><%=StringUtil.dateFormat(objNew.getDateCreate())%></a></p>
                                                        </div>
                                                    </div>
                                                </div>
												<%
													}}}
												%>
                                                
                                            </div>
                                        </div>

                                        <div class="col-12 col-md-6">
                                        	<%
                                        		if (request.getAttribute("listLatestNews") != null) {
                                        			                        			ArrayList<New> listNews = (ArrayList<New>) request.getAttribute("listLatestNews");
                                        			                        			if (listNews.size() > 0) {
                                        			                        				for (New objNew:listNews) {
                                        			                        					String urlDetail = request.getContextPath() + "/" + StringUtil.makeSlug(objNew.getTitle()) + "_" + objNew.getId() + ".html";
                                        	%>
                                            <!-- Single Blog Post -->
                                            <div class="single-blog-post post-style-2 d-flex align-items-center wow fadeInUpBig" data-wow-delay="0.2s">
                                                <!-- Post Thumbnail -->
                                                <div class="post-thumbnail">
                                                    <img src="<%=request.getContextPath()%>/files/<%=objNew.getPicture()%>" alt="<%=objNew.getTitle()%>">
                                                </div>
                                                <!-- Post Content -->
                                                <div class="post-content">
                                                    <a href="<%=urlDetail%>" class="headline">
                                                        <h5><%=objNew.getTitle()%></h5>
                                                    </a>
                                                    <!-- Post Meta -->
                                                    <div class="post-meta">
                                                        <p><a href="#" class="post-author"><%=objNew.getObjCat().getCatName()%></a> | <a href="#" class="post-date"><%=StringUtil.dateFormat(objNew.getDateCreate())%></a></p>
                                                    </div>
                                                </div>
                                            </div>
                                            <%
                                            	}}}
                                            %>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- ========== Sidebar Area ========== -->
                <%@ include file="/templates/public/inc/right-bar.jsp" %>
            </div>
       

            <div class="world-latest-articles">
                <div class="row">
                    <div class="col-12 col-lg-8">
                        <div class="title">
                            <h5>Danh mục</h5>
                        </div>
						<%
							if (request.getAttribute("listParentCat") != null) {
						                      			ArrayList<Category> listParentCat = (ArrayList<Category>) request.getAttribute("listParentCat");
						                      			if (listParentCat.size() > 0) {
						                      				for (Category objCat:listParentCat) {
						                      					String urlDetail = request.getContextPath() + "/" + StringUtil.makeSlug(objCat.getCatName()) + "-" + objCat.getCatId();
						%>
                        <!-- Single Blog Post -->
                        <div class="single-blog-post post-style-4 d-flex align-items-center wow fadeInUpBig" data-wow-delay="0.2s">
                            <!-- Post Thumbnail -->
                            <div class="post-thumbnail">
                                <a href="<%=urlDetail%>"><img src="<%=request.getContextPath()%>/files/<%=objCat.getPicture()%>" alt="danhmuc"></a>
                            </div>
                            <!-- Post Content -->
                            <div class="post-content">
                                <a href="<%=urlDetail%>" class="headline">
                                    <h5><%=objCat.getCatName().toUpperCase()%></h5>
                                </a>
                                <p><%
                                	if (objCat.getDescription().length() > 200) out.print(objCat.getDescription().substring(0, 200) + "..."); else out.print(objCat.getDescription());
                                %></p>
                                <!-- Post Meta -->
                                <%-- <div class="post-meta">
                                    <p><a href="#" class="post-author">JAVA</a> | <img src="<%=request.getContextPath() %>/templates/public/img/core-img/view.png" alt="">&nbsp;108 </p>
                                </div> --%>
                            </div>
                        </div>
						<%
							}}}
						%>
                    </div>

                    <div class="col-12 col-lg-4">
                        <div class="title">
                            <h5>Tuyển dụng</h5>
                        </div>
						<%
							if (request.getAttribute("listJobNews") != null) {
						                      			ArrayList<New> listNews = (ArrayList<New>) request.getAttribute("listJobNews");
						                      			if (listNews.size() > 0) {
						                      				for (New objNew:listNews) {
						                      					String urlDetail = request.getContextPath() + "/" + StringUtil.makeSlug(objNew.getTitle()) + "_" + objNew.getId() + ".html";
						%>
                        <!-- Single Blog Post -->
                        <div class="single-blog-post wow fadeInUpBig" data-wow-delay="0.2s">
                            <!-- Post Thumbnail -->
                            <div class="post-thumbnail">
                                <img src="<%=request.getContextPath()%>/files/<%=objNew.getPicture()%>" alt="tuyendung">
                            </div>
                            <!-- Post Content -->
                            <div class="post-content">
                                <a href="<%=urlDetail%>" class="headline">
                                    <h5><%=objNew.getTitle()%></h5>
                                </a>
                                <p><%
                                	if (objNew.getPreview().length() > 100) out.print(objNew.getPreview().substring(0, 100) + "..."); else out.print(objNew.getPreview());
                                %></p>
                                <!-- Post Meta -->
                                <div class="post-meta">
                                	<p><a href="#" class="post-author">Đăng bởi: <%=objNew.getObjUser().getFullname()%></a> | <a href="#" class="post-date"><%=StringUtil.dateFormat(objNew.getDateCreate())%></a></p>
                                </div>
                            </div>
                        </div>
                        <%
                        	}}}
                        %>
                    </div>
                </div>
            </div>

            <!-- Load More btn -->
            <!-- <div class="row">
                <div class="col-12">
                    <div class="load-more-btn mt-50 text-center">
                        <a href="#" class="btn world-btn">Load More</a>
                    </div>
                </div>
            </div> -->
        </div>
    </div>

    <!-- ***** Footer Area Start ***** -->
    <%@ include file="/templates/public/inc/footer.jsp" %>
    