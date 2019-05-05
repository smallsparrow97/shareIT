<%@page import="model.bean.Comment"%>
<%@page import="util.MessageUtil"%>
<%@page import="util.DefineUtil"%>
<%@page import="model.bean.Slide"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ include file="/templates/admin/inc/header.jsp" %>
<%@ include file="/templates/admin/inc/leftbar.jsp" %>
<div id="page-wrapper">
    <div id="page-inner">
        <div class="row">
            <div class="col-md-12">
                <h2>Quản lý bình luận</h2>
            </div>
        </div>
        <!-- /. ROW  -->
        <hr />
        <div class="row">
            <div class="col-md-12">
                <!-- Advanced Tables -->
                <div class="panel panel-default">
                    <div class="panel-body">
                        <div class="table-responsive">
                            <table class="table table-striped table-bordered table-hover" id="dataTables">
                                <thead>
                                    <tr>
                                        <th>ID</th>
                                        <th>Tên tin</th>
                                        <th>Người bình luận</th>
                                        <th>Trả lời cho</th>
                                        <th>Email</th>
                                        <th>Nội dung</th>
                                        <th>Thời gian</th>
                                        <th>Ẩn/hiện</th>
                                    </tr>
                                </thead>
                                <tbody>
                                	<%
                                		ArrayList<Comment> listCmt = null;
                                		if(request.getAttribute("listCmt") != null) {
                                			listCmt = (ArrayList<Comment>)request.getAttribute("listCmt");
                                			if(listCmt.size() > 0) {
                                				for(Comment objCmt:listCmt) {
                                	%>
                                    <tr>
                                        <td><%=objCmt.getId() %></td>
                                        <td class="center"><%=objCmt.getObjNew().getTitle() %></td>
                                        <td class="center"><%=objCmt.getUsername() %></td>
                                        <td class="center"><%=objCmt.getAnswer_to() %></td>
                                        <td class="center"><%=objCmt.getEmail() %></td>
                                        <td class="center"><%=objCmt.getContent() %></td>
                                        <td class="center"><%=objCmt.getTime_cmt() %></td>
                                        <%
                                        	if (objCmt.getIs_active() == 1) {
                                        %>
                                        <td class="text-center">
                                        	<a href="javascript:void(0)" ><img id="<%=objCmt.getId() %>" src="<%=request.getContextPath()%>/templates/admin/assets/img/active.gif" alt="" /></a>
                                        </td>
                                        <% } else { %>
                                        <td class="text-center">
                                        	<a href="javascript:void(0)" ><img id="<%=objCmt.getId() %>" src="<%=request.getContextPath()%>/templates/admin/assets/img/deactive.gif" alt="" /></a>
                                        </td>
                                        <%} %>
                                    </tr>
									<%}}} %>
                                </tbody>
                            </table>
                            <%
                            	int numberOfItems = (Integer) request.getAttribute("numberOfItems");
                            	int numberOfPages = (Integer) request.getAttribute("numberOfPages");
                           		int currentPage = (Integer) request.getAttribute("currentPage");
                           		int begin = (Integer) request.getAttribute("offset") + 1;
                           		int end = begin + DefineUtil.NUMBER_COMMENT_PER_PAGE_ADMIN - 1;
                           		if (currentPage == numberOfPages) {
                           			end = numberOfItems;
                           		}
                           		if (listCmt != null && listCmt.size() > 0) {
                            %>
                            <div class="row">
                                <div class="col-sm-6">
                                    <div class="dataTables_info" id="dataTables-example_info" style="margin-top:27px">Hiển thị từ <%=begin%> đến <%=end %> của <%=numberOfItems%> bình luận</div>
                                </div>
                                <div class="col-sm-6" style="text-align: right;">
                                    <div class="dataTables_paginate paging_simple_numbers" id="dataTables-example_paginate">
                                        <ul class="pagination">
                                        	<!-- trang trước -->
                                        	<%
	                                        	String urlPre = "";
	                                    		if (currentPage == 1) {
	                                    			urlPre = "javascript:void(0)";
	                                    		} else {
	                                    			urlPre = request.getContextPath() + "/admin/comments/page_" + (currentPage - 1);
	                                    		}
                                        	%>
                                        	<li class="paginate_button previous" aria-controls="dataTables-example" tabindex="0" id="dataTables-example_previous"><a href="<%=urlPre%>">Trang trước</a></li>
                                        	
                                        	<%
	                                        	String active = "";
	                                    		int cpage = 1;
	                                    		if (request.getParameter("page") != null) {
	                                    			cpage = Integer.valueOf(request.getParameter("page"));
	                                    		}
	                                    		
	                                        	
	                                        	// nếu tổng số trang nhỏ hơn hoặc bằng số trang muốn hiển thị + 2 thì cho vòng for in ra hết các trang luôn
                                        		if (numberOfPages <= DefineUtil.NUMBER_PAGE_SHOW_MIDDLE + 2) {
                                        	%>
                                        	<% 
                                        		for ( int i = 1; i <= numberOfPages; i++) {
                                        			if (currentPage == i) {
    	                                				active = " active";
    	                                			} else {
    	                                				active = "";
    	                                			}
                                        	%>
                                            <li class="paginate_button<%=active %>" aria-controls="dataTables-example" tabindex="0"><a href="<%=request.getContextPath()%>/admin/comments/page_<%=i%>"><%=i%></a></li>
                                            <%} %>
                                        	
                                        	<% } else { %> <!-- ngược lại in đầu là 1, đuôi là tổng số trang, khúc giữa là ... trang hiện tại - 1 đến trang hiện tại + 1 ... -->
                                        	<%
                	                        	String active1 = "";
                                        		if (currentPage == 1) {
                                        			active1 = " active";
                                        		} else {
                                        			active1 = "";
                                        		}
                                        	%>
                                        	<li class="paginate_button<%=active1 %>" aria-controls="dataTables-example" tabindex="0"><a href="<%=request.getContextPath()%>/admin/comments/page_1"><%=1%></a></li>
                                        	<% if (currentPage > DefineUtil.NUMBER_PAGE_SHOW_MIDDLE)%> <li class="paginate_button" aria-controls="dataTables-example" tabindex="0"><a>...</a></li>
                                        	<% 
                                        		for ( int i = currentPage - 1; i <= currentPage + 1; i++) {
                                        			if (currentPage == i) {
    	                                				active = " active";
    	                                			} else {
    	                                				active = "";
    	                                			}
                                        	%>
                                        	<% if ((i - 1 >= 1) && (i + 1 <= numberOfPages)) { %>
                                            <li class="paginate_button<%=active %>" aria-controls="dataTables-example" tabindex="0"><a href="<%=request.getContextPath()%>/admin/comments/page_<%=i%>"><%=i%></a></li>
                                            <%   }} %>
                                            
                                            <%
                	                        	String activeEnd = "";
                                        		if (currentPage == numberOfPages) {
                                        			activeEnd = " active";
                                        		} else {
                                        			activeEnd = "";
                                        		}
                                        	%>
                                            <% if (currentPage <= numberOfPages - DefineUtil.NUMBER_PAGE_SHOW_MIDDLE)%> <li class="paginate_button" aria-controls="dataTables-example" tabindex="0"><a>...</a></li>
                                            <li class="paginate_button<%=activeEnd %>" aria-controls="dataTables-example" tabindex="0"><a href="<%=request.getContextPath()%>/admin/comments/page_<%=numberOfPages%>"><%=numberOfPages%></a></li>
                                            <% } %>
                                            
                                            <!-- trang tiếp -->
                                            <%
                                            	String urlNext = "";
                                        		if (currentPage == numberOfPages) {
                                        			urlNext = "javascript:void(0)";
                                        		} else {
                                        			urlNext = request.getContextPath() + "/admin/comments/page_" + (currentPage + 1);
                                        		}
                                        	%>
                                            <li class="paginate_button next" aria-controls="dataTables-example" tabindex="0" id="dataTables-example_next"><a href="<%=urlNext%>">Trang tiếp</a></li>
                                        </ul>
                                    </div>
                                </div>
                            </div>
                            <%}%>
                        </div>
                    </div>
                </div>
                <!--End Advanced Tables -->
            </div>
        </div>
    </div>
</div>
<script type="text/javascript">
		$(document).ready(function () {
	        $('.text-center img').click(function () {
	        	var src = $(this).attr('src');
	        	var id = $(this).attr('id');
	        	
	            $.ajax({
					url: '<%=request.getContextPath()%>/xu-ly-active-cmt',
					type: 'POST',
					cache: false,
					data: {
						asrc: src,
						aid: id
					},
					success: function(data){
						//$('#' + id).attr('src', data);
						//$('#dataTables').load(document.URL +  ' #dataTables');
						// load lại trang
						location.reload();
						
					},
					error: function (){
						alert('Có lỗi xảy ra');
					}
				});
	        });
	 	});  
	</script>
<script>
    document.getElementById("cmt").classList.add('active-menu');
</script>
<!-- /. PAGE INNER  -->
<%@ include file="/templates/admin/inc/footer.jsp" %>