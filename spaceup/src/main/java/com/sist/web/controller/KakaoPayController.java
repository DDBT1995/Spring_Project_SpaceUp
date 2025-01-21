package com.sist.web.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.google.gson.JsonObject;
import com.sist.common.util.StringUtil;
import com.sist.web.model.KakaoPayApproveRequest;
import com.sist.web.model.KakaoPayApproveResponse;
import com.sist.web.model.KakaoPayCancelRequest;
import com.sist.web.model.KakaoPayCancelResponse;
import com.sist.web.model.KakaoPayReadyRequest;
import com.sist.web.model.KakaoPayReadyResponse;
import com.sist.web.model.Payment;
import com.sist.web.model.Reservation;
import com.sist.web.model.Response;
import com.sist.web.service.KakaoPayService;
import com.sist.web.service.PaymentService;
import com.sist.web.service.ReservationService;
import com.sist.web.util.CookieUtil;
import com.sist.web.util.HttpUtil;
import com.sist.web.util.SessionUtil;

@Controller("kakaoPayController")
public class KakaoPayController {
    private static Logger logger = LoggerFactory.getLogger(KakaoPayController.class);

    @Autowired
    private KakaoPayService kakaoPayService;

    @Autowired
    private ReservationService reservationService;

    @Autowired
    private PaymentService paymentService;

    @Value("#{env['auth.cookie.name']}")
    private String AUTH_COOKIE_NAME;

    @Value("#{env['kakaopay.tid.session.name']}")
    private String KAKAOPAY_TID_SESSION_NAME;

    // Reservation 필요한 값
    long reservationId = 0; // 예약ID
    long spaceId = 0; // 공간ID
    String useDate = ""; // 이용 날짜
    int useStartTime = 0; // 이용 시작 시간
    int useEndTime = 0; // 이용 종료 시간
    int usePeople = 0; // 사용 인원 수
    String usePurpose = ""; // 사용 용도

    // Payment 필요한 값
    int amount = 0;

    // 카카오페이 결제 준비
    @RequestMapping(value = "/kakao/readyAjax", method = RequestMethod.POST)
    @ResponseBody
    public Response<JsonObject> readyAjax(HttpServletRequest request, HttpServletResponse response) {
	Response<JsonObject> res = new Response<JsonObject>();

	String cookieUserId = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);
	// ajax data값 (예약정보 가져온값)
	spaceId = HttpUtil.get(request, "spaceId", (long)0); // 공간ID
	useDate = HttpUtil.get(request, "useDate"); // 이용 날짜
	useStartTime = HttpUtil.get(request, "useStartTime", 0); // 이용 시작 시간
	useEndTime = HttpUtil.get(request, "useEndTime", 0); // 이용 종료 시간
	usePeople = HttpUtil.get(request, "usePeople", 0); // 사용 인원 수
	usePurpose = "1"; // 사용 용도

	amount = HttpUtil.get(request, "amount", 0); // 결제 금액(총금액)
	
	String spaceName = HttpUtil.get(request, "spaceName");

	// 1. Reservation Id 시퀀스값 생성
	reservationId = reservationService.seqSelect();


	if (reservationId > 0) {
	    KakaoPayReadyRequest kakaoPayReadyRequest = new KakaoPayReadyRequest();

	    kakaoPayReadyRequest.setPartner_order_id(reservationId + ""); // (필수)가맹점 주문번호, 최대 100자
	    kakaoPayReadyRequest.setPartner_user_id(cookieUserId); // (필수)회원id, 최대 100자 ---------임시(cookieuserid)
	    kakaoPayReadyRequest.setItem_name(spaceName); // (필수) 상품명 ----------임시
	    kakaoPayReadyRequest.setItem_code(spaceId + ""); // (필수아님) 상품코드(SPACE_ID) --------임시
	    kakaoPayReadyRequest.setQuantity(1); // (필수)상품수량
	    kakaoPayReadyRequest.setTotal_amount(amount); // (필수)상품 총액(AMOUNT) -------임시
	    kakaoPayReadyRequest.setTax_free_amount(0); // (필수)상품 비과세 금액

	    // 카카오페이 연동 시작
	    logger.debug("00000000000000000000000");

	    KakaoPayReadyResponse kakaoPayReadyResponse = kakaoPayService.ready(kakaoPayReadyRequest);

	    // response 셋팅하고 리턴
	    if (kakaoPayReadyResponse != null) {
		// 카카오페이 트랜잭션 아이디 세션 저장
		HttpSession session = request.getSession(true);
		SessionUtil.setSession(session, KAKAOPAY_TID_SESSION_NAME, kakaoPayReadyResponse.getTid());

		JsonObject json = new JsonObject();

		json.addProperty("next_redirect_app_url", kakaoPayReadyResponse.getNext_redirect_app_url());
		json.addProperty("next_redirect_mobile_url", kakaoPayReadyResponse.getNext_redirect_mobile_url());
		json.addProperty("next_redirect_pc_url", kakaoPayReadyResponse.getNext_redirect_pc_url());
		json.addProperty("android_app_scheme", kakaoPayReadyResponse.getAndroid_app_scheme());
		json.addProperty("ios_app_scheme", kakaoPayReadyResponse.getIos_app_scheme());
		json.addProperty("created_at", kakaoPayReadyResponse.getCreated_at());

		res.setResponse(0, "success", json);
	    } else {
		res.setResponse(-1, "카카오페이 결제 준비 중 오류가 발생하였습니다.", null);
	    }

	} else {
	    res.setResponse(-5, "카카오페이 결제 준비 중 오류가 발생하였습니다(5).", null);
	}

