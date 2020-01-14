package config;

import org.apache.tomcat.jdbc.pool.DataSource;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

import controller.MainController;
import dao.WordDAO;

@Configuration
public class MainConfig {

	@Bean
	public MainController mainController() {
		return new MainController();
	}
	
	@Bean
	public DataSource datsSource() {
		return null;
	}

	@Bean(destroyMethod = "close")
	public DataSource dataSource() {
		DataSource ds = new DataSource();
		ds.setDriverClassName("com.mysql.jdbc.Driver");
		ds.setUrl("jdbc:mysql://localhost/word_db?verifyServerCertificate=false&useSSL=true");
		ds.setUsername("root");
		ds.setPassword("1234");
		return ds;
	}
	
	@Bean
	public WordDAO wordDao() {
		return new WordDAO(dataSource());
	}
}
