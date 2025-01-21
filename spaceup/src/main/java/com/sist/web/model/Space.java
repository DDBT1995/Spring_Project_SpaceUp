package com.sist.web.model;

import java.io.Serializable;

public class Space implements Serializable {
    private static final long serialVersionUID = 1L;

    private Long spaceId; // SPACE_ID
    private String hostEmail; // HOST_EMAIL
    private int spaceType; // SPACE_TYPE
    private String spaceName; // SPACE_NAME
    private String spaceDesc; // SPACE_DESC
    private String spaceTip; // SPACE_TIP
    private String spaceParking; // SPACE_PARKING
    private int spaceMaxCapacity; // SPACE_MAX_CAPACITY
    private String spaceAddr; // SPACE_ADDR
    private String spaceAddrDesc; // SPACE_ADDR_DESC
    private int spaceCloseDay; // SPACE_CLOSE_DAY
    private String spaceNotice; // SPACE_NOTICE
    private String spaceCloseDayHost; // SPACE_CLOSE_DAY_HOST
    private int spaceStartTime; // SPACE_START_TIME
    private int spaceEndTime; // SPACE_END_TIME
    private int minReservationTime; // MIN_RESERVATION_TIME
    private int spaceHourlyRate; // SPACE_HOURLY_RATE
    private String status; // STATUS
    private String regDate; // REG_DATE
    private String modiDate; // MODI_DATE
    private String delDate; // DEL_DATE

    private String hostNickname; // HOST_NICKNAME

    private Integer reviewCnt; // REVIEW_CNT : 리뷰수
    private float reviewScoreAvg; // REVIEW_SCORE_AVG : 리뷰 점수 평균
    private Integer spaceQuestionCnt; // SPACE_QUESTION_CNT : 공간 질문 수

    private Integer spaceReadCnt; // SPACE_READ_CNT : 공간 조회수
    private Integer likeyCnt; // LIKEY_CNT // 좋아요 수

    private Integer spaceSort; // 공간 정렬
    private Integer offset; // 페이징 시작점
    private Integer limit; // 한 번에 가져올 데이터 수

    private boolean spaceLiked; // 좋아요 눌렀는지 아닌지

    private String reservationWeek;
    
    
    
    // 기본 생성자
    public Space() {
	spaceId = (long) 0;
	hostEmail = "";
	spaceType = 0;
	spaceName = "";
	spaceDesc = "";
	spaceTip = "";
	spaceParking = "";
	spaceMaxCapacity = 0;
	spaceAddr = "";
	spaceAddrDesc = "";
	spaceCloseDay = 0;
	spaceNotice = "";
	spaceCloseDayHost = "";
	spaceStartTime = 0;
	spaceEndTime = 0;
	minReservationTime = 0;
	spaceHourlyRate = 0;
	status = "D";
	regDate = "";
	modiDate = null;
	delDate = null;
	
	hostNickname = "";

	reviewCnt = 0;
	reviewScoreAvg = 0;
	spaceQuestionCnt = 0;

	spaceReadCnt = 0;
	likeyCnt = 0;
	spaceSort = 0;

	offset = 0;
	limit = 0;

	spaceLiked = false;

	reservationWeek = "";
    }

    // Getter와 Setter
    
    
    public Long getSpaceId() {
	return spaceId;
    }

    public String getHostNickname() {
        return hostNickname;
    }

    public void setHostNickname(String hostNickname) {
        this.hostNickname = hostNickname;
    }

    public Integer getReviewCnt() {
        return reviewCnt;
    }

    public void setReviewCnt(Integer reviewCnt) {
        this.reviewCnt = reviewCnt;
    }

    public float getReviewScoreAvg() {
        return reviewScoreAvg;
    }

    public void setReviewScoreAvg(float reviewScoreAvg) {
        this.reviewScoreAvg = reviewScoreAvg;
    }

    public Integer getSpaceQuestionCnt() {
        return spaceQuestionCnt;
    }

    public void setSpaceQuestionCnt(Integer spaceQuestionCnt) {
        this.spaceQuestionCnt = spaceQuestionCnt;
    }

    public Integer getSpaceReadCnt() {
        return spaceReadCnt;
    }

