package com.sist.web.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.sist.web.model.SpaceLikey;

@Repository("spaceLikeyDao")
public interface SpaceLikeyDao {
    // 공간 좋아요 리스트
    public List<SpaceLikey> spaceLikeyList(SpaceLikey spaceLikey);

    // 공간 좋아요 총 갯수
    public long spaceLikeyCount(SpaceLikey spaceLikey);

    // 좋아요 등록(인서트)
    public int addLikey(SpaceLikey spaceLikey);

    // 좋아요 취소
    public int deleteLikey(SpaceLikey spaceLikey);

    // 좋아요 중복체크
    public int checkLikey(SpaceLikey spaceLikey);

    // 한 게시물 당 좋아요 총 카운트
    public int spaceIdLikeyCount(long spaceId);
}
