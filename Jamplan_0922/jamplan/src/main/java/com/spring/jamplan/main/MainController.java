package com.spring.jamplan.main;

import java.io.File;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.spring.jamplan.model.PlanVO;
import com.spring.jamplan.model.TeamInfoVO;
import com.spring.jamplan.model.UserVO;
import com.spring.jamplan.myroom.MyRoomDAOService;

@Controller
public class MainController {
	@Autowired(required = true)
	UserVO userVO;

	@Autowired
	MainDAOService mDAOS;
	/*
	 *
	 * 
	 * @Autowired TeamVO teamVo;
	 * 
	 * @RequestMapping("login.main") public ModelAndView loginMain(Http session,
	 * UserVO userVO, ModelAndView mav) {
	 * 
	 * System.out.println("login ID : " + userVO.getId() + " PW : " +
	 * userVO.getPass());
	 * 
	 * UserVO vo = mDAOS.getUserInfo(userVO); ArrayList<TeamVO> teamList =
	 * mDAOS.getTeamInfo(userVO.getId());
	 * System.out.println(teamList.get(0).getPlanNo()); mav.addObject("userVO", vo);
	 * //mav.addObject("map",map); mav.setViewName("managePlan/main");
	 * session.setAttribute("id", userVO.getId()); session.setAttribute("planNo",
	 * teamList.get(0).getPlanNo()); //vo.printElement(); return mav;
	 * 
	 * }
	 */

	@Autowired
	TeamInfoVO teamVo;

	@Autowired
	MyRoomDAOService myRoomDAO;

	@RequestMapping("/home.do")
	public String home(Locale locale, Model model) {
		System.out.println("AAAAAAA");
		return "main/JamHome";
	}

	@RequestMapping(value = "/emailConfirm.do", method = RequestMethod.GET)
	public String emailConfirm(UserVO vo, Model model, HttpServletResponse response) throws Exception { // 이메일인증
		System.out.println("emailConfirm.do 컨트롤러 진입");
		System.out.println("vo.getId()=" + vo.getId() + "의 이메일 인증 ");
		PrintWriter out = response.getWriter();
		response.setContentType("text/html; charset=UTF-8");
		String str = "";
		UserVO uservo = mDAOS.getUserInfo(vo.getId());
		if (!(uservo == null)) {
			System.out.println("uservo.getAuthCode()=" + uservo.getAuthCode());
			System.out.println("vo.getAuthCode()=" + vo.getAuthCode());
			if (uservo.getAuthCode().equals(vo.getAuthCode())) {
				System.out.println("db코드와 비교");
				vo.setAuthCode("Y");
				mDAOS.update(vo);
				model.addAttribute("email", uservo.getEmail());
				System.out.println("uservo.getAuthcode()=" + uservo.getAuthCode());
				str = "main/mainPage";
			} else {
				out.println("<script>alert('잘못된 요청입니다1');</script>");
				out.flush();
				str = "main/mainPage";
			}
		} else {
			out.println("<script>alert('잘못된 요청입니다2');</script>");
			out.flush();
			str = "main/mainPage";
		}
		return str;
	}

	@RequestMapping("/login.do")
	public String loginMain(HttpSession session, UserVO userVO, Model model, HttpServletResponse response)
			throws Exception {
		PrintWriter out = response.getWriter();
		response.setContentType("text/html; charset=UTF-8");
		String str = "";
		System.out.println("ID : " + userVO.getId() + " PW : " + userVO.getPass());
		UserVO vo = mDAOS.getUserInfo(userVO.getId());
		/* ArrayList<TeamVO> teamList = mDAOS.getTeamInfo(userVO.getId()); */

		// mav.addObject("map",map);

		if (!(vo == null)) {
			// id가 있고 pass워드가 같을 때
			if (vo.getPass().equals(userVO.getPass())) {
				if (vo.getAuthCode().equals("Y")) {
					session.setAttribute("id", vo.getId());
					model.addAttribute("id", vo.getId());
				} else {
					System.out.println("이메일 인증안된 아이디=" + vo.getId());
					out.println("<script>alert('이메일 인증을 해주세요');</script>");
					out.flush();
				}
				str = "main/mainPage";
				// 아이디는 있으나 패스워드 틀렸을 때
			} else {
				out.println("<script>alert('password error');</script>");
				out.flush();
				str = "main/mainPage";
			}
		}

		else {
			out.println("<script>alert('id error');</script>");
			out.flush();
			str = "main/mainPage";
			// return "redirect:/loginform.me";
		}
		// vo.printElement();
		return str;
	}

