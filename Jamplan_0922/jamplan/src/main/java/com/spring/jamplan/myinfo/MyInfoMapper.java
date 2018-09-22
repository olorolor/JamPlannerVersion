package com.spring.jamplan.myinfo;

import java.util.ArrayList;

import org.springframework.stereotype.Service;

import com.spring.jamplan.model.TeamInfoVO;
import com.spring.jamplan.model.UserVO;

@Service
public interface MyInfoMapper {
	
	UserVO getMyInfo(UserVO user);
	int updateMyInfo(UserVO user);
	int setProfileImage(UserVO user);
	
	ArrayList<TeamInfoVO> getTeamListAsLeader(UserVO user);
	ArrayList<TeamInfoVO> getTeamListAsMember(UserVO user);
	int removeTeamAsLeader(TeamInfoVO teamInfo);
	int signOutTeamAsMember(TeamInfoVO teamInfo);
	
	int removeTeam(TeamInfoVO teamInfo);
	int removeUser(UserVO user);
}
