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
                <h2>Sửa danh mục</h2>
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
								if(request.getParameter("msg") != null){
									int msg = Integer.valueOf(request.getParameter("msg"));
									if(msg == 0){
										msgText = "Có lỗi trong quá trình sửa, Vui lòng thử lại";
									}
								}
								%>
								<%if(!"".equals(msgText)) { %>
									<div class="alert alert-warning" role="alert">
	 								 	<%=msgText %>
									</div>
								<%} %>
								<%
									int id = 0;
									int parent_id = 0;
									String name = "";
	                            	String description = "";
	                            	String picture = "";
 									if(request.getAttribute("objCat") != null) {
										Category objCat = (Category)request.getAttribute("objCat");
										id = objCat.getCatId();
										name = objCat.getCatName();
										description = objCat.getDescription();
										picture = objCat.getPicture();
										parent_id = objCat.getParentId();
									}
								%>
                                <form role="form" method="post" action="<%=request.getContextPath() %>/admin/cat/edit?cid=<%=id %>" id="form" enctype="multipart/form-data">
                                    <div class="form-group">
                                        <label for="name">Tên danh mục</label>
                                        <input type="text" id="name" value="<% if (name != null) out.print(name); %>" name="name" class="form-control" required="required"/>
                                    </div>
                                    <div class="form-group">
                                        <label for="picture">Hình ảnh</label>
                                        <input type="file" name="picture" onchange="readURL(this);" />
                                        <% if (!picture.isEmpty()) {%>
                                        <br />
                                        <img width="200px" height="200px" id="img" alt="hinhanh" src="<%=request.getContextPath()%>/files/<%=picture%>" >
                                        <br />
                                        <%} else {%>
                                        <br />
                                        <img width="200px" height="200px" id="img" alt="hinhanh" src="<%=request.getContextPath() %>/templates/admin/assets/img/no.gif" >
                                        <br />
                                        <%}%>
                                   	</div>
                                   	
                                   	<div class="form-group">
                                        <label for="preview">Mô tả</label>
                                        <textarea class="form-control" id="description" rows="3" name="description" ><% if (description != null) out.print(description); %></textarea>
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