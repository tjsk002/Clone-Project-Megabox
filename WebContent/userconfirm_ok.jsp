<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%
	String userId = (String)session.getAttribute("loginid");
	String userPw = request.getParameter("pwd");
	
	Connection conn = null;
	String sql = "";
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	String url = "jdbc:mariadb://localhost:3306/project";
	String uid = "root";
	String upw = "1234";
	
	try{
		Class.forName("org.mariadb.jdbc.Driver");
		conn = DriverManager.getConnection(url, uid, upw);
		if(conn != null){
			sql = "SELECT mem_idx FROM mega_member WHERE mem_id=? AND mem_pw=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, userId);
			pstmt.setString(2, userPw);
			rs = pstmt.executeQuery();
			
			if(rs.next()){
			%>
				<script>
					location.href = "userinfo.jsp";
				</script>
			<%
			}else{
			%>
				<script>
					alert("비밀번호가 다릅니다.");
					history.back();
				</script>
			<%}
		}
	}catch(Exception e){
		e.printStackTrace();
	}
%>