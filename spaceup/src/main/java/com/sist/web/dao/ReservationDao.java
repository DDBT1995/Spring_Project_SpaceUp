package com.sist.web.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.sist.web.model.Reservation;

@Repository("reservationDao")
public interface ReservationDao {
    // 예약 조회
    public Reservation reservationSelect(long reservationId);

    // 예약 게시판 리스트
    public List<Reservation> reservationList(Reservation reservation);

    // 총 예약 내역 갯수를 표시하기 위한 쿼리
    public long reservTotalCount(Reservation reservation);

    // 리뷰 작성이 가능한 예약 리스트 조회
    public List<Reservation> reviewableReservations(Reservation reservation);

    // 리뷰 작성이 가능한 총 게시물 수
    public long reviewableCount(String guestEmail);

    // 시퀀스 선택(reservationId)
    public long seqSelect();

    // 예약 등록
    public int reservationInsert(Reservation reservation);

    // 예약 취소
    public int cancelReservation(long reservationId);

}
