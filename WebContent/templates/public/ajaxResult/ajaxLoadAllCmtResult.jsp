<%@page import="java.util.ArrayList"%>
<%@page import="util.StringUtil"%>
<%@page import="model.bean.Comment"%>
<%@page import="model.dao.CommentDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>

<%
	int nId = (Integer) request.getAttribute("nId");
	CommentDAO cmtDAO = new CommentDAO();
	if (request.getAttribute("listCmt") != null) {
		ArrayList<Comment> listCmt = (ArrayList<Comment>) request.getAttribute("listCmt");
		if (listCmt.size() > 0) {
			for (Comment objParentCmt : listCmt) {
				ArrayList<Comment> listChildCmt = cmtDAO.getChildItems(objParentCmt.getId());
%>
<!-- Single Comment Area -->
<li class="single_comment_area">
	<!-- Comment Content -->
	<div class="comment-content">
		<!-- Comment Meta -->
		<div
			class="comment-meta d-flex align-items-center justify-content-between">
			<p>
				<a href="#" class="post-author"><strong><%=objParentCmt.getUsername()%></strong></a>
				vào <a href="#" class="post-date"><%=StringUtil.timeCmtFormat(objParentCmt.getTime_cmt())%></a>
			</p>
			<a href="javascript:void(0)"
				onclick="showFormCmt(<%=objParentCmt.getId()%>)"
				class="comment-reply btn world-btn">Reply</a>
		</div>
		<p><%=objParentCmt.getContent()%></p>
	</div>
	<ol class="children" id="children<%=objParentCmt.getId()%>">
		<li class="single_comment_area repCmt"
			id="cmt<%=objParentCmt.getId()%>" style="display: none">
			<div class="comment-content">
				<!-- Contact Form -->
				<form action="javascript:void(0)"
					onsubmit="return xuLyRepCmt(<%=nId%>, <%=objParentCmt.getId()%>, <%=objParentCmt.getId()%>, '<%=objParentCmt.getUsername()%>')"
					method="post">
					<div class="row">
						<div class="col-12 col-md-6">
							<div class="group">
								<input type="text" name="name"
									id="name<%=objParentCmt.getId()%>" required> <span
									class="highlight"></span> <span class="bar"></span> <label>Enter
									your name</label>
							</div>
						</div>
						<div class="col-12 col-md-6">
							<div class="group">
								<input type="email" name="email"
									id="email<%=objParentCmt.getId()%>" required> <span
									class="highlight"></span> <span class="bar"></span> <label>Enter
									your email (never public)</label>
							</div>
						</div>
						<div class="col-12">
							<div class="group">
								<textarea name="message" id="message<%=objParentCmt.getId()%>"
									required></textarea>
								<span class="highlight"></span> <span class="bar"></span> <label>Enter
									your comment</label>
							</div>
						</div>
						<div class="col-12">
							<button type="submit" class="btn world-btn">Bình luận</button>
						</div>
					</div>
				</form>
			</div>
		</li>
		<%
			if (listChildCmt.size() > 0) {
				for (Comment objChildCmt : listChildCmt) {
		%>
		<li class="single_comment_area">
			<!-- Comment Content -->
			<div class="comment-content">
				<!-- Comment Meta -->
				<div
					class="comment-meta d-flex align-items-center justify-content-between">
					<p>
						<a href="#" class="post-author"><strong><%=objChildCmt.getUsername()%></strong></a>
						đã trả lời: <strong><%=objChildCmt.getAnswer_to()%></strong> vào
						<a href="#" class="post-date"><%=StringUtil.timeCmtFormat(objChildCmt.getTime_cmt())%></a>
					</p>
					<a href="javascript:void(0)"
						onclick="showFormCmt(<%=objChildCmt.getId()%>)"
						class="comment-reply btn world-btn">Reply</a>
				</div>
				<p><%=objChildCmt.getContent()%></p>
			</div>
		</li>
		<li class="single_comment_area repCmt"
			id="cmt<%=objChildCmt.getId()%>" style="display: none">
			<div class="comment-content">
				<!-- Contact Form -->
				<form action="javascript:void(0)"
					onsubmit="return xuLyRepCmt(<%=nId%> ,<%=objParentCmt.getId()%>, <%=objChildCmt.getId()%>, '<%=objChildCmt.getUsername()%>')"
					method="post">
					<div class="row">
						<div class="col-12 col-md-6">
							<div class="group">
								<input type="text" name="name" id="name<%=objChildCmt.getId()%>"
									required> <span class="highlight"></span> <span
									class="bar"></span> <label>Enter your name</label>
							</div>
						</div>
						<div class="col-12 col-md-6">
							<div class="group">
								<input type="email" name="email"
									id="email<%=objChildCmt.getId()%>" required> <span
									class="highlight"></span> <span class="bar"></span> <label>Enter
									your email (never public)</label>
							</div>
						</div>
						<div class="col-12">
							<div class="group">
								<textarea name="message" id="message<%=objChildCmt.getId()%>"
									required></textarea>
								<span class="highlight"></span> <span class="bar"></span> <label>Enter
									your comment</label>
							</div>
						</div>
						<div class="col-12">
							<button type="submit" class="btn world-btn">Bình luận</button>
						</div>
					</div>
				</form>
			</div>
		</li>
		<%
			}}
		%>
	</ol>
</li>
<%
	}}}
%>
