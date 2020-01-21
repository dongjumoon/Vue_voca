package controller;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import model.Word;
import dao.WordDAO;
import enums.ResultMessage;

@Controller
@CrossOrigin(origins = "http://localhost:8080")
public class MainController {
	
	@Autowired
	WordDAO wordDao;
	
	@GetMapping("/insert")
	@ResponseBody
	public Map<ResultMessage, String> insert(@RequestParam String word, @RequestParam String description){
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
	
	@GetMapping("/getPage")
	@ResponseBody
	public List<Word> getPage(@RequestParam String pageNum, @RequestParam String onePageViewCount){
    	return wordDao.getPage(pageNum, onePageViewCount);
    }
	
	@GetMapping("quizList")
	@ResponseBody
	public List<Word> quizList(@RequestParam String totalQuizNumber) {
		return wordDao.quizList(totalQuizNumber);
	}
	
	@GetMapping("/rightWordReader")
	@ResponseBody
	public Map<ResultMessage, String> rightWordReader(@RequestParam String word, @RequestParam String description){
		Word wordDto = new Word();
		wordDto.setWord(word);
		wordDto.setDescription(description);
    	return wordDao.rightWordReader(wordDto);
    }
	
	@GetMapping("/isHaveWord")
	@ResponseBody
	public boolean haveWord(@RequestParam String word){
    	return wordDao.isHaveWord(word);
    }
	
	@GetMapping("/update")
	@ResponseBody
	public Map<ResultMessage, String> update(@RequestParam String word, @RequestParam String description){
		Word wordDto = new Word();
		wordDto.setWord(word);
		wordDto.setDescription(description);
    	return wordDao.update(wordDto);
    }
	
	@GetMapping("/maxPage")
	@ResponseBody
	public int maxPage(@RequestParam String onePageViewCount) {
		return wordDao.maxPage(onePageViewCount);
	}
	
}
