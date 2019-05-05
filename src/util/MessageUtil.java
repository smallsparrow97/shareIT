package util;

import javax.servlet.http.HttpServletRequest;

public class MessageUtil {
	public static String getMessage(HttpServletRequest request) {
		String msgText = "";
		if(request.getParameter("msg") != null){
			int msg = Integer.valueOf(request.getParameter("msg"));
			switch(msg) {
				case 1: msgText = "Thêm thành công";
				break;
				case 2: msgText = "Sửa thành công";
				break;
				case 3: msgText = "Xóa thành công";
				break;
				case 0: msgText = "Có lỗi xảy ra";
				break;
			}
		}
		return msgText;
	}
}
