	<%@page import="model.bean.Comment"%>
<%@page import="model.dao.CommentDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
	<%@ include file="/templates/public/inc/header.jsp" %>
	
	<%
			int nId = 0;
				int countCmt = 0;
				int countParentCmt = 0;
				if (request.getAttribute("objNew") != null) {
			New objNew = (New) request.getAttribute("objNew");
			nId = objNew.getId();
			countCmt = (Integer) request.getAttribute("countCmt");
			countParentCmt = (Integer) request.getAttribute("countParentCmt");
		%>
    <!-- ********** Hero Area Start ********** -->
    <div class="hero-area height-600 bg-img background-overlay" style="background-image: url(<%=request.getContextPath()%>/templates/public/img/blog-img/bg2.jpg);">
        <div class="container h-100">
            <div class="row h-100 align-items-center justify-content-center">
                <div class="col-12 col-md-8 col-lg-6">
                    <div class="single-blog-title text-center">
                        <!-- Catagory -->
                        <div class="post-cta"><a href="#"><%=objNew.getObjCat().getCatName()%> | <%=StringUtil.dateFormat(objNew.getDateCreate())%></a></div>
                        <h3><%=objNew.getTitle()%></h3>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!-- ********** Hero Area End ********** -->

    <div class="main-content-wrapper section-padding-100">
        <div class="container">
            <div class="row justify-content-center">
                <!-- ============= Post Content Area ============= -->
                <div class="col-12 col-lg-8">
                    <div class="single-blog-content mb-100">
                        <!-- Post Meta -->
                        <div class="post-meta">
                            <p><img src="<%=request.getContextPath()%>/templates/public/img/core-img/user.png" alt="">
                            &nbsp;<a href="#" class="post-author"><%=objNew.getObjUser().getFullname()%></a>
                            &nbsp;&nbsp;&nbsp;<img src="<%=request.getContextPath()%>/templates/public/img/core-img/comment.png" alt="">
                            &nbsp;<a href="#" class="count-comment"><%=countCmt%> comments</a> </p>
                        </div>
                        <!-- Post Content -->
                        <div class="post-content">
                        	<h6><%=objNew.getDetail()%></h6>
                            <!-- Post Meta -->
                            <div class="post-meta second-part">
                                <p><img src="<%=request.getContextPath()%>/templates/public/img/core-img/time.png" alt="">&nbsp;<a href="#" class="post-date"><%=StringUtil.dateFormat(objNew.getDateCreate())%></a></p>
                            </div>
                        </div>
                    </div>
                </div>
				<%
					}
				%>
                <!-- ========== Sidebar Area ========== -->
                <%@ include file="/templates/public/inc/right-bar.jsp" %>
            </div>

            <!-- ============== Related Post ============== -->
            <h4>Bài viết liên quan</h4>
            <br />
            <div class="row">
            	<%
            		int parentId = 0; 
            	            		            	if (request.getAttribute("listRelatedNew") != null) {
            	            		        			ArrayList<New> listRelatedNew = (ArrayList<New>) request.getAttribute("listRelatedNew");
            	            		        			if (listRelatedNew.size() > 0) {
            	            		        				for (New objNew : listRelatedNew) {
            	            		        					String urlDetail = request.getContextPath() + "/" + StringUtil.makeSlug(objNew.getTitle()) + "_" + objNew.getId() + ".html";
            	%>
                <div class="col-12 col-md-6 col-lg-4">
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
                            	if (objNew.getPreview().length() > 115) out.print(objNew.getPreview().substring(0, 115) + "..."); else out.print(objNew.getPreview());
                            %></p>
                            <!-- Post Meta -->
                            <div class="post-meta">
                                <p><a href="#" class="post-author"><%=objNew.getObjUser().getFullname()%></a> on <a href="#" class="post-date"><%=StringUtil.dateFormat(objNew.getDateCreate())%></a></p>
                            </div>
                        </div>
                    </div>
                </div>
				<%
					}}}
				%>
            </div>

            <div class="row">
                <div class="col-12 col-lg-8">
                    <div class="post-a-comment-area mt-70">
                        <h5>BÌNH LUẬN</h5>
                        <!-- Contact Form -->
                        <form action="javascript:void(0)" onsubmit="return xuLyCmt(<%=nId%>)" method="post">
                            <div class="row">
                                <div class="col-12 col-md-6">
                                    <div class="group">
                                        <input type="text" name="name" id="name" required>
                                        <span class="highlight"></span>
                                        <span class="bar"></span>
                                        <label>Enter your name</label>
                                    </div>
                                </div>
                                <div class="col-12 col-md-6">
                                    <div class="group">
                                        <input type="email" name="email" id="email" required>
                                        <span class="highlight"></span>
                                        <span class="bar"></span>
                                        <label>Enter your email (never public)</label>
                                    </div>
                                </div>
                                <div class="col-12">
                                    <div class="group">
                                        <textarea name="message" id="message" required></textarea>
                                        <span class="highlight"></span>
                                        <span class="bar"></span>
                                        <label>Enter your comment</label>
                                    </div>
                                </div>
                                <div class="col-12">
                                    <button type="submit" class="btn world-btn">Bình luận</button>
                                </div>
                            </div>
                        </form>
                    </div>
                </div>

                <div class="col-12 col-lg-8">
                    <!-- Comment Area Start -->
                    <div class="comment_area clearfix mt-70">
                        <ol class="parent">
                        	<%
                        		boolean showBtnLoadAllCmt = false;
                        	                        	                        		CommentDAO cmtDAO = new CommentDAO();
                        	                        		                        	if(request.getAttribute("listCmt") != null) {
                        	                        		            		  			ArrayList<Comment> listCmt = (ArrayList<Comment>)request.getAttribute("listCmt");
                        	                        		            		  			if (countParentCmt > DefineUtil.NUMBER_COMMENT_SHOW_PER_NEWS) {
                        	                        		            		  				showBtnLoadAllCmt = true;
                        	                        		            		  			}
                        	                        		            		  			if (listCmt.size() > 0) {
                        	                        		            		  				for (Comment objParentCmt:listCmt) {
                        	                        		            		  					ArrayList<Comment> listChildCmt = cmtDAO.getChildItems(objParentCmt.getId());
                        	                        		            		  					boolean showBtnLoadAllRepCmt = false;
                        	                        		            		  					int countChildCmt = cmtDAO.countChildCmt(objParentCmt.getId());
                        	                        		            		  					if (listChildCmt.size() < countChildCmt) {
                        	                        		            		  						showBtnLoadAllRepCmt = true;
                        	                        		    	            		  			}
                        	%>
                            <!-- Single Comment Area -->
                            <li class="single_comment_area">
                                <!-- Comment Content -->
                                <div class="comment-content">
                                    <!-- Comment Meta -->
                                    <div class="comment-meta d-flex align-items-center justify-content-between">
                                        <p><a href="#" class="post-author"><strong><%=objParentCmt.getUsername()%></strong></a> vào <a href="#" class="post-date"><%=StringUtil.timeCmtFormat(objParentCmt.getTime_cmt())%></a></p>
                                        <a href="javascript:void(0)" onclick="showFormCmt(<%=objParentCmt.getId()%>)" class="comment-reply btn world-btn">Reply</a>
                                    </div>
                                    <p><%=objParentCmt.getContent()%></p>
                                </div>
                                <ol class="children" id="children<%=objParentCmt.getId()%>">
                                	<li class="single_comment_area repCmt" id="cmt<%=objParentCmt.getId()%>" style="display: none">
                                		<div class="comment-content">
                                			<!-- Contact Form -->
					                        <form action="javascript:void(0)" onsubmit="return xuLyRepCmt(<%=nId%> , <%=objParentCmt.getId()%>, <%=objParentCmt.getId()%>, '<%=objParentCmt.getUsername()%>')" method="post">
					                            <div class="row">
					                                <div class="col-12 col-md-6">
					                                    <div class="group">
					                                        <input type="text" name="name" id="name<%=objParentCmt.getId()%>" required>
					                                        <span class="highlight"></span>
					                                        <span class="bar"></span>
					                                        <label>Enter your name</label>
					                                    </div>
					                                </div>
					                                <div class="col-12 col-md-6">
					                                    <div class="group">
					                                        <input type="email" name="email" id="email<%=objParentCmt.getId()%>" required>
					                                        <span class="highlight"></span>
					                                        <span class="bar"></span>
					                                        <label>Enter your email (never public)</label>
					                                    </div>
					                                </div>
					                                <div class="col-12">
					                                    <div class="group">
					                                        <textarea name="message" id="message<%=objParentCmt.getId()%>" required></textarea>
					                                        <span class="highlight"></span>
					                                        <span class="bar"></span>
					                                        <label>Enter your comment</label>
					                                    </div>
					                                </div>
					                                <div class="col-12">
					                                    <button type="submit" class="btn world-btn">Bình luận</button>
					                                </div>
					                            </div>
					                        </form>
                                		</div>
                                	</li>
                                	<%
                                		if (listChildCmt.size() > 0) {
                                	                                	                                			for (Comment objChildCmt : listChildCmt) {
                                	%>
                                    <li class="single_comment_area">
                                        <!-- Comment Content -->
                                        <div class="comment-content">
                                            <!-- Comment Meta -->
                                            <div class="comment-meta d-flex align-items-center justify-content-between">
                                                <p><a href="#" class="post-author"><strong><%=objChildCmt.getUsername()%></strong>
                                                </a> đã trả lời: <strong><%=objChildCmt.getAnswer_to()%></strong> vào <a href="#" class="post-date"><%=StringUtil.timeCmtFormat(objChildCmt.getTime_cmt())%></a></p>
                                                <a href="javascript:void(0)" onclick="showFormCmt(<%=objChildCmt.getId()%>)" class="comment-reply btn world-btn">Reply</a>
                                            </div>
                                            <p><%=objChildCmt.getContent()%></p>
                                        </div>
                                    </li>
                                    <li class="single_comment_area repCmt" id="cmt<%=objChildCmt.getId()%>" style="display: none">
                                		<div class="comment-content">
                                			<!-- Contact Form -->
					                        <form action="javascript:void(0)" onsubmit="return xuLyRepCmt(<%=nId%> , <%=objParentCmt.getId()%>, <%=objChildCmt.getId()%>, '<%=objChildCmt.getUsername()%>')" method="post">
					                            <div class="row">
					                                <div class="col-12 col-md-6">
					                                    <div class="group">
					                                        <input type="text" name="name" id="name<%=objChildCmt.getId()%>" required>
					                                        <span class="highlight"></span>
					                                        <span class="bar"></span>
					                                        <label>Enter your name</label>
					                                    </div>
					                                </div>
					                                <div class="col-12 col-md-6">
					                                    <div class="group">
					                                        <input type="email" name="email" id="email<%=objChildCmt.getId()%>" required>
					                                        <span class="highlight"></span>
					                                        <span class="bar"></span>
					                                        <label>Enter your email (never public)</label>
					                                    </div>
					                                </div>
					                                <div class="col-12">
					                                    <div class="group">
					                                        <textarea name="message" id="message<%=objChildCmt.getId()%>" required></textarea>
					                                        <span class="highlight"></span>
					                                        <span class="bar"></span>
					                                        <label>Enter your comment</label>
					                                    </div>
					                                </div>
					                                <div class="col-12">
					                                    <button type="submit" class="btn world-btn">Bình luận</button>
					                                </div>
					                            </div>
					                        </form>
                                		</div>
                                	</li>
                                    <%
                                    	}}
                                    %>
                                    <%
                                    	if (showBtnLoadAllRepCmt == true) {
                                    %>
							        <!-- Load More btn -->
							        <div class="row" id="btn_loadmorerepcmt<%=objParentCmt.getId()%>">
							            <div class="col-12">
							                <div class="load-more-btn text-center">
							                    <a href="javascript:void(0)" onclick="return loadAllRepCmt(<%=nId%>, <%=objParentCmt.getId()%>)" class="btn world-btn">Xem tất cả câu trả lời</a>
							                </div>
							            </div>
							        </div>
							        <%
							        	}
							        %>
                                </ol>
                            </li>
                            <%
                            	}}}
                            %>
                        </ol>
                    </div>
                </div>
            </div>
        </div>
        <%
        	if (showBtnLoadAllCmt == true) {
        %>
        <!-- Load More btn -->
        <div class="row" id="btn_loadmore">
            <div class="col-12">
                <div class="load-more-btn mt-50 text-center">
                    <a href="javascript:void(0)" onclick="return loadAllCmt(<%=nId%>)" class="btn world-btn">Xem tất cả bình luận</a>
                </div>
            </div>
        </div>
        <%
        	}
        %>
    </div>
    
    <!-- ***** Footer Area Start ***** -->
    <%@ include file="/templates/public/inc/footer.jsp" %>
    
