package com.sist.web.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.sist.web.model.SpaceQuestion;

@Repository("spaceQuestionDao")
public interface SpaceQuestionDao {
    // QnA조회, 작성자
    public List<SpaceQuestion> selectSpaceQuestionByGuest(SpaceQuestion search);
    
    // 문의 갯수, 작성자
    public int spaceQuestionListCount(String guestEmail);
}
