package controller;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import model.bean.Comment;
import model.bean.New;
import model.dao.CommentDAO;
import model.dao.NewDAO;
import util.DefineUtil;

public class PublicDetailController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public PublicDetailController() {
		super();
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		
		int id = 0;
		try {
			id = Integer.valueOf(request.getParameter("nid"));
		} catch (NumberFormatException e) {
			System.out.println("Có lỗi");
			response.sendRedirect(request.getContextPath() + "/404");
			return;
		}
		// lấy ra tin tức dựa vào id
		NewDAO newDAO = new NewDAO();
		New objNew = newDAO.getItemPublic(id);
		// phương thức tăng lượt xem
		newDAO.increaseView(id);
		
		// lấy danh sách tin tức liên quan
		ArrayList<New> listRelatedNew = newDAO.getRelatedNew(objNew);
		
		// lấy ra danh sách comment cha
		CommentDAO commentDAO = new CommentDAO();
		ArrayList<Comment> listCmt = commentDAO.getParentItems(id, DefineUtil.NUMBER_COMMENT_SHOW_PER_NEWS);
		// lấy ra số cmt của tin tức
		int countCmt = commentDAO.countCmtOfNews(id);
		// lấy ra số cmt cha
		int countParentCmt = commentDAO.countParentCmtOfNews(id);
		
 		request.setAttribute("objNew", objNew);
 		request.setAttribute("listRelatedNew", listRelatedNew);
 		request.setAttribute("listCmt", listCmt);
 		request.setAttribute("countCmt", countCmt);
 		request.setAttribute("countParentCmt", countParentCmt);
 		
		RequestDispatcher rd = request.getRequestDispatcher("/public/detail.jsp");
		rd.forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		
		// xử lý ajax
		CommentDAO commentDAO = new CommentDAO();
		String type = request.getParameter("type");
		if ("loadAllCmt".equals(type)) {
			// xử lý ajax: load tất cả comment
			int nId = 0;
			try {
				nId = Integer.valueOf(request.getParameter("nId"));
			} catch (NumberFormatException e) {
				System.out.println("Có lỗi");
				response.sendRedirect(request.getContextPath() + "/404");
				return;
			}
			
			// lấy ra danh sách comment cha load tất cả
			ArrayList<Comment> listCmt = commentDAO.getParentLoadAllItems(nId, DefineUtil.NUMBER_COMMENT_SHOW_PER_NEWS);
			
			request.setAttribute("nId", nId);
			request.setAttribute("listCmt", listCmt);
	 		
			RequestDispatcher rd = request.getRequestDispatcher("/templates/public/ajaxResult/ajaxLoadAllCmtResult.jsp");
			rd.forward(request, response);
			return;
		}
		
		if ("loadAllRepCmt".equals(type)) {
			// xử lý ajax: load tất cả comment trả lời của cmt cha
			int nId = 0;
			try {
				nId = Integer.valueOf(request.getParameter("nId"));
			} catch (NumberFormatException e) {
				System.out.println("Có lỗi");
				response.sendRedirect(request.getContextPath() + "/404");
				return;
			}
			int parentId = Integer.valueOf(request.getParameter("parentId"));
			
			// lấy ra danh sách comment con load tất cả
			ArrayList<Comment> listCmt = commentDAO.getChildLoadAllItems(parentId, DefineUtil.NUMBER_CHILD_COMMENT_SHOW);
			
			request.setAttribute("nId", nId);
			request.setAttribute("parentId", parentId);
			request.setAttribute("listCmt", listCmt);
	 		
			RequestDispatcher rd = request.getRequestDispatcher("/templates/public/ajaxResult/ajaxLoadAllRepCmtResult.jsp");
			rd.forward(request, response);
			return;
		}
		
	}

}
