package com.spring.jamplan.myinfo;

import java.io.File;
import java.util.ArrayList;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import com.spring.jamplan.model.TeamInfoVO;
import com.spring.jamplan.model.UserVO;

@Controller
public class MyInfoController {
	
	ArrayList<TeamInfoVO> teamListAsLeader = null;
	ArrayList<TeamInfoVO> teamListAsMember = null;
	
	@Autowired(required=false)
	private MyInfoDAO myInfoDAO;
	
	@Autowired(required=false)
	private UserVO updatedUser;
	
	@RequestMapping(value="myInfo.info")
	public ModelAndView getMyInfo(HttpSession session, HttpServletRequest request, ModelAndView mov, UserVO user) {
		System.out.println("getMyInfo IN");
		
		user.setId("thkim9198");
		System.out.println("user id : " + user.getId());
		try {
			teamListAsLeader = myInfoDAO.getTeamListAsLeader(user);
			teamListAsMember = myInfoDAO.getTeamListAsMember(user);
			user = myInfoDAO.getMyInfo(user);
			
			System.out.println("controller 내에서 user = " + user.getId());
			System.out.println("controller 내에서 user = " + user.getEmail());
			System.out.println("controller 내에서 user = " + user.getGender());
			System.out.println("controller 내에서 user = " + user.getNation());
			System.out.println("controller 내에서 user = " + user.getTravelType());
			
			
			mov.addObject("teamListAsLeader", teamListAsLeader);
			mov.addObject("teamListAsMember", teamListAsMember);
			mov.addObject("user", user);
			
		}catch(Exception e) {
			e.printStackTrace();
		}
		mov.setViewName("myInfo/infoPage");
		
		System.out.println("getMyInfo OUT");
		
		return mov;
	}
	
	@RequestMapping(value="/removeTeam.info", method=RequestMethod.POST, produces="application/json;charset=UTF-8")
	@ResponseBody
	public String removeTeam(TeamInfoVO teamInfo) {
		System.out.println("removeTeam In");
		System.out.println(teamInfo.getTeamName());
		String check = String.valueOf(myInfoDAO.removeTeamAsLeader(teamInfo));
		System.out.println("removeTeam Out");
		return check;
	}
	
	@RequestMapping(value="/signOutTeam.info", method=RequestMethod.POST, produces="application/json;charset=UTF-8")
	@ResponseBody
	public String signOutTeam(TeamInfoVO teamInfo) {
		System.out.println("signOutTeam In");
		System.out.println(teamInfo.getTeamName());
		String check = String.valueOf(myInfoDAO.signOutTeamAsMember(teamInfo));
		System.out.println("signOutTeam Out");
		return check;
	}
	
	
	@RequestMapping(value="imageUpload.info")
	public ModelAndView imageUpload(MultipartHttpServletRequest multiRequest, ModelAndView mav, HttpSession session, UserVO user) throws Exception {
		System.out.println("fileUpload IN");		
		
		user.setId((String)session.getAttribute("id"));
		MultipartFile mf = multiRequest.getFile("file");
		
		// 해당 경로에 지정해준 이름의 폴더가 없으면 만들어주게된다.
		String uploadPath = "C:\\BigDeep\\upload\\";
				//"C:\\Users\\Playdata\\Downloads\\0805ProjectHan\\jamplan2\\src\\main\\webapp\\resources\\search\\image\\";
		
		System.out.println("originalFileExtension 들어가기 전");

		// 실제 파일의 확장자
		String originalFileExtension = mf.getOriginalFilename().substring(
				mf.getOriginalFilename().lastIndexOf("."));
		System.out.println(originalFileExtension);

		// 실제 파일명
		String storedFileName = UUID.randomUUID().toString().replaceAll("-", "") + originalFileExtension;
		System.out.println("storedFileName=" + storedFileName);
		if(mf.getSize() != 0) {
			mf.transferTo(new File(uploadPath+storedFileName));
			user.setImage(storedFileName);
		}
		myInfoDAO.setProfileImage(user);
		System.out.println("fileUpload OUT");
		
		try {
			teamListAsLeader = myInfoDAO.getTeamListAsLeader(user);
			teamListAsMember = myInfoDAO.getTeamListAsMember(user);
			updatedUser = myInfoDAO.getMyInfo(user);
			
			mav.setViewName("myInfo/infoPage");
			mav.addObject("teamListAsLeader", teamListAsLeader);
			mav.addObject("teamListAsMember", teamListAsMember);
			
		}catch(Exception e) {
			System.out.println(e.getMessage());
		}
		
		return mav;               
	}
	
	
	@RequestMapping(value="/updateMyInfo.info")
	public ModelAndView updateMyInfo(UserVO user, ModelAndView mav, HttpServletResponse response) throws Exception {
		System.out.println("updateMyInfo In");
		System.out.println(user.getId());
		System.out.println(user.getPass());
		System.out.println(user.getEmail());
		System.out.println(user.getGender());
		System.out.println(user.getTravelType());
		System.out.println(user.getNation());
		System.out.println(user.getHobby());

		myInfoDAO.updateMyInfo(user);
		
		teamListAsLeader = myInfoDAO.getTeamListAsLeader(user);
		teamListAsMember = myInfoDAO.getTeamListAsMember(user);
		updatedUser = myInfoDAO.getMyInfo(user);
		
		mav.addObject("teamListAsLeader", teamListAsLeader);
		mav.addObject("teamListAsMember", teamListAsMember);
		mav.addObject("user", updatedUser);
		mav.setViewName("myInfo/infoPage");
		
		System.out.println("updateMyInfo Out");
		return mav;
	}
	
//	@RequestMapping(value="imageUpload.info", method=RequestMethod.POST, produces="application/json;charset=UTF-8")
//	@ResponseBody
//	public String imageUpload(HttpServletRequest request, HttpSession session, UserVO user) throws Exception {
//		System.out.println("fileUpload IN");
//		System.out.println(request.getParameter("image"));
//		user.setId((String)session.getAttribute("id"));
//		String fileName = request.getParameter("image");
////		MultipartFile mf = request.getFile("image");
////		System.out.println(mf.getOriginalFilename());
////		System.out.println(mf.getContentType());
////		System.out.println(mf.getName());
////		System.out.println(mf.toString());
//		// 해당 경로에 지정해준 이름의 폴더가 없으면 만들어주게된다.
//		String uploadPath = "C:\\BigDeep\\upload\\";
//				//"C:\\Users\\Playdata\\Downloads\\0805ProjectHan\\jamplan2\\src\\main\\webapp\\resources\\search\\image\\";
//		
//		System.out.println("originalFileExtension 들어가기 전");
//
//		// 실제 파일의 확장자
//		String originalFileExtension = fileName.substring(
//				fileName.lastIndexOf("."));
//		System.out.println(originalFileExtension);
//
//		// 실제 파일명
//		String storedFileName = UUID.randomUUID().toString().replaceAll("-", "") + originalFileExtension;
//		System.out.println("storedFileName=" + storedFileName);
//		if(storedFileName.length() != 0) {
////			mf.transferTo(new File(uploadPath+storedFileName));
//			user.setImage(storedFileName);
//			System.out.println("user객체에서의 getImage() >> " + user.getImage());
//			System.out.println("user객체에서의 getId() >> " + user.getId());
//
//		}
//		String result = String.valueOf(myInfoDAO.setProfileImage(user));
//		System.out.println("fileUpload OUT");
//		
//		return result;
//	}
	
}
