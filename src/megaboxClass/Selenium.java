package megaboxClass;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.Statement;
import java.text.SimpleDateFormat;
import java.time.LocalTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

import org.apache.tomcat.dbcp.dbcp2.PStmtKey;
import org.openqa.selenium.By;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.chrome.ChromeDriver;

import com.sun.org.apache.xerces.internal.impl.xpath.regex.ParseException;

public class Selenium {
	public void bookingSelenium() {
		String DRIVER_ID = "webdriver.chrome.driver";
		String DRIVER_PATH = "C://clonePJ_megabox2//Megabox//WebContent//WEB-INF//libs//chromedriver.exe";
		//String DRIVER_PATH = "C:/Users//tjsk0//eclipse-workspace//koreaitTeam2//Megabox//WebContent//WEB-INF//libs//chromedriver.exe";
		
		
		System.setProperty(DRIVER_ID, DRIVER_PATH);
		WebDriver driver = new ChromeDriver();
		String base_url = "https://www.megabox.co.kr/booking/timetable";
		String xPath = "";
		

		ArrayList<TimeMovieDTO> tb = new ArrayList();

		try {
			driver.get(base_url);

			List<WebElement> locationList = driver.findElements(By.cssSelector("a.btn"));
			locationList.get(1).click();
			Thread.sleep(1000);

			xPath = "/html/body/div[2]/div[3]/div[2]/div/div/div[1]/div[2]/div[2]/div/div[1]/ul/li/a";
			locationList = driver.findElements(By.xpath(xPath));

			int locationCnt = 0;

			for (WebElement el : locationList) {

				el.click();
				Thread.sleep(500);

				locationList = driver.findElements(By.cssSelector("button.btn"));

				for (WebElement el2 : locationList) {

					if (el2.getText().equals("")) {
					} else 

						el2.click();
						Thread.sleep(500);

						WebElement date = driver.findElement(By.xpath(
								"/html/body/div[2]/div[3]/div[2]/div/div/div[4]/div/div[1]/div[2]/div/button[2]"));

						for (int i = 0; i < 10; i++) {

							xPath = "/html/body/div[2]/div[3]/div[2]/div/div/div[4]/div/div[1]/div[2]/div/button["
									+ (i + 2) + "]";

							date = driver.findElement(By.xpath(xPath));

							if (date.getAttribute("class").contains("disabled")) {
								continue;
							}

							date.click();
							Thread.sleep(500);

							List<WebElement> location = driver.findElements(By.cssSelector("a.on"));
							String time_location = location.get(1).getText();

							List<WebElement> theaterTime = driver.findElements(By.cssSelector("button.on"));

							String time_sinema = theaterTime.get(1 + locationCnt).getText();
							String time_date = theaterTime.get(2 + locationCnt).getText();
							time_date = time_date.substring(0, time_date.lastIndexOf("\n"));
							time_date = movie_date(time_date);

							String time_title = "";
							String time_theater = "";
							String time_allSeat = "";
							String time_remainSeat = "";
							String time_start = "";
							String time_running = "";
							String time_finish = "";
							String time_category = "";

							xPath = "/html/body/div[2]/div[3]/div[2]/div/div/div[6]/div";
							List<WebElement> movie_cnt = driver.findElements(By.xpath(xPath));

							for (int a = 1; a < movie_cnt.size(); a++) {

								xPath = "/html/body/div[2]/div[3]/div[2]/div/div/div[6]/div[" + (a + 1) + "]/div[1]";
								List<WebElement> timeCategory = driver.findElements(By.xpath(xPath));

								for (WebElement b : timeCategory) {

									String[] c = b.getText().split("\n");
									time_title = c[0];
									time_running = c[1];
									time_running = time_running.split(" ")[1];
									time_running = time_running.split("분")[0];

									xPath = "/html/body/div[2]/div[3]/div[2]/div/div/div[6]/div[" + (a + 1) + "]/div";
									List<WebElement> timeCategory1 = driver.findElements(By.xpath(xPath));

									for (int d = 2; d <= timeCategory1.size(); d++) {

										xPath = "/html/body/div[2]/div[3]/div[2]/div/div/div[6]/div[" + (a + 1)
												+ "]/div[" + d + "]";
										List<WebElement> timeCategory2 = driver.findElements(By.xpath(xPath));

										for (WebElement el3 : timeCategory2) {
											String[] abc = el3.getText().split("\n");
											time_theater = abc[0];

											time_allSeat = abc[1];
											time_allSeat = time_allSeat.split(" ")[1];
											time_category = abc[2];

											xPath = "/html/body/div[2]/div[3]/div[2]/div/div/div[6]/div[" + (a + 1)
													+ "]/div[" + d + "]/div[2]/div[2]/table/tbody/tr/td";
											List<WebElement> timeLength = driver.findElements(By.xpath(xPath));

											for (int len1 = 1; len1 <= timeLength.size(); len1++) {

												xPath = "/html/body/div[2]/div[3]/div[2]/div/div/div[6]/div[" + (a + 1)
														+ "]/div[" + d + "]/div[2]/div[2]/table/tbody/tr/td[" + len1
														+ "]";
												List<WebElement> timeCategory3 = driver.findElements(By.xpath(xPath));

												for (WebElement el4 : timeCategory3) {
													String[] e = el4.getText().split("\n");
													time_start = e[0];
													time_finish = movie_finish(time_start, time_running);
													TimeMovieDTO add = new TimeMovieDTO();
													add.setTime_allSeat(time_allSeat);
													add.setTime_category(time_category);
													add.setTime_date(time_date);
													add.setTime_finish(time_finish);
													add.setTime_location(time_location);
													add.setTime_sinema(time_sinema);
													add.setTime_start(time_start);
													add.setTime_theater(time_theater);
													add.setTime_title(time_title);
													System.out.println(add.toString());
													tb.add(add);

												}
											}
										}
									}
								}
							}
						}
					}
				}
				locationCnt++;
			}

		} catch (Exception e) {
			System.out.println("오류");
		}

