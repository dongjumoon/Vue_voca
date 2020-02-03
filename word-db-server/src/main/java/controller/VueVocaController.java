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
public class VueVocaController {
	
	@Autowired
	WordDAO wordDao;
	
	@GetMapping("/root")
	public String root(){
    	return "root";
    }
	
}
