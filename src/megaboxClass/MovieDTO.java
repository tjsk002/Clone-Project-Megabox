package megaboxClass;

/*
 * movie_idx INT AUTO_INCREMENT PRIMARY KEY NOT null,
   movie_title VARCHAR(50) UNIQUE NOT NULL,
   movie_score DOUBLE,
   movie_reser DOUBLE,
   movie_release DATE NOT NULL,
   movie_info TEXT NOT NULL,
   movie_age VARCHAR(10) NOT NULL,
   FILE MEDIUMBLOB NOT NULL, 
   movie_num INT DEFAULT 0
 * 
 * */




public class MovieDTO {
	private String movieTitle;//제목 
	private String movieScore;//평점(메가스코어) 
	private String movieReser;//예매율 
	private String movieRelease;//개봉일 
	private String movieSummary;//줄거리, 감독, 출연진
	private String movieDirector;//r
	private String movieActors;
	private String movieType;//영화타입 
	private String movieGenre;//영화 장르 
	private String movieAge;//관람연령 
	private String movieNum;//누적관객수 
	private String movieImg;//영화이미지 포스터는 [0]번째에 저
	private String movieVideo;//영화 예고편 
	private String movieRank;//영화 순위 
	private String movieLike;
	
	
	public String getMovieLike() {
		return movieLike;
	}
	public void setMovieLike(String movieLike) {
		this.movieLike = movieLike;
	}
	@Override
	public String toString() {
		return "MovieDTO [movieTitle=" + movieTitle + ", movieScore=" + movieScore + ", movieReser=" + movieReser
				+ ", movieRelease=" + movieRelease + ", movieSummary=" + movieSummary + ", movieDirector="
				+ movieDirector + ", movieActors=" + movieActors + ", movieType=" + movieType + ", movieGenre="
				+ movieGenre + ", movieAge=" + movieAge + ", movieNum=" + movieNum + ", movieImg=" + movieImg
				+ ", movieVideo=" + movieVideo + ", movieRank=" + movieRank + "]";
	}
	public String getMovieGenre() {
		return movieGenre;
	}
	public void setMovieGenre(String movieGenre) {
		this.movieGenre = movieGenre;
	}
	public String getMovieType() {
		return movieType;
	}
	public void setMovieType(String movieType) {
		this.movieType = movieType;
	}
	
	public String getMovieSummary() {
		return movieSummary;
	}
	public void setMovieSummary(String movieSummary) {
		this.movieSummary = movieSummary;
	}
	public String getMovieDirector() {
		return movieDirector;
	}
	public void setMovieDirector(String movieDirector) {
		this.movieDirector = movieDirector;
	}
	public String getMovieActors() {
		return movieActors;
	}
	public void setMovieActors(String movieActors) {
		this.movieActors = movieActors;
	}
	
	public String getMovieRank() {
		return movieRank;
	}
	public void setMovieRank(String movieRank) {
		this.movieRank = movieRank;
	}
	public String getMovieTitle() {
		return movieTitle;
	}
	public void setMovieTitle(String movieTitle) {
		this.movieTitle = movieTitle;
	}
	public String getMovieScore() {
		return movieScore;
	}
	public void setMovieScore(String movieScore) {
		this.movieScore = movieScore;
	}
	public String getMovieReser() {
		return movieReser;
	}
	public void setMovieReser(String movieReser) {
		this.movieReser = movieReser;
	}
	public String getMovieRelease() {
		return movieRelease;
	}
	public void setMovieRelease(String movieRelease) {
		this.movieRelease = movieRelease;
	}
	
	public String getMovieAge() {
		return movieAge;
	}
	public void setMovieAge(String movieAge) {
		this.movieAge = movieAge;
	}
	public String getMovieNum() {
		return movieNum;
	}
	public void setMovieNum(String movieNum) {
		this.movieNum = movieNum;
	}
	public String getMovieImg() {
		return movieImg;
	}
	public void setMovieImg(String movieImg) {
		this.movieImg = movieImg;
	}
	public String getMovieVideo() {
		return movieVideo;
	}
	public void setMovieVideo(String movieVideo) {
		this.movieVideo = movieVideo;
	}
	
}