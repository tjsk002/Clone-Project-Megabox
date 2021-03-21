package GetMovieLists;

import java.awt.image.BufferedImage;
import java.io.BufferedInputStream;
import java.io.File;
import java.io.FileOutputStream;
import java.net.URL;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.util.List;

import javax.imageio.ImageIO;

import org.openqa.selenium.By;
import org.openqa.selenium.NoSuchElementException;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.chrome.ChromeDriver;

import megaboxClass.MovieDTO;

public class GetMovieDetail {

	MovieDTO movielist = new MovieDTO();
	ChromeDriverInfo info = new ChromeDriverInfo();

	private int Max = 10;
	private String DRIVER_ID = info.DRIVER_ID; // chromedriver 용
	private String DRIVER_PATH= info.DRIVER_PATH;
	private String RELATIVE_PATH = info.RELATIVE_PATH; // 디비에 저장될 상대 경로
	private String ABSOLUTE_PATH = info.ABSOLITE_PATH;// 절대 경로로 저장
	private String url = "";// 정보 가져올 영화 링크
	private int i = 0;
	//private List<MovieDTO> movieList;

	public GetMovieDetail(String url, int i) {
		this.url = url;
		this.i = i;
	}

	@SuppressWarnings("unlikely-arg-type")
	public void Crawling() {
		System.setProperty(DRIVER_ID, DRIVER_PATH);
		WebDriver driver = new ChromeDriver();

		// 파일 저장경로 생성
		File Folder = new File(ABSOLUTE_PATH);
		if (!Folder.exists()) {
			try {
				Folder.mkdir();
			} catch (Exception e) {
				e.getStackTrace();
			}
		}

		try {

			/* 널값으로 생성해서 오류방지 */
			movielist.setMovieActors("null");
			movielist.setMovieAge("null");
			movielist.setMovieDirector("null");
			movielist.setMovieTitle("null");
			movielist.setMovieRank("null");
			movielist.setMovieNum("null");
			movielist.setMovieSummary("null");
			movielist.setMovieType("null");
			movielist.setMovieActors("null");
			movielist.setMovieGenre("null");
			movielist.setMovieAge("null");
			movielist.setMovieRelease("null");
			movielist.setMovieImg("null");
			movielist.setMovieVideo("null");

			driver.get(url);

			// 제목
			try {
			WebElement title = driver.findElement(By.cssSelector("div.movie-detail-cont>p.title"));
			movielist.setMovieTitle(title.getText());
			System.out.println(title.getText());
			}catch (NoSuchElementException e) {
				System.out.println("제목없음");
				movielist.setMovieTitle("null");
			}
			// 순위
			try {
			WebElement rate = driver.findElement(By.cssSelector("div.rate>p.cont>em"));// 순위
			System.out.println(rate.getText());
			movielist.setMovieRank(rate.getText());
			}catch (NoSuchElementException e) {
				System.out.println("순위 없음");
				movielist.setMovieRank("null");
			}
			// 누적관객
			try {
			List<WebElement> audience = driver.findElements(By.cssSelector("div.audience>p>em"));// 누적관객수
			for (WebElement e : audience) {
				System.out.println(e.getText());
				movielist.setMovieNum(e.getText().replaceAll(",", ""));
			}}catch (NoSuchElementException e) {
				System.out.println("누적관객 없음");
				movielist.setMovieNum("null");
			}

			Thread.sleep(2000);
			// 줄거리
			try {
			WebElement summary = driver.findElement(By.cssSelector("#info>div.txt"));// 줄거리
			System.out.println(summary.getText());
			movielist.setMovieSummary(summary.getText());}
			catch (NoSuchElementException e) {
				System.out.println("줄거리 없음");
				movielist.setMovieSummary("null");
			}
			
			// 영화타입
			try {
			WebElement movietype = driver.findElement(By.cssSelector("div.movie-info.infoContent>p:nth-child(1)"));// 영화타입
			System.out.println(movietype.getText());
			movielist.setMovieType(movietype.getText().substring(7));}
			catch (NoSuchElementException e) {
				System.out.println("영화타입 없음");
				movielist.setMovieType("null");
			}
			
			// 배우 
			try {
				WebElement actor = driver.findElement(By.cssSelector("div.movie-info.infoContent>p:nth-child(3)"));// 배우
				System.out.println(actor.getSize());
				System.out.println(actor.getText());
				movielist.setMovieActors(actor.getText().substring(5));
			} catch (NoSuchElementException e) {
				System.out.println("배우없음");
				movielist.setMovieActors("null");
			}
			
			// 감독이 있는 경우
			try {
				//개봉일 
				WebElement released = driver.findElement(By.cssSelector("div.line>p:nth-child(4)"));// 개봉일
				System.out.println(released.getText());
				movielist.setMovieRelease(released.getText().substring(6));
				//감독 
				WebElement director = driver.findElement(By.cssSelector("div.line>p:nth-child(1)"));
				System.out.println(director.getText());
				movielist.setMovieDirector(director.getText().substring(5));
				//장르
				WebElement genre = driver.findElement(By.cssSelector("div.line>p:nth-child(2)"));// 장르
				System.out.println(genre.getText());
				movielist.setMovieGenre(genre.getText().substring(5));
				//등급
				WebElement rated = driver.findElement(By.cssSelector("div.line>p:nth-child(3)"));// 등급
				System.out.println(rated.getText());
				// 청불일때 저장
				if (rated.getText().substring(5, 7).equals("청소"))
					movielist.setMovieAge("청불");
				movielist.setMovieAge(rated.getText().substring(5, 7));
				
			}
			catch (NoSuchElementException e) {
				System.out.println("감독없음");
				movielist.setMovieActors("null");
				
				
				try {
					//장르 
					WebElement genre = driver.findElement(By.cssSelector("div.line>p:nth-child(1)"));// 장르
					System.out.println(genre.getText());
					movielist.setMovieGenre(genre.getText().substring(5));
					//등급
					WebElement rated = driver.findElement(By.cssSelector("div.line>p:nth-child(2)"));// 등급
					System.out.println(rated.getText());
					// 청불일때 저장
					if (rated.getText().substring(5, 7).equals("청소"))
						movielist.setMovieAge("청불");
					movielist.setMovieAge(rated.getText().substring(5, 7));
					//개봉일 
					WebElement released = driver.findElement(By.cssSelector("div.line>p:nth-child(3)"));// 개봉일
					System.out.println(released.getText());
					movielist.setMovieRelease(released.getText().substring(6));
				}catch(NoSuchElementException err) {
					//장르없음
					movielist.setMovieGenre("null");
					System.out.println("장르없음 ");
					
					//등급
					WebElement rated = driver.findElement(By.cssSelector("div.line>p:nth-child(1)"));// 등급
					System.out.println(rated.getText());
					// 청불일때 저장
					if (rated.getText().substring(5, 7).equals("청소"))
						movielist.setMovieAge("청불");
					movielist.setMovieAge(rated.getText().substring(5, 7));
					//개봉일 
					WebElement released = driver.findElement(By.cssSelector("div.line>p:nth-child(2)"));// 개봉일
					System.out.println(released.getText());
					movielist.setMovieRelease(released.getText().substring(6));
				}
		
			}
			
			// 썸네일//
			Thread.sleep(5000);
			try {
				WebElement preview = driver.findElement(By.cssSelector("div.tab-list.fixed>ul>li:nth-child(4)"));
	
				preview.click();// 예고편 버튼 클릭
				Thread.sleep(2000);
				List<WebElement> thumnails = driver.findElements(By.cssSelector("div.stair-slide-list>div.thumb>a>img"));
				String photoPath = "";
				int j = 0;
				for (WebElement e : thumnails) {
					String thumURL = e.getAttribute("src");
					URL imageURL = new URL(thumURL);
					BufferedImage saveImage = ImageIO.read(imageURL);
					photoPath += RELATIVE_PATH + "/thum" + movielist.getMovieRank() + "_" + j + ".png,";
					ImageIO.write(saveImage, "png", new File(ABSOLUTE_PATH + "/thum" + movielist.getMovieRank() + "_" + j + ".png"));
					j++;
					if (j == Max)
						break;
				}
				System.out.println(photoPath);
				movielist.setMovieImg(photoPath);
			}catch (NoSuchElementException e) {
				System.out.println("썸네일 없음");
				movielist.setMovieImg("null");
			}
			
			// 예고편 저장
			
			int vidcnt = Integer.parseInt(driver
					.findElement(By.xpath("/html/body/div[2]/div[4]/div[2]/div[2]/div/div[2]/div[1]/div/span[1]")).getText().substring(4, 5));
			System.out.println("예고편 개수"+vidcnt);
			if (vidcnt<=0) {
				System.out.println("예고편없음");
				movielist.setMovieVideo("null");
				System.out.println(movielist.getMovieVideo());
			} else {
				List<WebElement> video = driver.findElements(By.cssSelector("#videoTag>source"));
				System.out.println(movielist.getMovieVideo());
				System.out.println("예고편있음");
				String vidURL = video.get(0).getAttribute("src");
				URL vidurl = new URL(vidURL);
				BufferedInputStream bufferedInputStream = new BufferedInputStream(vidurl.openStream());
				FileOutputStream fileOutputStream = new FileOutputStream(ABSOLUTE_PATH + "/video" +  movielist.getMovieRank() + ".mp4");
				int count = 0;
				byte[] b = new byte[1000];
//영상 저장 주석처리 
//				while ((count = bufferedInputStream.read(b)) != -1) {
//					fileOutputStream.write(b, 0, count);
//				}
				String moviePath = RELATIVE_PATH + "/video" +  movielist.getMovieRank() + ".mp4";
				movielist.setMovieVideo(moviePath);// 예고편 경로 저장
			}


			// DB저장
			Connection conn = null;
			PreparedStatement pstmt = null;
			int rows = 0;

			try {
				String url="jdbc:mariadb://127.0.0.1:3306/project";
				String user = "root";
				String pw="1234";
				Class.forName("org.mariadb.jdbc.Driver");
				conn = DriverManager.getConnection(url, user, pw);
				String sql = "insert into mega_movie(movie_title,movie_release,movie_summary,\n"
						+ "movie_age,movie_num,movie_type,movie_genre,movie_director,movie_actors,movie_img,movie_video,movie_rank) "
						+ "values(?,?,?,?,?,?,?,?,?,?,?,?)";
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, movielist.getMovieTitle());
				pstmt.setString(2, movielist.getMovieRelease());
				pstmt.setString(3, movielist.getMovieSummary());
				pstmt.setString(4, movielist.getMovieAge());
				pstmt.setString(5, movielist.getMovieNum());
				pstmt.setString(6, movielist.getMovieType());
				pstmt.setString(7, movielist.getMovieGenre());
				pstmt.setString(8, movielist.getMovieDirector());
				pstmt.setString(9, movielist.getMovieActors());
				pstmt.setString(10, movielist.getMovieImg());
				pstmt.setString(11, movielist.getMovieVideo());
				pstmt.setString(12, movielist.getMovieRank());
				rows = pstmt.executeUpdate();
				if (rows != 0)
					System.out.println(movielist.getMovieTitle()+"디비에 저장됐음");
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				//DBconn.close(conn, pstmt);
			}
		} catch (Exception e) {
			e.printStackTrace();

		} finally {
			driver.close();
		}
	}
}
