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
                <h2>Sửa slide</h2>
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
	                            	String picture = "";
	                            	String link = "";
	                            	int location = 0;
	                            	Slide objSlide = null;
									if (request.getAttribute("objSlide") != null) {
										objSlide = (Slide) request.getAttribute("objSlide");
										name = objSlide.getName();
										picture = objSlide.getPicture();
										link = objSlide.getLink();
										location = objSlide.getLocation();
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
                                <form role="form" action="<%=request.getContextPath()%>/admin/slide/edit?id=<%=objSlide.getId()%>" method="post" enctype="multipart/form-data" id="form">
                                    <div class="form-group">
                                        <label for="name">Tên slide</label>
                                        <input type="text" name="name" id="name" value="<% if (name != null) out.print(name); %>" class="form-control" />
                                    </div>
                                    <div class="form-group">
                                        <label for="picture">Hình ảnh</label>
                                        <input type="file" name="picture" onchange="readURL(this);" />
                                        <% if (!picture.isEmpty()) {%>
                                        <br />
                                        <img width="300px" height="200px" id="img" alt="hinhanh" src="<%=request.getContextPath()%>/files/<%=picture%>" >
                                        <br />
                                        <%} else {%>
                                        <br />
                                        <img width="300px" height="200px" id="img" alt="hinhanh" src="<%=request.getContextPath() %>/templates/admin/assets/img/no.gif" >
                                        <br />
                                        <%}%>
                                    </div>
                                    <div class="form-group">
                                        <label for="link">Link</label>
                                        <input id="link" class="form-control"  name="link" value="<% if (link != null) out.print(link); %>" />
                                    </div>
                                    <div class="form-group">
                                        <label for="location">Vị trí</label>
                                        <input class="form-control" id="location" name="location" value="<% if (location != 0) out.print(location); %>" />
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