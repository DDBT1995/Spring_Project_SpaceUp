package com.sist.web.dao;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.sist.web.model.Reservation;
import com.sist.web.model.Review;
import com.sist.web.model.ReviewLikey;
import com.sist.web.model.Space;
import com.sist.web.model.SpaceQuestion;

@Repository("spaceDao")
public interface SpaceDao {
    public Space spaceSelectByReservationId(long reservationId);

    public Space spaceSelectById(long spaceId);

    public Space spaceView(long spaceId);

    public List<Review> spaceReview(Review review);

    public long reviewTotalCnt(long spaceId);

    public long reviewTotalCntY(long spaceId);

    public int reviewReport(Map<String, Object> reviewReportMap);

    public Space spaceSelect(long spaceId);

    public Review reviewSelect(long reviewId);

    public int reviewUpdate(Review review);

    public int reviewDelete(long reviewId);

    public List<SpaceQuestion> spaceQuestionList(SpaceQuestion sQ);

    public long spaceQuestionTotalCnt(long spaceId);

    public long spaceQuestionTotalCntY(long spaceId);

    public int questionInsert(SpaceQuestion sQ);

    public int questionUpdate(SpaceQuestion sQ);

    public int questionDelete(long spaceQuestionId);

    public int questionUserSelect(SpaceQuestion sQ);
    
    public int reviewLikeySelect(ReviewLikey reviewLikey);
	
	public int reviewLikeyInsert(ReviewLikey reviewLikey);
	
	public int reviewLikeyDelete(ReviewLikey reviewLikey);
	
	public List<Reservation> reservationSelect(Reservation reservation);

    // 베스트 공간 리스트
    public List<Space> bestSpaceList(Space space);

    // 라이키 공간 리스트
    public List<Space> likeySpaceList(Space space);

    // 최신 공간 리스트
    public List<Space> newSpaceList(Space space);

    // 공간 리스트
    public List<Space> spaceList(Space space);

    // 공간 리스트 더보기
    public List<Space> spaceListMore(Space space);

    // 공간 좋아요
    public int spaceLikey(Map<String, Object> likeMap);

    // 공간 좋아요 중복체크
    public int spaceLikeyCheck(Map<String, Object> likeMap);

    // 공간 좋아요 삭제
    public int spaceLikeyDel(Map<String, Object> likeMap);
    
    // 공간 조회 수 증가
    public int spaceReadCntPlus(long spaceId);
    
    //공간 수
    public int spaceListCount(Space space);

}
