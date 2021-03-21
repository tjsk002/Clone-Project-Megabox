package GetMovieLists;

import java.util.ArrayList;
import java.util.List;

import org.openqa.selenium.By;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.chrome.ChromeDriver;

import megaboxClass.MovieDTO;

public class GetMovieList {
	ChromeDriverInfo info = new ChromeDriverInfo();
	private String DRIVER_ID = info.DRIVER_ID; // chromedriver 사용
	private String DRIVER_PATH=info.DRIVER_PATH;
	
	private List<MovieDTO> movieList =new ArrayList<MovieDTO>();
	
	public void Crawling() {
		
		System.setProperty(DRIVER_ID, DRIVER_PATH);

		WebDriver driver = new ChromeDriver();
		String base_url = "https://megabox.co.kr/movie";
		try {
			driver.get(base_url);
			Thread.sleep(2000);
			
			//현재 상영중인 영화수 
			WebElement tot=driver.findElement(By.cssSelector("#totCnt"));
			int totMovie=Integer.parseInt(tot.getText());
			
			//박스오피스 순위 가져옴 
			List<WebElement> movieorder = driver.findElements(By.cssSelector("button.button.btn-like"));
			System.out.println("###############"+movieorder.size());
			
			Thread.sleep(3000);
			String[] datano = new String[totMovie];
			int cnt = 0;
			for (WebElement e : movieorder) {
				datano[cnt] = e.getAttribute("data-no");
				cnt++;
			}
			
			for (int i = 0; i < 20; i++) {
				String nextMovie = "https://megabox.co.kr/movie-detail?rpstMovieNo=" + datano[i];
				GetMovieDetail getMovieDetail = new GetMovieDetail(nextMovie, i);
				getMovieDetail.Crawling();
			}
			 
		} catch (Exception e) {
			e.printStackTrace();

		} finally {
			driver.close();
		}
	}
	
	
}
