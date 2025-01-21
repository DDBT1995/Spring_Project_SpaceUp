package com.sist.web.service;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sist.web.dao.SpaceAnswerDao;
import com.sist.web.model.SpaceAnswer;

@Service("spaceAnswerService")
public class SpaceAnswerService {
    private static Logger logger = LoggerFactory.getLogger(SpaceQuestionService.class);
    
    @Autowired
    private SpaceAnswerDao spaceAnswerDao;
    
    // 답변 조회, 문의 번호
    public SpaceAnswer selectSpaceAnswerByQuestionId(long spaceQuestionId) {
	SpaceAnswer spaceAnswer = null;
	
	try {
	    spaceAnswer = spaceAnswerDao.selectSpaceAnswerByQuestionId(spaceQuestionId);
	} catch (Exception e) {
	    logger.error("[spaceAnswerService] selectSpaceAnswerByQuestionId Exception", e);
	}
	return spaceAnswer;
    }
}
