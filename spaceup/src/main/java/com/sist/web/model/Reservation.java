package com.sist.web.model;

import java.io.Serializable;

public class Reservation implements Serializable
{
	private static final long serialVersionUID = 1L;
	
	private long reservationId;		// 예약 ID, SEQUENCE
	private long spaceId;			// 공간 ID, SEQUENCE
	private Integer spaceType;		// 공간 타입
	private String guestEmail;		// 구매자 이메일, 아이디로 사용
	private String useDate;			// 이용 날짜, ex)20241225
	private int useStartTime;		// 이용 시작 시간, ex) 14
	private int useEndTime;			// 이용 종료 시간, ex) 24
	private int usePeople;			// 사용 인원 수
	private String usePurpose;		// 사용 용도, 255바이트, 한글은 2바이트이므로 한글 127글자 입력 가능
	private String status;			// 예약 상태, P: 진행 중, C: 완료, D: 취소
	private String regDate;			// 예약을 한 날짜
	private String delDate;			// 예약을 취소한 날짜
	
	private String searchValue;		// 예약번호 조회
	
	private long startRow;			// 시작페이지(rownum)
	private long endRow;			// 끝페이지(rownum)
	
	//추가(지영)
	private String spaceName;		// 공간 이름
	private String spaceAddr;		// 공간 주소 (간단히)
	private String hostNickname;		// 호스트 닉네임
	
	private String guestNickname;
	
	public Reservation()
	{
		reservationId = (long)0;
		spaceId = 0;
		spaceType = 0;
		guestEmail = "";
		useDate = "";
		useStartTime = 0;
		useEndTime = 0;
		usePeople = 0;
		usePurpose = "";
		status = "";
		regDate = "";
		delDate = "";
		
		searchValue = "";
		
		startRow = 0;
		endRow = 0;
		
		//추가 지영
		spaceName = "";
		spaceAddr = "";
		hostNickname = "";
		
		guestNickname = "";
	}
	
	

	public String getGuestNickname() {
	    return guestNickname;
	}



	public void setGuestNickname(String guestNickname) {
	    this.guestNickname = guestNickname;
	}



	public String getSpaceName() {
	    return spaceName;
	}

	public void setSpaceName(String spaceName) {
	    this.spaceName = spaceName;
	}

	public Integer getSpaceType() {
		return spaceType;
	}



	public void setSpaceType(Integer spaceType) {
		this.spaceType = spaceType;
	}



	public String getSpaceAddr() {
	    return spaceAddr;
	}

	public void setSpaceAddr(String spaceAddr) {
	    this.spaceAddr = spaceAddr;
	}

	public String getHostNickname() {
	    return hostNickname;
	}

	public void setHostNickname(String hostNickname) {
	    this.hostNickname = hostNickname;
	}

	public long getReservationId() {
		return reservationId;
	}

	public void setReservationId(long reservationId) {
		this.reservationId = reservationId;
	}

	public long getSpaceId() {
		return spaceId;
	}

	public void setSpaceId(long spaceId) {
		this.spaceId = spaceId;
	}

	public String getGuestEmail() {
		return guestEmail;
	}

	public void setGuestEmail(String guestEmail) {
		this.guestEmail = guestEmail;
	}

	public String getUseDate() {
		return useDate;
	}

	public void setUseDate(String useDate) {
		this.useDate = useDate;
	}

	public int getUseStartTime() {
		return useStartTime;
	}

	public void setUseStartTime(int useStartTime) {
		this.useStartTime = useStartTime;
	}

	public int getUseEndTime() {
		return useEndTime;
	}

	public void setUseEndTime(int useEndTime) {
		this.useEndTime = useEndTime;
	}

	public int getUsePeople() {
		return usePeople;
	}

	public void setUsePeople(int usePeople) {
		this.usePeople = usePeople;
	}

	public String getUsePurpose() {
		return usePurpose;
	}

	public void setUsePurpose(String usePurpose) {
		this.usePurpose = usePurpose;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public String getRegDate() {
		return regDate;
	}

	public void setRegDate(String regDate) {
		this.regDate = regDate;
	}

	public String getDelDate() {
		return delDate;
	}

	public void setDelDate(String delDate) {
		this.delDate = delDate;
	}

	public String getSearchValue() {
		return searchValue;
	}

	public void setSearchValue(String searchValue) {
		this.searchValue = searchValue;
	}

	public long getStartRow() {
		return startRow;
	}

	public void setStartRow(long startRow) {
		this.startRow = startRow;
	}

	public long getEndRow() {
		return endRow;
	}

	public void setEndRow(long endRow) {
		this.endRow = endRow;
	}
	
}