	@RequestMapping("/join.do")
	public String JoinMain(UserVO vo, Model model, HttpServletResponse response) throws Exception {
		PrintWriter out = response.getWriter();
		response.setContentType("text/html; charset=UTF-8");
		System.out.println("vo.getId()=" + vo.getId());
		String str = "";

		int count = mDAOS.idcheck(vo.getId());
		System.out.println("count=" + count);
		if (count == 0) {
			vo.setIsAdmin(0);
			mDAOS.create(vo);
			out.println("<script>alert('회원가입 성공');</script>");
			out.println("<script>alert('이메일 인증을 완료하시면 로그인이 가능합니다');</script>");
			out.flush();
			str = "main/mainPage";
		} else {
			out.println("<script>alert('아이디 중복체크를 해주세요');</script>");
			out.flush();
			str = "main/mainPage";
		}
		return str;
	}

	@RequestMapping("/idcheck.do")
	@ResponseBody
	public Map<Object, Object> idcheck(@RequestBody String userid) {

		int count = 0;
		Map<Object, Object> map = new HashMap<Object, Object>();

		count = mDAOS.idcheck(userid);
		map.put("cnt", count);

		return map;
	}

	@RequestMapping("/logout.do")
	public String logout(Model model, HttpServletRequest request) {
		request.getSession().removeAttribute("id");
		return "main/mainPage";
	}

	@RequestMapping("/myroom.do")
	public ModelAndView myroom(HttpSession session, UserVO vo, ModelAndView mav) {
		System.out.println("searchplan이동성공");
		if (session.getAttribute("id") != null) {
			String id = (String) session.getAttribute("id");
			vo = mDAOS.getUserInfo(id);
			System.out.println("vo.getImage() = " + vo.getImage() + "입니다. ");
			mav.addObject("userVO", vo);
			mav.setViewName("myRoom/myRoomPage");
			System.out.println("userVO속성에 vo객체 담았음");
		} else {
			mav.setViewName("myRoom/myRoomPage");
		}
		return mav;
	}

	@RequestMapping("/searchplan.do")
	public ModelAndView searchplan(HttpSession session, UserVO vo, ModelAndView mav) {
		System.out.println("searchplan이동성공");
		if (session.getAttribute("id") != null) {
			String id = (String) session.getAttribute("id");
			vo = mDAOS.getUserInfo(id);
			mav.addObject("userVO", vo);
			mav.setViewName("search/searchPlanPage");
			System.out.println("userVO속성에 vo객체 담았음");
		} else {
			mav.setViewName("search/searchPlanPage");
		}
		return mav;
	}

	@RequestMapping("/fileUpload.do")
	public String fileUpload(MultipartHttpServletRequest multiRequest, PlanVO planVO) throws Exception {
		System.out.println("1");

		MultipartFile mf = multiRequest.getFile("file");
		String uploadPath = "C:\\BigDeep\\upload\\";
		// "C:\\Users\\Playdata\\Downloads\\0805ProjectHan\\jamplan2\\src\\main\\webapp\\resources\\search\\image\\";

		String originalFileExtension = mf.getOriginalFilename().substring(mf.getOriginalFilename().lastIndexOf("."));
		String storedFileName = UUID.randomUUID().toString().replaceAll("-", "") + originalFileExtension;
		System.out.println("storedFileName=" + storedFileName);
		if (mf.getSize() != 0) {
			mf.transferTo(new File(uploadPath + storedFileName));
			planVO.setImage(storedFileName);
		}
		int check = mDAOS.fileUpload(planVO);
		return "main/mainPage";
	}

	@RequestMapping(value = "/imgJson.do", method = RequestMethod.GET, produces = "application/json;charset=utf-8")
	@ResponseBody
	public String getPlanGET() {
		System.out.println("제이슨 접근 전");
		List<PlanVO> list = mDAOS.getPlanjson();
		System.out.println("제이슨 접근 후");
		String var = list.get(1).getPlanName();
		String img = list.get(1).getImage();
		System.out.println("var=" + var);
		System.out.println("img=" + img);
		String str = "";

		ObjectMapper mapper = new ObjectMapper();
		try {
			str = mapper.writeValueAsString(list);
		} catch (Exception e) {
			System.out.println("firest() mapper :" + e.getMessage());
		}
		return str;
	}
	
}
