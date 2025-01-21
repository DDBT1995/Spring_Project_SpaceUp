package com.sist.web.service;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.sist.web.dao.PaymentDao;
import com.sist.web.dao.ReservationDao;
import com.sist.web.model.KakaoPayApproveRequest;
import com.sist.web.model.KakaoPayApproveResponse;
import com.sist.web.model.Payment;
import com.sist.web.model.Reservation;

@Service("paymentService")
public class PaymentService {
    private static Logger logger = LoggerFactory.getLogger(ReservationService.class);

    @Autowired
    private PaymentDao paymentDao;

    @Autowired
    private ReservationDao reservationDao;

    @Autowired
    private KakaoPayService kakaoPayService;

    @Autowired
    private MailService mailService;

    public Payment paymentSelectByReservationId(long reservationId) {
	Payment payment = null;
	try {
	    payment = paymentDao.paymentSelectByReservationId(reservationId);
	} catch (Exception e) {
	    logger.error("[paymentService] paymentSelectByReservationId Exception", e);
	}
	return payment;
    }

    // 예약 등록
    @Transactional(propagation = Propagation.REQUIRED, rollbackFor = Exception.class)
    public KakaoPayApproveResponse processPayment(Reservation reservation, Payment payment,
	    KakaoPayApproveRequest kakaoPayApproveRequest) throws Exception {

	// 1. 카카오페이 승인 요청
	KakaoPayApproveResponse kakaoPayApproveResponse = kakaoPayService.approve(kakaoPayApproveRequest);
	if (kakaoPayApproveResponse == null || kakaoPayApproveResponse.getError_code() != 0) {
	    throw new RuntimeException("KakaoPay approval failed: "
		    + (kakaoPayApproveResponse != null ? kakaoPayApproveResponse.getError_message() : "Unknown error"));
	}

	// 2. 예약 생성
	int reservationResult = reservationDao.reservationInsert(reservation);
	if (reservationResult <= 0) {
	    throw new RuntimeException("Reservation creation failed: reservationId not generated");
	}

	// 3. 결제 데이터 생성
	int paymentResult = paymentDao.paymentInsert(payment);
	if (paymentResult <= 0) {
	    throw new RuntimeException("Payment record creation failed");
	}
	if (reservationResult > 0 && paymentResult > 0) {

	    String title = "SpaceUp 예약 완료";
	    String content = "<div style='font-family: Arial, sans-serif; background-color: #f9f9f9; padding: 30px;'>"
		    + "<table align='center' cellpadding='0' cellspacing='0' style='max-width: 600px; width: 100%; background-color: #ffffff; border: 1px solid #eaeaea;'>"
		    + "<tr>" + "<td style='text-align: center; padding: 20px;'>"
		    + "<img src=\"https://i.imgur.com/kbS8igq.png\" alt=\"SpaceUp\" style=\"width: 150px; margin-bottom: -30px;\">\n"
		    + "</td>" + "</tr>" + "<tr>"
		    + "<td style='padding: 20px; text-align: center; color: #333; font-size: 16px; line-height: 1.5;'>"
		    + "<h2 style='color: #333;'>예약 안내문</h2>" + "<p>안녕하세요, 고객님.\n" + "<br>"
		    + "<p>아래 예약 번호와 관련된 예약이 성공적으로 예약되었습니다.\n" + "<br>" + "<br>" + "스페이스업 바로가기 : \n"
		    + "<a href=\"http://spaceup.sist.co.kr:8088/space/spaceMain\" \r\n>"
		    + "http://spaceup.sist.co.kr:8088/space/spaceMain</a></p>" + "</td>" + "</tr>" + "<tr>"
		    + "<td style='text-align: center; padding: 20px;'>"
		    + "<span style='display: inline-block; background-color: #3dc4a3; padding: 10px 20px; font-size: 22px; font-weight: bold; color: #fff; border: 1px solid #3dc4a3;'>\n"
		    + "예약 번호: " + reservation.getReservationId() + "\n" + "</span>" + "</td>" + "</tr>" + "<tr>"
		    + "<td style='padding: 20px; text-align: center; color: #888; font-size: 12px; line-height: 1.5;'>"
		    + "<p>본 메일은 정보통신망 이용촉진 및 정보보호 등에 관한 법률 시행규칙 제 11조 3항에 의거<br>"
		    + "귀하의 요청에 의해 발송된 메일입니다. 발신 전용 메일이므로 회신을 통한 문의는 처리되지 않습니다.</p>"
		    + "<p>문의사항은 <a href='mailto:team@spaceup.co.kr' style='color: #2575fc;'>team@spaceup.co.kr</a>로 문의해주세요.</p>"
		    + "</td>" + "</tr>" + "<tr>"
		    + "<td style='background-color: #f1f1f1; color: #888; font-size: 12px; text-align: center; padding: 10px;'>"
		    + "(주)spaceUp | 서울특별시 마포구 월드컵북로 21 풍성빌딩 쌍용강북교육센터<br>"
		    + "사업자 등록번호 214-85-29296 | 이메일 <a href='mailto:team@spaceup.co.kr' style='color: #2575fc;'>team@spaceup.co.kr</a><br>"
		    + "© spaceUp Inc. All Rights Reserved." + "</td>" + "</tr>" + "</table>" + "</div>";

	    mailService.sendMail(reservation.getGuestEmail(), title, content);
	}

	// 성공적으로 완료된 경우 승인 응답 반환
	return kakaoPayApproveResponse;
    }