<script type="text/javascript"> 
    function showFormCmt(parentId) {
    	// đóng tất cả form rep cmt khác trước khi hiện form để rep cmt
    	var y = document.getElementsByClassName('single_comment_area repCmt');
    	var arrFromList = Array.prototype.slice.call(y);
    	arrFromList.forEach(function(element) {
    		element.style.display = "none";
    	});
    	// hiện form để rep cmt
    	document.getElementById('cmt' + parentId).style.display = "block";
    }
</script>
<script>
	function xuLyCmt(nid){
		var username = $('#name').val() + '';
		var email = $('#email').val() + '';	
		var message	= $('#message').val() + '';	
		var typeCmt = "parentCmt";
		//var countCmt = parseInt($('.countCmt').text(),10);
		
		$.ajax({
			url: '<%=request.getContextPath()%>/xu-ly-comment',
			type: 'POST',
			cache: false,
			data: {
				atypeCmt: typeCmt,
				ausername: username,
				aemail: email,
				amessage: message,
				anid: nid,
			},
			success: function(data){
				$('#name').val('');
				$('#email').val('');
				$('#message').val('');
				$('.parent').prepend(data);
				//countCmt += 1;
				//$('.countCmt').html(countCmt);
				
			},
			error: function (){
				alert('Có lỗi xảy ra');
			}
		});	
		return false;
	}