    public void setSpaceReadCnt(Integer spaceReadCnt) {
        this.spaceReadCnt = spaceReadCnt;
    }

    public Integer getLikeyCnt() {
        return likeyCnt;
    }

    public void setLikeyCnt(Integer likeyCnt) {
        this.likeyCnt = likeyCnt;
    }

    public Integer getSpaceSort() {
        return spaceSort;
    }

    public void setSpaceSort(Integer spaceSort) {
        this.spaceSort = spaceSort;
    }

    public Integer getOffset() {
        return offset;
    }

    public void setOffset(Integer offset) {
        this.offset = offset;
    }

    public Integer getLimit() {
        return limit;
    }

    public void setLimit(Integer limit) {
        this.limit = limit;
    }

    public boolean getSpaceLiked() {
        return spaceLiked;
    }

    public void setSpaceLiked(boolean spaceLiked) {
        this.spaceLiked = spaceLiked;
    }

    public String getReservationWeek() {
        return reservationWeek;
    }

    public void setReservationWeek(String reservationWeek) {
        this.reservationWeek = reservationWeek;
    }

    public void setSpaceId(Long spaceId) {
	this.spaceId = spaceId;
    }

    public String getHostEmail() {
	return hostEmail;
    }

    public void setHostEmail(String hostEmail) {
	this.hostEmail = hostEmail;
    }

    public int getSpaceType() {
	return spaceType;
    }

    public void setSpaceType(int spaceType) {
	this.spaceType = spaceType;
    }

    public String getSpaceName() {
	return spaceName;
    }

    public void setSpaceName(String spaceName) {
	this.spaceName = spaceName;
    }

    public String getSpaceDesc() {
	return spaceDesc;
    }

    public void setSpaceDesc(String spaceDesc) {
	this.spaceDesc = spaceDesc;
    }

    public String getSpaceTip() {
	return spaceTip;
    }

    public void setSpaceTip(String spaceTip) {
	this.spaceTip = spaceTip;
    }

    public String getSpaceParking() {
	return spaceParking;
    }

    public void setSpaceParking(String spaceParking) {
	this.spaceParking = spaceParking;
    }

    public int getSpaceMaxCapacity() {
	return spaceMaxCapacity;
    }

    public void setSpaceMaxCapacity(int spaceMaxCapacity) {
	this.spaceMaxCapacity = spaceMaxCapacity;
    }

    public String getSpaceAddr() {
	return spaceAddr;
    }

    public void setSpaceAddr(String spaceAddr) {
	this.spaceAddr = spaceAddr;
    }

    public String getSpaceAddrDesc() {
	return spaceAddrDesc;
    }

    public void setSpaceAddrDesc(String spaceAddrDesc) {
	this.spaceAddrDesc = spaceAddrDesc;
    }

    public int getSpaceCloseDay() {
	return spaceCloseDay;
    }

    public void setSpaceCloseDay(int spaceCloseDay) {
	this.spaceCloseDay = spaceCloseDay;
    }

    public String getSpaceNotice() {
	return spaceNotice;
    }

    public void setSpaceNotice(String spaceNotice) {
	this.spaceNotice = spaceNotice;
    }

    public String getSpaceCloseDayHost() {
	return spaceCloseDayHost;
    }

    public void setSpaceCloseDayHost(String spaceCloseDayHost) {
	this.spaceCloseDayHost = spaceCloseDayHost;
    }

    public int getSpaceStartTime() {
	return spaceStartTime;
    }

    public void setSpaceStartTime(int spaceStartTime) {
	this.spaceStartTime = spaceStartTime;
    }

    public int getSpaceEndTime() {
	return spaceEndTime;
    }

    public void setSpaceEndTime(int spaceEndTime) {
	this.spaceEndTime = spaceEndTime;
    }

    public int getMinReservationTime() {
	return minReservationTime;
    }

    public void setMinReservationTime(int minReservationTime) {
	this.minReservationTime = minReservationTime;
    }

    public int getSpaceHourlyRate() {
	return spaceHourlyRate;
    }

    public void setSpaceHourlyRate(int spaceHourlyRate) {
	this.spaceHourlyRate = spaceHourlyRate;
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

}
