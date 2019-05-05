<%@page import="model.dao.CatDAO"%>
<%@page import="util.StringUtil"%>
<%@page import="model.bean.Category"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<footer class="footer-area">
       <div class="container">
           <div class="row">
               <div class="col-12 col-md-4">
                   <div class="footer-single-widget">
                       <a href="<%=request.getContextPath()%>"><img src="<%=request.getContextPath()%>/templates/public/img/core-img/logo.png" alt=""></a>
                       <div class="copywrite-text mt-30">
                           <p>
								Copyright &copy;<script>document.write(new Date().getFullYear());</script> All rights reserved
								<br />
								This website is made with <i class="fa fa-heart-o" aria-hidden="true"></i> by <a href="https://colorlib.com" target="_blank">Colorlib</a>
								<br />
								Edit and code by Ba Duy - VinaEnter Java26
						   </p>

                    </div>
                </div>
            </div>
            <div class="col-12 col-md-4">
                <div class="footer-single-widget">
                	<ul class="footer-menu d-flex justify-content-between">
                        <li><a href="<%=request.getContextPath()%>">Home</a></li>
	                	<%
	                		CatDAO cDAO = new CatDAO();
   		                		ArrayList<Category> listCatParent = cDAO.getParentItems();
   		                		if (listCatParent.size() > 0) {
   		                    		for (Category objCatP:listCatParent) {
   		                    			String urlDetail = request.getContextPath() + "/" + StringUtil.makeSlug(objCatP.getCatName()) + "-" + objCatP.getCatId();
	                	%>
                    	<li><a href="<%=urlDetail%>"><%=objCatP.getCatName() %></a></li>
                    	<%}} %>
                    	<li><a href="<%=request.getContextPath()%>/about">About me</a></li>
                    </ul>
                </div>
            </div>
            <div class="col-12 col-md-4">
                <div class="footer-single-widget">
                    <h5>Subscribe</h5>
                    <form action="#" method="post">
                        <input type="email" name="email" id="email" placeholder="Enter your mail">
                        <button type="button"><i class="fa fa-arrow-right"></i></button>
                    </form>
                </div>
            </div>
        </div>
    </div>
</footer>
<!-- ***** Footer Area End ***** -->
	<!-- jQuery (Necessary for All JavaScript Plugins) -->
    <script src="<%=request.getContextPath() %>/templates/public/js/jquery/jquery_2.2.4.min.js"></script>
    <!-- Popper js -->
    <script src="<%=request.getContextPath() %>/templates/public/js/popper.min.js"></script>
    <!-- Bootstrap js -->
    <script src="<%=request.getContextPath() %>/templates/public/js/bootstrap.min.js"></script>
    <!-- Plugins js -->
    <script src="<%=request.getContextPath() %>/templates/public/js/plugins.js"></script>
    <!-- Active js -->
    <script src="<%=request.getContextPath() %>/templates/public/js/active.js"></script>

</body>

</html>