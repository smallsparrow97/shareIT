package util;

import java.math.BigInteger;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.sql.Timestamp;
import java.text.Normalizer;
import java.text.SimpleDateFormat;
import java.util.regex.Pattern;

public class StringUtil {
	
	public static String md5(String str) {
		MessageDigest md;
		String result = "";
		try {
			md = MessageDigest.getInstance("MD5");
			md.update(str.getBytes());
			BigInteger bi = new BigInteger(1, md.digest());

			result = bi.toString(16);
		} catch (NoSuchAlgorithmException e) {
			e.printStackTrace();
		}
		return result;
	}

	public static String makeSlug(String title) {
		String slug = Normalizer.normalize(title, Normalizer.Form.NFD);
		Pattern pattern = Pattern.compile("\\p{InCombiningDiacriticalMarks}+");
		slug = pattern.matcher(slug).replaceAll("");
		slug = slug.toLowerCase();
		// Thay đ thành d
		slug = slug.replaceAll("đ", "d");
		// Xóa các ký tự đặt biệt
		slug = slug.replaceAll("([^0-9a-z-\\s])", "");
		// Thay space thành dấu gạch ngang
		slug = slug.replaceAll("[\\s]", "_");
		// Đổi nhiều ký tự gạch ngang liên tiếp thành 1 ký tự gạch ngang
		slug = slug.replaceAll("(_+)", "_");
		// Xóa các ký tự gạch ngang ở đầu và cuối
		slug = slug.replaceAll("^-+", "");
		slug = slug.replaceAll("-+$", "");
		return slug;
	}
	
	// chuẩn hóa xâu
	public static String standardizedString(String str) {
        str = str.trim();
        str = str.replaceAll("\\s+", " ");
        return str;
    }
	
	public static String dateFormat(Timestamp timestamp) {
		String formattedDate = new SimpleDateFormat("dd/MM/yyyy").format(timestamp);
		return formattedDate;	
	}
	
	public static String timeCmtFormat(Timestamp timestamp) {
		String formattedDate = new SimpleDateFormat("dd/MM/yyyy - hh:mm a").format(timestamp);
		return formattedDate;	
	}
	/*public static void main(String[] args) {
		System.out.println(StringUtil.md5("123123"));
	}*/

}
