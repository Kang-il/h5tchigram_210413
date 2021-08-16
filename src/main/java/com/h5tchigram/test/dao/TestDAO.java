package com.h5tchigram.test.dao;

import java.util.Map;

import org.springframework.stereotype.Repository;

@Repository
public interface TestDAO {
	public Map<String, Object> testSelectUser();
	
}
