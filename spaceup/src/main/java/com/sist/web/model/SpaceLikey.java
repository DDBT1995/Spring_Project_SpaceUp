package com.sist.web.model;

import java.io.Serializable;

public class SpaceLikey implements Serializable
{
	private static final long serialVersionUID = 1L;
	
	private String guestEmail;			// 구매자 이메일, 아이디로 사용
	private long spaceId;				// 공간 ID
	
	private String spaceName;			// 공간 명
	private String hostNickname;		// 호스트 닉네임
	private String hostEmail;			// 호스트 이메일, 아이디로 사용
	private String spaceAddr;			// 공간 주소
	private Integer spaceHourlyRate;	// 시간 당 공간 대여비
	private Integer spaceType;
	
	private long startRow;				// 시작페이지(rownum)
	private long endRow;				// 끝페이지(rownum)
	
	public SpaceLikey()
	{
		guestEmail = "";
		spaceId = 0;
		
		spaceName = "";
		hostNickname = "";
		hostEmail = "";
		spaceAddr = "";
		spaceHourlyRate = 0;
		spaceType = 0;
		
		startRow = 0;
		endRow = 0;
	}

	public String getGuestEmail() {
		return guestEmail;
	}

	public void setGuestEmail(String guestEmail) {
		this.guestEmail = guestEmail;
	}

	public long getSpaceId() {
		return spaceId;
	}

	public void setSpaceId(long spaceId) {
		this.spaceId = spaceId;
	}

	public String getSpaceName() {
		return spaceName;
	}

	public void setSpaceName(String spaceName) {
		this.spaceName = spaceName;
	}

	public String getHostNickname() {
		return hostNickname;
	}

	public void setHostNickname(String hostNickname) {
		this.hostNickname = hostNickname;
	}

	public String getHostEmail() {
		return hostEmail;
	}

	public void setHostEmail(String hostEmail) {
		this.hostEmail = hostEmail;
	}

	public String getSpaceAddr() {
		return spaceAddr;
	}

	public void setSpaceAddr(String spaceAddr) {
		this.spaceAddr = spaceAddr;
	}

	public Integer getSpaceHourlyRate() {
		return spaceHourlyRate;
	}

	public void setSpaceHourlyRate(Integer spaceHourlyRate) {
		this.spaceHourlyRate = spaceHourlyRate;
	}

	public Integer getSpaceType() {
		return spaceType;
	}

	public void setSpaceType(Integer spaceType) {
		this.spaceType = spaceType;
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
