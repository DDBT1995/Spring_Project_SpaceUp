package com.sist.web.dao;

import org.springframework.stereotype.Repository;

import com.sist.web.model.SpaceAnswer;

@Repository("spaceAnserDao")
public interface SpaceAnswerDao {
    // QnA 답변 조회, 문의 번호
    public SpaceAnswer selectSpaceAnswerByQuestionId(long spaceQuestionId);
}
