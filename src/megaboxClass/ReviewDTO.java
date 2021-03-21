package megaboxClass;

public class ReviewDTO {
	private String review_title;
	public String getReview_title() {
		return review_title;
	}
	public void setReview_title(String review_title) {
		this.review_title = review_title;
	}

	private int review_score;
	private String review_text;
	private String review_id; //작성자 아이디 
	public int getReview_score() {
		return review_score;
	}
	public void setReview_score(int review_score) {
		this.review_score = review_score;
	}
	public String getReview_text() {
		return review_text;
	}
	public void setReview_text(String review_text) {
		this.review_text = review_text;
	}
	public String getReview_id() {
		return review_id;
	}
	public void setReview_id(String review_id) {
		this.review_id = review_id;
	}
	
	@Override
	public String toString() {
		return "ReviewDTO [review_score=" + review_score + ", review_text=" + review_text + ", review_id=" + review_id
				+"review_title="+ review_title+"]";
	}
}
