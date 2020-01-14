package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

import javax.sql.DataSource;

import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.PreparedStatementCreator;
import org.springframework.jdbc.core.RowMapper;

import model.Word;

public class WordDAO {

	private JdbcTemplate jdbcTemplate;
	private RowMapper<Word> wordRowMapper = 
			new RowMapper<Word>() {
				@Override
				public Word mapRow(ResultSet rs, int rowNum)
						throws SQLException {
					Word word = new Word();
					word.setWord(rs.getString("word"));
					word.setDescription(rs.getString("description"));
					return word;
				}
			};

	public WordDAO(DataSource dataSource) {
		this.jdbcTemplate = new JdbcTemplate(dataSource);
	}

	public void insert(Word word) {
		jdbcTemplate.update(new PreparedStatementCreator() {
			@Override
			public PreparedStatement createPreparedStatement(Connection con)
					throws SQLException {
				// 파라미터로 전달받은 Connection을 이용해서 PreparedStatement 생성
				PreparedStatement pstmt = con.prepareStatement(
						"insert into WORDS (word, description) " +
								"values (?, ?)");
				// 인덱스 파라미터 값 설정
				pstmt.setString(1, word.getWord());
				pstmt.setString(2, word.getDescription());
				// 생성한 PreparedStatement 객체 리턴
				return pstmt;
			}
		});
	}

	public List<Word> selectAll() {
		List<Word> results = jdbcTemplate.query("select * from WORDS",
				wordRowMapper);
		return results;
	}

}
