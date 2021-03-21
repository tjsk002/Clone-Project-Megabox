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
 * Servlet implementation class SeatDAO
 */

@WebServlet("/SeatDAO")
public class SeatDAO extends HttpServlet {
	private static final long serialVersionUID = 1L;
    
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
		response.setContentType("text/html; charset=UTF-8");
		String ticket_movieTime = request.getParameter("ticket_movieTime");
		String userid = request.getParameter("userid");
		String seat[] = {request.getParameter("seat1"), request.getParameter("seat2"), request.getParameter("seat3"), request.getParameter("seat4"), request.getParameter("seat5"), request.getParameter("seat6"), request.getParameter("seat7"), request.getParameter("seat8")};
		System.out.println(ticket_movieTime + seat);
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			String url="jdbc:mariadb://127.0.0.1:3306/project";
			String user = "root";
			String pw = "1234";
			Class.forName("org.mariadb.jdbc.Driver");
			conn = DriverManager.getConnection(url, user, pw);
			String sql = "";
			for(int i=0; i<8; i++) {
			if(seat[i].equals("-")){continue;}
			sql = "INSERT INTO mega_ticket(ticket_movieTime, ticket_id, ticket_seat) VALUES('"+ticket_movieTime+"', '"+userid+"', '"+ seat[i] +"');";
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				System.out.println("성공");
			}
			}
			rs.close();
			pstmt.close();
			conn.close();
			
		}catch(Exception e) {
			e.printStackTrace();
		}
		
	}

}
