package com.sist.web.model;

import java.io.Serializable;

public class QuestionReport implements Serializable {
    private static final long serialVersionUID = 1L;

    private Long questionReportId; // QUESTION_REPORT_ID
    private Long spaceQuestionId; // SPACE_QUESTION_ID
    private String hostEmail; // HOST_EMAIL
    private String reportReason; // REPORT_REASON
    private String reportDate; // REPORT_DATE
    private String status; // STATUS

    // 기본 생성자 (필드 초기화)
    public QuestionReport() {
	this.questionReportId = null;
	this.spaceQuestionId = null;
	this.hostEmail = "";
	this.reportReason = "";
	this.reportDate = ""; // 현재 날짜로 초기화
	this.status = "N"; // 기본 상태값 (Active)
    }

    // Getter and Setter
    public Long getQuestionReportId() {
	return questionReportId;
    }

    public void setQuestionReportId(Long questionReportId) {
	this.questionReportId = questionReportId;
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

    public String getReportReason() {
	return reportReason;
    }

    public void setReportReason(String reportReason) {
	this.reportReason = reportReason;
    }

    public String getReportDate() {
	return reportDate;
    }

    public void setReportDate(String reportDate) {
	this.reportDate = reportDate;
    }

    public String getStatus() {
	return status;
    }

    public void setStatus(String status) {
	this.status = status;
    }

    // toString() 메서드 (디버깅 및 로깅에 유용)
    @Override
    public String toString() {
	return "QuestionReport{" + "questionReportId=" + questionReportId + ", spaceQuestionId=" + spaceQuestionId
		+ ", hostEmail='" + hostEmail + '\'' + ", reportReason='" + reportReason + '\'' + ", reportDate="
		+ reportDate + ", status='" + status + '\'' + '}';
    }
}
