package com.sist.web.controller;

import java.io.File;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

import javax.mail.MessagingException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.sist.common.model.FileData;
import com.sist.common.util.StringUtil;
import com.sist.web.model.Guest;
import com.sist.web.model.Paging;
import com.sist.web.model.Payment;
import com.sist.web.model.Reservation;
import com.sist.web.model.Response;
import com.sist.web.model.Review;
import com.sist.web.model.Space;
import com.sist.web.model.SpaceLikey;
import com.sist.web.model.SpaceQuestion;
import com.sist.web.service.GuestService;
import com.sist.web.service.PaymentService;
import com.sist.web.service.ReservationService;
import com.sist.web.service.ReviewService;
import com.sist.web.service.SpaceAnswerService;
import com.sist.web.service.SpaceLikeyService;
import com.sist.web.service.SpaceQuestionService;
import com.sist.web.service.SpaceService;
import com.sist.web.util.CookieUtil;
import com.sist.web.util.HttpUtil;
import com.sist.web.util.JsonUtil;

@Controller("guestController")
public class GuestController {
    private static Logger logger = LoggerFactory.getLogger(GuestController.class);

    @Autowired
    private GuestService guestService;

    @Autowired
    private ReservationService reservationService;

    @Autowired
    private SpaceService spaceService;

    @Autowired
    private SpaceQuestionService spaceQuestionService;

    @Autowired
    private SpaceAnswerService spaceAnswerService;

    @Autowired
    private ReviewService reviewService;

    @Autowired
    private PaymentService paymentService;

    @Autowired
    private SpaceLikeyService spaceLikeyService;

    @Value("#{env['auth.cookie.name']}")
    private String AUTH_COOKIE_NAME;

    @Value("#{env['upload.save.guest.dir']}")
    private String UPLOAD_GUEST_SAVE_DIR;

    private static final int QnA_LIST_COUNT = 3;
    private static final int QnA_PAGE_COUNT = 5;

    private static final int Reserv_LIST_COUNT = 6;
    private static final int Reserv_PAGE_COUNT = 3;

    private static final int REVIEW_LIST_COUNT = 3; // 한 페이지의 게시물 수
    private static final int REVIEW_PAGE_COUNT = 3; // 페이징 수

    private static final int LIKEY_LIST_COUNT = 6;
    private static final int LIKEY_PAGE_COUNT = 3;

    // 리뷰 작성 aJax
    @RequestMapping(value = "/guest/insertReview", method = RequestMethod.POST)
    @ResponseBody
    public Response<Object> insertReview(HttpServletRequest request, HttpServletResponse response) {
	Response<Object> res = new Response<Object>();

	String cookieUserId = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);

	long reservationId = HttpUtil.get(request, "reservationId", (long) 0);
	String reviewContent = HttpUtil.get(request, "reviewContent", "");
	int reviewScore = HttpUtil.get(request, "reviewScore", (int) 1);

	logger.debug("============================");
	logger.debug("reservationId : " + reservationId);
	logger.debug("reviewScore : " + reviewScore);
	logger.debug("============================");

	if (!StringUtil.isEmpty(cookieUserId)) { // 로그인
	    if (reservationId > 0) { // 예약 내역이 있는 경우
		Review review = new Review();

		review.setGuestEmail(cookieUserId);
		review.setReservationId(reservationId);
		review.setReviewContent(reviewContent.replace("\n", "<br>"));
		review.setReviewScore(reviewScore);
		review.setStatus("Y");

		logger.debug("=====*====*=======*====*=====*===");
		logger.debug("cookieUserId : " + cookieUserId);
		logger.debug("reviewContent : " + reviewContent);
		logger.debug("reviewScore : " + reviewScore);
		logger.debug("======*====*===*=====*====*======");

		if (reviewService.insertReview(review) > 0) {
		    res.setResponse(0, "Review insert success");
		} else {
		    res.setResponse(500, "Internal server error");
		}
	    } else { // 예약 내역이 없는 경우
		res.setResponse(404, "Reservation not found");
	    }
	} else { // 미로그인
	    res.setResponse(410, "Not logged in");
	}

