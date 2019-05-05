<%@page import="model.bean.Slide"%>
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
                <h2>Thêm slide</h2>
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
                            	String name = "";
                            	String link = "";
								if (request.getParameter("msg") != null) {
									if (request.getAttribute("objSlide") != null) {
										Slide objSlide = (Slide) request.getAttribute("objSlide");
										name = objSlide.getName();
										link = objSlide.getLink();
									}
									int msg = Integer.valueOf(request.getParameter("msg"));
									if(msg == 0){
										msgText = "Có lỗi trong quá trình thêm, Vui lòng thử lại";
									}
								}
								%>
								<%if (!"".equals(msgText)) { %>
									<div class="alert alert-warning" role="alert">
	 								 	<%=msgText %>
									</div>
								<%} %>
                                <form role="form" action="" method="post" enctype="multipart/form-data" id="form">
                                    <div class="form-group">
                                        <label for="name">Tên slide</label>
                                        <input type="text" id="name" value="<% if (name != null) out.print(name); %>" name="name" class="form-control" />
                                    </div>
                                   
                                    <div class="form-group">
                                        <label for="picture">Hình ảnh</label>
                                        <input type="file" name="picture" onchange="readURL(this);" />
                                        <br />
                                        <img width="300px" height="200px" id="img" alt="hinhanh" src="#" >
                                        <br />
                                    </div>
                                    <div class="form-group">
                                        <label for="link">Link</label>
                                        <input id="link" class="form-control" name="link" value="<% if (link != null) out.print(link); %>" />
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
	$().ready(function () {
		// validate form when it submited
		$('#form').validate({
			errorPlacement: function(error, element) {
				$(element).closest("form").find("label[for='"+ element.attr("id") + "']").append(error); 
			},
			errorElement: "span",
			rules:{
				name: {
					required: true,
				},
			},
			messages:{
				name: {
					required: " (Vui lòng nhập trường này)",
				},
			},
		});
	});
</script>
<script>
    document.getElementById("slide").classList.add('active-menu');
</script>
<script>
    function readURL(input) {
        if (input.files && input.files[0]) {
            var reader = new FileReader();

            reader.onload = function (e) {
                $('#img')
                    .attr('src', e.target.result);
            };

            reader.readAsDataURL(input.files[0]);
        }
    }
</script>
<!-- /. PAGE WRAPPER  -->
<%@ include file="/templates/admin/inc/footer.jsp" %>