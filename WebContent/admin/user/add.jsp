<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ include file="/templates/admin/inc/header.jsp" %>
<%@ include file="/templates/admin/inc/leftbar.jsp" %>
<div id="page-wrapper">
    <div id="page-inner">
        <div class="row">
            <div class="col-md-12">
                <h2>Thêm người dùng</h2>
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
                            	String username = "";
                            	String fullname = "";
								if(request.getParameter("msg") != null){
									username = request.getParameter("username");
									fullname = request.getParameter("fullname");
									int msg = Integer.valueOf(request.getParameter("msg"));
									if(msg == 0){
										msgText = "Có lỗi trong quá trình thêm, Vui lòng thử lại";
									}
									if(msg == 4){
										msgText = "Tên đăng nhập đã tồn tại, Vui lòng thử lại";
									}
								}
								%>
								<%if(!"".equals(msgText)) { %>
									<div class="alert alert-warning" role="alert">
	 								 	<%=msgText %>
									</div>
								<%} %>
                                <form role="form" method="post" id="form">
                                    <div class="form-group">
                                        <label for="username">Tên đăng nhập</label>
                                        <input type="text" id="username" value="<%if(username != null) out.print(username); %>" name="username" required="required" style="width: 50%" class="form-control" />
                                    </div>
                                    <div class="form-group">
                                        <label for="password">Mật khẩu</label>
                                        <input type="password" id="password" value="" name="password" required="required" style="width: 50%" class="form-control" />
                                    </div>
                                    <div class="form-group">
                                        <label for="fullname">Họ tên</label>
                                        <input type="text" id="fullname" value="<%if(fullname != null) out.print(fullname); %>" name="fullname" required="required" style="width: 50%" class="form-control" />
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
    document.getElementById("user").classList.add('active-menu');
</script>
<!-- /. PAGE WRAPPER  -->
<%@ include file="/templates/admin/inc/footer.jsp" %>