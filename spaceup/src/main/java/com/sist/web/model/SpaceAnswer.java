package com.sist.web.model;

import java.io.Serializable;

public class SpaceAnswer implements Serializable {

    private static final long serialVersionUID = 1L;

    private Long spaceAnswerId; // SPACE_ANSWER_ID
    private Long spaceQuestionId; // SPACE_QUESTION_ID
    private String hostEmail; // HOST_EMAIL
    private String answerContent; // ANSWER_CONTENT
    private String status; // STATUS
    private String regDate; // REG_DATE
    private String modiDate; // MODI_DATE
    private String delDate; // DEL_DATE
    
    private String hostNickname;

    public SpaceAnswer() {
	spaceAnswerId = 0L;
	spaceQuestionId = 0L;
	hostEmail = "";
	answerContent = "";
	status = "";
	regDate = "";
	modiDate = "";
	delDate = "";
	hostNickname = "";
    }

    public String getHostNickname() {
	return hostNickname;
    }

    public void setHostNickname(String hostNickname) {
	this.hostNickname = hostNickname;
    }

    public Long getSpaceAnswerId() {
	return spaceAnswerId;
    }

    public void setSpaceAnswerId(Long spaceAnswerId) {
	this.spaceAnswerId = spaceAnswerId;
    }

    public Long getSpaceQuestionId() {
	return spaceQuestionId;
    }

    public void setSpaceQuestionId(Long spaceQuestionId) {
	this.spaceQuestionId = spaceQuestionId;
    }

    public String getHostEmail() {
	return hostEmail;
    }

    public void setHostEmail(String hostEmail) {
	this.hostEmail = hostEmail;
    }

    public String getAnswerContent() {
	return answerContent;
    }

    public void setAnswerContent(String answerContent) {
	this.answerContent = answerContent;
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
