package com.sist.web.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.sist.web.model.Guest;

@Repository("guestDao")
public interface GuestDao {
    // 사용자 조회
    public Guest guestSelect(String guestEmail);

    // 닉네임 중복 체크
    public int guestNicknameDupChk(String guestNickname);

    // 게스트 회원가입
    public int guestReg(Guest guest);

    // 게스트 아이디 찾기
    public List<Guest> findEmailList(String guestTel);

    // 게스트 비밀번호 변경
    public int guestPwdUpdate(Guest guest);

    // 게스트 닉네임 조회
    public Guest guestSelectNick(String guestNickname);

    // 회원정보 관리 비밀번호 확인
    public String guestChkPwd(String guestEmail);

    // 회원정보 수정
    public int guestUpdate(Guest guest);

    // 회원 탈퇴
    public int guestDelete(Guest guest);
}
