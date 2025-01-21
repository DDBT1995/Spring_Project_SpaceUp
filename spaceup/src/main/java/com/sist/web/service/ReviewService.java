package com.sist.web.service;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sist.web.dao.ReviewDao;
import com.sist.web.model.Review;

@Service("reviewService")
public class ReviewService {

    private static Logger logger = LoggerFactory.getLogger(ReviewService.class);

    @Autowired
    private ReviewDao reviewDao;
    
    // 리뷰 작성
    public int insertReview(Review review) {
	int count = 0;

	try {
	    count = reviewDao.insertReview(review);
	} catch (Exception e) {
	    logger.error("[ReviewService] insertReview Exception", e);
	}

	return count;
    }

    // 작성한 리뷰 리스트
    public List<Review> myReviewList(Review review) {
	List<Review> list = null;

	try {
	    list = reviewDao.myReviewList(review);
	} catch (Exception e) {
	    logger.error("[ReviewService] myReviewList Exception", e);
	}

	return list;
    }

    // 작성한 리뷰 리스트 총 게시물 수
    public long myReviewCount(String guestEmail) {
	long count = 0;

	try {
	    count = reviewDao.myReviewCount(guestEmail);
	} catch (Exception e) {
	    logger.error("[ReviewService] myReviewCount Exception", e);
	}

	return count;
    }
}
