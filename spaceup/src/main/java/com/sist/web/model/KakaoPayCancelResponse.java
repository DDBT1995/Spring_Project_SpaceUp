package com.sist.web.model;

import java.io.Serializable;

import com.sist.web.util.JsonUtil;

public class KakaoPayCancelResponse implements Serializable{

	private static final long serialVersionUID = 1L;

    private String aid;                       // 요청 고유 번호
    private String tid;                       // 결제 고유번호, 20자
    private String cid;                       // 가맹점 코드, 10자
    private String status;                    // 결제 상태
    private String partner_order_id;          // 가맹점 주문번호
    private String partner_user_id;           // 가맹점 회원 id
    private String payment_method_type;       // 결제 수단, CARD 또는 MONEY 중 하나
    private KakaoPayAmount amount;                    // 결제 금액
    private KakaoPayApprovedCancelAmount approved_cancel_amount; // 이번 요청으로 취소된 금액
    private KakaoPayCanceledAmount canceled_amount;   // 누계 취소 금액
    private KakaoPayCancelAvailableAmount cancel_available_amount; // 남은 취소 가능 금액
    private String item_name;                 // 상품 이름, 최대 100자
    private String item_code;                 // 상품 코드, 최대 100자
    private int quantity;                     // 상품 수량
    private String created_at;                // 결제 준비 요청 시각 (ISO 8601 문자열)
    private String approved_at;               // 결제 승인 시각 (ISO 8601 문자열)
    private String canceled_at;               // 결제 취소 시각 (ISO 8601 문자열)
    private String payload;                   // 취소 요청 시 전달한 값

    // 기본 생성자
    public KakaoPayCancelResponse() {
        aid = "";
        tid = "";
        cid = "";
        status = "";
        partner_order_id = "";
        partner_user_id = "";
        payment_method_type = "";
        amount = null;
        approved_cancel_amount = new KakaoPayApprovedCancelAmount();
        canceled_amount = new KakaoPayCanceledAmount();
        cancel_available_amount = new KakaoPayCancelAvailableAmount();
        item_name = "";
        item_code = "";
        quantity = 0;
        created_at = "";
        approved_at = "";
        canceled_at = null; // 취소되지 않은 경우 null
        payload = "";
    }

    // Getter 및 Setter
	public String getAid() {
		return aid;
	}

	public void setAid(String aid) {
		this.aid = aid;
	}

	public String getTid() {
		return tid;
	}

	public void setTid(String tid) {
		this.tid = tid;
	}

	public String getCid() {
		return cid;
	}

	public void setCid(String cid) {
		this.cid = cid;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public String getPartner_order_id() {
		return partner_order_id;
	}

	public void setPartner_order_id(String partner_order_id) {
		this.partner_order_id = partner_order_id;
	}

	public String getPartner_user_id() {
		return partner_user_id;
	}

	public void setPartner_user_id(String partner_user_id) {
		this.partner_user_id = partner_user_id;
	}

	public String getPayment_method_type() {
		return payment_method_type;
	}

	public void setPayment_method_type(String payment_method_type) {
		this.payment_method_type = payment_method_type;
	}

	public KakaoPayAmount getKakaoPayAmount() {
		return amount;
	}

	public void setKakaoPayAmount(KakaoPayAmount amount) {
		this.amount = amount;
	}

	public KakaoPayApprovedCancelAmount getApproved_cancel_amount() {
		return approved_cancel_amount;
	}

	public void setApproved_cancel_amount(KakaoPayApprovedCancelAmount approved_cancel_amount) {
		this.approved_cancel_amount = approved_cancel_amount;
	}

	public KakaoPayCanceledAmount getCanceled_amount() {
		return canceled_amount;
	}

	public void setCanceled_amount(KakaoPayCanceledAmount canceled_amount) {
		this.canceled_amount = canceled_amount;
	}

	public KakaoPayCancelAvailableAmount getCancel_available_amount() {
		return cancel_available_amount;
	}

	public void setCancel_available_amount(KakaoPayCancelAvailableAmount cancel_available_amount) {
		this.cancel_available_amount = cancel_available_amount;
	}

	public String getItem_name() {
		return item_name;
	}

	public void setItem_name(String item_name) {
		this.item_name = item_name;
	}

	public String getItem_code() {
		return item_code;
	}

	public void setItem_code(String item_code) {
		this.item_code = item_code;
	}

	public int getQuantity() {
		return quantity;
	}

	public void setQuantity(int quantity) {
		this.quantity = quantity;
	}

	public String getCreated_at() {
		return created_at;
	}

	public void setCreated_at(String created_at) {
		this.created_at = created_at;
	}

	public String getApproved_at() {
		return approved_at;
	}

	public void setApproved_at(String approved_at) {
		this.approved_at = approved_at;
	}

	public String getCanceled_at() {
		return canceled_at;
	}

	public void setCanceled_at(String canceled_at) {
		this.canceled_at = canceled_at;
	}

	public String getPayload() {
		return payload;
	}

	public void setPayload(String payload) {
		this.payload = payload;
	}
	
    @Override
    public String toString()
    {
       return JsonUtil.toJsonPretty(this);
    }
}
