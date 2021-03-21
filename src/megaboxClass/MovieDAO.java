package megaboxClass;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;


public class MovieDAO {


	//수정필요 
	//i는 영화 랭크..? 
	
	public void insertMovie(List<MovieDTO> movieList, int i) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		int rows = 0;

		
			try {
				String url="jdbc:mariadb://127.0.0.1:3306/project";
				String user = "root";
				String pw = "1234";
				Class.forName("org.mariadb.jdbc.Driver");
				conn = DriverManager.getConnection(url, user, pw);
				String sql = "insert into mega_movie(movie_title,movie_release,movie_summary,\n"
						+ "movie_age,movie_num,movie_type,movie_genre,movie_director,movie_actors,movie_img,movie_video,movie_rank) "
						+ "values(?,?,?,?,?,?,?,?,?,?,?,?)";
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, movieList.get(i).getMovieTitle());
				pstmt.setString(2, movieList.get(i).getMovieRelease());
				pstmt.setString(3, movieList.get(i).getMovieSummary());
				pstmt.setString(4, movieList.get(i).getMovieAge());
				pstmt.setString(5, movieList.get(i).getMovieNum());
				pstmt.setString(6, movieList.get(i).getMovieType());
				pstmt.setString(7, movieList.get(i).getMovieGenre());
				pstmt.setString(8, movieList.get(i).getMovieDirector());
				pstmt.setString(9, movieList.get(i).getMovieActors());
				pstmt.setString(10, movieList.get(i).getMovieImg());
				pstmt.setString(11, movieList.get(i).getMovieVideo());
				pstmt.setString(12, movieList.get(i).getMovieRank());
				rows = pstmt.executeUpdate();
				if (rows != 0)
					System.out.println("디비에 저장됐음");
				
				pstmt.close();
				conn.close();
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				//DBconn.close(conn, pstmt);
			}
		

	}

	public ArrayList<MovieDTO> selectMovid1() {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		ArrayList<MovieDTO> result = new ArrayList<>();
		try {
			String url="jdbc:mariadb://127.0.0.1:3306/project";
			String user = "root";
			String pw = "1234";
			Class.forName("org.mariadb.jdbc.Driver");
			conn = DriverManager.getConnection(url, user, pw);
			
			String sql = "SELECT * FROM mega_movie";
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();

			while(rs.next()) {
				MovieDTO movie= new MovieDTO();
				movie.setMovieTitle(rs.getString("movie_title"));
				movie.setMovieRelease(rs.getString("movie_release"));
				movie.setMovieSummary(rs.getString("movie_summary"));
				movie.setMovieAge(rs.getString("movie_age"));
				movie.setMovieNum(rs.getString("movie_num"));
				movie.setMovieType(rs.getString("movie_type"));
				movie.setMovieGenre(rs.getString("movie_genre"));
				movie.setMovieDirector(rs.getString("movie_director"));
				movie.setMovieActors(rs.getString("movie_actors"));
				movie.setMovieImg(rs.getString("movie_img"));
				movie.setMovieVideo(rs.getString("movie_video"));
				movie.setMovieRank(rs.getString("movie_rank"));
				movie.setMovieScore(rs.getString("movie_score"));
				movie.setMovieReser(rs.getString("movie_reser"));
				movie.setMovieLike(rs.getString("movie_like"));
				result.add(movie);
			}
			
			rs.close();
			pstmt.close();
			conn.close();
		}catch(Exception e) {
			e.printStackTrace();
		}
		return result;
	}
	
	public MovieDTO selectMovid(String title) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		MovieDTO movie= new MovieDTO();
		try {
			String url="jdbc:mariadb://127.0.0.1:3306/project";
			String user = "root";
//			String pw="jina0925";
			String pw = "1234";
			Class.forName("org.mariadb.jdbc.Driver");
			conn = DriverManager.getConnection(url, user, pw);
			
			String sql = "SELECT * FROM mega_movie WHERE movie_title=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1,title);
			rs = pstmt.executeQuery();

			if(rs.next()) {
				movie.setMovieTitle("movie_title");
				movie.setMovieRelease("movie_release");
				movie.setMovieSummary("movie_summary");
				movie.setMovieAge("movie_age");
				movie.setMovieNum("movie_num");
				movie.setMovieType("movie_type");
				movie.setMovieGenre("movie_genre");
				movie.setMovieDirector("movie_director");
				movie.setMovieActors("movie_actors");
				movie.setMovieImg("movie_img");
				movie.setMovieVideo("movie_video");
				movie.setMovieRank("movie_rank");
				movie.setMovieScore("movie_score");
				movie.setMovieReser("movie_reser");	
			}
			rs.close();
			pstmt.close();
			conn.close();
		}catch(Exception e) {
			e.printStackTrace();
		}
		return movie;
	}
}
