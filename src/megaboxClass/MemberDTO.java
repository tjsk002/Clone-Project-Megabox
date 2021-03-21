package megaboxClass;

public class MemberDTO {
	private String username;
	private String ssn1;
	private String hp;
	private String userid;
	private String userpw;
	private String userpw_re;
	private String email;
	
	public String getUsername() {
		return username;
	}
	public void setUsername(String username) {
		this.username = username;
	}
	public String getSsn1() {
		return ssn1;
	}
	public void setSsn1(String ssn1) {
		this.ssn1 = ssn1;
	}
	public String getHp() {
		return hp;
	}
	public void setHp(String hp) {
		this.hp = hp;
	}
	public String getUserid() {
		return userid;
	}
	public void setUserid(String userid) {
		this.userid = userid;
	}
	public String getUserpw() {
		return userpw;
	}
	public void setUserpw(String userpw) {
		this.userpw = userpw;
	}
	public String getUserpw_re() {
		return userpw_re;
	}
	public void setUserpw_re(String userpw_re) {
		this.userpw_re = userpw_re;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	@Override
	public String toString() {
		return "MemberDTO [username="+username+", ssn1="+ssn1+", hp="+hp+", userid="+userid+", userpw="+userpw+", userpw_re="+userpw_re+", email="+email+"]";
	}
	
}
