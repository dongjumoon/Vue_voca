package controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import model.Word;
import dao.WordDAO;

@Controller
@CrossOrigin(origins = "http://localhost:8080")
public class MainController {
	
	@Autowired
	WordDAO wordDao;
	
	@GetMapping("/insert")
	@ResponseBody
	public int insert(@RequestParam String word, @RequestParam String description){
		Word wordDto = new Word();
		wordDto.setWord(word);
		wordDto.setDescription(description);
    	return wordDao.insert(wordDto);
    }
	
	@GetMapping("/selectAll")
	@ResponseBody
	public List<Word> selectAll() {
		return wordDao.selectAll();
	}
	
	@GetMapping("quizList")
	@ResponseBody
	public List<Word> quizList() {
		return wordDao.quizList();
	}
	
	@GetMapping("/rightWordReader")
	@ResponseBody
	public int rightWordReader(@RequestParam String word, @RequestParam String description){
		Word wordDto = new Word();
		wordDto.setWord(word);
		wordDto.setDescription(description);
    	return wordDao.rightWordReader(wordDto);
    }
	
	@GetMapping("/isHaveWord")
	@ResponseBody
	public int haveWord(@RequestParam String word){
    	return wordDao.isHaveWord(word) ? 1 : 0;
    }
	
	@GetMapping("/update")
	@ResponseBody
	public int update(@RequestParam String word, @RequestParam String description){
		Word wordDto = new Word();
		wordDto.setWord(word);
		wordDto.setDescription(description);
    	return wordDao.update(wordDto);
    }
	
}
