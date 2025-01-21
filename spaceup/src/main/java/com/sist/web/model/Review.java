package com.sist.web.model;

import java.io.Serializable;

public class Review implements Serializable {

    private static final long serialVersionUID = 1L;

    private long reviewId; // 리뷰 ID, sequence
    private long reservationId; // 예약 ID, sequence
    private int reviewScore; // 리뷰 별점
    private String reviewContent; // 리뷰 내용
    private String status; // 리뷰 상태 (ex. 정상:"Y", 삭제:"N")
    private String regDate; // 리뷰 등록날짜
    private String modiDate; // 리뷰 수정날짜
    private String delDate; // 리뷰 삭제날짜

    private String guestEmail;
    private String guestNickname;
    private int reviewLikeyCnt;
    private ReviewReply reviewReply; // 답글 매핑
    private ReviewLikey reviewLikey; // 도움돼요 매핑
    private int reviewSort;
    
    private String spaceName; // 공간이름
    private String spaceAddr; // 공간주소
    private long spaceId;
    private Integer spaceType;

    private long startRow; // 시작페이지(rownum)
    private long endRow; // 끝페이지(rownum)

    // 기본 생성자: Long은 0L, String은 ""로 초기화
    public Review() {
	reviewId = 0;
	reservationId = 0;
	reviewScore = 0;
	reviewContent = "";
	status = "";
	regDate = "";
	modiDate = "";
	delDate = "";

	guestEmail = "";
	guestNickname = "";
	spaceName = "";
	spaceAddr = "";
	spaceId = 0;
	spaceType = 0;
	
	reviewLikeyCnt = 0;
	reviewReply = null;
	reviewLikey = null;
	reviewSort = 1;
	
	startRow = 0;
	endRow = 0;
    }
    
    

    // Getter and Setter methods
    
    
    public Long getReviewId() {
	return reviewId;
    }

    public String getGuestNickname() {
        return guestNickname;
    }



    public void setGuestNickname(String guestNickname) {
        this.guestNickname = guestNickname;
    }



    public int getReviewLikeyCnt() {
        return reviewLikeyCnt;
    }



    public void setReviewLikeyCnt(int reviewLikeyCnt) {
        this.reviewLikeyCnt = reviewLikeyCnt;
    }



    public ReviewReply getReviewReply() {
        return reviewReply;
    }



    public void setReviewReply(ReviewReply reviewReply) {
        this.reviewReply = reviewReply;
    }



    public ReviewLikey getReviewLikey() {
        return reviewLikey;
    }



    public void setReviewLikey(ReviewLikey reviewLikey) {
        this.reviewLikey = reviewLikey;
    }



    public int getReviewSort() {
        return reviewSort;
    }



    public void setReviewSort(int reviewSort) {
        this.reviewSort = reviewSort;
    }



    public void setReviewId(long reviewId) {
        this.reviewId = reviewId;
    }



    public void setReservationId(long reservationId) {
        this.reservationId = reservationId;
    }



    public void setReviewScore(int reviewScore) {
        this.reviewScore = reviewScore;
    }



    public void setReviewId(Long reviewId) {
	this.reviewId = reviewId;
    }

    public Long getReservationId() {
	return reservationId;
    }

    public void setReservationId(Long reservationId) {
	this.reservationId = reservationId;
    }

    public Integer getReviewScore() {
	return reviewScore;
    }

    public void setReviewScore(Integer reviewScore) {
	this.reviewScore = reviewScore;
    }

    public String getReviewContent() {
	return reviewContent;
    }

    public void setReviewContent(String reviewContent) {
	this.reviewContent = reviewContent;
    }

    public String getStatus() {
	return status;
    }

    public void setStatus(String status) {
	this.status = status;
    }

    public String getRegDate() {
	return regDate;
    }

    public void setRegDate(String regDate) {
	this.regDate = regDate;
    }

    public String getModiDate() {
	return modiDate;
    }

    public void setModiDate(String modiDate) {
	this.modiDate = modiDate;
    }

    public String getDelDate() {
	return delDate;
    }

    public void setDelDate(String delDate) {
	this.delDate = delDate;
    }

    public String getSpaceName() {
	return spaceName;
    }

    public void setSpaceName(String spaceName) {
	this.spaceName = spaceName;
    }

    public String getSpaceAddr() {
	return spaceAddr;
    }

    public void setSpaceAddr(String spaceAddr) {
	this.spaceAddr = spaceAddr;
    }

    public String getGuestEmail() {
	return guestEmail;
    }

    public void setGuestEmail(String guestEmail) {
	this.guestEmail = guestEmail;
    }

    public long getStartRow() {
	return startRow;
    }

    public void setStartRow(long startRow) {
	this.startRow = startRow;
    }

    public long getEndRow() {
	return endRow;
    }

    public void setEndRow(long endRow) {
	this.endRow = endRow;
    }

    public long getSpaceId() {
	return spaceId;
    }

    public void setSpaceId(long spaceId) {
	this.spaceId = spaceId;
    }
    
    public Integer getSpaceType() {
		return spaceType;
	}
    
	public void setSpaceType(Integer spaceType) {
		this.spaceType = spaceType;
	}
    

}
