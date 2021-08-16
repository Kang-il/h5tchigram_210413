package com.h5tchigram.test.bo;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.h5tchigram.test.dao.TestDAO;

@Service
public class TestBO {
	@Autowired
	private TestDAO testdao;
	
	public Map<String, Object> getTestDB(){
		return testdao.testSelectUser();
	}
}
