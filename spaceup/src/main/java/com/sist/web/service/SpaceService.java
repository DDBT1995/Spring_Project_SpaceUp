package com.sist.web.service;

import java.time.DayOfWeek;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sist.web.dao.SpaceDao;
import com.sist.web.model.Reservation;
import com.sist.web.model.Review;
import com.sist.web.model.ReviewLikey;
import com.sist.web.model.Space;
import com.sist.web.model.SpaceQuestion;

@Service("spaceService")
public class SpaceService {
    private static Logger logger = LoggerFactory.getLogger(ReservationService.class);

    @Autowired
    private SpaceDao spaceDao;

    public Space spaceSelectByReservationId(long reservationId) {
	Space space = null;
	try {
	    space = spaceDao.spaceSelectByReservationId(reservationId);
	} catch (Exception e) {
	    logger.error("[spaceService] spaceSelectByReservationId Exception", e);
	}
	return space;
    }

    public Space spaceSelectById(long spaceId) {
	Space space = null;

	try {
	    space = spaceDao.spaceSelectById(spaceId);
	} catch (Exception e) {
	    logger.error("[spaceService] spaceSelectById Exception", e);
	}
	return space;
    }

    public Space spaceView(long spaceId) {
		Space space = null;
	
		try {
		    space = spaceDao.spaceView(spaceId);
	
		    // 조회수 증가 추가
		    if (space != null) {
			spaceDao.spaceReadCntPlus(spaceId);
		    }
	
		} catch (Exception e) {
		    logger.error("[spaceService] spaceView Exception", e);
		}
	
		return space;
    }

    public List<Review> spaceReview(Review review) {
		List<Review> sRvList = null;
	
		try {
		    sRvList = spaceDao.spaceReview(review);
		} catch (Exception e) {
		    logger.error("[spaceService] spaceReview Exception", e);
		}
	
		return sRvList;
    }

    public long reviewTotalCnt(long spaceId) {
		long totalCnt = 0;
	
		try {
		    totalCnt = spaceDao.reviewTotalCnt(spaceId);
		} catch (Exception e) {
		    logger.error("[spaceService] reviewTotalCnt Exception", e);
		}
	
		return totalCnt;
    }

    public long reviewTotalCntY(long spaceId) {
		long totalCnt = 0;
	
		try {
		    totalCnt = spaceDao.reviewTotalCntY(spaceId);
		} catch (Exception e) {
		    logger.error("[spaceService] reviewTotalCntY Exception", e);
		}
	
		return totalCnt;
    }

    public int reviewReport(Map<String, Object> reviewReportMap) {
		int count = 0;
	
		try {
		    count = spaceDao.reviewReport(reviewReportMap);
		} catch (Exception e) {
		    logger.error("[spaceService] reviewReport Exception", e);
		}
	
		return count;
    }

    public Space spaceSelect(long spaceId) {
		Space space = null;
	
		try {
		    space = spaceDao.spaceView(spaceId);
		} catch (Exception e) {
		    logger.error("[spaceService] spaceSelect Exception", e);
		}
	
		return space;
    }

    public Review reviewSelect(long reviewId) {
		Review review = null;
	
		try {
		    review = spaceDao.reviewSelect(reviewId);
		} catch (Exception e) {
		    logger.error("[spaceService] reviewSelect Exception", e);
		}
	
		return review;
    }

    public int reviewUpdate(Review review) {
		int count = 0;
	
		try {
		    count = spaceDao.reviewUpdate(review);
		} catch (Exception e) {
		    logger.error("[spaceService] reviewUpdate Exception", e);
		}
	
		return count;
    }

    public int reviewDelete(long reviewId) {
		int count = 0;
	
		try {
		    count = spaceDao.reviewDelete(reviewId);
		} catch (Exception e) {
		    logger.error("[spaceService] reviewDelete Exception", e);
		}
	
		return count;
    }

    public List<SpaceQuestion> spaceQuestionList(SpaceQuestion sQ) {
		List<SpaceQuestion> spaceQuestion = null;
	
		try {
		    spaceQuestion = spaceDao.spaceQuestionList(sQ);
		} catch (Exception e) {
		    logger.error("[spaceService] spaceQuestionList Exception", e);
		}
	
		return spaceQuestion;
    }

    public long spaceQuestionTotalCnt(long spaceId) {
		long totalCnt = 0;
	
		try {
		    totalCnt = spaceDao.spaceQuestionTotalCnt(spaceId);
		} catch (Exception e) {
		    logger.error("[spaceService] spaceQuestionTotalCnt Exception", e);
		}
	
		return totalCnt;
    }

    public long spaceQuestionTotalCntY(long spaceId) {
		long totalCnt = 0;
	
		try {
		    totalCnt = spaceDao.spaceQuestionTotalCntY(spaceId);
		} catch (Exception e) {
		    logger.error("[spaceService] spaceQuestionTotalCntY Exception", e);
		}
	
		return totalCnt;
    }

