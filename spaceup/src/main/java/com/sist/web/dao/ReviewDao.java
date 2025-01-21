package com.sist.web.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.sist.web.model.Review;

@Repository("reviewDao")
public interface ReviewDao {
	
	//작성한 리뷰 리스트 조회
	public List<Review> myReviewList(Review review);
	
	//작성한 리뷰 총 게시물 수
	public long myReviewCount(String guestEmail);
	
	// 리뷰 작성
	public int insertReview(Review review);
}