	return res;
    }

    // 공간 좋아요 등록 및 취소 aJax
    @RequestMapping(value = "/guest/addLikey", method = RequestMethod.POST)
    @ResponseBody
    public Response<Object> addLikey(HttpServletRequest request, HttpServletResponse response) {
	Response<Object> res = new Response<Object>();

	String cookieUserEmail = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);
	long spaceId = HttpUtil.get(request, "spaceId", (long) 0);

	if (spaceId > 0) { // 공간 ID가 있음
	    if (!StringUtil.isEmpty(cookieUserEmail)) // 나중에 cookieUserId
	    { // 로그인 됨
		SpaceLikey spaceLikey = new SpaceLikey();

		spaceLikey.setSpaceId(spaceId);
		spaceLikey.setGuestEmail(cookieUserEmail); // 나중에 cookieUserId

		try {
		    int likeStatus = spaceLikeyService.checkLikey(spaceLikey);

		    if (likeStatus == 1) { // 이미 좋아요된 상태라서 취소
			if (spaceLikeyService.deleteLikey(spaceLikey) > 0) {
			    res.setResponse(0, "Delete likey success");
			} else {
			    res.setResponse(500, "Delete likey Internal Server Error");
			}
		    } else if (likeStatus == 0) { // 중복체크해서 0이면 등록
			if (spaceLikeyService.addLikey(spaceLikey) > 0) {
			    res.setResponse(0, "Add likey success");
			} else {
			    res.setResponse(500, "Add likey Internal Server Error");
			}
		    } else {
			res.setResponse(409, "Conflict: Likey already exists");
		    }
		} catch (Exception e) {
		    logger.error("Unexpected error occurred: ", e);
		    res.setResponse(500, "Unexpected error occurred");
		}
	    } else { // 로그인 안 됨
		res.setResponse(410, "Not logged in");
	    }
	} else { // 공간 ID가 없음
	    res.setResponse(400, "SpaceId not found");
	}

	if (logger.isDebugEnabled()) {
	    logger.debug("[SpaceLikeyController] /guest/addLikey response \n" + JsonUtil.toJsonPretty(res));
	}

	return res;
    }

    // QnA 조회(지영님)
    @RequestMapping(value = "/guest/QnAList", method = RequestMethod.GET)
    public String QnAList(ModelMap model, HttpServletRequest request, HttpServletResponse response) {

	String cookieuserEmail = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);
	if (!StringUtil.isEmpty(cookieuserEmail)) {
	    String hexGuestEmail = emailToHex(cookieuserEmail);
	    Guest guest = guestService.guestSelect(cookieuserEmail);

	    model.addAttribute("guest", guest);
	    model.addAttribute("hexGuestEmail", hexGuestEmail);
	}

	long curPage = HttpUtil.get(request, "curPage", (long) 1);

	// 총 spaceQuestion 수
	long totalspaceQuestion = 0;

	// spaceQuestion 리스트
	List<SpaceQuestion> list = null;

	// 조회용 객체(paging)
	SpaceQuestion search = new SpaceQuestion();

	// 페이징 객체
	Paging paging = null;

	// 작성자 이메일 세팅
	if (!StringUtil.isEmpty(cookieuserEmail)) {
	    search.setGuestEmail(cookieuserEmail);
	}

	// 페이징을 위한 총 문의 수 조회
	totalspaceQuestion = spaceQuestionService.spaceQuestionListCount(cookieuserEmail);

	// 문의가 존재하면 페이징 객체 생성, 댓글 리스트 가져오기
	if (totalspaceQuestion > 0) {
	    paging = new Paging("/guest/QnAList", totalspaceQuestion, QnA_LIST_COUNT, QnA_PAGE_COUNT, curPage,
		    "curPage");

	    search.setStartRow(paging.getStartRow());
	    search.setEndRow(paging.getEndRow());
	    list = spaceQuestionService.selectSpaceQuestionByGuest(search);

	    for (int i = 0; i < list.size(); i++) {
		list.get(i).setSpaceAnswer(
			spaceAnswerService.selectSpaceAnswerByQuestionId(list.get(i).getSpaceQuestionId()));
	    }
	}

	model.addAttribute("list", list);
	model.addAttribute("curPage", curPage);
	model.addAttribute("paging", paging);

	return "/guest/QnAList";
    }

    // 예약내역 조회(지영님)
    @RequestMapping(value = "/guest/reservationView", method = RequestMethod.GET)
    public String reservationDetail(ModelMap model, HttpServletRequest request, HttpServletResponse response) {

	long reservationId = HttpUtil.get(request, "reservationId", (long) 0);

	String cookieuserEmail = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);
	if (!StringUtil.isEmpty(cookieuserEmail)) {
	    String hexGuestEmail = emailToHex(cookieuserEmail);
	    Guest guest = guestService.guestSelect(cookieuserEmail);

	    model.addAttribute("guest", guest);
	    model.addAttribute("hexGuestEmail", hexGuestEmail);
	}

	Reservation reservation = null;
	reservation = reservationService.reservationSelect(reservationId);

	Payment payment = null;
	payment = paymentService.paymentSelectByReservationId(reservationId);

	Space space = null;
	space = spaceService.spaceSelectByReservationId(reservationId);

	model.addAttribute("reservation", reservation);
	model.addAttribute("payment", payment);
	model.addAttribute("space", space);

	return "/guest/reservationView";
    }

    // 게스트 비밀번호 변경
    @RequestMapping(value = "/guest/updatePwdProc", method = RequestMethod.POST)
    @ResponseBody
    public Response<Object> guestPwdUpdate(HttpServletRequest request, HttpServletResponse response) {
	Response<Object> ajaxResponse = new Response<Object>();

	String guestEmail = HttpUtil.get(request, "guestEmail");
	String guestPwd = HttpUtil.get(request, "guestPwd");

	// 전달 받은 값 체크
	if (!StringUtil.isEmpty(guestEmail) && !StringUtil.isEmpty(guestPwd)) {
	    Guest guest = new Guest();
	    guest.setGuestEmail(guestEmail);
	    guest.setGuestPwd(guestPwd);

	    if (guestService.guestPwdUpdate(guest) > 0) {
		ajaxResponse.setResponse(1, "비밀번호 업데이트 성공");
	    } else {
		ajaxResponse.setResponse(0, "비밀번호 업데이트 실패");
	    }
	} else {
	    ajaxResponse.setResponse(400, "전달받은 값이 비어있음");
	}

	return ajaxResponse;
    }

    // 로그인
    @RequestMapping(value = "/guest/loginProc", method = RequestMethod.POST)
    @ResponseBody
    public Response<Object> loginProc(HttpServletRequest request, HttpServletResponse response) {
	Response<Object> ajaxResponse = new Response<Object>();

	String guestEmail = HttpUtil.get(request, "guestEmail");
	String guestPwd = HttpUtil.get(request, "guestPwd");

	// 전달 받은 값 체크
	if (!StringUtil.isEmpty(guestEmail) && !StringUtil.isEmpty(guestPwd)) {
	    Guest guest = guestService.guestSelect(guestEmail);

	    // 해당 회원 가입 여부 체크
	    if (guest != null) {

		// 아이디와 비밀번호 일치 여부 체크
		if (StringUtil.equals(guest.getGuestPwd(), guestPwd)) {
		    // 회원 상태 체크
		    if (StringUtil.equals(guest.getStatus(), "Y")) {
			CookieUtil.addCookie(response, "/", -1, AUTH_COOKIE_NAME, CookieUtil.stringToHex(guestEmail));
			ajaxResponse.setResponse(1, "로그인 성공");
		    } else if (StringUtil.equals(guest.getStatus(), "N")) {
			ajaxResponse.setResponse(0, "탈퇴한 회원");
		    } else if (StringUtil.equals(guest.getStatus(), "S")) {
			ajaxResponse.setResponse(-1, "정지된 회원");
		    }
		} else {
		    ajaxResponse.setResponse(-2, "일치하지 않는 비밀번호");
		}
	    } else {
		ajaxResponse.setResponse(-3, "존재하지 않는 계정");
	    }
	} else {
	    ajaxResponse.setResponse(400, "전달받은 값이 비어있음");
	}
	return ajaxResponse;
    }

    // 로그아웃
    @RequestMapping(value = "/guest/logout", method = RequestMethod.GET)
    public String logOut(HttpServletRequest request, HttpServletResponse response) {

	if (CookieUtil.getCookie(request, AUTH_COOKIE_NAME) != null) {
	    CookieUtil.deleteCookie(request, response, "/", AUTH_COOKIE_NAME);
	}
	return "redirect:/space/spaceMain";
    }

    // 회원가입
    @RequestMapping(value = "/guest/regProc", method = RequestMethod.POST)
    @ResponseBody
    public Response<Object> regProc(HttpServletRequest request, HttpServletResponse response) {
	Response<Object> ajaxResponse = new Response<Object>();

	String guestEmail = HttpUtil.get(request, "guestEmail");
	String guestPwd = HttpUtil.get(request, "guestPwd");
	String guestNickname = HttpUtil.get(request, "guestNickname");
	String guestTel = HttpUtil.get(request, "guestTel");
	String guestBirth = HttpUtil.get(request, "guestBirth");

	// 전달 받은 값 체크
	if (!StringUtil.isEmpty(guestEmail) && !StringUtil.isEmpty(guestPwd) && !StringUtil.isEmpty(guestNickname)
		&& !StringUtil.isEmpty(guestTel) && !StringUtil.isEmpty(guestBirth)) {

	    Guest guest = new Guest();
	    guest.setGuestEmail(guestEmail);
	    guest.setGuestPwd(guestPwd);
	    guest.setGuestNickname(guestNickname);
	    guest.setGuestTel(guestTel);
	    guest.setGuestBirth(guestBirth);

	    // DB 인서트 결과
	    if (guestService.guestReg(guest) > 0) {
		ajaxResponse.setResponse(1, "회원 가입 성공");
	    } else {
		ajaxResponse.setResponse(0, "회원가입 실패");
	    }
	} else {
	    ajaxResponse.setResponse(400, "전달받은 값이 비어있음");
	}

	return ajaxResponse;
    }

    // 인증 메일 전송
    @RequestMapping(value = "/guest/emailAuth", method = RequestMethod.POST)
    @ResponseBody
    public Response<Object> sendAuthEmail(HttpServletRequest request, HttpServletResponse response) {
	Response<Object> ajaxResponse = new Response<Object>();

	String guestEmail = HttpUtil.get(request, "guestEmail");
	String authCode = guestService.createAuthCode();
	logger.debug(authCode);

	try {
	    // 서비스에서 메일 전송
	    guestService.sendAuthCodeMail(guestEmail, authCode, request.getSession());

	    // 메일 전송 성공 응답
	    ajaxResponse.setResponse(1, "인증 코드가 이메일로 전송되었습니다.");
	} catch (MessagingException e) {
	    // 메일 전송 실패 예외 처리
	    ajaxResponse.setResponse(500, "메일 전송에 실패하였습니다.");
	    logger.error("메일 전송 실패: ", e);
	} catch (Exception e) {
	    // 기타 예외 처리
	    ajaxResponse.setResponse(500, "서버에서 알 수 없는 오류가 발생했습니다.");
	    logger.error("서버 오류: ", e);
	}
	return ajaxResponse;
    }

    // 이메일 중복 체크
    @RequestMapping(value = "/guest/emailDupChk", method = RequestMethod.POST)
    @ResponseBody
    public Response<Object> emailDupChk(HttpServletRequest request, HttpServletResponse response) {
	Response<Object> ajaxResponse = new Response<Object>();

	String guestEmail = HttpUtil.get(request, "guestEmail");

	Guest guest = null;
	// guestEmail 값 체크
	if (!StringUtil.isEmpty(guestEmail)) {
	    // 해당 이메일과 일치하는 guest 객체 선택
	    guest = guestService.guestSelect(guestEmail);

	    if (guest == null) {
		ajaxResponse.setResponse(1, "일치하는 이메일 없음");
	    } else {
		if (StringUtil.equals(guest.getStatus(), "Y")) {
		    ajaxResponse.setResponse(0, "이미 사용중인 이메일");
		} else if (StringUtil.equals(guest.getStatus(), "N")) {
		    ajaxResponse.setResponse(0, "탈퇴한 회원");
		} else if (StringUtil.equals(guest.getStatus(), "S")) {
		    ajaxResponse.setResponse(0, "정지된 회원");
		}
	    }
	} else {
	    ajaxResponse.setResponse(400, "guestEmail 값이 비어있음");
	}
	return ajaxResponse;
    }

    // 인증코드 일치 여부 확인
    @RequestMapping(value = "/guest/verifyAuthCode", method = RequestMethod.POST)
    @ResponseBody
    public Response<Object> verifyAuthCode(HttpServletRequest request, HttpServletResponse response) {
	Response<Object> ajaxResponse = new Response<Object>();

	String guestAuthCode = HttpUtil.get(request, "guestAuthCode");

	HttpSession session = request.getSession();
	boolean isVerified = guestService.checkAuthCode(guestAuthCode, session); // 입력된 코드와 세션 코드 비교
	request.getSession().setAttribute("pwdFound", false);

	if (isVerified) {
	    request.getSession().setAttribute("pwdFound", true);
	    ajaxResponse.setResponse(1, "일치");
	} else {
	    ajaxResponse.setResponse(0, "불일치");
	}
	return ajaxResponse;
    }

    // 닉네임 중복 체크
    @RequestMapping(value = "/guest/nicknameDupChk", method = RequestMethod.POST)
    @ResponseBody
    public Response<Object> nicknameDupChk(HttpServletRequest request, HttpServletResponse response) {
	Response<Object> ajaxResponse = new Response<Object>();

	String guestNickname = HttpUtil.get(request, "guestNickname");

	// guestNickname 값 체크
	if (!StringUtil.isEmpty(guestNickname)) {
	    // 해당 이메일과 일치하는 guest 객체 선택
	    if (guestService.guestNicknameDupChk(guestNickname) == 0) {
		ajaxResponse.setResponse(1, "사용 가능한 닉네임");
	    } else {
		ajaxResponse.setResponse(0, "이미 사용중인 닉네임");
	    }
	} else {
	    ajaxResponse.setResponse(400, "guestEmail 값이 비어있음");
	}
	return ajaxResponse;
    }

    // 아이디 찾기
    @RequestMapping(value = "/guest/findEmailProc", method = RequestMethod.POST)
    @ResponseBody
    public Response<Object> findEmailProc(HttpServletRequest request, HttpServletResponse response) {
	Response<Object> ajaxResponse = new Response<Object>();

	String guestTel = HttpUtil.get(request, "guestTel");

	List<Guest> list = null;

	request.getSession().setAttribute("emailFound", false);

	// guestTel 값 체크
	if (!StringUtil.isEmpty(guestTel)) {
	    // 전화번호로 이메일 찾기
	    list = guestService.findEmailList(guestTel);

	    // list가 null 또는 비어 있을 경우 아이디가 없다고 응답
	    if (list == null || list.isEmpty()) {
		ajaxResponse.setResponse(0, "일치하는 이메일이 없습니다.");
	    } else {
		// 이메일을 찾았으면 세션에 저장하고, 이메일이 있다고 표시
		request.getSession().setAttribute("list", list);
		request.getSession().setAttribute("listCount", list.size());
		request.getSession().setAttribute("emailFound", true);
		ajaxResponse.setResponse(1, "아이디 찾기 성공");
	    }
	} else {
	    ajaxResponse.setResponse(400, "guestTel 값이 비어있음");
	}

	return ajaxResponse;
    }

    // 찾은 아이디 보여주는 페이지
    @RequestMapping(value = "/guest/showEmailForm", method = RequestMethod.GET)
    public String showEmailForm(ModelMap model, HttpServletRequest request, HttpServletResponse response) {
	Boolean emailFound = (Boolean) request.getSession().getAttribute("emailFound");

	// 만약 emailFound가 true일 때만 진행
	if (emailFound != null && emailFound) {
	    // list와 listCount를 세션에서 가져오기
	    List<Guest> list = (List<Guest>) request.getSession().getAttribute("list");
	    int listCount = (int) request.getSession().getAttribute("listCount");

	    if (list != null) {
		model.addAttribute("list", list);
		model.addAttribute("listCount", listCount);
	    }

	    request.getSession().setAttribute("emailFound", false);

	    return "/guest/showEmailForm"; // 정상적으로 이메일을 찾은 경우 페이지 이동
	} else {
	    // 이메일이 없거나 이메일 찾기 과정을 밟지 않은 경우 리다이렉트
	    return "redirect:/guest/findEmailForm"; // 예: 다시 아이디 찾기 페이지로 이동
	}
    }

    // 예약 게시판 리스트 화면
    @RequestMapping(value = "/guest/myPage")
    public String myPage(ModelMap model, HttpServletRequest request, HttpServletResponse response) {

	String cookieuserEmail = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);
	String searchValue = HttpUtil.get(request, "searchValue", "");
	String status = HttpUtil.get(request, "status", "");
	long curPage = HttpUtil.get(request, "curPage", (long) 1);

	// 조회하는 총 예약 수
	long totalCount = 0;

	// reservation 리스트
	List<Reservation> list = null;

	// 조회용 객체(paging)
	Reservation search = new Reservation();

	// 페이징 객체
	Paging paging = null;

	Guest guest = new Guest();

	// 작성자 이메일 세팅, 작성자 정보
	if (!StringUtil.isEmpty(cookieuserEmail)) {
	    String hexGuestEmail = emailToHex(cookieuserEmail);
	    guest = guestService.guestSelect(cookieuserEmail);

	    model.addAttribute("guest", guest);
	    model.addAttribute("hexGuestEmail", hexGuestEmail);

	    search.setGuestEmail(cookieuserEmail);
	}

	// 상태 세팅
	if (!StringUtil.isEmpty(status)) {
	    search.setStatus(status);
	}

	// 검색어 세팅
	if (!StringUtil.isEmpty(searchValue)) {
	    search.setSearchValue(searchValue);
	}

	// 페이징을 위한 총 문의 수 조회
	totalCount = reservationService.reservationTotalCount(search);

	// 조회하는 총 예약 수
	if (totalCount > 0) {
	    paging = new Paging("/guest/myPage", totalCount, Reserv_LIST_COUNT, Reserv_PAGE_COUNT, curPage, "curPage");

	    search.setStartRow(paging.getStartRow());
	    search.setEndRow(paging.getEndRow());

	    list = reservationService.reservationList(search);
	}

	model.addAttribute("list", list);
	model.addAttribute("curPage", curPage);
	model.addAttribute("searchValue", searchValue);
	model.addAttribute("status", status);
	model.addAttribute("paging", paging);

	return "/guest/myPage";
    }

    // 회원정보 관리(비밀번호) 화면
    @RequestMapping(value = "/guest/pwdCheckForm", method = RequestMethod.GET)
    public String pwdCheckForm(ModelMap model, HttpServletRequest request, HttpServletResponse response) {
	String cookieuserEmail = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);
	String hexGuestEmail = emailToHex(cookieuserEmail);

	Guest guest = guestService.guestSelect(cookieuserEmail);

	model.addAttribute("guest", guest);
	model.addAttribute("hexGuestEmail", hexGuestEmail);

	return "/guest/pwdCheckForm";
    }

    // 회원정보 관리(비밀번호) aJax
    @RequestMapping(value = "/guest/pwdCheckProc", method = RequestMethod.POST)
    @ResponseBody
    public Response<Object> pwdCheckProc(HttpServletRequest request, HttpServletResponse response) {
	Response<Object> res = new Response<Object>();

	String cookieUserId = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);
	String guestPassword = HttpUtil.get(request, "guestPassword");

	request.getSession().setAttribute("checkedPwd", false);

	if (StringUtil.isEmpty(cookieUserId)) // 나중에 cookieUserId
	{ // 로그인 되어있지 않음
	    res.setResponse(410, "Not logged in");
	    return res;
	}

	if (StringUtil.isEmpty(guestPassword)) { // 비밀번호 값 없음
	    res.setResponse(400, "Bad request");
	    return res;
	}

	Guest guest = guestService.guestSelect(cookieUserId);

	if (guest == null) // 나중에 guest
	{ // 게스트 정보가 DB에 없을 경우
	    res.setResponse(404, "Not found");
	    return res;
	}

	// 게스트 정보가 DB에 있을 경우
	if (!StringUtil.equals(guest.getStatus(), "Y")) // 나중에 guest
	{ // 게스트 상태 Y 가 아닐 경우
	    res.setResponse(-99, "Status error");
	    return res;
	}

	// 비밀번호 조회
	String chkPassword = guestService.guestChkPwd(guest.getGuestEmail()); // 나중에 guest

	if (chkPassword == null || !StringUtil.equals(guestPassword, chkPassword)) { // 비밀번호 값이 없거나 일치하지 않을 경우
	    res.setResponse(-1, "Password mismatch");
	} else {
	    res.setResponse(0, "Guest check password success");
	    request.getSession().setAttribute("checkedPwd", true);
	}

	if (logger.isDebugEnabled()) {
	    logger.debug("[GuestController] /guest/pwdCheckProc response \n" + JsonUtil.toJsonPretty(res));
	}

	return res;
    }

    // 공간 좋아요 리스트
    @RequestMapping(value = "/guest/likeyList")
    public String likeyList(ModelMap model, HttpServletRequest request, HttpServletResponse response) {
	String cookieuserEmail = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);
	String hexGuestEmail = emailToHex(cookieuserEmail);
	long spaceId = HttpUtil.get(request, "spaceId", (long) 0);

	Guest guest = guestService.guestSelect(cookieuserEmail);

	model.addAttribute("guest", guest);
	model.addAttribute("hexGuestEmail", hexGuestEmail);

	// 현재 페이지
	long curPage = HttpUtil.get(request, "curPage", (long) 1);

	// 총 좋아요 수
	long totalCount = 0;

	List<SpaceLikey> list = null;

	// 페이징 담을 객체
	SpaceLikey likey = new SpaceLikey();
	likey.setGuestEmail(cookieuserEmail);

	// 페이징 객체
	Paging paging = null;

	totalCount = spaceLikeyService.spaceLikeyCount(likey);

	if (totalCount > 0) {
	    paging = new Paging("/guest/likeyList", totalCount, LIKEY_LIST_COUNT, LIKEY_PAGE_COUNT, curPage, "curPage");

	    likey.setStartRow(paging.getStartRow());
	    likey.setEndRow(paging.getEndRow());

	    list = spaceLikeyService.spaceLikeyList(likey);
	}

	model.addAttribute("list", list);
	model.addAttribute("curPage", curPage);
	model.addAttribute("paging", paging);

	return "/guest/likeyList";
    }

    // 회원정보수정 화면
    @RequestMapping(value = "/guest/updateForm")
    public String updateForm(ModelMap model, HttpServletRequest request, HttpServletResponse response) {
	Boolean checkedPwd = (Boolean) request.getSession().getAttribute("checkedPwd");

	// 만약 emailFound가 true일 때만 진행
	if (checkedPwd != null && checkedPwd) {
	    String cookieuserEmail = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);
	    String hexGuestEmail = emailToHex(cookieuserEmail);

	    Guest guest = guestService.guestSelect(cookieuserEmail);

	    model.addAttribute("guest", guest);
	    model.addAttribute("hexGuestEmail", hexGuestEmail);

	    request.getSession().setAttribute("checkedPwd", false);

	    return "/guest/updateForm";
	} else {
	    // 이메일이 없거나 이메일 찾기 과정을 밟지 않은 경우 리다이렉트
	    return "redirect:/guest/pwdCheckForm"; // 예: 다시 아이디 찾기 페이지로 이동
	}

    }

    // 회원정보수정 aJax
    @RequestMapping(value = "/guest/updateProc", method = RequestMethod.POST)
    @ResponseBody
    public Response<Object> updateProc(MultipartHttpServletRequest request, HttpServletResponse response) {
	Response<Object> res = new Response<Object>();

	String cookieUserId = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);
	String cookieValue = CookieUtil.getValue(request, AUTH_COOKIE_NAME);

	String guestEmail = HttpUtil.get(request, "guestEmail");
	String guestPassword = HttpUtil.get(request, "guestPassword");
	String guestNickname = HttpUtil.get(request, "guestNickname");
	String guestTel = HttpUtil.get(request, "guestTel");

	// 프로필 사진 변경 저장
	FileData fileData = HttpUtil.getFile(request, "fileInput", UPLOAD_GUEST_SAVE_DIR);

	if (!StringUtil.isEmpty(cookieUserId)) // 나중에 cookieUserId
	{ // 로그인 시

	    if (StringUtil.equals(guestEmail, cookieUserId)) // 나중에 cookieUserId
	    { // 쿠키 정보와 넘어온 guestEmail이 같을 경우

		Guest guest = guestService.guestSelect(cookieUserId); // 나중에 cookieUserId

		if (guest != null) { // 사용자 정보가 DB에 있을 경우

		    if (!StringUtil.isEmpty(guestPassword) && !StringUtil.isEmpty(guestNickname)
			    && !StringUtil.isEmpty(guestTel)) { // 파라미터 값이 비어있지 않을 경우

			guest.setGuestEmail(guestEmail);
			guest.setGuestPwd(guestPassword);
			guest.setGuestNickname(guestNickname);
			guest.setGuestTel(guestTel);

			if (fileData != null && fileData.getFileSize() > 0) { // 프로필 첨부파일이 있고, 사이즈가 0 이상일 경우

			    String originalName = fileData.getFileName();
			    String newName = cookieValue + ".png";

			    logger.debug(originalName);
			    logger.debug(newName);
			    logger.debug(originalName);
			    logger.debug(newName);

			    // 파일 경로 설정
			    File originalFile = new File(UPLOAD_GUEST_SAVE_DIR, originalName);
			    File renameFile = new File(UPLOAD_GUEST_SAVE_DIR, newName);

			    // 이미 같은 이름의 파일이 존재하면 덮어쓰도록 삭제
			    if (renameFile.exists()) {
				renameFile.delete(); // 기존 파일 삭제
			    }

			    originalFile.renameTo(renameFile);
			}

			if (guestService.guestUpdate(guest) > 0) { // 업데이트 건수 있을 경우
			    res.setResponse(0, "Guest profile update success");
			} else { // 업데이트 건수 없을 경우
			    res.setResponse(500, "Internal server error");
			}
		    } else { // 파라미터 값이 올바르지 않을 경우
			res.setResponse(400, "Bad request");
		    }
		} else { // 사용자 정보가 DB에 없을 경우
		    CookieUtil.deleteCookie(request, response, "/", AUTH_COOKIE_NAME);
		    res.setResponse(404, "Not found");
		}
	    } else { // 쿠키 정보와 넘어온 guestEmail이 다른 경우
		CookieUtil.deleteCookie(request, response, "/", AUTH_COOKIE_NAME);
		res.setResponse(430, "Email information is different");
	    }
	} else { // 로그인 아닐 시
	    res.setResponse(410, "Not logged in");
	}

	if (logger.isDebugEnabled()) {
	    logger.debug("[GuestController] /guest/updateProc response \n" + JsonUtil.toJsonPretty(res));
	}

	return res;
    }

    // 닉네임 중복체크 aJax
    @RequestMapping(value = "/guest/nickCheck", method = RequestMethod.POST)
    @ResponseBody
    public Response<Object> nickCheck(HttpServletRequest request, HttpServletResponse response) {
	Response<Object> res = new Response<Object>();

	String guestNickname = HttpUtil.get(request, "guestNickname");

	if (!StringUtil.isEmpty(guestNickname)) { // 닉네임 값이 있을 경우
	    if (guestService.guestSelectNick(guestNickname) == null) { // 닉네임 없으면 정상
		res.setResponse(0, "Nickname check success");
	    } else { // 닉네임 있으면 중복
		res.setResponse(100, "Duplicate nickname");
	    }
	} else { // 닉네임 값이 없을 경우
	    res.setResponse(400, "Bad request");
	}

	if (logger.isDebugEnabled()) {
	    logger.debug("[GuestController] /guest/nickCheck response \n" + JsonUtil.toJsonPretty(res));
	}

	return res;
    }

    // 회원 탈퇴 화면
    @RequestMapping(value = "/guest/deleteForm", method = RequestMethod.GET)
    public String deleteForm(ModelMap model, HttpServletRequest request, HttpServletResponse response) {

	String cookieuserEmail = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);
	String hexGuestEmail = emailToHex(cookieuserEmail);

	Guest guest = guestService.guestSelect(cookieuserEmail);

	model.addAttribute("guest", guest);
	model.addAttribute("hexGuestEmail", hexGuestEmail);

	return "/guest/deleteForm";
    }

    // 회원 탈퇴 aJax
    @RequestMapping(value = "/guest/deleteProc", method = RequestMethod.POST)
    @ResponseBody
    public Response<Object> deleteProc(HttpServletRequest request, HttpServletResponse response) {
	Response<Object> res = new Response<Object>();
	
	String cookieUserId = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);

	Guest guest = null;

	// if(!StringUtil.isEmpty(guest2.getGuestEmail())) //나중에 cookieUserId
	// { //로그인 되어있음

    guest = guestService.guestSelect(cookieUserId); // 나중에 cookieUserId

    if (guest != null) { // 게스트 정보가 DB에 있을 경우
		if (StringUtil.equals(guest.getStatus(), "Y")) { // 게스트 상태 Y 일 경우
			if (guestService.guestDelete(guest) > 0) {
			    // if(CookieUtil.getCookie(request, AUTH_COOKIE_NAME) != null)
			    // {
			    res.setResponse(0, "Guest delete success");
			    
			    if (CookieUtil.getCookie(request, AUTH_COOKIE_NAME) != null) {
				    CookieUtil.deleteCookie(request, response, "/", AUTH_COOKIE_NAME);
				}
			    // CookieUtil.deleteCookie(request, response, "/", AUTH_COOKIE_NAME);
			    // }
			} else {
			    res.setResponse(500, "Internal server error");
			}
		} else { // 게스트 상태 Y 가 아닐 경우
		    res.setResponse(-99, "Status error");
		}
    } else { // 게스트 정보가 DB에 없을 경우
	res.setResponse(404, "Not found");
    }

