package com.h5tchigram.timeline.bo;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.h5tchigram.timeline.dao.TimeLineDAO;
import com.h5tchigram.timeline.model.TimeLine;

@Service
public class TimeLineBO {
	@Autowired
	private TimeLineDAO timeLineDAO;
	
	public void insertTimeLine(int postId, int userId) {
		timeLineDAO.insertTimeline(postId, userId);
	}
	
	public void deleteTimeLineByPostId(int postId) {
		timeLineDAO.deleteTimeLineByPostId(postId);
	}
	
	public List<TimeLine> getTimeLineListByUserIdList(List<Integer> userIdList){
		return timeLineDAO.selectTimeLineListByUserIdList(userIdList);
	}
	
}
