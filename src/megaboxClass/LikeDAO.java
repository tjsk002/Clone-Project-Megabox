package megaboxClass;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class LikeDAO {
	public boolean selectMovieLike(String like_title, String like_member) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		boolean result = false;
		
		try {
			String url="jdbc:mariadb://127.0.0.1:3306/project";
			String user = "root";
			String pw = "1234";
			Class.forName("org.mariadb.jdbc.Driver");
			conn = DriverManager.getConnection(url, user, pw);

			String sql = "SELECT like_boolean from movie_like where like_title = ? and like_member = ?;";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, like_title);
			pstmt.setString(2, like_member);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				result = rs.getBoolean("like_boolean");
			}
			rs.close();
			pstmt.close();
			conn.close();
		}catch(Exception e) {
			e.printStackTrace();
		}
		
		return result;
	}
}