    public int questionInsert(SpaceQuestion sQ) {
		int count = 0;
	
		try {
		    count = spaceDao.questionInsert(sQ);
		} catch (Exception e) {
		    logger.error("[spaceService] questionInsert Exception", e);
		}
	
		return count;
    }

    public int questionUpdate(SpaceQuestion sQ) {
		int count = 0;
	
		try {
		    count = spaceDao.questionUpdate(sQ);
		} catch (Exception e) {
		    logger.error("[spaceService] questionUpdate Exception", e);
		}
	
		return count;
    }

    public int questionDelete(long spaceQuestionId) {
		int count = 0;
	
		try {
		    count = spaceDao.questionDelete(spaceQuestionId);
		} catch (Exception e) {
		    logger.error("[spaceService] questionDelete Exception", e);
		}
	
		return count;
    }

    public int questionUserSelect(SpaceQuestion sQ) {
		int count = 0;
	
		try {
		    count = spaceDao.questionUserSelect(sQ);
		} catch (Exception e) {
		    logger.error("[spaceService] questionUserSelect Exception", e);
		}
	
		return count;
    }
    
	public int reviewLikeySelete(ReviewLikey reviewLikey) {
		int rkCnt = 0;
		int count = 0;
		
		try {
			rkCnt = spaceDao.reviewLikeySelect(reviewLikey);
			
			if(rkCnt > 0) {
				if(spaceDao.reviewLikeyDelete(reviewLikey) > 0) {
					count = 1;
				}
			} else {
				if(spaceDao.reviewLikeyInsert(reviewLikey) > 0) {
					count = 2;
				}
			}
		} catch(Exception e) {
			logger.error("[spaceService] reviewLikeySelete Exception", e);
		}
		
		return count; 
	}
	
	public List<int[]> reservationSelect(Reservation reservation) {
		Space sapceSelect = spaceDao.spaceSelect(reservation.getSpaceId());
		List<Reservation> reservationList = spaceDao.reservationSelect(reservation);
		
        // 전체 예약 가능한 시간 범위
        int startTime = sapceSelect.getSpaceStartTime();
        int endTime = sapceSelect.getSpaceEndTime();

        // 예약된 시간 목록
        List<int[]> reservedSlots = new ArrayList<>();
        
        if(reservationList.size() > 0) {
        	for(int i = 0; i < reservationList.size(); i++) {
        		reservedSlots.add(new int[]{reservationList.get(i).getUseStartTime(), reservationList.get(i).getUseEndTime()});
        	}        	
        }

        // 최소 예약 시간
        int minReservationTime = sapceSelect.getMinReservationTime();

        // 예약 가능한 시간 계산
        List<int[]> availableSlots = calculateAvailableSlots(startTime, endTime, reservedSlots, minReservationTime);

        // 결과 출력
        for (int[] slot : availableSlots) {
            System.out.println(slot[0] + "시 ~ " + slot[1] + "시");
        }
        
        return availableSlots;
    }

    private static List<int[]> calculateAvailableSlots(int start, int end, List<int[]> reservedSlots, int minReservationTime) {
        List<int[]> availableSlots = new ArrayList<>();
        int currentTime = start;

        for (int[] reserved : reservedSlots) {
            int reservedStart = reserved[0];
            int reservedEnd = reserved[1];

            // 현재 시간과 예약 시작 시간 사이의 빈 시간 계산
            if (currentTime < reservedStart) {
                int availableStart = currentTime;
                int availableEnd = reservedStart;
                
                if(availableStart == start) {
                	if (availableEnd - (availableStart) >= minReservationTime) {
                        availableSlots.add(new int[]{availableStart, availableEnd});
                    }
                } else {
                	// 최소 예약 시간을 만족하는 경우만 추가
                    if (availableEnd - (availableStart) >= minReservationTime) {
                        availableSlots.add(new int[]{availableStart, availableEnd});
                    }
                }
                
            }

            // 예약 종료 시간 이후로 현재 시간 이동
            currentTime = reservedEnd;
        }

        // 마지막 예약 이후의 시간 처리
        if (currentTime <= end) {
            int availableStart = currentTime;
            int availableEnd = end;
            
            if(reservedSlots.size() == 0) {
            	if (availableEnd - availableStart >= minReservationTime) {
                    availableSlots.add(new int[]{availableStart, availableEnd});
                }
        	} else {
        		if (availableEnd - (availableStart - 1) >= minReservationTime) {
                    availableSlots.add(new int[]{availableStart, availableEnd});
                }
        	}
        }

        return availableSlots;
    }



