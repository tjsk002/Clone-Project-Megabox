package megaboxClass;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class review
 */

public class ReviewDAO extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ReviewDAO() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
	}
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;charset=UTF-8");
		String review_id=request.getParameter("review_id");
		String review_text=request.getParameter("review_text");
		double review_score=Double.parseDouble(request.getParameter("review_score"));
		String review_title=request.getParameter("review_title");
		System.out.println(review_text+" "+review_title+" "+review_id+" "+review_score);
		
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			String url="jdbc:mariadb://127.0.0.1:3306/project";
			String user = "root";
			String pw = "1234";
			Class.forName("org.mariadb.jdbc.Driver");
			conn = DriverManager.getConnection(url, user, pw);
			
			//작성한 데이터 insert
			String sql = "INSERT INTO movie_review(review_id,review_text,review_score,review_title) VALUES(?,?,?,?);";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1,review_id); pstmt.setString(2, review_text); pstmt.setDouble(3, review_score); pstmt.setString(4,review_title);
			System.out.println(review_id+" "+review_text+" "+review_score+" "+review_title);
			rs = pstmt.executeQuery();
	
			//mega_movie의 movie_score 업데이트 
			//평점남긴 사람 수
			int audience=0;
			sql="SELECT review_id FROM movie_review WHERE review_title =?";
			pstmt=conn.prepareStatement(sql); pstmt.setString(1, review_title);
			rs=pstmt.executeQuery();
			while(rs.next()) {audience+=1;}
			System.out.println(review_title);
			System.out.println("리뷰남긴 수 "+audience);
			//영화 점수 
			double score=0;
			sql="SELECT movie_score FROM mega_movie WHERE movie_title=(?)";
			pstmt=conn.prepareStatement(sql); pstmt.setString(1, review_title);
		
			rs=pstmt.executeQuery();
			if(rs.next()) {score=rs.getDouble("movie_score")*(audience-1);}
			System.out.println("영화 관람 평점"+score);
			score+=review_score;
			score=Math.round(((score/audience)*10)/10.0);// 관람평 점수 소수 첫째자리까지 표현 	
			System.out.println("등록될 점수"+score);
			
			sql="UPDATE mega_movie SET movie_score=? WHERE movie_title=?";
			pstmt=conn.prepareStatement(sql);
			pstmt.setDouble(1, score); pstmt.setString(2, review_title);
			pstmt.executeUpdate();
			
			System.out.println("수정된 영화 관람 평점"+score);

			rs.close();
			pstmt.close();
			conn.close();
			
		}catch(Exception e) {
			e.printStackTrace();
		}

	
	}

}
