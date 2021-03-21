package megaboxClass;

public class TimeMovieDTO {
	String time_title;
	String time_start;
	String time_finish;
	String time_location;
	String time_sinema;
	String time_theater;
	String time_date;
	String time_allSeat;
	int time_remainSeat;
	public int getTime_remainSeat() {
		return time_remainSeat;
	}
	public void setTime_remainSeat(int time_remainSeat) {
		this.time_remainSeat = time_remainSeat;
	}
	String time_category;
	
	public String getTime_title() {
		return time_title;
	}
	public void setTime_title(String time_title) {
		this.time_title = time_title;
	}
	public String getTime_start() {
		return time_start;
	}
	public void setTime_start(String time_start) {
		this.time_start = time_start;
	}
	public String getTime_finish() {
		return time_finish;
	}
	public void setTime_finish(String time_finish) {
		this.time_finish = time_finish;
	}
	public String getTime_location() {
		return time_location;
	}
	public void setTime_location(String time_location) {
		this.time_location = time_location;
	}
	public String getTime_sinema() {
		return time_sinema;
	}
	public void setTime_sinema(String time_sinema) {
		this.time_sinema = time_sinema;
	}
	public String getTime_theater() {
		return time_theater;
	}
	public void setTime_theater(String time_theater) {
		this.time_theater = time_theater;
	}
	public String getTime_date() {
		return time_date;
	}
	public void setTime_date(String time_date) {
		this.time_date = time_date;
	}
	
	
	public String getTime_allSeat() {
		return time_allSeat;
	}
	public void setTime_allSeat(String time_allSeat) {
		this.time_allSeat = time_allSeat;
	}
	
	public String getTime_category() {
		return time_category;
	}
	public void setTime_category(String time_category) {
		this.time_category = time_category;
	}
	@Override
	public String toString() {
		return "timeTable [time_title=" + time_title + ", time_start=" + time_start + ", time_finish=" + time_finish
				+ ", time_location=" + time_location + ", time_sinema=" + time_sinema + ", time_theater=" + time_theater
				+ ", time_date=" + time_date + ", time_allSeat=" + time_allSeat + ", time_category=" + time_category
				+ "]";
	}
}
