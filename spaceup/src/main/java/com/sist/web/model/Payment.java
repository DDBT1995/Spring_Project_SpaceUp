package com.sist.web.model;

import java.io.Serializable;

public class Payment implements Serializable {
	
	private static final long serialVersionUID = 1L;
	
	private long paymentId;			//결제ID (seq)
	private long reservationId;		//예약ID (seq)
	private String paymentMethod;	//결제 수단 (카카오페이, 토스, 신용카드..)
	private String status;				//결제 상태 (Y: 완료, N: 취소, P: 대기)
	private String regDate;			//결제 일시
	private String delDate;			//결제 취소 일시
	private int amount;			//결제 금액
	private String kakaoTid;		//결제 취소를 위한 해당 결제의 TID
	
	public Payment()
	{
		paymentId = 0;
		reservationId = 0;
		paymentMethod = "";
		status = "";
		regDate = "";
		delDate = "";
		amount = 0;
		kakaoTid = "";
	}

	public long getPaymentId() {
		return paymentId;
	}

	public void setPaymentId(long paymentId) {
		this.paymentId = paymentId;
	}

	public long getReservationId() {
		return reservationId;
	}

	public void setReservationId(long reservationId) {
		this.reservationId = reservationId;
	}

	public String getPaymentMethod() {
		return paymentMethod;
	}

	public void setPaymentMethod(String paymentMethod) {
		this.paymentMethod = paymentMethod;
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

	public String getDelDate() {
		return delDate;
	}

	public void setDelDate(String delDate) {
		this.delDate = delDate;
	}

	public int getAmount() {
		return amount;
	}

	public void setAmount(int amount) {
		this.amount = amount;
	}

	public String getKakaoTid() {
		return kakaoTid;
	}

	public void setKakaoTid(String kakaoTid) {
		this.kakaoTid = kakaoTid;
	}
	
	
}
