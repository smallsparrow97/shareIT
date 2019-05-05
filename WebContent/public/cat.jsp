	<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
	<%@ include file="/templates/public/inc/header.jsp" %>
    <!-- ********** Hero Area Start ********** -->
    <div class="hero-area height-400 bg-img background-overlay" style="background-image: url(<%=request.getContextPath()%>/templates/public/img/blog-img/bg3.jpg);"></div>
    <!-- ********** Hero Area End ********** -->

    <div class="main-content-wrapper section-padding-50">
        <div class="container">
            <div class="row justify-content-center">
                <!-- ============= Post Content Area Start ============= -->
                <div class="col-12 col-lg-8">
                    <div class="post-content-area mb-100">
                        <!-- Catagory Area -->
                        <div class="world-catagory-area">
                            <ul class="nav nav-tabs" id="myTab" role="tablist">
                            	<%
                            		int catId = 0;
                            	                            	                            		boolean showBtnLoadMore = false;
                            	                            	                            		int countNews = (Integer) request.getAttribute("countNews");
                            	                            	                            		if (countNews > DefineUtil.NUMBER_NEWS_PER_CAT_PAGE) {
                            	                            	                            			showBtnLoadMore = true;
                            	                            	                            		}
                            	                            	                            		if (request.getAttribute("category") != null) {
                            	                            	                            			Category objCat = (Category) request.getAttribute("category");
                            	                            	                            			catId = objCat.getCatId();
                            	%>
                                <li class="title"><%=objCat.getCatName().toUpperCase()%></li>
								<%
									}
								%>
                                <li class="nav-item">
                                    <a class="nav-link" id="tab1" data-toggle="tab" href="#world-tab-1" role="tab" aria-controls="world-tab-1" aria-selected="true"></a>
                                </li>
                            </ul>

                            <div class="tab-content" id="myTabContent">

                                <div class="tab-pane fade show active" id="world-tab-1" role="tabpanel" aria-labelledby="tab1">
                                    <%
                                    	if (request.getAttribute("listNews") != null) {
                                                                                                            		ArrayList<New> listNews =  (ArrayList<New>) request.getAttribute("listNews");
                                                                                                            		if (listNews.size() > 0) {
                                                                                                            			for (New objNew : listNews) {
                                                                                                            				String urlDetail = request.getContextPath() + "/" + StringUtil.makeSlug(objNew.getTitle()) + "_" + objNew.getId() + ".html";
                                    %>
                                    <!-- Single Blog Post -->
                                    <div class="single-blog-post post-style-4 d-flex align-items-center">
                                        <!-- Post Thumbnail -->
                                        <div class="post-thumbnail">
                                            <img src="<%=request.getContextPath()%>/files/<%=objNew.getPicture()%>" alt="hinhanh">
                                            <!-- Catagory -->
                                            <div class="post-cta"><a href="#"><%=objNew.getObjCat().getCatName()%></a></div>
                                        </div>
                                        <!-- Post Content -->
                                        <div class="post-content">
                                            <a href="<%=urlDetail%>" class="headline">
                                                <h5><%=objNew.getTitle()%></h5>
                                            </a>
                                            <p><%
                                            	if (objNew.getPreview().length() > 160) out.print(objNew.getPreview().substring(0, 160) + "..."); else out.print(objNew.getPreview());
                                            %></p>
                                            <!-- Post Meta -->
                                            <div class="post-meta">
                                                <p><a href="#" class="post-author">Đăng bởi: <%=objNew.getObjUser().getFullname()%></a> on <a href="#" class="post-date"><%=StringUtil.dateFormat(objNew.getDateCreate())%></a>
                                                	 | <img src="<%=request.getContextPath()%>/templates/public/img/core-img/view.png" alt="">&nbsp;<%=objNew.getView()%>
                                                </p>
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

                <!-- ========== Sidebar Area ========== -->
                <%@ include file="/templates/public/inc/right-bar.jsp" %>
            </div>
			
			<%
							if (showBtnLoadMore) {
													int maxTimeLoadMore = (int) Math.ceil((float) countNews/DefineUtil.NUMBER_NEWS_PER_CAT_PAGE ) - 1;
						%>
            <!-- Load More btn -->
            <div class="row" id="btnLoadMore">
                <div class="col-12">
                    <div class="load-more-btn text-center">
                    	<label style="display: none" id="countTimeLoadMore">0</label>
                        <a href="javascript:void(0)" onclick="return loadMore(<%=catId%>, <%=maxTimeLoadMore%>)" class="btn world-btn">Load More</a>
                    </div>
                </div>
            </div>
            <%
            	}
            %>
        </div>
    </div>

    <!-- ***** Footer Area Start ***** -->
    <%@ include file="/templates/public/inc/footer.jsp" %>
<script type="text/javascript">
	function loadMore(catId, maxTimeLoadMore) {
		$(document).ready(function() {
			var countTimeLoadMore = parseInt($('#countTimeLoadMore').text(),10);
			countTimeLoadMore += 1;
			
			$.ajax({
				url: '<%=request.getContextPath()%>/danh-muc',
				type: 'POST',
				cache: false,
				data: {
					countTimeLoadMore : countTimeLoadMore,
					catId : catId,
				},
				success: function(data){
					$('#world-tab-1').append(data);
					$('#countTimeLoadMore').text(countTimeLoadMore);
					if (countTimeLoadMore == maxTimeLoadMore) {
						document.getElementById('btnLoadMore').style.display = "none";
					}
					//countCmt += 1;
					//$('.countCmt').html(countCmt);
					
				},
				error: function (){
					alert('Có lỗi xảy ra');
				}
			});	
			
		});
		return false;
	}
</script>
    