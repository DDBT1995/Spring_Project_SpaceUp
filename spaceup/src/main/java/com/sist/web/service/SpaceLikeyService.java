package com.sist.web.service;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sist.web.dao.SpaceLikeyDao;
import com.sist.web.model.SpaceLikey;

@Service("spaceLikeyService")
public class SpaceLikeyService {
    private static Logger logger = LoggerFactory.getLogger(SpaceLikeyService.class);

    @Autowired
    private SpaceLikeyDao spaceLikeyDao;

    // 공간 좋아요 리스트
    public List<SpaceLikey> spaceLikeyList(SpaceLikey spaceLikey) {
	List<SpaceLikey> list = null;

	try {
	    list = spaceLikeyDao.spaceLikeyList(spaceLikey);
	} catch (Exception e) {
	    logger.error("[SpaceLikeyService] spaceLikeyList Exception", e);
	}

	return list;
    }

    // 공간 좋아요 총 갯수
    public long spaceLikeyCount(SpaceLikey spaceLikey) {
	long count = 0;

	try {
	    count = spaceLikeyDao.spaceLikeyCount(spaceLikey);
	} catch (Exception e) {
	    logger.error("[SpaceLikeyService] spaceLikeyCount Exception", e);
	}

	return count;
    }
    
    public int addLikey(SpaceLikey spaceLikey) {
	int count = 0;

	try {
	    count = spaceLikeyDao.addLikey(spaceLikey);
	} catch (Exception e) {
	    logger.error("[SpaceLikeyService] spaceLikeyInsert Exception", e);
	}

	return count;
    }

    // 공간 좋아요 취소
    public int deleteLikey(SpaceLikey spaceLikey) {
	int count = 0;

	try {
	    count = spaceLikeyDao.deleteLikey(spaceLikey);
	} catch (Exception e) {
	    logger.error("[SpaceLikeyService] spaceLikeyDelete Exception", e);
	}

	return count;
    }

    // 좋아요 중복체크
    public int checkLikey(SpaceLikey spaceLikey) {
	int count = 0;

	try {
	    count = spaceLikeyDao.checkLikey(spaceLikey);
	} catch (Exception e) {
	    logger.error("[SpaceLikeyService] spaceLikeyCheck Exception", e);
	}

	return count;
    }

    // 한 게시물 당 좋아요 총 카운트
    public int spaceIdLikeyCount(long spaceId) {
	int count = 0;

	try {
	    count = spaceLikeyDao.spaceIdLikeyCount(spaceId);
	} catch (Exception e) {
	    logger.error("[SpaceLikeyService] spaceLikeyCount Exception", e);
	}

	return count;
    }
}
