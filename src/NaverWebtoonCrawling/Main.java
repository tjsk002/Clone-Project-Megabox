package NaverWebtoonCrawling;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.openqa.selenium.By;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.chrome.ChromeDriver;

import CrawlingInfo.CrawlingInfo;


public class Main {

	public static void main(String[] args) {
		CrawlingInfo info = new CrawlingInfo();
		String DRIVER_ID = info.DRIVER_ID; // chromedriver 사용
		String DRIVER_PATH=info.DRIVER_PATH;
		System.setProperty(DRIVER_ID, DRIVER_PATH);
		WebDriver driver = new ChromeDriver();
		String url = "https://comic.naver.com/webtoon/weekday.nhn";
		
		try {
			driver.get(url);
			Thread.sleep(2000);
			
			List<WebElement> colums = driver.findElements(By.cssSelector("div.list_area.daily_all>div.col"));
			String day="";//요일
			List<String> webtoonList;//웹툰명
			HashMap<String, List> map = new HashMap<String,List>();//요일+웹툰명 저장할 변수 
			
			for(WebElement colum : colums) {
				webtoonList = new ArrayList<String>();
				day = colum.findElement(By.cssSelector("div.col_inner>h4>span")).getText();
				List<WebElement> titles = colum.findElements(By.cssSelector("div.col_inner>ul>li>a"));
				for(WebElement title : titles) {
					webtoonList.add(title.getText());
				}
				map.put(day, webtoonList);
			}
			//java map print all
			for (Map.Entry<String, List> entry : map.entrySet()) {
			    System.out.println(entry.getKey() + ":" + entry.getValue().toString());
			}
			
		} catch (Exception e) {
			e.printStackTrace();

		} finally {
			driver.close();
		}
	}

}