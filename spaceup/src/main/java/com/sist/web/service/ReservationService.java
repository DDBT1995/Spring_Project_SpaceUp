package com.sist.web.service;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sist.web.dao.ReservationDao;
import com.sist.web.model.Reservation;

@Service("reservationService")
public class ReservationService {
    private static Logger logger = LoggerFactory.getLogger(ReservationService.class);

    @Autowired
    private ReservationDao reservationDao;

    // 예약 조회
    public Reservation reservationSelect(long reservationId) {
	Reservation reservation = null;
	try {
	    reservation = reservationDao.reservationSelect(reservationId);
	} catch (Exception e) {
	    logger.error("[reservationService] reservationSelect Exception", e);
	}
	return reservation;
    }

    // 예약 게시판 리스트
    public List<Reservation> reservationList(Reservation reservation) {
	List<Reservation> list = null;

	try {
	    list = reservationDao.reservationList(reservation);
	} catch (Exception e) {
	    logger.error("[ReservationService] reservationList Exception", e);
	}

	return list;
    }

    // 총 예약 내역 갯수를 표시하기 위한 쿼리
    public long reservationTotalCount(Reservation reservation) {
	long count = 0;

	try {
	    count = reservationDao.reservTotalCount(reservation);

	} catch (Exception e) {
	    logger.error("[ReservationService] reservationTotalCount Exception", e);
	}

	return count;
    }

    // 작성 가능한 리뷰 리스트
    public List<Reservation> reviewableReservations(Reservation reservation) {
	List<Reservation> list = null;

	try {
	    list = reservationDao.reviewableReservations(reservation);
	} catch (Exception e) {
	    logger.error("[ReviewService] reviewableReservations Exception", e);
	}

	return list;
    }

    // 작성 가능한 리뷰 리스트 총 게시물 수
    public long reviewableCount(String guestEmail) {
	long count = 0;

	try {
	    count = reservationDao.reviewableCount(guestEmail);
	} catch (Exception e) {
	    logger.error("[ReviewService] reviewableCount Exception", e);
	}

	return count;
    }

    // 시퀀스 선택(reservationId)
    public long seqSelect() {
	long reservationId = 0;

	try {
	    reservationId = reservationDao.seqSelect();
	} catch (Exception e) {
	    logger.error("[ReservationService] seqSelect Exception", e);
	}

	return reservationId;
    }

    // 예약 취소
    public int cancelReservation(long reservationId) {
	int count = 0;

	try {
	    count = reservationDao.cancelReservation(reservationId);
	} catch (Exception e) {
	    logger.error("[ReservationService] cancelReservation Exception", e);
	}

	return count;
    }
}
