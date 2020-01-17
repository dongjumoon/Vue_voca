package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Collections;
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

	public int insert(Word word) {
		int result = 0;
		
		if (!isHaveWord(word.getWord())) {
			result = jdbcTemplate.update(new PreparedStatementCreator() {
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
		
		return result; // 저장 완료=1, 이미 있는 단어=0
	}

	public List<Word> selectAll() {
		List<Word> results = jdbcTemplate.query("select * from WORDS",
				wordRowMapper);
		return results;
	}
	
	public List<Word> quizList() {
		List<Word> words = selectAll();
		Collections.shuffle(words);
		return words;
	}
	
	public int rightWordReader(Word word) {
		int result = 0;
		
		Word dbWord = selectByWord(word.getWord());
		if (dbWord != null && dbWord.getDescription().equals(word.getDescription())) {
			result = 1;
		}
		
		return result; // 정답=1, 뭔가 잘못되었다=0
	}
	
	public Word selectByWord(String word) {
		List<Word> results = jdbcTemplate.query(
				"select * from words where word = ?",
				wordRowMapper, word);
		return results.isEmpty() ? null : results.get(0);
	}
	
	public boolean isHaveWord(String word) {
		return selectByWord(word) != null ? true : false;
	}
	
	public int update(Word word) {
		int result = 0;
		
		if (isHaveWord(word.getWord())) {
			result = jdbcTemplate.update(
					"update words set description = ? where word = ?",
					word.getDescription(), word.getWord());
		}
		
		return result; // 수정 완료=1, 존재 하지 않는 단어=0
	}
		
}
