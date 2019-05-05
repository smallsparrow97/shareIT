<%@page import="model.bean.New"%>
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
                <h2>Sửa tin tức</h2>
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
                            	String title = "";
                            	String preview = "";
                            	String detail = "";
                            	String picture = "";
                            	New objNew = null;
                            	int cat_id = 0;
                            	int id = 0;
								
								if (request.getAttribute("objNew") != null) {
									objNew = (New) request.getAttribute("objNew");
									id = objNew.getId();
									title = objNew.getTitle();
									preview = objNew.getPreview();
									detail = objNew.getDetail();
									picture = objNew.getPicture();
									cat_id = objNew.getObjCat().getCatId();
								}
								
								if (request.getParameter("msg") != null) {
									int msg = Integer.valueOf(request.getParameter("msg"));
									if(msg == 0){
										msgText = "Có lỗi trong quá trình sửa, Vui lòng thử lại";
									}
								}
								%>
								<%if (!"".equals(msgText)) { %>
									<div class="alert alert-warning" role="alert">
	 								 	<%=msgText %>
									</div>
								<%} %>
                                <form role="form" action="<%=request.getContextPath() %>/admin/new/edit?id=<%=id %>" method="post" enctype="multipart/form-data" id="form">
                                    <div class="form-group">
                                        <label for="title">Tiêu đề tin</label>
                                        <input type="text" id="title" value="<% if (title != null) out.print(title); %>" name="title" class="form-control" />
                                    </div>
                                    <div class="form-group">
                                        <label for="category">Danh mục tin</label>
                                        <select id="category" name="cat_id" class="form-control">
                                         	<%
                                         		if (request.getAttribute("listCat") != null) {
	                                        		ArrayList<Category> listCat = (ArrayList<Category>) request.getAttribute("listCat");
	                                        		if(listCat.size() > 0) {
	                                        			for(Category objCat:listCat) {
                                         	%>
	                                       		<option <% if (cat_id == objCat.getCatId()) out.print(" selected "); %> value="<%=objCat.getCatId()%>"><%=objCat.getCatName() %></option>
											<%}}} %>
                                        </select>
                                    </div>
                                    <div class="form-group">
                                        <label for="picture">Hình ảnh</label>
                                        <input type="file" name="picture" onchange="readURL(this);" />
                                        <% if (!picture.isEmpty()) {%>
                                        <br />
                                        <img width="240px" height="150px" id="img" alt="hinhanh" src="<%=request.getContextPath()%>/files/<%=picture%>" >
                                        <br />
                                        <%} else {%>
                                        <br />
                                        <img width="240px" height="150px" id="img" alt="hinhanh" src="<%=request.getContextPath() %>/templates/admin/assets/img/no.gif" >
                                        <br />
                                        <%}%>
                                    </div>
                                    <div class="form-group">
                                        <label for="preview">Mô tả</label>
                                        <textarea id="preview" class="form-control" rows="3" name="preview"><% if (preview != null) out.print(preview); %></textarea>
                                    </div>
                                    <div class="form-group">
                                        <label for="detail">Chi tiết</label>
                                        <textarea id="detail" class="form-control" id="detail" rows="10" name="detail"><% if (detail != null) out.print(detail); %></textarea>
                                    </div>
                                    <button type="submit" name="submit" class="btn btn-success btn-md">Sửa</button>
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
	document.getElementById("new").classList.add('active-menu');
</script>
<script>
	var editor = CKEDITOR.replace("detail");
	CKFinder.setupCKEditor(editor, '<%=request.getContextPath()%>/library/ckfinder');
</script>
<script>
$().ready(function () {
	// validate form when it submited
	$('#form').validate({
		errorPlacement: function(error, element) {
			$(element).closest("form").find("label[for='"+ element.attr("id") + "']").append(error); 
		},
		errorElement: "span",
		ignore: [],
		rules:{
			title: {
				required: true,
			},
			preview: {
				required: true,
			},
			detail:{
               required: function() 
               {
                	CKEDITOR.instances.detail.updateElement();
               },

               minlength: 10
           }
		},
		messages:{
			title: {
				required: " (Vui lòng nhập trường này)",
			},
			preview: {
				required: " (Vui lòng nhập trường này)",
			},
			detail: {
                required:" (Vui lòng nhập trường này)",
                minlength:" (Vui lòng nhập ít nhất 10 ký tự)"
            }
		},
	});
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
<!-- /. PAGE WRAPPER  -->
<%@ include file="/templates/admin/inc/footer.jsp" %>