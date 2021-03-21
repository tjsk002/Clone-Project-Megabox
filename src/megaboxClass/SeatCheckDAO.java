package megaboxClass;

import java.io.IOException;
import java.io.PrintWriter;
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
 * Servlet implementation class SeatCheckDAO
 */
@WebServlet("/SeatCheckDAO")
public class SeatCheckDAO extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
  

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

		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String ticket_movieTime = request.getParameter("ticket_movieTime");
		String result = "";
		
		try {
			String url="jdbc:mariadb://127.0.0.1:3306/project";
			String user = "root";
			String pw = "1234";
			Class.forName("org.mariadb.jdbc.Driver");
			conn = DriverManager.getConnection(url, user, pw);
			
			
			String sql="SELECT ticket_seat FROM mega_ticket where ticket_movieTime="+ticket_movieTime+";";
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				String seat = rs.getString("ticket_seat");
				result = result + seat + " ";
			}
			
			rs.close();
			pstmt.close();
			conn.close();
			
			//System.out.println(result);
			PrintWriter printwriter = response.getWriter();
			printwriter.print(result);
		}catch(Exception e) {
			e.printStackTrace();
		}

	}

}
