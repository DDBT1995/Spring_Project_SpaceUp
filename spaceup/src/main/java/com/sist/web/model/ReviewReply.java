package com.sist.web.model;

import java.io.Serializable;

public class ReviewReply implements Serializable {
	private static final long serialVersionUID = 1L;
	
	private Long replyId;
    private Long reviewId;
    private String hostEmail;
    private String replyContent;
    private String status;
    private String regDate;
    private String modiDate;
    private String delDate;

    private String hostNickname;

    public ReviewReply() {
	replyId = (long) 0;
	reviewId = (long) 0;
	hostEmail = "";
	replyContent = "";
	status = "";
	regDate = "";
	modiDate = "";
	delDate = "";

	hostNickname = "";
    }

    public Long getReplyId() {
	return replyId;
    }

    public void setReplyId(Long replyId) {
	this.replyId = replyId;
    }

    public Long getReviewId() {
	return reviewId;
    }

    public void setReviewId(Long reviewId) {
	this.reviewId = reviewId;
    }

    public String getHostEmail() {
	return hostEmail;
    }

    public void setHostEmail(String hostEmail) {
	this.hostEmail = hostEmail;
    }

    public String getReplyContent() {
	return replyContent;
    }

    public void setReplyContent(String replyContent) {
	this.replyContent = replyContent;
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

    public String getHostNickname() {
	return hostNickname;
    }

    public void setHostNickname(String hostNickname) {
	this.hostNickname = hostNickname;
    }

}
