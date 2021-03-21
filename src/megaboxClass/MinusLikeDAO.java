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
 * Servlet implementation class MinusLikeDAO
 */
@WebServlet("/MinusLikeDAO")
public class MinusLikeDAO extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
   

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
		response.setContentType("text/html; charset=UTF-8");
		String title = request.getParameter("title");
		String userid = request.getParameter("userid");
		
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		int num=0;
		
		try {
			String url="jdbc:mariadb://127.0.0.1:3306/project";
			String user = "root";
//			String pw="jina0925";
			String pw = "1234";
			Class.forName("org.mariadb.jdbc.Driver");
			conn = DriverManager.getConnection(url, user, pw);
			
			String sql = "DELETE FROM movie_like WHERE like_title='"+title+"' AND like_member='"+userid+"';";
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			sql="UPDATE mega_movie SET movie_like = movie_like-1 WHERE movie_title = '"+title+"';";
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			sql="SELECT movie_like FROM mega_movie WHERE movie_title = '"+title+"';";
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				num = rs.getInt("movie_like");
			}
			
			rs.close();
			pstmt.close();
			conn.close();
			
			String result = Integer.toString(num);
			response.getWriter().print(result);
			
		}catch(Exception e) {
			e.printStackTrace();
		}
	}

}
