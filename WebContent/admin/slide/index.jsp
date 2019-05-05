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
                <h2>Quản lý Slide</h2>
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
                                    <a href="<%=request.getContextPath() %>/admin/slide/add" class="btn btn-success btn-md">Thêm</a>
                                </div>
                                <div class="col-sm-6" style="text-align: right;">
                                    <form method="" action="">
                                        <input type="submit" name="search" value="Tìm kiếm" class="btn btn-warning btn-sm" style="float:right" />
                                        <input type="search" name="textSearch" class="form-control input-sm" placeholder="Search" required="required" style="float:right; width: 300px;" />
                                        <div style="clear:both"></div>
                                    </form><br />
                                </div>
                            </div>
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
                                        <th>Tên slide</th>
                                        <th>Hình ảnh</th>
                                        <th>Link</th>
                                        <th>Trạng thái</th>
                                        <th>Vị trí</th>
                                        <th width="160px">Chức năng</th>
                                    </tr>
                                </thead>
                                <tbody>
                                	<%
                                		ArrayList<Slide> listSlide = null;
                                		if(request.getAttribute("listSlide") != null) {
                                			listSlide = (ArrayList<Slide>)request.getAttribute("listSlide");
                                			if(listSlide.size() > 0) {
                                				for(Slide objSlide:listSlide) {
                                					String urlEdit = request.getContextPath() + "/admin/slide/edit/" + objSlide.getId();
													String urlDel = request.getContextPath() + "/admin/slide/del?id=" + objSlide.getId();
                                	%>
                                    <tr>
                                        <td><%=objSlide.getId() %></td>
                                        <td class="center"><%=objSlide.getName() %></td>
                                        <td class="text-center">
                                        	<%
                                        		if(!"".equals(objSlide.getPicture())) {
                                        	%>
												<img width="300px" height="200px" src="<%=request.getContextPath() %>/files/<%=objSlide.getPicture() %>" alt="<%=objSlide.getName() %>"/>
                                        	<%
                                        		} else {
                                        	%>
                                        		<img width="300px" height="200px" src="<%=request.getContextPath() %>/templates/admin/assets/img/no.gif" />
                                        	<%} %>
                                        </td>
                                        <td class="center"><%=objSlide.getLink() %></td>
                                        <%
                                        	if (objSlide.getActive() == 1) {
                                        %>
                                        <td class="text-center">
                                        	<a href="javascript:void(0)" ><img id="<%=objSlide.getId() %>" src="<%=request.getContextPath()%>/templates/admin/assets/img/active.gif" alt="" /></a>
                                        </td>
                                        <% } else { %>
                                        <td class="text-center">
                                        	<a href="javascript:void(0)" ><img id="<%=objSlide.getId() %>" src="<%=request.getContextPath()%>/templates/admin/assets/img/deactive.gif" alt="" /></a>
                                        </td>
                                        <%} %>
                                        <td class="center"><%=objSlide.getLocation() %></td>
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
                           		int end = begin + DefineUtil.NUMBER_SLIDE_PER_PAGE - 1;
                           		if (currentPage == numberOfPages) {
                           			end = numberOfItems;
                           		}
                           		if (listSlide != null && listSlide.size() > 0) {
                            %>
                            <div class="row">
                                <div class="col-sm-6">
                                    <div class="dataTables_info" id="dataTables-example_info" style="margin-top:27px">Hiển thị từ <%=begin%> đến <%=end %> của <%=numberOfItems%> slide</div>
                                </div>
                                <div class="col-sm-6" style="text-align: right;">
                                    <div class="dataTables_paginate paging_simple_numbers" id="dataTables-example_paginate">
                                        <ul class="pagination">
                                        	<%
	                                        	String urlPre = "";
	                                    		if (currentPage == 1) {
	                                    			urlPre = "javascript:void(0)";
	                                    		} else {
	                                    			urlPre = request.getContextPath() + "/admin/slide/index/page_" + (currentPage - 1);
	                                    		}
                                        	%>
                                        	<li class="paginate_button previous" aria-controls="dataTables-example" tabindex="0" id="dataTables-example_previous"><a href="<%=urlPre%>">Trang trước</a></li>
                                        	<% 
                                        		String active = "";
                                        		for ( int i = 1; i <= numberOfPages; i++) {
                                        			if (currentPage == i) {
                                        				active = " active";
                                        			} else {
                                        				active = "";
                                        			}
                                        	%>
                                            <li class="paginate_button<%=active %>" aria-controls="dataTables-example" tabindex="0"><a href="<%=request.getContextPath()%>/admin/slide/index/page_<%=i%>"><%=i%></a></li>
                                            <%} %>
                                            <%
                                            	String urlNext = "";
                                        		if (currentPage == numberOfPages) {
                                        			urlNext = "javascript:void(0)";
                                        		} else {
                                        			urlNext = request.getContextPath() + "/admin/slide/index/page_" + (currentPage + 1);
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
					url: '<%=request.getContextPath()%>/xu-ly-active-slide',
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
    document.getElementById("slide").classList.add('active-menu');
</script>
<!-- /. PAGE INNER  -->
<%@ include file="/templates/admin/inc/footer.jsp" %>