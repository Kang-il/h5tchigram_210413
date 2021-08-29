package com.h5tchigram.timeline.bo;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.h5tchigram.timeline.dao.TimelineDAO;

@Service
public class TimelineBO {
	@Autowired
	private TimelineDAO timelineDAO;
	
	
}
