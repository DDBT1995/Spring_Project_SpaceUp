package com.sist.web.controller;

import java.io.File;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.sist.common.util.StringUtil;
import com.sist.web.model.Paging;
import com.sist.web.model.Reservation;
import com.sist.web.model.Response;
import com.sist.web.model.Review;
import com.sist.web.model.ReviewLikey;
import com.sist.web.model.Space;
import com.sist.web.model.SpaceQuestion;
import com.sist.web.service.SpaceService;
import com.sist.web.util.CookieUtil;
import com.sist.web.util.HttpUtil;

@Controller("spaceController")
public class SpaceController {
    
    private static Logger logger = LoggerFactory.getLogger(SpaceController.class);

    @Autowired
    SpaceService spaceService;

    private static final int LIST_COUNT = 3;
    private static final int PAGE_COUNT = 2;

    @Value("#{env['upload.save.dir']}")
    private String UPLOAD_SAVE_DIR;

    @Value("#{env['auth.cookie.name']}")
    private String AUTH_COOKIE_NAME;
    
    @RequestMapping(value = "/space/spaceView", method = RequestMethod.GET)
    public String spaceView(Model model, HttpServletRequest request, HttpServletResponse response) {
	long spaceId = HttpUtil.get(request, "spaceId", (long) 0);
	Space space = null;

	String cookieEmail = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);
	String loginEmail = "";
	
	if(cookieEmail != null && cookieEmail != "") {
		loginEmail = emailToHex(cookieEmail);
	}
	
	

	if (spaceId > 0) {
	    space = spaceService.spaceView(spaceId);

	    if (StringUtil.equals(space.getStatus(), "Y")) {
		long spaceIdSelect = space.getSpaceId();
		int spaceTypeSelect = space.getSpaceType();
		
		File spaceImgs = new File(UPLOAD_SAVE_DIR + "/space/upload/" + spaceTypeSelect + "/" + spaceIdSelect);
		String[] spaceImgNames = spaceImgs.list();

//		for (String spaceImgName : spaceImgNames) {
//		    System.out.println("spaceName : " + spaceImgName);
//		}
		
//		System.out.println("%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%");
//		int sq = 0;
//		int[] spaceIdT;
//		for(int j=1; j<=14; j++) {
//			for(int i=1; i<=1500; i++) {
//				File spaceImgs11 = new File(UPLOAD_SAVE_DIR + "/space/upload/" + j + "/" + i);
//				String[] spaceImgNames11 = spaceImgs11.list();
//				if(spaceImgNames11 != null) {
//					if(spaceImgNames11.length < 5) {
//						System.out.println("i값 : " + i +", 이미지 크기@@@ : " + spaceImgNames11.length);
//						++sq;
//						
//					}
//				}
//			}			
//		}
//		System.out.println("갯수 : " + sq);
//		System.out.println("%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%");
		
		
		model.addAttribute("loginEmail", loginEmail);
		model.addAttribute("space", space);
		model.addAttribute("spaceImgNames", spaceImgNames);

	    } else {
		model.addAttribute("reject", "삭제되었거나 비활성화한 상품입니다.");
	    }
	} else {
	    model.addAttribute("reject", "존재하지 않는 상품입니다.");
	}

