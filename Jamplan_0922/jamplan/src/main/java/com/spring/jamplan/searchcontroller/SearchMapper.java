package com.spring.jamplan.searchcontroller;

import java.util.ArrayList;
import java.util.List;

import com.spring.jamplan.model.LikeVO;
import com.spring.jamplan.model.PlanVO;
import com.spring.jamplan.model.UserVO;


public interface SearchMapper {
	List<PlanVO> getPlanList();
	/*int fileUpload(PlanVO planVO);*/
	ArrayList<PlanVO> planSearch(PlanVO planVO);
	ArrayList<PlanVO> clickSearch(PlanVO planVO);
	void moveSchedule();
	UserVO getUserId(String id);
	/*LikeVO likeUserId(String userId); //라이크-로그인db에서 받아오기*/
	ArrayList<LikeVO> getLikeCount(LikeVO likeVO);
	ArrayList<LikeVO> getLikeData(LikeVO likeVO);
	void insertLikeData(LikeVO likeVO);
	void updateLikeData(LikeVO likeVO);
	void updateTotalLike(LikeVO likeVO);
	void updateReadCount(PlanVO planVO);
	
	
}
