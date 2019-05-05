<%@page import="java.util.ArrayList"%>
<%@page import="model.bean.Category"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ include file="/templates/admin/inc/header.jsp" %>
<%@ include file="/templates/admin/inc/leftbar.jsp" %>
<div id="page-wrapper">
    <div id="page-inner">
        <div class="row">
            <div class="col-md-12">
                <h2>Thêm danh mục</h2>
            </div>
        </div>
        <!-- /. ROW  -->
        <hr />
        <div class="row">
            <div class="col-md-12">
                <!-- Form Elements -->
                <div class="panel panel-default">
                    <div class="panel-body">
                        <div class="row">
                            <div class="col-md-12">
                            	<%
								String msgText = "";
                            	String name = null;
                            	String description = null;
								if(request.getParameter("msg") != null){
									if (request.getAttribute("objSong") != null) {
										Category objCat = (Category) request.getAttribute("objCat");
										name = objCat.getCatName();
										description = objCat.getDescription();
									}
									int msg = Integer.valueOf(request.getParameter("msg"));
									if(msg == 0){
										msgText = "Có lỗi trong quá trình thêm, Vui lòng thử lại";
									}
								}
								%>
								<%if(!"".equals(msgText)) { %>
									<div class="alert alert-warning" role="alert">
	 								 	<%=msgText %>
									</div>
								<%} %>
                                <form role="form" method="post" action="<%=request.getContextPath() %>/admin/cat/add" id="form" enctype="multipart/form-data">
                                    <div class="form-group">
                                        <label for="name">Tên danh mục</label>
                                        <input required="required" type="text" id="name" value="<% if (name != null) out.print(name); %>" name="name" class="form-control" />
                                    </div>
                                    <div class="form-group">
                                    	<label >Danh mục cha</label>
	                                    <select id="parent_select" name="parent_select" class="form-control">
	                                      	<option value="0">Không</option>
	                                      	<%
		                                      	if(request.getAttribute("listParentCat") != null) {
													ArrayList<Category> listParentCat = (ArrayList<Category>)request.getAttribute("listParentCat");
													if(listParentCat.size() > 0) {
		                                      			for(Category objCat:listParentCat) {
	                                      	%>
	                                     	<option value="<%=objCat.getCatId() %>"><%=objCat.getCatName() %></option>
											<% }}} %>
	                                     </select>
                                     </div>
                                     
                                     <div class="form-group" id="parent_info_extend">
                                     	<div class="form-group">
	                                        <label for="picture">Hình ảnh</label>
	                                        <input type="file" name="picture" onchange="readURL(this);" />
	                                        <br />
	                                        <img width="200px" height="200px" id="img" alt="" src="" >
	                                        <br />
                                    	</div>
                                    	
                                    	<div class="form-group">
	                                        <label for="preview">Mô tả</label>
	                                        <textarea class="form-control" id="description" rows="3" name="description" ><% if (description != null) out.print(description); %></textarea>
                                    	</div>
                                     </div>
                                    <button type="submit" name="submit" class="btn btn-success btn-md">Thêm</button>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>
                <!-- End Form Elements -->
            </div>
        </div>
        <!-- /. ROW  -->
    </div>
    <!-- /. PAGE INNER  -->
</div>
<script>
	$(document).ready(function (){
		$(document).on('click', '#parent_select', function () {
			var parent_id = $("#parent_select").val();
			if (parent_id > 0){
				$('#parent_info_extend').fadeOut();
			} else {
				$('#parent_info_extend').show("fade", 500);
			}
		})
	});
</script>
<script>
	function readURL(input) {
	    if (input.files && input.files[0]) {
	        var reader = new FileReader();
	        reader.onload = function (e) {
	            $('#img').attr('src', e.target.result);
	        };
	        reader.readAsDataURL(input.files[0]);
	    }
	}
</script>
<script>
    document.getElementById("category").classList.add('active-menu');
</script>
<!-- /. PAGE WRAPPER  -->
<%@ include file="/templates/admin/inc/footer.jsp" %>