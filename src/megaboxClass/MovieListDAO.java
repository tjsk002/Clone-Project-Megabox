package megaboxClass;

import java.io.IOException;
import java.io.PrintWriter;
import java.net.URLEncoder;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class MovieListDAO
 */
@WebServlet("/MovieListDAO")
public class MovieListDAO extends HttpServlet {
	private static final long serialVersionUID = 1L;
    
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}
	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */

	//@RequestMapping(produces="application/text; charset=utf8")
	//@GetMapping(produces="application/text; charset=utf8");
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
		request.setCharacterEncoding("UTF-8");
		
		String title0 = request.getParameter("title0");
		String title1 = request.getParameter("title1");
		String title2 = request.getParameter("title2");
		String location0 = request.getParameter("location0");
		String location1 = request.getParameter("location1");
		String location2 = request.getParameter("location2");
		String time = request.getParameter("time");
		String date = request.getParameter("date");
		String result = "";
		String where = "";
		
		if(time=="") {
			Calendar cal = Calendar.getInstance();
			SimpleDateFormat sdf1 = new SimpleDateFormat("HH");
			time = sdf1.format(cal.getTime());
		}
		//System.out.println(time);
		//System.out.println(title0 +" .. " + title1 +" .. " + title2 +" .. " + location0 +" .. " + location1 +" .. " + location2 +" .. " + time +" .. " + date);
		if(title0 == null) {
			where = "where (time_sinema='"+location0+"' or "+"time_sinema='"+location1+"' or "+"time_sinema='"+location2+"')"+" and "+"time_date='"+date+"'"+" order by time_start";
		}else {
			where = "where (time_title='"+title0+"' or "+"time_title='"+title1+"' or "+"time_title='"+title2+"')"+" and "+"(time_sinema='"+location0+"' or "+"time_sinema='"+location1+"' or "+"time_sinema='"+location2+"')"+" and "+"time_date='"+date+"'"+" order by time_start";
		}
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		
		try {

			String url = "jdbc:mariadb://127.0.0.1:3306/project";
			String user = "root";
			 //String pw="jina0925";
			String pw = "1234";
			Class.forName("org.mariadb.jdbc.Driver");
			conn = DriverManager.getConnection(url, user, pw);

			String sql = "SELECT * FROM movie_time "+where;
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				String add = "";
				String time_idx = rs.getString("time_idx");
				String time_start = rs.getString("time_start");
				String time_allSeat = rs.getString("time_allSeat");
				String time_category = rs.getString("time_category");
				//String time_date = rs.getString("time_date");
				String time_finish = rs.getString("time_finish");
				//String time_location = rs.getString("time_location");
				String time_sinema = rs.getString("time_sinema");
				String time_theater = rs.getString("time_theater");
				String time_title = rs.getString("time_title");
				String time_remainSeat = Integer.toString(rs.getInt("time_remainSeat"));
				if(Integer.parseInt(time)>Integer.parseInt(time_start.split(":")[0])) {
					continue;
				}
				add="<li style='height: 66px; border-top: 1px solid #ebebeb;'>" + "<button class='btn-time'>" + "<div style='display:none;'>"+ time_idx +"</div>" + "<div class='legend-time'></div>" + "<span class='time'>" + "<strong>"+time_start+"</strong>" + "<i>~"+time_finish+"</i>" + "</span>" + "<span class='title'>" + "<strong>"+time_title+"</strong>" + "<i>"+time_category+"</i>" + "</span>" + "<div class='info'>" + "<span class='theater'>"+time_sinema+"<br>"+time_theater+"</span>" + "<span class='seat'>" + "<strong class='now'>"+time_remainSeat+"</strong>" + "<span>/</span>" + "<i class='all'>"+time_allSeat+"</i>" + "</span>" + "</div>" + "</button>" + "</li>";
				
				result = result + add;
			}
			rs.close();
			pstmt.close();
			conn.close();
			
			/*
			 * for(String a : result) { System.out.println(a); } 후 성공
			 */
			//System.out.println(result);
			//response.getWriter().print(result);
			response.setCharacterEncoding("UTF-8");
			//response.setContentType("text/html; charset=UTF-8");
			//String temp = URLEncoder.encode("한글 ", "UTF-8");
			result = URLEncoder.encode(result, "UTF-8");
			PrintWriter printwriter = response.getWriter();
			printwriter.print(result);
		} catch (Exception e) {
			e.printStackTrace();
		}

	}

}