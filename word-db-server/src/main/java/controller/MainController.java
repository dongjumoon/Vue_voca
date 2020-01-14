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
	public String test(@RequestParam String word, @RequestParam String description){
		Word wordDto = new Word();
		wordDto.setWord(word);
		wordDto.setDescription(description);
    	wordDao.insert(wordDto);
    	return "hello";
    }
	
	@GetMapping("/selectAll")
	@ResponseBody
	public List<Word> test2() {
		return wordDao.selectAll();
	}
}