    // 결제정보 호출
    public Payment paymentSelect(long paymentId) {
	Payment payment = null;

	try {
	    payment = paymentDao.paymentSelect(paymentId);
	} catch (Exception e) {
	    logger.error("[PaymentService] tidSelect Exception", e);
	}

	return payment;
    }

    // 결제 취소(환불)
    @Transactional(propagation = Propagation.REQUIRED, rollbackFor = Exception.class)
    public int paymentCancel(long reservationId, long paymentId, String deleteReason) throws Exception {
	int reservCount = reservationDao.cancelReservation(reservationId);
	int paymentCount = 0;

	if (reservCount > 0) {
	    paymentCount = paymentDao.paymentCancel(paymentId);
	}

	if (paymentCount > 0) {
	    Reservation reservation = reservationDao.reservationSelect(reservationId);
	    Payment payment = paymentDao.paymentSelect(paymentId);

	    String title = "";
	    String content = "";

	    if (deleteReason != null && deleteReason != "") {
		title = "SpaceUp 예약취소";
		content = "<div style='font-family: Arial, sans-serif; background-color: #f9f9f9; padding: 30px;'>"
			+ "<table align='center' cellpadding='0' cellspacing='0' style='max-width: 600px; width: 100%; background-color: #ffffff; border: 1px solid #eaeaea;'>"
			+ "<tr>" + "<td style='text-align: center; padding: 20px;'>"
			+ "<img src=\"https://i.imgur.com/kbS8igq.png\" alt=\"SpaceUp\" style=\"width: 150px; margin-bottom: -30px;\">\n"
			+ "</td>" + "</tr>" + "<tr>"
			+ "<td style='padding: 20px; text-align: center; color: #333; font-size: 16px; line-height: 1.5;'>"
			+ "<h2 style='color: #333;'>예약취소 안내문</h2>" + "<p>안녕하세요, 고객님.\n" + "<br>"
			+ "<p>아래 예약 번호와 관련된 예약이 성공적으로 취소되었습니다.\n" + "<br>" + "<br>" + "스페이스업 바로가기 : \n"
			+ "<a href=\"http://spaceup.sist.co.kr:8088/space/spaceMain\" \r\n>"
			+ "http://spaceup.sist.co.kr:8088/space/spaceMain</a></p>" + "</td>" + "</tr>" + "<tr>"
			+ "<td style='text-align: center; padding: 20px;'>"
			+ "<span style='display: inline-block; background-color: #fc514e; padding: 10px 20px; font-size: 22px; font-weight: bold; color: #fff; border: 1px solid #fc514e;'>\n"
			+ "예약 번호: " + reservation.getReservationId() + "\n" + "</span>" + "</td>" + "</tr>" + "<tr>"
			+ "<td style='padding: 20px; text-align: center; color: #888; font-size: 12px; line-height: 1.5;'>"
			+ "<p>본 메일은 정보통신망 이용촉진 및 정보보호 등에 관한 법률 시행규칙 제 11조 3항에 의거<br>"
			+ "귀하의 요청에 의해 발송된 메일입니다. 발신 전용 메일이므로 회신을 통한 문의는 처리되지 않습니다.</p>"
			+ "<p>문의사항은 <a href='mailto:team@spaceup.co.kr' style='color: #2575fc;'>team@spaceup.co.kr</a>로 문의해주세요.</p>"
			+ "</td>" + "</tr>" + "<tr>"
			+ "<td style='background-color: #f1f1f1; color: #888; font-size: 12px; text-align: center; padding: 10px;'>"
			+ "(주)spaceUp | 서울특별시 마포구 월드컵북로 21 풍성빌딩 쌍용강북교육센터<br>"
			+ "사업자 등록번호 214-85-29296 | 이메일 <a href='mailto:team@spaceup.co.kr' style='color: #2575fc;'>team@spaceup.co.kr</a><br>"
			+ "© spaceUp Inc. All Rights Reserved." + "</td>" + "</tr>" + "</table>" + "</div>";
	    } else {
		title = "SpaceUp 예약취소";
		content = "<div style='font-family: Arial, sans-serif; background-color: #f9f9f9; padding: 30px;'>"
			+ "<table align='center' cellpadding='0' cellspacing='0' style='max-width: 600px; width: 100%; background-color: #ffffff; border: 1px solid #eaeaea;'>"
			+ "<tr>" + "<td style='text-align: center; padding: 20px;'>"
			+ "<img src=\"https://i.imgur.com/kbS8igq.png\" alt=\"SpaceUp\" style=\"width: 150px; margin-bottom: -30px;\">\n"
			+ "</td>" + "</tr>" + "<tr>"
			+ "<td style='padding: 20px; text-align: center; color: #333; font-size: 16px; line-height: 1.5;'>"
			+ "<h2 style='color: #333;'>예약취소 안내문</h2>" + "<p>안녕하세요, 고객님.\n" + "<br>"
			+ "<p>아래 예약 번호와 관련된 예약이 성공적으로 취소되었습니다.\n" + "<br>" + "<br>" + "스페이스업 바로가기 : \n"
			+ "<a href=\"http://spaceup.sist.co.kr:8088/space/spaceMain\" \r\n>"
			+ "http://spaceup.sist.co.kr:8088/space/spaceMain</a></p>" + "</td>" + "</tr>" + "<tr>"
			+ "<td style='text-align: center; padding: 20px;'>"
			+ "<span style='display: inline-block; background-color: #fc514e; padding: 10px 20px; font-size: 22px; font-weight: bold; color: #fff; border: 1px solid #fc514e;'>\n"
			+ "예약 번호: " + reservation.getReservationId() + "\n" + "</span>" + "</td>" + "</tr>" + "<tr>"
			+ "<td style='padding: 20px; text-align: center; color: #888; font-size: 12px; line-height: 1.5;'>"
			+ "<p>본 메일은 정보통신망 이용촉진 및 정보보호 등에 관한 법률 시행규칙 제 11조 3항에 의거<br>"
			+ "귀하의 요청에 의해 발송된 메일입니다. 발신 전용 메일이므로 회신을 통한 문의는 처리되지 않습니다.</p>"
			+ "<p>문의사항은 <a href='mailto:team@spaceup.co.kr' style='color: #2575fc;'>team@spaceup.co.kr</a>로 문의해주세요.</p>"
			+ "</td>" + "</tr>" + "<tr>"
			+ "<td style='background-color: #f1f1f1; color: #888; font-size: 12px; text-align: center; padding: 10px;'>"
			+ "(주)spaceUp | 서울특별시 마포구 월드컵북로 21 풍성빌딩 쌍용강북교육센터<br>"
			+ "사업자 등록번호 214-85-29296 | 이메일 <a href='mailto:team@spaceup.co.kr' style='color: #2575fc;'>team@spaceup.co.kr</a><br>"
			+ "© spaceUp Inc. All Rights Reserved." + "</td>" + "</tr>" + "</table>" + "</div>";
	    }

	    mailService.sendMail(reservation.getGuestEmail(), title, content);
	}
	return paymentCount;
    }
}
