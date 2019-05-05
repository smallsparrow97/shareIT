<%@page import="model.dao.CatDAO"%>
<%@page import="util.DefineUtil"%>
<%@page import="util.MessageUtil"%>
<%@page import="model.bean.Category"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ include file="/templates/admin/inc/header.jsp" %>
<%@ include file="/templates/admin/inc/leftbar.jsp" %>
<div id="page-wrapper">
    <div id="page-inner">
        <div class="row">
            <div class="col-md-12">
                <h2>Quản lý danh mục</h2>
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
                                    <a href="<%=request.getContextPath()%>/admin/cat/add" class="btn btn-success btn-md">Thêm</a>
                                </div>
                            </div>
                            <div>
                            	<br />
								<%
									String msgText = MessageUtil.getMessage(request);
								%>
								<%
									if(!"".equals(msgText)) {
								%>
									<div class="alert alert-success" role="alert">
		 								 <strong><%=msgText%></strong>
									</div>
								<%
									}
								%>
							</div>							
							<div id="ajax-alert"></div>
							
                            <table class="table table-striped table-bordered table-hover" id="dataTables-example">
                                <thead>
                                    <tr>
                                        <th>ID</th>
                                        <th>Tên danh mục</th>
                                        <th>Hình ảnh</th>
                                        <th width="160px">Chức năng</th>
                                    </tr>
                                </thead>
                                <tbody>
                                	<%
                                		CatDAO catDAO = new CatDAO();
      	                                		ArrayList<Category> listParentCat = null;
      	                                		ArrayList<Category> listChildCat = null;
      									if(request.getAttribute("listParentCat") != null) {
      										listParentCat = (ArrayList<Category>)request.getAttribute("listParentCat");
      										if(listParentCat.size() > 0) {
      											for(Category objCat:listParentCat) {
      												listChildCat = catDAO.getChildCat(objCat.getCatId());
      												String urlEdit = request.getContextPath() + "/admin/cat/edit/" + objCat.getCatId();
      												String urlDel = request.getContextPath() + "/admin/cat/del?cid=" + objCat.getCatId();
                                	%>
                                    <tr>
                                        <td><%=objCat.getCatId() %></td>
                                        <td class="center"><%=objCat.getCatName() %>
                                        	<ul>
	                                        	<%
	                                        		if (listChildCat.size() > 0) {
	                                        			for(Category objChildCat:listChildCat) {
	                                        				String urlEditChildCat = request.getContextPath() + "/admin/cat/edit/" + objChildCat.getCatId();
	    													String urlDelChildCat = request.getContextPath() + "/admin/cat/del?cid=" + objChildCat.getCatId();
	                                        	%>
                                        		<li style="list-style: none">
                                        			- <%=objChildCat.getCatName() %>&nbsp;
                                        			<a class="del_cat" href="<%=urlDelChildCat %>" onclick="return confirm('Bạn có chắc chắn muốn xóa?')" ></a>
                                        			<a class="edit_cat" id="<%=objChildCat.getCatId()%>" ></a>
                                        		</li>
                                        		<% }} %>
                                        	</ul>
                                        </td>
                                        
                                        <td class="text-center">
                                        	<%
                                        		if(!"".equals(objCat.getPicture())) {
                                        	%>
												<img width="120px" height="120px" src="<%=request.getContextPath() %>/files/<%=objCat.getPicture() %>" alt="<%=objCat.getCatName() %>"/>
                                        	<%
                                        		} else {
                                        	%>
                                        		<img width="120px" height="120px" src="<%=request.getContextPath() %>/templates/admin/assets/img/no.gif" />
                                        	<%} %>
                                        </td>
                                        <td class="center">
                                            <a href="<%=urlEdit %>" title="" class="btn btn-primary"><i class="fa fa-edit "></i> Sửa</a>
                                            <a href="<%=urlDel%>" onclick="return confirm('Bạn có chắc chắn muốn xóa?')" title="" class="btn btn-danger"><i class="fa fa-pencil"></i> Xóa</a>
                                        </td>
                                    </tr>
                                    <%}}} %>
                                </tbody>
                                <!-- Phần ẩn -->
                                <div id="edit_dialog" style="display: none">
	                   				<form method="post" id="form_edit_dialog">
	                   					<div class="form-group">
		                    				<label>Tên danh mục</label>
		                    				<input class="form-control" id="catname" type="text" name="catname" value="" required="required"  />
		                    			</div>
		                    			<div class="form-group">
		                    				<label>Danh mục cha</label>
		                    				<select id="parent_select" name="parent_select" class="form-control">
	                                         	<%
	                                         		for(Category objCat:listParentCat) {
	                                         	%>
		                                       		<option value="<%=objCat.getCatId() %>"><%=objCat.getCatName() %></option>
												<% } %>
	                                        </select>
		                    			</div>
	                   				</form>
	                   				<!-- thẻ input ẩn để lưu lại id cat khi data trả về từ ajax -->
	                   				<input type="hidden" id="hidden_id" value="" >
	                   			</div>
                            </table>
                        </div>
                    </div>
                </div>
                <!--End Advanced Tables -->
            </div>
        </div>
    </div>
</div>
<script>
    document.getElementById("category").classList.add('active-menu');
</script>
<script>
	$(document).ready(function () {
		var selector = {
				autoOpen: false,
				position: { my: "center top", at: "center top", of: window },
		    	show: {effect: "blind", duration: 500},
		        hide: {effect: "fade", duration:500},
		        width: 250,
		        height: "auto",
		        resizable: false,
		        modal: true,
		        closeOnEscape: true,
		        title: 'SỬA DANH MỤC TIN',
		        buttons:{
		        	"Lưu": function () {
		        		var id = $('#hidden_id').val();
		        		var catname = $('#catname').val();
		        		var parent_id = $('#parent_select').val();
		        		
		        		if (catname == ""){
		        			alert("Vui lòng nhập tên danh mục");
		        		} else {
		        			$.ajax({
			    				url:"<%=request.getContextPath()%>/ajaxEditChildCat",
			    				method: "POST",
			    				data: {
			    					id: id,
			    					catname: catname,
			    					parent_id: parent_id,
			    				},
			    				success: function(data) {
			    					// load lại 1 phần của trang (table)
			    					$('#dataTables-example').load(document.URL +  ' #dataTables-example');
			    					$('#ajax-alert').html(data);
			    				},
			    				error: function (data){
			    					$('#ajax-alert').html(data);
								}
			    			}),
							$(this).dialog("close");
		        			// load lại trang
			        		//location.reload();
		        		}
					},
					"Đóng": function () {
						$(this).dialog("close");
					}
		        }
			}
		
		$(document).on('click', '.edit_cat', function () {
			var id = $(this).attr("id");
			$.ajax({
				url:"<%=request.getContextPath()%>/getchildcat",
				method: "POST",
				data: {id:id},
				dataType: 'json',
				success:function(data) {
					$('#catname').val(data.catname);
					$('#parent_select').val(data.parent_id);
					$('#hidden_id').val(id);
					$('#edit_dialog').dialog(selector).dialog("open");
				},
				error: function (){
					alert('Có lỗi xảy ra. Vui lòng thử lại');
				}
			})
		});
	});
	
	
</script>
<!-- /. PAGE INNER  -->
<%@ include file="/templates/admin/inc/footer.jsp" %>