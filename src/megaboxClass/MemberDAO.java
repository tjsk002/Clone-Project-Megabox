package megaboxClass;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class MemberDAO {
	// 회원가입
	public Boolean insertMember(MemberDTO memberDTO) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		boolean state = false;
		try {
			String url="jdbc:mariadb://127.0.0.1:3306/project";
			String user = "root";
			String pw = "1234";
			Class.forName("org.mariadb.jdbc.Driver");
			conn = DriverManager.getConnection(url, user, pw);
			conn.setAutoCommit(false);
			boolean admin = false;
			String sql = "INSERT INTO mega_member(mem_id, mem_pw, mem_birth, mem_hp, mem_email, mem_name, mem_admin) values(?,?,?,?,?,?,?)";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, memberDTO.getUserid());
			pstmt.setString(2, memberDTO.getUserpw());
			pstmt.setString(3, memberDTO.getSsn1());
			pstmt.setString(4, memberDTO.getHp());
			pstmt.setString(5, memberDTO.getEmail());
			pstmt.setString(6, memberDTO.getUsername());
			pstmt.setBoolean(7, admin);
			int rows = pstmt.executeUpdate();
			state = (rows >= 1);
			conn.commit();
			
			pstmt.close();
			conn.close();
		} catch (Exception e) {
			e.printStackTrace();
			if (conn != null) {
				try {
					conn.rollback();
				} catch (Exception sqle) {
					sqle.printStackTrace();
				}
			}
		}

		return state;
	}

	// 로그인
	public Boolean selectMember(MemberDTO memberDTO) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		boolean state = false;
		String userId = memberDTO.getUserid();
		String userPw = memberDTO.getUserpw();
		try {

			String url="jdbc:mariadb://127.0.0.1:3306/project";
			String user = "root";
			String pw = "1234";
			Class.forName("org.mariadb.jdbc.Driver");
			conn = DriverManager.getConnection(url, user, pw);
			String sql = "select mem_id from mega_member where mem_id=? and mem_pw=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, userId);
			pstmt.setString(2, userPw);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				state = true;
			}
			
			rs.close();
			pstmt.close();
			conn.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return state;
	}
}