//    	}
//    	else
//    	{	//로그인 되어있지 않음
//    		res.setResponse(410, "Not logged in");
//    	}

	if (logger.isDebugEnabled()) {
	    logger.debug("[GuestController] /guest/deleteProc response \n" + JsonUtil.toJsonPretty(res));
	}

	return res;
    }

    @RequestMapping(value = "/guest/reviewList")
    public String reviewList(ModelMap model, HttpServletRequest request, HttpServletResponse response) {
	// 탭 상태 확인 변수(탭 전환)
	String tab = HttpUtil.get(request, "tab", "reviewable");

	// 프로필 사진 왼쪽 바에 넣기

	// 프로필 왼쪽 닉네임, 이메일 보여주기
	String cookieUserEmail = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);
	Guest guest = guestService.guestSelect(cookieUserEmail);
	String hexGuestEmail = emailToHex(cookieUserEmail);

	model.addAttribute("guest", guest);
	model.addAttribute("hexGuestEmail", hexGuestEmail);

	// 현재 페이지
	long curPage = HttpUtil.get(request, "curPage", (long) 1);

	// 총게시물 수
	long totalCount = 0;
	long myReviewCount = 0;

	// 작성가능한 리뷰 리스트
	List<Reservation> reviewable = null;

	// 작성한 리뷰 리스트
	List<Review> myReviewList = null;

	// 페이징 객체
	Paging paging = null;
	Paging myReviewPaging = null;

	totalCount = reservationService.reviewableCount(cookieUserEmail); // cookieUserId (나중에 수정)
	myReviewCount = reviewService.myReviewCount(cookieUserEmail); // cookieUserId

	logger.debug("=============================");
	logger.debug("totalCount : " + totalCount);
	logger.debug("myReviewCount : " + myReviewCount);
	logger.debug("=============================");

	if ("reviewable".equals(tab) && totalCount > 0) {
	    // 작성 가능한 리뷰 페이징 처리
	    long reviewablePage = HttpUtil.get(request, "reviewablePage", (long) 1);
	    paging = new Paging("/guest/reviewList", totalCount, REVIEW_LIST_COUNT, REVIEW_PAGE_COUNT, reviewablePage,
		    "reviewablePage");

	    Reservation reservation = new Reservation();
	    reservation.setGuestEmail(cookieUserEmail);
	    reservation.setStartRow(paging.getStartRow());
	    reservation.setEndRow(paging.getEndRow());
	    reviewable = reservationService.reviewableReservations(reservation);
	} else if ("myReview".equals(tab) && myReviewCount > 0) {
	    // 작성한 리뷰 페이징 처리
	    long myReviewPage = HttpUtil.get(request, "myReviewPage", (long) 1);
	    myReviewPaging = new Paging("/guest/reviewList", myReviewCount, REVIEW_LIST_COUNT, REVIEW_PAGE_COUNT,
		    myReviewPage, "myReviewPage");

	    Review review = new Review();
	    review.setGuestEmail(cookieUserEmail);
	    review.setStartRow(myReviewPaging.getStartRow());
	    review.setEndRow(myReviewPaging.getEndRow());
	    myReviewList = reviewService.myReviewList(review);
	}

	model.addAttribute("tab", tab);
	model.addAttribute("totalCount", totalCount); // 작성 가능한 리뷰 갯수
	model.addAttribute("myReviewCount", myReviewCount); // 작성한 리뷰 갯수
	model.addAttribute("reviewable", reviewable); // 작성 가능한 리뷰 리스트
	model.addAttribute("myReviewList", myReviewList); // 작성한 리뷰 리스트
	model.addAttribute("curPage", curPage);
	model.addAttribute("paging", paging); // 작성 가능한 리뷰 페이징
	model.addAttribute("myReviewPaging", myReviewPaging); // 작성한 리뷰 페이징

	return "/guest/reviewList";
    }

    @RequestMapping(value = "/guest/changePwdForm", method = RequestMethod.GET)
    public String changePwdForm(HttpServletRequest request, HttpServletResponse response) {
	Boolean pwdFound = (Boolean) request.getSession().getAttribute("pwdFound");

	// 만약 emailFound가 true일 때만 진행
	if (pwdFound != null && pwdFound) {
	    // list와 listCount를 세션에서 가져오

	    request.getSession().setAttribute("pwdFound", false);

	    return "/guest/changePwdForm"; // 정상적으로 이메일을 찾은 경우 페이지 이동
	} else {
	    // 이메일이 없거나 이메일 찾기 과정을 밟지 않은 경우 리다이렉트
	    return "redirect:/guest/findPwdForm"; // 예: 다시 아이디 찾기 페이지로 이동
	}
    }

    @RequestMapping(value = "/guest/findEmailForm", method = RequestMethod.GET)
    public String findEmailForm(HttpServletRequest request, HttpServletResponse response) {

	return "/guest/findEmailForm";
    }

    @RequestMapping(value = "/guest/findPwdForm", method = RequestMethod.GET)
    public String findPwdForm(HttpServletRequest request, HttpServletResponse response) {

	return "/guest/findPwdForm";
    }

    @RequestMapping(value = "/guest/loginForm", method = RequestMethod.GET)
    public String loginForm(HttpServletRequest request, HttpServletResponse response) {

	return "/guest/loginForm";
    }

    @RequestMapping(value = "/guest/regForm", method = RequestMethod.GET)
    public String regForm(HttpServletRequest request, HttpServletResponse response) {

	return "/guest/regForm";
    }

    // 이메일을 16진수로 변환하는 메서드
    public static String emailToHex(String email) {
	if (email == null || email.isEmpty()) {
	    throw new IllegalArgumentException("Email cannot be null or empty");
	}
	StringBuilder hexBuilder = new StringBuilder();
	for (char c : email.toCharArray()) {
	    hexBuilder.append(String.format("%02x", (int) c)); // 각 문자에 대해 16진수 변환
	}
	return hexBuilder.toString();
    }

}