	logger.debug("33333333333333333333333");

	return res;
    }

    // 카카오페이 결제 승인
    @RequestMapping(value = "/order/kakaoPay/success", method = RequestMethod.GET)
    public String success(Model model, HttpServletRequest request, HttpServletResponse response) {
	String cookieUserId = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);
	String pgToken = HttpUtil.get(request, "pg_token");
	String tid = null;

	HttpSession session = request.getSession(false);
	if (session != null) {
	    tid = (String) SessionUtil.getSession(session, KAKAOPAY_TID_SESSION_NAME);
	}

	logger.info("pg_token : [{}]", pgToken);
	logger.info("tid      : [{}]", tid);

	if (StringUtil.isEmpty(pgToken) || StringUtil.isEmpty(tid)) {
	    model.addAttribute("code", -1);
	    model.addAttribute("msg", "결제에 필요한 데이터가 누락되었습니다.");
	    return "/space/paymentResult";
	}

	try {

	    // 1. KakaoPayApproveRequest 객체 생성
	    KakaoPayApproveRequest kakaoPayApproveRequest = new KakaoPayApproveRequest();
	    kakaoPayApproveRequest.setTid(tid);
	    kakaoPayApproveRequest.setPartner_order_id(reservationId + "");
	    kakaoPayApproveRequest.setPartner_user_id(cookieUserId); // 사용자 ID(쿠키)
	    kakaoPayApproveRequest.setPg_token(pgToken);

	    // 2. Reservation 객체 생성
	    Reservation reservation = new Reservation();
	    reservation.setReservationId(reservationId); // 예약ID
	    reservation.setSpaceId(spaceId); // 공간ID
	    reservation.setGuestEmail(cookieUserId); // 구매자 이메일-------------------
	    reservation.setUseDate(useDate); // 이용 날짜
	    reservation.setUseStartTime(useStartTime); // 이용 시작 시간
	    reservation.setUseEndTime(useEndTime); // 이용 종료 시간
	    reservation.setUsePeople(usePeople); // 사용 인원 수
	    reservation.setUsePurpose(usePurpose); // 사용 용도
	    reservation.setStatus("P"); // 예약상태 (진행중)

	    // 3. Payment 객체 생성
	    Payment payment = new Payment();
	    payment.setReservationId(reservationId);
	    payment.setPaymentMethod("카카오페이");
	    payment.setStatus("Y");
	    payment.setAmount(amount);
	    payment.setKakaoTid(tid);

	    if (kakaoPayApproveRequest != null && reservation != null && payment != null) // 값 존재 여부 확인
	    {
		// 4. Service 호출
		KakaoPayApproveResponse kakaoPayApproveResponse = paymentService.processPayment(reservation, payment,
			kakaoPayApproveRequest);

		if (kakaoPayApproveResponse != null && kakaoPayApproveResponse.getError_code() == 0) {
		    model.addAttribute("code", 0);
		    model.addAttribute("msg", "카카오페이 결제가 완료되었습니다.");
		    model.addAttribute("reservationId", reservationId);
		} else {
		    model.addAttribute("code", -2);
		    model.addAttribute("msg",
			    kakaoPayApproveResponse != null ? kakaoPayApproveResponse.getError_message()
				    : "결제 처리 중 알 수 없는 오류가 발생했습니다.");
		}
	    } else {
		model.addAttribute("code", -4);
		model.addAttribute("msg", "결제 정보가 존재하지 않습니다.");
	    }
	} catch (Exception e) {
	    logger.error("결제 처리 중 오류 발생: {}", e.getMessage(), e);
	    model.addAttribute("code", -3);
	    model.addAttribute("msg", "결제 처리 중 오류가 발생했습니다.");
	} finally {
	    if (!StringUtil.isEmpty(tid) && session != null) {
		SessionUtil.removeSession(session, KAKAOPAY_TID_SESSION_NAME);
	    }
	}

	return "/space/paymentResult";
    }

    // 카카오페이 결제 취소
    @RequestMapping(value = "/order/kakaoPay/cancel", method = RequestMethod.GET)
    public String cancel(Model model, HttpServletRequest request, HttpServletResponse response) {
	String tid = null;

	HttpSession session = request.getSession(false);

	if (session != null) {
	    tid = (String) SessionUtil.getSession(session, KAKAOPAY_TID_SESSION_NAME);

	    if (!StringUtil.isEmpty(tid)) {
		// tid 세션 삭제
		SessionUtil.removeSession(session, KAKAOPAY_TID_SESSION_NAME);

		// 취소처리 DB작업 필요
	    }
	}

	// 취소
	model.addAttribute("code", -2);
	model.addAttribute("msg", "카카오페이 결제가 취소 되었습니다.");

	return "/space/paymentResult";
    }

    // 카카오페이 결제 실패
    @RequestMapping(value = "/order/kakaoPay/fail", method = RequestMethod.GET)
    public String fail(Model model, HttpServletRequest request, HttpServletResponse response) {
	String tid = null;

	HttpSession session = request.getSession(false);

	if (session != null) {
	    tid = (String) SessionUtil.getSession(session, KAKAOPAY_TID_SESSION_NAME);

	    if (!StringUtil.isEmpty(tid)) {
		// tid 세션 삭제
		SessionUtil.removeSession(session, KAKAOPAY_TID_SESSION_NAME);

		// 실패시 DB작업 필요
	    }
	}

	// 취소
	model.addAttribute("code", -3);
	model.addAttribute("msg", "카카오페이 결제가 실패 하였습니다.");

	return "/space/paymentResult";
    }

    // 카카오페이 결제취소 (환불)
    @RequestMapping(value = "/order/kakaoPay/refund", method = RequestMethod.POST)
    @CrossOrigin(origins = "http://spaceuphostcenter.sist.co.kr:8088") // 필요한 도메인으로 제한 가능
    @ResponseBody
    public Response<JsonObject> refundAjax(HttpServletRequest request, HttpServletResponse response) {
	Response<JsonObject> res = new Response<JsonObject>();

	
	String cookieUserId = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME); // 쿠키아이디 존재하지 않을시 결제취소 불가.. 예외처리
	
	String deleteReason = HttpUtil.get(request, "deleteReason");
	
	// 결제 ID
	long paymentId = HttpUtil.get(request, "paymentId", (long) 0); // 결제아이디로 결제정보 불로오기
	Payment payment = null;

	logger.info("paymentId : [" + paymentId + "]");

	if (paymentId > 0) {
	    KakaoPayCancelRequest kakaoPayCancelRequest = new KakaoPayCancelRequest();

	    payment = paymentService.paymentSelect(paymentId); // DB에서 결제아이디로 결제정보 불러오기

	    logger.info("paymentId : [" + paymentId + "]22222222222222222");

	    if (payment != null) {

		logger.info("paymentId : [" + payment.getStatus() + "]333333333333");

		if (StringUtil.equals(payment.getStatus(), "Y")) {
		    logger.info("444444444444444444paymentId : [" + paymentId + "]4444444");
		    logger.info("paymentId : [" + payment.getKakaoTid() + "]5555555555555");
		    kakaoPayCancelRequest.setTid(payment.getKakaoTid()); // 결제고유번호 tid
		    kakaoPayCancelRequest.setCancel_amount(payment.getAmount()); // 취소 금액
		    kakaoPayCancelRequest.setCancel_tax_free_amount(0); // 취소 비과세 금액

		    // 결제 취소 요청
		    KakaoPayCancelResponse kakaoPayCancelResponse = kakaoPayService.cancel(kakaoPayCancelRequest);

		    if (kakaoPayCancelResponse != null) {
			logger.info("[OrderKakaoPayController] approve kakaoPayCancelResponse : \n"
				+ kakaoPayCancelResponse);

			// 성공(DB작업)
			try {
			    if (paymentService.paymentCancel(payment.getReservationId(), paymentId, deleteReason) > 0) {
				res.setResponse(0, "결제취소 성공");
			    }
			} catch (Exception e) {
			    e.printStackTrace();
			}
		    } else { // 실패 (결제ID값 없음)
			res.setResponse(-1, "카카오페이 결제 취소 중 오류가 발생하였습니다.", null);
		    }
		} else { // 이미 삭제된 건
		    res.setResponse(-2, "이미 취소된 결제입니다.", null);
		}
	    } else { // 해당하는 payment 존재 X
		res.setResponse(-3, "카카오페이 결제 취소 중 오류가 발생하였습니다.(2)", null);
	    }
	}

	return res;
    }

}
