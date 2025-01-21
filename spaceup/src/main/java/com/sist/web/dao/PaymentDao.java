package com.sist.web.dao;

import org.springframework.stereotype.Repository;

import com.sist.web.model.Payment;

@Repository("paymentDao")
public interface PaymentDao {
    public Payment paymentSelectByReservationId(long reservationId);

    // 결제 등록
    public int paymentInsert(Payment payment);

    // 결제정보 호출
    public Payment paymentSelect(long paymentId);

    // 결제 취소(환불)
    public int paymentCancel(long paymentId);
}