    // 베스트 공간 리스트
    public List<Space> bestSpaceList(Space space) {
	List<Space> bestSpaceList = null;

	try {
	    bestSpaceList = spaceDao.bestSpaceList(space);
	} catch (Exception e) {
	    logger.error("[SpaceService] bestSpaceList Exception", e);
	}

	return bestSpaceList;
    }

    // 라이키 공간 리스트
    public List<Space> likeySpaceList(Space space) {
	List<Space> likeySpaceList = null;

	try {
	    likeySpaceList = spaceDao.likeySpaceList(space);
	} catch (Exception e) {
	    logger.error("[SpaceService] likeySpaceList Exception", e);
	}

	return likeySpaceList;
    }

    // 최신 공간 리스트
    public List<Space> newSpaceList(Space space) {
	List<Space> newSpaceList = null;

	try {
	    newSpaceList = spaceDao.newSpaceList(space);
	} catch (Exception e) {
	    logger.error("[SpaceService] newSpaceList Exception", e);
	}

	return newSpaceList;
    }

    // 공간 리스트
    public List<Space> spaceList(Space space) {
	List<Space> spaceList = null;

	try {
	    spaceList = spaceDao.spaceList(space);
	} catch (Exception e) {
	    logger.error("[SpaceService] spaceList Exception", e);
	}

	return spaceList;
    }

    // 공간 리스트
    public List<Space> spaceListMore(Space space) {
	List<Space> spaceListMore = null;

	try {
	    spaceListMore = spaceDao.spaceListMore(space);
	} catch (Exception e) {
	    logger.error("[SpaceService] spaceListMore Exception", e);
	}

	return spaceListMore;
    }

    // 공간 좋아요
    public int spaceLikey(Map<String, Object> likeMap) {
	int spaceLikey = 0;

	try {
	    spaceLikey = spaceDao.spaceLikey(likeMap);
	} catch (Exception e) {
	    logger.error("[SpaceService] spaceLikey Exception", e);
	}

	return spaceLikey;
    }

    // 공간 좋아요 중복체크
    public int spaceLikeyCheck(Map<String, Object> likeMap) {
	int spaceLikeyCheck = 0;

	try {
	    spaceLikeyCheck = spaceDao.spaceLikeyCheck(likeMap);
	} catch (Exception e) {
	    logger.error("[SpaceService] spaceLikeyCheck Exception", e);
	}

	return spaceLikeyCheck;
    }

    // 공간 좋아요 삭제
    public int spaceLikeyDel(Map<String, Object> likeMap) {
	int spaceLikeyDel = 0;

	try {
	    spaceLikeyDel = spaceDao.spaceLikeyDel(likeMap);
	} catch (Exception e) {
	    logger.error("[SpaceService] spaceLikeyDel Exception", e);
	}

	return spaceLikeyDel;
    }

    // 공간 좋아요 색깔 설정
    public boolean spaceLikeyColor(Map<String, Object> likeMap) {
	int count = 0;

	try {
	    count = spaceDao.spaceLikeyCheck(likeMap);
	} catch (Exception e) {
	    logger.error("[SpaceService] spaceLikeyColor Exception", e);
	}

	return count > 0; // 좋아요가 있다면 true, 없다면 false
    }

    //
    public String reservationDateChange(String reservationDate) {
	String inputDate = reservationDate; // 입력 값 (String 타입)
	String dayOfWeekString = "";
	String dayOfWeekNumber = "";

	// 한글 요일 배열
	String[] koreanDays = { "일", "월", "화", "수", "목", "금", "토" };

	try {
	    // 1. 문자열을 LocalDate로 변환
	    DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
	    LocalDate date = LocalDate.parse(inputDate, formatter);

	    // 2. DayOfWeek 객체 구하기
	    DayOfWeek dayOfWeek = date.getDayOfWeek();

	    // 3. 숫자 요일 구하기 (1: 월요일, 7: 일요일)

	    dayOfWeekNumber = String.valueOf(dayOfWeek.getValue());

	    // 4. 영어 요일을 한글로 매핑
	    dayOfWeekString = koreanDays[dayOfWeek.getValue() % 7]; // 일요일을 0으로 맞추기 위해 % 7

	    // 5. 출력
	    System.out.println("입력 날짜: " + inputDate);
	    System.out.println("요일: " + dayOfWeek); // 예: THURSDAY
	    System.out.println("요일 번호: " + dayOfWeekNumber); // 예: 4 (목요일)
	    System.out.println("한글로 매핑한 요일: " + dayOfWeekString); // 한글로 매핑한 요일

	} catch (Exception e) {
	    System.err.println("예외 발생: " + e.getMessage());
	}

	return dayOfWeekString;
    }
    
    // 공간 수
    public int spaceListCount(Space space) {
	int count = 0;

	try {
	    count = spaceDao.spaceListCount(space);
	} catch (Exception e) {
	    logger.error("[SpaceService] spaceListCount Exception", e);
	}

	return count;
    }
}
