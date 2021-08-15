package com.h5tchigram.test;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.h5tchigram.test.bo.TestBO;

@Controller
public class TestController {

	@Autowired
	private TestBO testBO;
	
	@RequestMapping("/test")
	@ResponseBody
	public String helloWorld() {
		return "Hello World!";
	}
	
	@RequestMapping("/test_db")
	@ResponseBody
	public Map<String, Object> testDB(){
		Map<String, Object> result=testBO.getTestDB();
		return result;
	}
	
	@RequestMapping("/test_jsp")
	public String testJsp() {
		return "test/test";
	}
}
