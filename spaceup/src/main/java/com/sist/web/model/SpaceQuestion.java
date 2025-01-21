package com.sist.web.model;

import java.io.Serializable;

public class SpaceQuestion implements Serializable {

    private static final long serialVersionUID = 1L;

    private Long spaceQuestionId; // SPACE_QUESTION_ID
    private String guestEmail; // GUEST_EMAIL
    private Long spaceId; // SPACE_ID
    private String questionContent; // QUESTION_CONTENT (CLOB 타입은 String으로 매핑)
    private Integer questionCategory; // QUESTION_CATEGORY
    private String status; // STATUS (CHAR 타입은 String으로 매핑)
    private String regDate; // REG_DATE
    private String modiDate; // MODI_DATE
    private String delDate; // DEL_DATE
    
    private String guestNickname;
    private String spaceName;
    private String spaceTip;
    private Integer spaceType;
    private SpaceAnswer spaceAnswer;

    private long startRow; // 시작 페이지 rownum
    private long endRow; // 끝 페이지 rownum

    public SpaceQuestion() {
	spaceQuestionId = 0L;
	guestEmail = "";
	spaceId = 0L;
	questionContent = "";
	questionCategory = 0;
	status = "";
	regDate = "";
	modiDate = "";
	delDate = "";
	spaceName = "";
	spaceTip = "";
	spaceType = 0;
	spaceAnswer = null;
	guestNickname = "";
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

    public SpaceAnswer getSpaceAnswer() {
	return spaceAnswer;
    }

    public void setSpaceAnswer(SpaceAnswer spaceAnswer) {
	this.spaceAnswer = spaceAnswer;
    }

    public String getSpaceTip() {
	return spaceTip;
    }

    public void setSpaceTip(String spaceTip) {
	this.spaceTip = spaceTip;
    }

    public Integer getSpaceType() {
		return spaceType;
	}

	public void setSpaceType(Integer spaceType) {
		this.spaceType = spaceType;
	}

	public String getSpaceName() {
	return spaceName;
    }

    public void setSpaceName(String spaceName) {
	this.spaceName = spaceName;
    }

    public Long getSpaceQuestionId() {
	return spaceQuestionId;
    }

    public void setSpaceQuestionId(Long spaceQuestionId) {
	this.spaceQuestionId = spaceQuestionId;
    }

    public String getGuestEmail() {
	return guestEmail;
    }

    public void setGuestEmail(String guestEmail) {
	this.guestEmail = guestEmail;
    }

    public Long getSpaceId() {
	return spaceId;
    }

    public void setSpaceId(Long spaceId) {
	this.spaceId = spaceId;
    }

    public String getQuestionContent() {
	return questionContent;
    }

    public void setQuestionContent(String questionContent) {
	this.questionContent = questionContent;
    }

    public Integer getQuestionCategory() {
	return questionCategory;
    }

    public void setQuestionCategory(Integer questionCategory) {
	this.questionCategory = questionCategory;
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
