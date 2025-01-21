package com.sist.web.model;

import java.io.Serializable;

public class ReviewLikey implements Serializable {
    private static final long serialVersionUID = 1L;

    private String guestEmail;
    private long reviewId;

    public ReviewLikey() {
	this.guestEmail = "";
	this.reviewId = 0;
    }

    public String getGuestEmail() {
	return guestEmail;
    }

    public void setGuestEmail(String guestEmail) {
	this.guestEmail = guestEmail;
    }

    public long getReviewId() {
	return reviewId;
    }

    public void setReviewId(long reviewId) {
	this.reviewId = reviewId;
    }

}
