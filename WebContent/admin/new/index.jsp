<%@page import="model.dao.NewDAO"%>
<%@page import="util.DefineUtil"%>
<%@page import="util.MessageUtil"%>
<%@page import="model.bean.New"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ include file="/templates/admin/inc/header.jsp" %>
<%@ include file="/templates/admin/inc/leftbar.jsp" %>
<div id="page-wrapper">
    <div id="page-inner">
        <div class="row">
            <div class="col-md-12">
                <h2>Quản lý tin tức</h2>
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
                        	<div class="row">
                                <div class="col-sm-6">
                                    <a href="<%=request.getContextPath() %>/admin/new/add" class="btn btn-success btn-md">Thêm</a>
                                </div>
                          	</div><br />
							<%
								String msgText = MessageUtil.getMessage(request);
							%>
							<%	if(!"".equals(msgText)) { %>
								<div class="alert alert-success" role="alert">
	 								 <strong><%=msgText %></strong>
								</div>
							<%} %>
                            <table class="table table-striped table-bordered table-hover" id="dataTables-example">
                                <thead>
                                    <tr>
                                        <th>ID</th>
                                        <th>Tên tin</th>
                                        <th>Danh mục</th>
                                        <th>Hình ảnh</th>
                                        <th>Lượt đọc</th>
                                        <th>Trạng thái</th>
                                        <th width="160px">Chức năng</th>
                                    </tr>
                                </thead>
                                <tbody>
                                	<%
                                		ArrayList<New> listNew = null;
                                		if(request.getAttribute("listNew") != null) {
                                			listNew = (ArrayList<New>)request.getAttribute("listNew");
                                			if(listNew.size() > 0) {
                                				for(New objNew:listNew) {
                                					String urlEdit = request.getContextPath() + "/admin/new/edit/" + objNew.getId();
													String urlDel = request.getContextPath() + "/admin/new/del?id=" + objNew.getId();
                                	%>
                                    <tr>
                                        <td><%=objNew.getId() %></td>
                                        <td class="center"><%=objNew.getTitle() %></td>
                                        <td class="center"><%=objNew.getObjCat().getCatName() %></td>
                                        <td class="text-center">
                                        	<%
                                        		if(!"".equals(objNew.getPicture())) {
                                        	%>
												<img width="180px" height="120px" src="<%=request.getContextPath() %>/files/<%=objNew.getPicture() %>" alt="<%=objNew.getTitle() %>"/>
                                        	<%
                                        		} else {
                                        	%>
                                        		<img width="180px" height="120px" src="<%=request.getContextPath() %>/templates/admin/assets/img/no.gif" />
                                        	<%} %>
                                        </td>
                                        <td class="center"><%=objNew.getView() %></td>
                                        <%
                                        	if (objNew.getIsActive() == 1) {
                                        %>
                                        <td class="text-center">
                                        	<a href="javascript:void(0)" ><img id="<%=objNew.getId() %>" src="<%=request.getContextPath()%>/templates/admin/assets/img/active.gif" alt="" /></a>
                                        </td>
                                        <% } else { %>
                                        <td class="text-center">
                                        	<a href="javascript:void(0)" ><img id="<%=objNew.getId() %>" src="<%=request.getContextPath()%>/templates/admin/assets/img/deactive.gif" alt="" /></a>
                                        </td>
                                        <%} %>
                                        <td class="text-center">
                                            <a href="<%=urlEdit %>" title="" class="btn btn-primary"><i class="fa fa-edit "></i> Sửa</a>
                                            <a href="<%=urlDel %>" onclick="return confirm('Bạn có muốn xóa không?')" title="" class="btn btn-danger"><i class="fa fa-pencil"></i> Xóa</a>
                                        </td>
                                    </tr>
									<%}}} %>
                                </tbody>
                            </table>
                            <%
                            	int numberOfItems = (Integer) request.getAttribute("numberOfItems");
                            	int numberOfPages = (Integer) request.getAttribute("numberOfPages");
                           		int currentPage = (Integer) request.getAttribute("currentPage");
                           		int begin = (Integer) request.getAttribute("offset") + 1;
                           		int end = begin + DefineUtil.NUMBER_NEWS_PER_PAGE - 1;
                           		if (currentPage == numberOfPages) {
                           			end = numberOfItems;
                           		}
                           		if (listNew != null && listNew.size() > 0) {
                            %>
                            <div class="row">
                                <div class="col-sm-6">
                                    <div class="dataTables_info" id="dataTables-example_info" style="margin-top:27px">Hiển thị từ <%=begin%> đến <%=end %> của <%=numberOfItems%> tin tức</div>
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
	                                    			urlPre = request.getContextPath() + "/admin/new/index/page_" + (currentPage - 1);
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
                                            <li class="paginate_button<%=active %>" aria-controls="dataTables-example" tabindex="0"><a href="<%=request.getContextPath()%>/admin/new/index/page_<%=i%>"><%=i%></a></li>
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
                                        	<li class="paginate_button<%=active1 %>" aria-controls="dataTables-example" tabindex="0"><a href="<%=request.getContextPath()%>/admin/new/index/page_1"><%=1%></a></li>
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
                                            <li class="paginate_button<%=active %>" aria-controls="dataTables-example" tabindex="0"><a href="<%=request.getContextPath()%>/admin/new/index/page_<%=i%>"><%=i%></a></li>
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
                                            <li class="paginate_button<%=activeEnd %>" aria-controls="dataTables-example" tabindex="0"><a href="<%=request.getContextPath()%>/admin/new/index/page_<%=numberOfPages%>"><%=numberOfPages%></a></li>
                                            <% } %>
                                            
                                            <!-- trang tiếp -->
                                            <%
                                            	String urlNext = "";
                                        		if (currentPage == numberOfPages) {
                                        			urlNext = "javascript:void(0)";
                                        		} else {
                                        			urlNext = request.getContextPath() + "/admin/new/index/page_" + (currentPage + 1);
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
<script>
		$(document).ready(function () {
	        $('.text-center img').click(function () {
	        	var src = $(this).attr('src');
	        	var id = $(this).attr('id');
	        	
	            $.ajax({
					url: '<%=request.getContextPath()%>/xu-ly-active-new',
					type: 'POST',
					cache: false,
					data: {
						asrc: src,
						aid: id
					},
					success: function(data){
						$('#' + id).attr('src', data);
					},
					error: function (){
						alert('Có lỗi xảy ra');
					}
				});
	        });
	 	});  
	</script>
<script>
    document.getElementById("new").classList.add('active-menu');
</script>
<!-- /. PAGE INNER  -->
<%@ include file="/templates/admin/inc/footer.jsp" %>