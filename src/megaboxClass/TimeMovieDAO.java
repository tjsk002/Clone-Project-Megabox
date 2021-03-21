package megaboxClass;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

public class TimeMovieDAO {
	public ArrayList<TimeMovieDTO> selectTimeMovie() {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		ArrayList<TimeMovieDTO> result = new ArrayList();
		try {
			String url="jdbc:mariadb://127.0.0.1:3306/project";
			String user = "root";
			String pw = "1234";
			Class.forName("org.mariadb.jdbc.Driver");
			conn = DriverManager.getConnection(url, user, pw);
			String sql = "SELECT * FROM movie_time order by time_start";
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				TimeMovieDTO add = new TimeMovieDTO();
				add.setTime_allSeat(rs.getString("time_allSeat"));
				add.setTime_category(rs.getString("time_category"));
				add.setTime_date(rs.getString("time_date"));
				add.setTime_finish(rs.getString("time_finish"));
				add.setTime_location(rs.getString("time_location"));
				add.setTime_sinema(rs.getString("time_sinema"));
				add.setTime_start(rs.getString("time_start"));
				add.setTime_theater(rs.getString("time_theater"));
				add.setTime_title(rs.getString("time_title"));
				add.setTime_remainSeat(rs.getInt("time_remainSeat"));
				result.add(add);
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