		System.out.println("---");

		try {
			Connection conn = null;
			String url = "jdbc:mariadb://127.0.0.1:3306/project";
			String user = "root";
			String pw = "1234";
			Class.forName("org.mariadb.jdbc.Driver");
			conn = DriverManager.getConnection(url, user, pw);

			if (conn != null) {
				Statement pstmt1 = conn.createStatement();
				pstmt1.executeUpdate("DROP TABLE if EXISTS movie_time");

				pstmt1.executeUpdate(
						"CREATE TABLE movie_time(time_idx int PRIMARY KEY not null auto_increment, time_title varchar(100) not NULL, time_start varchar(30), time_finish varchar(30), time_sinema varchar(30), time_location varchar(30), time_theater varchar(30), time_date varchar(30), time_allSeat varchar(30), time_remainSeat int, time_category varchar(30))");
				PreparedStatement pstmt = null;

				for (int cnt = 0; cnt < tb.size(); cnt++) {
					pstmt = conn.prepareStatement(
							"INSERT INTO movie_time(time_title, time_start, time_sinema, time_location, time_theater, time_date, time_allSeat, time_category, time_finish) VALUES(?, ?, ?, ?, ?, ?, ?, ?, ?);");
					pstmt.setString(1, tb.get(cnt).getTime_title());
					pstmt.setString(2, tb.get(cnt).getTime_start());
					pstmt.setString(3, tb.get(cnt).getTime_sinema());
					pstmt.setString(4, tb.get(cnt).getTime_location());
					pstmt.setString(5, tb.get(cnt).getTime_theater());
					pstmt.setString(6, tb.get(cnt).getTime_date());
					pstmt.setString(7, tb.get(cnt).getTime_allSeat());
					pstmt.setString(8, tb.get(cnt).getTime_category());
					pstmt.setString(9, tb.get(cnt).getTime_finish());
					pstmt.executeUpdate();
				}
				pstmt.close();
				pstmt1.close();
				conn.close();
			}

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			driver.close();

		}

	}

	public static String movie_date(String movieDate) {
		Calendar cal = Calendar.getInstance();
		int month = cal.get(cal.MONTH) + 1;
		int date = cal.get(cal.DATE);
		if (date > Integer.parseInt(movieDate)) {
			month++;
		}
		return String.valueOf(month) + "." + movieDate;
	}

	public static String movie_finish(String start, String running) throws ParseException {
		String movieFinish = "";

		String hour = start.split(":")[0];
		String minute = start.split(":")[1];
		LocalTime startTime = LocalTime.of(Integer.parseInt(hour), Integer.parseInt(minute));
		SimpleDateFormat calDate = new SimpleDateFormat("HH:mm");

		movieFinish = startTime.plusMinutes(Long.parseLong(running)).format(DateTimeFormatter.ofPattern("HH:mm"));

		return movieFinish;
	}

}