</script>
<script>
	function xuLyRepCmt(nid, parentId, childId, answerTo) {
		$(document).ready(function() {
			var username = $('#name' + childId).val() + '';
			var email = $('#email' + childId).val() + '';	
			var message	= $('#message' + childId).val() + '';	
			var typeCmt = "childCmt";
			//var countCmt = parseInt($('.countCmt').text(),10);
			
			$.ajax({
				url: '<%=request.getContextPath()%>/xu-ly-comment',
				type: 'POST',
				cache: false,
				data: {
					atypeCmt: typeCmt,
					ausername: username,
					aemail: email,
					amessage: message,
					anid: nid,
					aparentId: parentId,
					aanswerTo: answerTo,
				},
				success: function(data){
					$('#name' + childId).val('');
					$('#email' + childId).val('');
					$('#message' + childId).val('');
					document.getElementById('cmt' + childId).style.display = "none";
					$('#children' + parentId).append(data);
					
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
<script type="text/javascript">
	function loadAllCmt(nId) {
		$(document).ready(function() {
			var type = "loadAllCmt";
			$.ajax({
				url: '<%=request.getContextPath()%>/chi-tiet',
				type: 'POST',
				cache: false,
				data: {
					nId : nId,
					type : type,
				},
				success: function(data){
					$('.parent').append(data);
					document.getElementById('btn_loadmore').style.display = "none";
				},
				error: function (){
					alert('Có lỗi xảy ra');
				}
			});	
		});
		return false;
	}
	
	function loadAllRepCmt(nId, parentId) {
		$(document).ready(function() {
			var type = "loadAllRepCmt";
			$.ajax({
				url: '<%=request.getContextPath()%>/chi-tiet',
				type: 'POST',
				cache: false,
				data: {
					type : type,
					nId : nId,
					parentId : parentId,
				},
				success: function(data){
					$('#children' + parentId).append(data);
					document.getElementById('btn_loadmorerepcmt' + parentId).style.display = "none";
				},
				error: function (){
					alert('Có lỗi xảy ra');
				}
			});	
		});
		return false;
	}
	
</script>