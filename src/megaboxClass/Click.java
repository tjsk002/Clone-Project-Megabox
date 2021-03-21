package megaboxClass;

import java.io.BufferedInputStream;
import java.io.File;
import java.io.FileOutputStream;
import java.net.URL;
import java.util.ArrayList;
import java.util.List;

import javax.imageio.ImageIO;
import javax.lang.model.element.Element;

import org.openqa.selenium.By;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.chrome.ChromeDriver;

public class Click {
	String DRIVER_ID = "webdriver.chrome.driver"; // chromedriver 사용
	String DRIVER_PATH = "C://clonePJ_megabox/Megabox/WebContent/WEB-INF/libs/chromedriver.exe";
	
	//String DRIVER_PATH = "C://Users//vanes//Documents//GitHub//koreaitTeam//Megabox//WebContent//WEB-INF//libs//chromedriver.exe";
	//String DRIVER_PATH="/Users/jina/koreaitTeam/Megabox/WebContent/WEB-INF/libs/chromedriver ";

	
	private List<MovieDTO> movieList =new ArrayList<MovieDTO>();
	
	
	public void Crawling() {
		
		System.setProperty(DRIVER_ID, DRIVER_PATH);

		WebDriver driver = new ChromeDriver();
		String base_url = "https://megabox.co.kr/movie";
		try {
			

			driver.get(base_url);
			
			/*
			WebElement toggle=driver.findElement(By.cssSelector("div.onair-condition>button"));
			toggle.click();
			*/
			/*미완
			for(;;) {
			WebElement more=driver.findElement(By.cssSelector("div.btn-more.v1>button"));
			//String visibility = driver.findElement(By.cssSelector("div.btn-more.v1>button")).getCssValue("display");
			more.click();Thread.sleep(5000);
			more.click();Thread.sleep(5000);
			more.click();Thread.sleep(5000);
			more.click();
			if(more.getAttribute("display").equals("none")) {
				break;
			}
			}
			*/

			Thread.sleep(2000);
			
			
			//현재 상영중인 영화수 
			WebElement tot=driver.findElement(By.cssSelector("#totCnt"));
			System.out.println(tot);
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
				//영화 url과 rank값 받아옴  
				GetDetail GD = new GetDetail(nextMovie, i);
				GD.Crawling();
			}
			 
		} catch (Exception e) {
			e.printStackTrace();

		} finally {
			driver.close();
		}
	}
	
	
}
