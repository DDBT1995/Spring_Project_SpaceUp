package com.sist.web.service;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sist.web.dao.SpaceQuestionDao;
import com.sist.web.model.SpaceQuestion;

@Service("spaceQuestionService")
public class SpaceQuestionService {
    private static Logger logger = LoggerFactory.getLogger(SpaceQuestionService.class);
    
    @Autowired
    private SpaceQuestionDao spaceQuestionDao;
    
    // QnA조회, 작성자
    public List<SpaceQuestion> selectSpaceQuestionByGuest(SpaceQuestion search) {
	List<SpaceQuestion> list = null;
	
	try {
	    list = spaceQuestionDao.selectSpaceQuestionByGuest(search);
	} catch (Exception e) {
	    logger.error("[spaceQuestionService] selectSpaceQuestionByGuest Exception", e);
	}
	return list;
    }
    
    public int spaceQuestionListCount(String guestEmail) {
	int count = 0;
	
	try {
	    count = spaceQuestionDao.spaceQuestionListCount(guestEmail);
	} catch (Exception e) {
	    logger.error("[spaceQuestionService] spaceQuestionListCount Exception", e);
	}
	return count;
    }
}
