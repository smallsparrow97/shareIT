package controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import model.bean.Category;
import model.bean.Comment;
import model.bean.New;
import model.bean.User;
import model.dao.CommentDAO;

public class PublicXuLyCommentController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public PublicXuLyCommentController() {
		super();
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setCharacterEncoding("UTF-8");
		response.setContentType("text/html");
		CommentDAO commentDAO = new CommentDAO();
		
		String typeCmt = request.getParameter("atypeCmt");
		String username = request.getParameter("ausername");
		String answerTo = "";
		String email = request.getParameter("aemail");
		String content = request.getParameter("amessage");
		int nid = Integer.valueOf(request.getParameter("anid"));
		int parentId = 0;
		
		if ("parentCmt".equals(typeCmt)) {
			Comment objCmt = new Comment(0, parentId, 1, username, answerTo , email, content, null, new New(nid, new User(), 0, 1, "", "", "", "", null, new Category()));
			if (commentDAO.addCmt(objCmt) > 0) {
				response.sendRedirect(request.getContextPath() + "/templates/public/ajaxResult/ajaxCmtResult.jsp?nid=" + nid);
				return;
			}
		} else {
			if ("childCmt".equals(typeCmt)) {
				parentId = Integer.valueOf(request.getParameter("aparentId"));
				answerTo = request.getParameter("aanswerTo");
				Comment objCmt = new Comment(0, parentId, 1, username, answerTo, email, content, null, new New(nid, new User(), 0, 1, "", "", "", "", null, new Category()));
				if (commentDAO.addCmt(objCmt) > 0) {
					response.sendRedirect(request.getContextPath() + "/templates/public/ajaxResult/ajaxCmtResult.jsp?parentid=" + parentId);
					return;
				}
			}
		}
	}
}