	return "/space/spaceView";
    }

    @RequestMapping(value = "/space/reviewList", method = RequestMethod.GET)
    @ResponseBody
    public Map<String, Object> reviewList(HttpServletRequest request, HttpServletResponse response) {
	Map<String, Object> resAjax = new HashMap<>();

	String loginEmail = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);
	long curPage = HttpUtil.get(request, "curPage", (long) 1);
	long spaceId = HttpUtil.get(request, "spaceId", (long) 0);
	int reviewSort = HttpUtil.get(request, "reviewSort", 1);

	List<Review> reviewList = new ArrayList<Review>();
	Paging paging = null;
	Review review = new Review();

	long totalReviewCnt = spaceService.reviewTotalCnt(spaceId);
	long totalReviewCntY = spaceService.reviewTotalCntY(spaceId);

	if (totalReviewCnt > 0) {
	    paging = new Paging("/board/list", totalReviewCnt, LIST_COUNT, PAGE_COUNT, curPage, "curPage");

	    review.setGuestEmail(loginEmail);
	    review.setSpaceId(spaceId);
	    review.setReviewSort(reviewSort);
	    review.setStartRow(paging.getStartRow());
	    review.setEndRow(paging.getEndRow());

	    reviewList = spaceService.spaceReview(review);
	}
	
	for (Review reviewData : reviewList) {
        String guestEmail = reviewData.getGuestEmail();
        
        if (guestEmail != null) {
            String hexEmail = emailToHex(guestEmail);

            reviewData.setGuestEmail(hexEmail);
        }
    }

	resAjax.put("paging", paging);
	resAjax.put("curPage", curPage);
	resAjax.put("reviewList", reviewList);
	resAjax.put("reviewSort", reviewSort);
	resAjax.put("totalReviewCntY", totalReviewCntY);

	return resAjax;
    }

    @RequestMapping(value = "/space/reviewReport", method = RequestMethod.POST)
    @ResponseBody
    public Response<Object> reviewReport(HttpServletRequest request, HttpServletResponse response) {
	Response<Object> resAjax = new Response<Object>();

	String userEmail = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);
	long reviewId = HttpUtil.get(request, "reviewId", (long) 0);
	String reportReason = HttpUtil.get(request, "reportReason");
	long spaceId = HttpUtil.get(request, "spaceId", (long) 0);
	String reporterType = "G"; // 신고자 타입(G:게스트, H:호스트) 임시 G

	if (userEmail != null && !StringUtil.isEmpty(userEmail)) {
	    if (spaceService.spaceSelect(spaceId) != null) {
		if (!StringUtil.isEmpty(reportReason)) {
		    Map<String, Object> reviewReportMap = new HashMap<>();

		    reviewReportMap.put("reporterId", userEmail);
		    reviewReportMap.put("reporterType", reporterType);
		    reviewReportMap.put("reviewId", reviewId);
		    reviewReportMap.put("reportReason", reportReason);

		    if (spaceService.reviewReport(reviewReportMap) > 0) {
			resAjax.setResponse(0, "신고하였습니다.");
		    } else {
			resAjax.setResponse(-2, "신고 실패하였습니다.");
		    }
		} else {
		    resAjax.setResponse(-2, "신고사유 작성바랍니다.");
		}
	    } else {
		resAjax.setResponse(-1, "존재하지 않는 공간입니다.");
	    }
	} else {
	    resAjax.setResponse(-1, "로그인 확인바랍니다.");
	}

	return resAjax;
    }

    @RequestMapping(value = "/space/reviewUpdate", method = RequestMethod.POST)
    @ResponseBody
    public Response<Object> reviewUpdate(HttpServletRequest request, HttpServletResponse response) {
	Response<Object> resAjax = new Response<Object>();

	String userEmail = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);
	long reviewId = HttpUtil.get(request, "reviewId", (long) 0);
	String reviewContent = HttpUtil.get(request, "reviewContent");
	int reviewScore = HttpUtil.get(request, "reviewScore", 0);

	if (reviewId > 0) {
	    if (StringUtil.equals(spaceService.reviewSelect(reviewId).getGuestEmail(), userEmail)) {
		if (!StringUtil.isEmpty(reviewContent) && reviewScore != 0) {
		    Review review = new Review();

		    review.setReviewId(reviewId);
		    review.setReviewContent(reviewContent);
		    review.setReviewScore(reviewScore);

		    if (spaceService.reviewUpdate(review) > 0) {
			resAjax.setResponse(0, "리뷰를 수정하였습니다.");
		    } else {
			resAjax.setResponse(-2, "리뷰 수정 실패하였습니다.");
		    }
		} else {
		    resAjax.setResponse(-2, "수정 내용 작성 또는 평점 선택바랍니다.");
		}
	    } else {
		resAjax.setResponse(-1, "잘못된 로그인 정보입니다.");
	    }
	} else {
	    resAjax.setResponse(-1, "리뷰 상태 확인바랍니다.");
	}

	return resAjax;
    }

    @RequestMapping(value = "/space/reviewDelete", method = RequestMethod.POST)
    @ResponseBody
    public Response<Object> reviewDelete(HttpServletRequest request, HttpServletResponse response) {
	Response<Object> resAjax = new Response<Object>();

	String userEmail = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);
	long reviewId = HttpUtil.get(request, "reviewId", (long) 0);

	if (reviewId > 0) {
	    if (StringUtil.equals(spaceService.reviewSelect(reviewId).getGuestEmail(), userEmail)) {
		if (spaceService.reviewDelete(reviewId) > 0) {

		    resAjax.setResponse(0, "리뷰 삭제 완료");
		} else {
		    resAjax.setResponse(-1, "리뷰 삭제하지 못하였습니다.");
		}
	    } else {
		resAjax.setResponse(-1, "잘못된 로그인 정보입니다.");
	    }
	} else {
	    resAjax.setResponse(-1, "리뷰 상태 확인바랍니다.");
	}

	return resAjax;
    }

    @RequestMapping(value = "/space/spaceQuestionList", method = RequestMethod.GET)
    @ResponseBody
    public Map<String, Object> spaceQuestionList(HttpServletRequest request, HttpServletResponse response) {
	Map<String, Object> resAjax = new HashMap<>();

	long curPage = HttpUtil.get(request, "curPage", (long) 1);
	long spaceId = HttpUtil.get(request, "spaceId", (long) 0);

	List<SpaceQuestion> sQList = new ArrayList<SpaceQuestion>();
	SpaceQuestion sQ = new SpaceQuestion();
	Paging paging = null;

	long sQTotalCnt = spaceService.spaceQuestionTotalCnt(spaceId);
	long sQTotalCntY = spaceService.spaceQuestionTotalCntY(spaceId);

	if (sQTotalCnt > 0) {
	    paging = new Paging("/board/list", sQTotalCnt, LIST_COUNT, PAGE_COUNT, curPage, "curPage");

	    sQ.setSpaceId(spaceId);
	    sQ.setStartRow(paging.getStartRow());
	    sQ.setEndRow(paging.getEndRow());

	    sQList = spaceService.spaceQuestionList(sQ);
	}
	
	for (SpaceQuestion sQListData : sQList) {
        String guestEmail = sQListData.getGuestEmail();
        
        if (guestEmail != null) {
            String hexEmail = emailToHex(guestEmail);

            sQListData.setGuestEmail(hexEmail);
        }
    }

	resAjax.put("paging", paging);
	resAjax.put("curPage", curPage);
	resAjax.put("sQList", sQList);
	resAjax.put("sQTotalCntY", sQTotalCntY);

	return resAjax;
    }

    @RequestMapping(value = "/space/questionUpdate", method = RequestMethod.POST)
    @ResponseBody
    public Response<Object> questionUpdate(HttpServletRequest request, HttpServletResponse response) {
	Response<Object> resAjax = new Response<Object>();

	String userEmail = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);
	long spaceQuestionId = HttpUtil.get(request, "spaceQuestionId", (long) 0);
	String questionContent = HttpUtil.get(request, "questionContent");
	int questionCategory = HttpUtil.get(request, "questionCategory", 0);

	SpaceQuestion sQ = new SpaceQuestion();
	sQ.setGuestEmail(userEmail);
	sQ.setSpaceQuestionId(spaceQuestionId);
	sQ.setQuestionCategory(questionCategory);

	if (spaceQuestionId > 0) {
	    if (spaceService.questionUserSelect(sQ) > 0) {
		if (!StringUtil.isEmpty(questionContent) && questionCategory != 0) {
		    sQ.setSpaceQuestionId(spaceQuestionId);
		    sQ.setQuestionContent(questionContent.replace("\n", "<br>"));

		    if (spaceService.questionUpdate(sQ) > 0) {
			resAjax.setResponse(0, "질문을 수정하였습니다.");
		    } else {
			resAjax.setResponse(-2, "질문 수정 실패하였습니다.");
		    }
		} else {
		    resAjax.setResponse(-2, "질문 내용 작성 또는 질문유형 선택바랍니다.");
		}
	    } else {
		resAjax.setResponse(-1, "잘못된 로그인 정보입니다.");
	    }
	} else {
	    resAjax.setResponse(-1, "질문 상태 확인바랍니다.");
	}

	return resAjax;
    }

    @RequestMapping(value = "/space/questionDelete", method = RequestMethod.POST)
    @ResponseBody
    public Response<Object> questionDelete(HttpServletRequest request, HttpServletResponse response) {
	Response<Object> resAjax = new Response<Object>();

	String userEmail = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);
	long spaceQuestionId = HttpUtil.get(request, "spaceQuestionId", (long) 0);

	SpaceQuestion sQ = new SpaceQuestion();

	if (spaceQuestionId > 0) {
	    sQ.setGuestEmail(userEmail);
	    sQ.setSpaceQuestionId(spaceQuestionId);

	    if (spaceService.questionUserSelect(sQ) > 0) {
		if (spaceService.questionDelete(spaceQuestionId) > 0) {
		    resAjax.setResponse(0, "리뷰 삭제 완료");
		} else {
		    resAjax.setResponse(-1, "리뷰 삭제하지 못하였습니다.");
		}
	    } else {
		resAjax.setResponse(-1, "잘못된 로그인 정보입니다.");
	    }
	} else {
	    resAjax.setResponse(-1, "리뷰 상태 확인바랍니다.");
	}

	return resAjax;
    }

    @RequestMapping(value = "/space/questionInsert", method = RequestMethod.POST)
    @ResponseBody
    public Response<Object> questionInsert(HttpServletRequest request, HttpServletResponse response) {
	Response<Object> resAjax = new Response<Object>();

	String userEmail = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);
	long spaceId = HttpUtil.get(request, "spaceId", (long) 0);
	String questionContent = HttpUtil.get(request, "questionContent");
	int questionCategory = HttpUtil.get(request, "questionCategory", 0);

	if (spaceId > 0) {
	    if (userEmail != null && userEmail != "") {
		if (!StringUtil.isEmpty(questionContent) && questionCategory != 0) {
		    SpaceQuestion sQ = new SpaceQuestion();

		    sQ.setGuestEmail(userEmail);
		    sQ.setSpaceId(spaceId);
		    sQ.setQuestionContent(questionContent.replace("\n", "<br>"));
		    sQ.setQuestionCategory(questionCategory);

		    if (spaceService.questionInsert(sQ) > 0) {
			resAjax.setResponse(0, "질문 작성하였습니다. 판매자가 확인 후 답변할 것입니다.");
		    } else {
			resAjax.setResponse(-2, "질문 작성 실패하였습니다. 재시도 바랍니다.");
		    }
		} else {
		    resAjax.setResponse(-2, "내용 입력 또는 질문 유형 선택바랍니다.");
		}
	    } else {
		resAjax.setResponse(-1, "로그인 확인바랍니다.");
	    }
	} else {
	    resAjax.setResponse(-1, "공간 상태 확인바랍니다.");
	}

	return resAjax;
    }
    
    @RequestMapping(value="/space/reviewLikeySelect", method=RequestMethod.GET)
    @ResponseBody
    public Response<Object> review(HttpServletRequest request, HttpServletResponse response) {
    	Response<Object> resAjax = new Response<Object>();
    	
    	String userEmail = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);
    	long reviewId = HttpUtil.get(request, "reviewId", (long)0);
    	
    	ReviewLikey reviewLikey = new ReviewLikey();
    	int resultCount = 0;
    	
    	if(reviewId > 0) {
    		if(!StringUtil.isEmpty(userEmail)) {
    			reviewLikey.setGuestEmail(userEmail);
    			reviewLikey.setReviewId(reviewId);
    			
    			resultCount = spaceService.reviewLikeySelete(reviewLikey);
    			
    			if(resultCount == 1) {
    				resAjax.setResponse(1, "도움돼요 해제");
    			} else if(resultCount == 2) {
    				resAjax.setResponse(2, "도움돼요!");
    			} else {
    				resAjax.setResponse(-1, "도움돼요 실패");
    			}
    		} else {
    			resAjax.setResponse(-2, "로그인 정보 확인바랍니다.");
    		}
    	}
    	
    	
        return resAjax;
    }
    
    @RequestMapping(value="/space/reservationTimeView", method=RequestMethod.POST)
    @ResponseBody
    public Response<Object> reservationTimeView(HttpServletRequest request, HttpServletResponse response) {
    	Response<Object> resAjax = new Response<Object>();
    	
    	long spaceId = HttpUtil.get(request, "spaceId", (long)0);
    	String useDate = HttpUtil.get(request, "useDate");
    	
    	Reservation reservation = new Reservation();
    	
    	reservation.setSpaceId(spaceId);
    	reservation.setUseDate(useDate.replaceAll("-", ""));
    	
    	List<int[]> availableSlots = spaceService.reservationSelect(reservation);
        
    	resAjax.setResponse(1, "예약 가능 날짜입니다.", availableSlots);
    	
        return resAjax;
    }
    
  @RequestMapping(value="/space/reservationCheck", method=RequestMethod.POST)
  @ResponseBody
  public Response<Object> spaceList(HttpServletRequest request, HttpServletResponse response) {
	  Response<Object> resAjax = new Response<Object>();
	  
	  long spaceId = HttpUtil.get(request, "spaceId", (long)0);
	  String useDate = HttpUtil.get(request, "useDate");
	  String[] reservationTimeItem = request.getParameterValues("reservationTimeItem[]");
	  int inputPeopleValue = HttpUtil.get(request, "inputPeopleValue", 0);
	  
	  // String 배열을 ArrayList<Integer>로 변환
      List<Integer> reservationTimeItemInt = Arrays.stream(reservationTimeItem)
                                    .map(Integer::parseInt) // 문자열을 정수로 변환
                                    .collect(Collectors.toList()); // 결과를 리스트로 수집
	  
	  if(spaceId > 0) {
		  if(!StringUtil.isEmpty(useDate) && reservationTimeItem.length > 0 && inputPeopleValue > 0) {
			  Reservation reservation = new Reservation();
			  
			  reservation.setSpaceId(spaceId);
			  reservation.setUseDate(useDate.replaceAll("-", ""));
			  
			  List<int[]> availableSlots = spaceService.reservationSelect(reservation);
	          
	          ArrayList<Integer> timeDatas = new ArrayList<>();
	          
	          for(int i=0; i < availableSlots.size(); i++) {
	        	  for(int j=availableSlots.get(i)[0]; j <= availableSlots.get(i)[1]; j++) {
	        		  timeDatas.add(j);
	        	  }
	          }
	          
	          if(timeDatas.containsAll(reservationTimeItemInt)) {
	        	  resAjax.setResponse(0, "예약 페이지로 이동합니다.");
	          } else {
	        	  resAjax.setResponse(-2, "이미 예약된 시간입니다.");
	          }  
		  } else {
			  resAjax.setResponse(-1, "입력값을 확인 바랍니다.");
		  }
	  } else {
		  resAjax.setResponse(-1, "공간 상태 확인바랍니다.");
	  }
	
	  return resAjax;
  }
  
  @RequestMapping(value="/space/spaceReservationForm", method=RequestMethod.POST)
  public String spaceReservationForm(HttpServletRequest request, HttpServletResponse response, Model model) {
	  long spaceId = HttpUtil.get(request, "spaceId", (long)0);
	  String useDate = HttpUtil.get(request, "useDate");
	  String[] reservationTimeItem = HttpUtil.gets(request, "reservationTimeItem");
	  int inputPeopleValue = HttpUtil.get(request, "inputPeopleValue", 0);
	  
	  Reservation reservation = new Reservation();
	
	  reservation.setSpaceId(spaceId);
	  reservation.setUseDate(useDate.replaceAll("-", ""));
	  
	  if(spaceId > 0) {
		  Space space = spaceService.spaceSelect(spaceId);
		  
		  File spaceImgs = new File(UPLOAD_SAVE_DIR + "/space/upload/" + space.getSpaceType() + "/" + spaceId);
		  String[] spaceImgNames = spaceImgs.list();
		  
		  System.out.println("날짜 확인@@@@@@@@@@@@@@@@ : " + useDate);
		  
		  if(space != null) {
			  model.addAttribute("space", space);
			  model.addAttribute("useDate", useDate);
			  model.addAttribute("useDateFormat", reservation.getUseDate());
			  model.addAttribute("reservationTimeItem", reservationTimeItem);
			  model.addAttribute("inputPeopleValue", inputPeopleValue);
			  model.addAttribute("spaceImgNames", spaceImgNames);
		  }
	  }
	  
	  for(int i=0;i<reservationTimeItem.length;i++) {
		  System.out.println(reservationTimeItem[i]);
	  }
	  
	  
  	
      return "/space/spaceReservationForm";
  }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    @RequestMapping(value="/space/spaceMain", method=RequestMethod.GET)
    public String spaceMain(ModelMap model, HttpServletRequest request, HttpServletResponse response) {

	// 추가
	// Liked 좋아요 색깔 설정
    	
    // 12/17 풀 하고 수정 @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
	String guestEmail = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);
	
	long spaceId = HttpUtil.get(request, "spaceId", (long) 0);
	Map<String, Object> likedMap = new HashMap<>();

	// 데이터 추가 ( Liked 좋아요 색깔 설정을 위한 키값 설정 )
	likedMap.put("guestEmail", guestEmail);
	likedMap.put("spaceId", spaceId);

	// 베스트 공간 리스트
	List<Space> bestSpaceList = null;
	// 라이키 공간 리스트
	List<Space> likeySpaceList = null;
	// 최신 공간 리스트
	List<Space> newSpaceList = null;

	// 공간 객체
	Space space = new Space();

	bestSpaceList = spaceService.bestSpaceList(space);
	likeySpaceList = spaceService.likeySpaceList(space);
	newSpaceList = spaceService.newSpaceList(space);

	logger.debug("bestSpaceList@@@@@@@@@@@@@" + bestSpaceList);
	logger.debug("likeySpaceList@@@@@@@@@@@@@" + likeySpaceList);
	logger.debug("newSpaceList@@@@@@@@@@@@@" + newSpaceList);

	// 추가
	// 각 게시물에 대해 사용자가 좋아요를 눌렀는지 체크
	for (Space bestSpaceLikeyColor : bestSpaceList) {
	    // 추가
	    likedMap.put("spaceId", bestSpaceLikeyColor.getSpaceId()); // 현재 게시물의 spaceId를 likedMap에 추가
	    boolean isLiked = spaceService.spaceLikeyColor(likedMap);
	    bestSpaceLikeyColor.setSpaceLiked(isLiked);
	}
	// 추가 좋아요 중복체크 불리안 확인용
	for (Space spaces : bestSpaceList) {
	    System.out.println(spaces.getSpaceLiked());
	}

	// 추가
	// 각 게시물에 대해 사용자가 좋아요를 눌렀는지 체크
	for (Space likeySpaceLikeyColor : likeySpaceList) {
	    // 추가
	    likedMap.put("spaceId", likeySpaceLikeyColor.getSpaceId()); // 현재 게시물의 spaceId를 likedMap에 추가
	    boolean isLiked = spaceService.spaceLikeyColor(likedMap);
	    likeySpaceLikeyColor.setSpaceLiked(isLiked);
	}
	// 추가 좋아요 중복체크 불리안 확인용
	for (Space spaces : likeySpaceList) {
	    System.out.println(spaces.getSpaceLiked());
	}

	// 추가
	// 각 게시물에 대해 사용자가 좋아요를 눌렀는지 체크
	for (Space newSpaceLikeyColor : newSpaceList) {
	    // 추가
	    likedMap.put("spaceId", newSpaceLikeyColor.getSpaceId()); // 현재 게시물의 spaceId를 likedMap에 추가
	    boolean isLiked = spaceService.spaceLikeyColor(likedMap);
	    newSpaceLikeyColor.setSpaceLiked(isLiked);
	}
	// 추가 좋아요 중복체크 불리안 확인용
	for (Space spaces : newSpaceList) {
	    System.out.println(spaces.getSpaceLiked());
	}

	model.addAttribute("bestSpaceList", bestSpaceList);
	model.addAttribute("likeySpaceList", likeySpaceList);
	model.addAttribute("newSpaceList", newSpaceList);

	return "/space/spaceMain";
    }

    @RequestMapping(value = "/space/spaceList", method = RequestMethod.GET)
    public String spaceList(ModelMap model, HttpServletRequest request, HttpServletResponse response) {

	// Liked 좋아요 색깔 설정
	String guestEmail = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);
	long spaceId = HttpUtil.get(request, "spaceId", (long) 0);
	Map<String, Object> likedMap = new HashMap<>();

	// 데이터 추가 ( Liked 좋아요 색깔 설정을 위한 키값 설정 )
	likedMap.put("guestEmail", guestEmail);
	likedMap.put("spaceId", spaceId);

	// reservationTimeBar를 한글 요일로 변환 변수값 잡기
	String reservationWeek = "";

	// 리스트 페이징 페이징 변수 설정
	Integer offset = HttpUtil.get(request, "offset", 0); // 시작 인덱스
	Integer limit = HttpUtil.get(request, "limit", 6); // 가져올 데이터 수

	String spaceAddrBar = HttpUtil.get(request, "spaceAddrBar", "");
	Integer spaceTypeBar = HttpUtil.get(request, "spaceTypeBar", 0);
	Integer spaceMaxCapacityBar = HttpUtil.get(request, "spaceMaxCapacityBar", 0);
	String reservationTimeBar = HttpUtil.get(request, "reservationTimeBar", "");
	String spaceName = HttpUtil.get(request, "spaceName");
	System.out.println("이거 spaceName@@@@@@@@@@@@@@@@@ : " + spaceName);

	
	if (reservationTimeBar != null && reservationTimeBar != "") {
	    // 변환된 요일 값
	    reservationWeek = spaceService.reservationDateChange(reservationTimeBar);
	}

	// 공간 정렬
	Integer spaceSort = HttpUtil.get(request, "spaceSort", 1);

	logger.debug("spaceType.toString()@@@@@@@@@@@@@@@@" + spaceTypeBar.toString());

	// 공간 리스트
	List<Space> spaceList = null;

	// 공간 객체
	Space space = new Space();
	Space search = new Space();

	// 두 번째 조건: 하나라도 비어있지 않으면 실행
	if (!StringUtil.isEmpty(spaceAddrBar) || spaceTypeBar != 0 || spaceMaxCapacityBar != 0
		|| !StringUtil.isEmpty(reservationTimeBar) || !StringUtil.isEmpty(spaceName)) {

	    // `spaceTypeBar`가 비어있지 않으면 그 값을 설정 (첫 번째 조건에서 이미 `spaceType`을 설정한 경우에는 덮어쓰지
	    // 않도록)
	    if (spaceTypeBar != 0) {
		space.setSpaceType(spaceTypeBar);
	    }

	    if (!StringUtil.isEmpty(spaceAddrBar)) {
		space.setSpaceAddr(spaceAddrBar); // 주소 설정
	    }

	    if (spaceMaxCapacityBar != 0) {
		space.setSpaceMaxCapacity(spaceMaxCapacityBar); // 최대 용량 설정
	    }
	    
	    if (!StringUtil.isEmpty(spaceName)) {
	    	space.setSpaceName(spaceName);
	    	System.out.println("이거 spaceName###########################@ : " + spaceName);
	    }

	    if (!StringUtil.isEmpty(reservationTimeBar)) {
		space.setRegDate(reservationTimeBar); // 예약 날짜, ex) 2024-12-19
		space.setReservationWeek(reservationWeek); // 예약 요일 설정 ex) 목
	    }
	}

	if (!StringUtil.isEmpty(spaceSort) && spaceSort != 0) {
	    space.setSpaceSort(spaceSort); // 공간 정렬
	}

	logger.debug("space.getSpaceType: " + space.getSpaceType());
	
	int spaceListTotalCount = spaceService.spaceListCount(space);

	
	// 페이징 변수 설정
	space.setOffset(offset);
	space.setLimit(limit);
	
	// 공간 리스트
	spaceList = spaceService.spaceList(space);
	logger.debug("spaceList@@@@@@@@@@@@@" + spaceList);

	// 추가
	// 각 게시물에 대해 사용자가 좋아요를 눌렀는지 체크
	for (Space spaceLikeyColor : spaceList) {
	    // 추가
	    likedMap.put("spaceId", spaceLikeyColor.getSpaceId()); // 현재 게시물의 spaceId를 likedMap에 추가
	    boolean isLiked = spaceService.spaceLikeyColor(likedMap);
	    spaceLikeyColor.setSpaceLiked(isLiked);
	}
	// 추가 좋아요 중복체크 불리안 확인용
	for (Space spaces : spaceList) {
	    System.out.println(spaces.getSpaceLiked());
	}
	
	System.out.println("이거 spaceName#%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%@ : " + spaceName);

	model.addAttribute("spaceList", spaceList);
	model.addAttribute("spaceListTotalCount", spaceListTotalCount);
	model.addAttribute("spaceAddrBar", spaceAddrBar);
	model.addAttribute("spaceTypeBar", spaceTypeBar);
	model.addAttribute("spaceMaxCapacityBar", spaceMaxCapacityBar);
	model.addAttribute("reservationTimeBar", reservationTimeBar);
	model.addAttribute("spaceName", spaceName);

	model.addAttribute("offset", offset);
	model.addAttribute("limit", limit);

	return "/space/spaceList";
    }

    @RequestMapping(value = "/space/loadMoreSpace", method = RequestMethod.GET)
    @ResponseBody
    public Response<Object> loadMoreSpace(HttpServletRequest request, HttpServletResponse response) {
	Response<Object> ajaxResponse = new Response<Object>();

	// 추가
	// Liked 좋아요 색깔 설정
	
	// 12/17 풀 하고 수정 @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
	String guestEmail = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);
	
	long spaceId = HttpUtil.get(request, "spaceId", (long) 0);
	Map<String, Object> likedMap = new HashMap<>();

	// 데이터 추가 ( Liked 좋아요 색깔 설정을 위한 키값 설정 )
	likedMap.put("guestEmail", guestEmail);
	likedMap.put("spaceId", spaceId);

	// reservationTimeBar를 한글 요일로 변환 변수값 잡기
	String reservationWeek = "";

	// 리스트 페이징 페이징 변수 설정
	// 현재 페이지에서 시작 인덱스
	Integer offset = HttpUtil.get(request, "offset", 0); // 기본값 0
	// 한 번에 가져올 데이터 개수
	Integer limit = HttpUtil.get(request, "limit", 6); // 기본값 6

	// 카테고리 값
	Integer spaceType = HttpUtil.get(request, "mainCateType", 0);

	// 카테고리 값
	String spaceAddrBar = HttpUtil.get(request, "spaceAddrBar", "");
	Integer spaceTypeBar = HttpUtil.get(request, "spaceTypeBar", 0);
	Integer spaceMaxCapacityBar = HttpUtil.get(request, "spaceMaxCapacityBar", 0);
	String reservationTimeBar = HttpUtil.get(request, "reservationTimeBar", "");
	String spaceName = HttpUtil.get(request, "spaceName");

	if (reservationTimeBar != null && reservationTimeBar != "") {
	    // 변환된 요일 값
	    reservationWeek = spaceService.reservationDateChange(reservationTimeBar);
	}

	// 공간 정렬
	Integer spaceSort = HttpUtil.get(request, "spaceSort", 1);

	List<Space> spaceListMore = null;

	// 공간 객체
	Space space = new Space();

	// 페이징 변수 설정
	space.setOffset(offset);
	space.setLimit(limit);

	// 첫 번째 조건: `spaceType`이 비어있지 않으면 설정
	if (!StringUtil.isEmpty(spaceType) && spaceType != 0) {
	    space.setSpaceType(spaceType);
	}

	// 두 번째 조건: 하나라도 비어있지 않으면 실행
	if (!StringUtil.isEmpty(spaceAddrBar) || spaceTypeBar != 0 || spaceMaxCapacityBar != 0
		|| !StringUtil.isEmpty(reservationTimeBar) || !StringUtil.isEmpty(spaceName)) {

	    // `spaceTypeBar`가 비어있지 않으면 그 값을 설정 (첫 번째 조건에서 이미 `spaceType`을 설정한 경우에는 덮어쓰지
	    // 않도록)
	    if (spaceTypeBar != 0 && (StringUtil.isEmpty(spaceType) || spaceType == 0)) {
		space.setSpaceType(spaceTypeBar);
	    }

	    if (!StringUtil.isEmpty(spaceAddrBar)) {
		space.setSpaceAddr(spaceAddrBar); // 주소 설정
	    }

	    if (spaceMaxCapacityBar != 0) {
		space.setSpaceMaxCapacity(spaceMaxCapacityBar); // 최대 용량 설정
	    }
	    
	    if (!StringUtil.isEmpty(spaceName)) {
			space.setSpaceName(spaceName);
		}

	    if (!StringUtil.isEmpty(reservationTimeBar)) {
		space.setRegDate(reservationTimeBar); // 예약 시간 설정
		space.setReservationWeek(reservationWeek); // 예약 요일 설정
	    }
	}

	if (!StringUtil.isEmpty(spaceSort) && spaceSort != 0) {
	    space.setSpaceSort(spaceSort); // 공간 정렬
	}

	try {
	    // 페이징 처리된 데이터 가져오기
	    spaceListMore = spaceService.spaceListMore(space);

	    // 추가
	    // 각 게시물에 대해 사용자가 좋아요를 눌렀는지 체크
	    for (Space spaceLikeyColor : spaceListMore) {
		// 추가
		likedMap.put("spaceId", spaceLikeyColor.getSpaceId()); // 현재 게시물의 spaceId를 likedMap에 추가
		boolean isLiked = spaceService.spaceLikeyColor(likedMap);
		spaceLikeyColor.setSpaceLiked(isLiked);
	    }
	    // 추가 좋아요 중복체크 불리안 확인용
	    for (Space spaces : spaceListMore) {
		System.out.println(spaces.getSpaceLiked());
	    }

	    if (spaceListMore != null && !spaceListMore.isEmpty()) {
		ajaxResponse.setResponse(0, "success", spaceListMore);
	    } else {
		ajaxResponse.setResponse(404, "No data found.");
	    }
	} catch (Exception e) {
	    ajaxResponse.setResponse(500, "internal server error");
	    logger.error("[SpaceController] Error retrieving space list", e);
	}

	return ajaxResponse;
    }

    @RequestMapping(value = "/space/spaceSorting", method = RequestMethod.GET)
    @ResponseBody
    public Response<Object> spaceSorting(HttpServletRequest request, HttpServletResponse response) {
	Response<Object> ajaxResponse = new Response<Object>();

	// 추가
	// Liked 좋아요 색깔 설정
	
	// 12/17 풀 하고 수정@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
	String guestEmail = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);
	
	long spaceId = HttpUtil.get(request, "spaceId", (long) 0);
	Map<String, Object> likedMap = new HashMap<>();

	// 데이터 추가 ( Liked 좋아요 색깔 설정을 위한 키값 설정 )
	likedMap.put("guestEmail", guestEmail);
	likedMap.put("spaceId", spaceId);

	// reservationTimeBar를 한글 요일로 변환 변수값 잡기
	String reservationWeek = "";

	String spaceAddrBar = HttpUtil.get(request, "spaceAddrBar", "");
	Integer spaceTypeBar = HttpUtil.get(request, "spaceTypeBar", 0);
	Integer spaceMaxCapacityBar = HttpUtil.get(request, "spaceMaxCapacityBar", 0);
	String reservationTimeBar = HttpUtil.get(request, "reservationTimeBar", "");
	String spaceName = HttpUtil.get(request, "spaceName");

	if (reservationTimeBar != null && reservationTimeBar != "") {
	    // 변환된 요일 값
	    reservationWeek = spaceService.reservationDateChange(reservationTimeBar);
	}

	// 공간 정렬
	Integer spaceSort = HttpUtil.get(request, "spaceSort", 1);

	List<Space> spaceList = null;

	// 카테고리 값
	Integer spaceType = HttpUtil.get(request, "mainCateType", 0);

	// 공간 객체
	Space space = new Space();

	// 첫 번째 조건: `spaceType`이 비어있지 않으면 설정
	if (!StringUtil.isEmpty(spaceType) && spaceType != 0) {
	    space.setSpaceType(spaceType);
	}

	// 두 번째 조건: 하나라도 비어있지 않으면 실행
	if (!StringUtil.isEmpty(spaceAddrBar) || spaceTypeBar != 0 || spaceMaxCapacityBar != 0
		|| !StringUtil.isEmpty(reservationTimeBar) || !StringUtil.isEmpty(spaceName)) {

	    // `spaceTypeBar`가 비어있지 않으면 그 값을 설정 (첫 번째 조건에서 이미 `spaceType`을 설정한 경우에는 덮어쓰지
	    // 않도록)
	    if (spaceTypeBar != 0 && (StringUtil.isEmpty(spaceType) || spaceType == 0)) {
		space.setSpaceType(spaceTypeBar);
	    }

	    if (!StringUtil.isEmpty(spaceAddrBar)) {
		space.setSpaceAddr(spaceAddrBar); // 주소 설정
	    }

	    if (spaceMaxCapacityBar != 0) {
		space.setSpaceMaxCapacity(spaceMaxCapacityBar); // 최대 용량 설정
	    }
	    
	    if (!StringUtil.isEmpty(spaceName)) {
			space.setSpaceName(spaceName);
		}

	    if (!StringUtil.isEmpty(reservationTimeBar)) {
		space.setRegDate(reservationTimeBar); // 예약 시간 설정
		space.setReservationWeek(reservationWeek); // 예약 요일 설정
	    }
	}

	if (!StringUtil.isEmpty(spaceSort) && spaceSort != 0) {
	    space.setSpaceSort(spaceSort); // 공간 정렬
	}

	try {
	    // 페이징 처리된 데이터 가져오기
	    spaceList = spaceService.spaceList(space);

	    // 추가
	    // 각 게시물에 대해 사용자가 좋아요를 눌렀는지 체크
	    for (Space spaceLikeyColor : spaceList) {
		// 추가
		likedMap.put("spaceId", spaceLikeyColor.getSpaceId()); // 현재 게시물의 spaceId를 likedMap에 추가
		boolean isLiked = spaceService.spaceLikeyColor(likedMap);
		spaceLikeyColor.setSpaceLiked(isLiked);
	    }
	    // 추가 좋아요 중복체크 불리안 확인용
	    for (Space spaces : spaceList) {
		System.out.println(spaces.getSpaceLiked());
	    }

	    if (spaceList != null && !spaceList.isEmpty()) {
		ajaxResponse.setResponse(0, "success", spaceList);
	    } else {
		ajaxResponse.setResponse(404, "No data found.");
	    }
	} catch (Exception e) {
	    ajaxResponse.setResponse(500, "internal server error");
	    logger.error("[SpaceController] Error retrieving space list", e);
	}
	return ajaxResponse;
    }

    // 좋아요 중복 체크
    @RequestMapping(value = "space/likeCheckProc", method = RequestMethod.POST)
    @ResponseBody
    public Response<Object> likeCheckProc(HttpServletRequest request, HttpServletResponse response) {
	Response<Object> ajaxResponse = new Response<Object>();
	
	// 12/17 풀 하고 수정@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
	String guestEmail = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);

	long spaceId = HttpUtil.get(request, "spaceId", (long) 0);

	Map<String, Object> likeMap = new HashMap<>();

	// 데이터 추가 ( 문자만 키값으로 지정 가능함 )
	likeMap.put("guestEmail", guestEmail);
	likeMap.put("spaceId", spaceId);

	logger.error("likeMap: guestEmail = " + guestEmail + ", spaceId = " + spaceId);
	// 또는, likeMap 전체 출력
	logger.error("likeMap: " + likeMap);
	logger.error("spaceService.spaceLikeyCheck(likeMap) " + spaceService.spaceLikeyCheck(likeMap));
	try {
	    if (spaceService.spaceLikeyCheck(likeMap) <= 0) {
		if (spaceService.spaceLikey(likeMap) > 0) {
		    ajaxResponse.setResponse(0, "success");
		} else {
		    ajaxResponse.setResponse(500, "success error");
		}
	    } else {
		if (spaceService.spaceLikeyDel(likeMap) > 0) {
		    ajaxResponse.setResponse(1, "delete success");
		} else {
		    ajaxResponse.setResponse(2, "delete error");
		}
	    }
	}

	catch (Exception e) {
	    logger.error("[BoardController] likeCheckProc Exception", e);
	    ajaxResponse.setResponse(500, "intetnal server error");
	}
	return ajaxResponse;
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
