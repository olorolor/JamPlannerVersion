package com.spring.jamplan.manageplan;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.spring.jamplan.model.CalendarVO;
import com.spring.jamplan.model.MapVO;
import com.spring.jamplan.model.UserVO;



@Controller
public class ManagePlanController {


	@Autowired(required = false) 
	private UserVO user;

	@Autowired(required = false)	
	private ManagePlanDAOService mpDAOS;
	
	@Autowired(required = false) 
	private ChatDAOService chatDAO;

	private HashMap<String, Object> map;
	private ObjectMapper mapper;
	
	//map 지은 
	//test
	/*   @RequestMapping(value="mapPage.mp")
	   public String mapPage() {
	      return "managePlan/mapPage";
	   }*/
	   
	   @RequestMapping(value="getAllPickList.mp", method = RequestMethod.POST,   produces="application/json;charset=UTF-8")
	   @ResponseBody
	   public String getAllPickList(MapVO mapVO) {      //클래스 타입 확인   
	      System.out.println("why");
	      List<MapVO> allPickList = mpDAOS.getAllPickList(mapVO);
	      System.out.println("why2");
	      String str="";
	      ObjectMapper mapper = new ObjectMapper();
	      try {
	         System.out.println("listcontrollerfirst");
	         str = mapper.writeValueAsString(allPickList);
	         System.out.println("listcontrollelast");
	         System.out.println("allPickList 메소드: " + str);
	      }catch(Exception e) {
	         System.out.println("first() mapper: " + e.getMessage());
	      }
	      return str;   
	   }   
	   
	   @RequestMapping(value="getPickList.mp", method = RequestMethod.POST, produces="application/json;charset=UTF-8")
	   @ResponseBody
	   public String getPickList(MapVO mapVO) {      //클래스 타입 확인      
	      List<MapVO> pickList = mpDAOS.getPickList(mapVO);
	      System.out.println("controllerPickList");
	      String str="";
	      ObjectMapper mapper = new ObjectMapper();
	      try {
	         System.out.println("listcontrollerfirst");
	         str = mapper.writeValueAsString(pickList);
	         System.out.println("listcontrollelast");
	         System.out.println("pickList 메소드: " + str);
	      }catch(Exception e) {
	         System.out.println("first() mapper: " + e.getMessage());
	      }
	      return str;   
	   }
	      
	   @RequestMapping(value="insertMember.mp", method = RequestMethod.POST, produces="application/json;charset=UTF-8")
	   @ResponseBody
	   public Map<String, Object> insertMember(MapVO mapVO) {
	      int check, pickNum = 0;
	      Map<String, Object> retVal = new HashMap<String, Object>(); 
	      
	      try {
	         System.out.println("Checkcontrollerfirst");
	         System.out.println(mapVO.getUserColor());
	         
	         check = mpDAOS.checkPick(mapVO);    //이 장소를 pick했는지 체크
	          
	         if(check==0) {   //pick한 적 없음
	            System.out.println("Checkcontroller3");
	            mpDAOS.insertMember(mapVO);      //데이터 삽입
	            pickNum=mpDAOS.pickCount(mapVO);   //pick한 멤버카운트
	            
	            mapVO.setPickCount(pickNum);
	            mpDAOS.updatePickCount(mapVO);   //데이터삽입후 pickCount수정
	            
	            System.out.println("mapVO.getId()=" + mapVO.getId());
	            System.out.println("mapVO.getLocation()=" + mapVO.getPlaceName());
	            System.out.println(pickNum);         
	            
	            //managePlanDAOService.updatePickCount(mapVO);            
	            retVal.put("pickNum", pickNum);
	            
	         }
	         else{
	            System.out.println("whhathat");
	         }
	         System.out.println("Checkcontrollersecond");
	         
	         retVal.put("res", "OK"); 
	      }
	      catch (Exception e)
	      {
	         retVal.put("res", "FAIL");
	         retVal.put("message", "Failure");
	         System.out.println(retVal);
	      }
	      return retVal; 
	   }   
	   
	   @RequestMapping(value="deleteMember.mp", method = RequestMethod.POST, produces="application/json;charset=UTF-8")
	   @ResponseBody
	   public Map<String, Object> deleteMember(MapVO mapVO) {
	      int pickNum, check;
	      Map<String, Object> retVal = new HashMap<String, Object>(); 
	      
	      try {
	         System.out.println("vo11.getId()=" + mapVO.getId());
	         check = mpDAOS.checkPick(mapVO);
	         System.out.println(check);
	         if(check==1){   //해당 장소를 pick했을때
	        	 mpDAOS.deleteMember(mapVO);   //pick취소
	            pickNum = mpDAOS.pickCount(mapVO);   //pick한 멤버카운트
	            System.out.println("deleteController1");
	            mapVO.setPickCount(pickNum);
	            mpDAOS.updatePickCount(mapVO);      //데이터삭제후 pickCount수정
	            System.out.println("deleteController2");
	            retVal.put("pickNum", pickNum);      //pickCount를 마커에 집어넣기 위해      
	            System.out.println(pickNum);         
	         }
	         retVal.put("res", "OK");
	      }
	      catch (Exception e)
	      {
	         retVal.put("res", "FAIL");
	         retVal.put("message", "Failure");
	      }
	      return retVal; 
	   }   
	   
	   @RequestMapping(value="confirmPlace.mp", method = RequestMethod.POST, produces="application/json;charset=UTF-8")
	   @ResponseBody
	   public Map<String, Object> confirmPlace(MapVO mapVO, String[] placeList){      
	      List<String> confirmPlaceList = new ArrayList<String>();
	      Map<String, Object> hm = new HashMap<String, Object>(); 
	      Map<String, Object> retVal = new HashMap<String, Object>();
	      
	      System.out.println("confirmPlaceController");
	      try {
	         for(String str:placeList) {      //placeList바로 사용못함
	            confirmPlaceList.add(str);         
	         }
	         System.out.println("confirmPlaceList="+confirmPlaceList);
	         
	         hm.put("confirmPlaceList", confirmPlaceList);
	         /*hm.put("planNo", planNoList);
	         hm.put("selectDate", selectDateList);*/
	         hm.put("planNo", mapVO.getPlanNo());
	         hm.put("selectDate", mapVO.getSelectDate());
	         
	         System.out.println(hm);
	         System.out.println("confirmController1");
	         mpDAOS.confirmPlace(hm);
	         System.out.println("confirmController2");
	         
	         retVal.put("res", "OK");
	      }
	      catch (Exception e)
	      {
	         retVal.put("res", "FAIL");
	         retVal.put("message", "Failure");
	      }
	      
	      return retVal; 
	   }
	   
	   @RequestMapping(value="resetPlace.mp", method = RequestMethod.POST, produces="application/json;charset=UTF-8")
	   @ResponseBody
	   public Map<String, Object> resetPlace(MapVO mapVO){
	      System.out.println("resetplaceController");
	      Map<String, Object> retVal = new HashMap<String, Object>();
	      
	      try {
	    	  mpDAOS.resetPlace(mapVO);   
	         retVal.put("res", "OK");
	      }
	      catch (Exception e)
	      {
	         retVal.put("res", "FAIL");
	         retVal.put("message", "Failure");
	      }
	      
	      return retVal;
	   }
	   
	   
	   @RequestMapping(value="changeColor.mp", method = RequestMethod.POST, produces="application/json;charset=UTF-8")
	   @ResponseBody
	   public Map<String, Object> changeColor(MapVO mapVO){
	      System.out.println("changeColorController");
	      Map<String, Object> retVal = new HashMap<String, Object>();
	      
	      try {
	         System.out.println("mapVO.getPlanNo():" + mapVO.getPlanNo() + " mapVO.getUserColor():" + mapVO.getUserColor());
	         mpDAOS.changeColor(mapVO);   
	         retVal.put("res", "OK");
	      }
	      catch (Exception e)
	      {
	         retVal.put("res", "FAIL");
	         retVal.put("message", "Failure");
	      }
	      
	      return retVal;
	   }
	   
	   @RequestMapping(value="getSelectDate.mp", method = RequestMethod.POST, produces="application/json;charset=UTF-8")
	   @ResponseBody
	   public String getSelectDate(HttpSession session){
		   System.out.println("컨트롤러 들어옴===============");
		   int planNo = (int)session.getAttribute("planNo");
		   System.out.println("======getSelectDate  plan No : "+planNo);
		   CalendarVO vo = new CalendarVO();
		   vo.setPlanNo(planNo);
		   List<MapVO> selectDateList = mpDAOS.getSelectDateMap(vo);
		   
		   String str="";
	       ObjectMapper mapper = new ObjectMapper();
	       try {
	          System.out.println("getselectDatecontrolle2");
	          for(int i = 0; i<selectDateList.size();i++) {
	        	  System.out.println("===========select date : "+selectDateList.get(i).getSelectDate());
	          }
	          str = mapper.writeValueAsString(selectDateList);
	          System.out.println("str=" + str);
	       }catch(Exception e) {
	          System.out.println("first() mapper: " + e.getMessage());
	       }

	      return str;   
	   }
	//end map 지은
	
//	@RequestMapping(value = "/main.mp")
//	public String mainLoad() {
//		
//		
//		return "managePlan/main";
//	}
	
	// 웹소켓 테스트를 위한 부분
	@RequestMapping(value = "/main.mp")
	public String mainLoad(HttpSession session, UserVO user) {
		
		session.setAttribute("id", user.getId());
		
		return "managePlan/main";
	}

	@RequestMapping(value = "/selectCalendar.mp", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public Map<String, Object> calendarSelect(HttpSession session, CalendarVO vo) {
		vo.setId((String) session.getAttribute("id"));
		vo.setPlanNo((int) session.getAttribute("planNo"));
		mpDAOS.insertSelectDate(vo);

		map = new HashMap<String, Object>();
		map.put("res", "ok");
		return map;
	}
	
	@RequestMapping(value = "/getMemberId.mp", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody 
	public String getMemberId(HttpSession session) {
		int planNo = (int)session.getAttribute("planNo");
		ArrayList<CalendarVO> voList = mpDAOS.getMemberId(planNo);
		
		mapper = new ObjectMapper();// json형식으로 데이터를 반환하기 위해 사용(pom.xml 편집)
		String str = "";
		try {
			str = mapper.writeValueAsString(voList);
			System.out.println("확인 : "+voList.get(0).getId());
		} catch (Exception e) {
			// TODO: handle exception
			System.out.println("castring fail");
		}
		return str;
		
	}

	// 선택한 날짜 디비에서 불러오는 컨트롤러 json으로 해당 데이터 보내기
	@RequestMapping(value = "/loadCalendar.mp", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String calendarLoadDate(HttpSession session) {
		ArrayList<CalendarVO> calVO = mpDAOS.getSelectDate((int) session.getAttribute("planNo"));
		mapper = new ObjectMapper();// json형식으로 데이터를 반환하기 위해 사용(pom.xml 편집)
		String str = "";
		try {
			str = mapper.writeValueAsString(calVO);
			//System.out.println("확인 : "+calVO.get(0).getConfirmed());
		} catch (Exception e) {
			// TODO: handle exception
			System.out.println("castring fail");
		}
		return str;
	}
	//방장(혹은팀원)이 날짜를 확정 지으면 update문으로 해당 일정 업데이트 + 삽입
	@RequestMapping(value = "/fixcal.mp", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	//json받을 떄 필수다 리스폰스 바디
	@ResponseBody
	public HashMap<String, Object> fixDate(HttpSession session, CalendarVO vo) {
		
		vo.setId((String)session.getAttribute("id"));
		vo.setPlanNo((int)session.getAttribute("planNo"));
		System.out.println("컨트롤러 select date : "+vo.getSelectDate());
		System.out.println("컨트롤러 실행");
		map = new HashMap<String, Object>();
		try {
			mpDAOS.getSelectDateFix(vo);
			map.put("res", "ok");
			System.out.println("fixCal Success");
		} catch (Exception e) {
			// TODO: handle exception
			map.put("res", "fail");
			System.out.println("fixCal fail");
		}
		return map;
	}
	@RequestMapping(value = "calendarajax.mp", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String calendarLoad(HttpSession session) {

		map = new HashMap<String, Object>();
		map.put("link", "managePlan/calendarPage");
		
		mapper = new ObjectMapper();// json형식으로 데이터를 반환하기 위해 사용(pom.xml 편집)
		String str = "";
		try {
			str = mapper.writeValueAsString(map);
		} catch (Exception e) {
			System.out.println("castring fail");
		}
		return str;
	}
	
	// 접속 중인 유저들의 프로필 사진명을 얻기 위한 메서드
	@RequestMapping(value="/onUserList.mp", method=RequestMethod.POST, produces="application/json;charset=UTF-8")
	@ResponseBody 
	public String getOnUserList(String[] nameList) {
		System.out.println("getOnUserList IN");
		System.out.println(nameList[2]);
		Map<String, String> imageMap = new HashMap<String, String>();
		System.out.println("nameList.length=" + nameList.length);
		System.out.println("nameList[0]=" + nameList[0]);
		
		for(int i=1; i<nameList.length-1; i++) {
			String name = nameList[i];
			System.out.println("name=" + name + "AAAA");
			System.out.println("들어갔니");
			user.setId(name);
			System.out.println("user에 set은 잘했니");
			user = chatDAO.getImageName(user);
			System.out.println("DB엔 잘갔다왔고?=" + user);
			try {
				imageMap.put(name, user.getImage());
			}catch(Exception e) {
				e.getMessage();
			}
			
			System.out.println("name=" + name + "BBBB");
			System.out.println("user.getImage()" + user.getImage());
			System.out.println("이제 map에 다 넣었지?");
		}
		
		System.out.println("1");
		mapper = new ObjectMapper();// json형식으로 데이터를 반환하기 위해 사용(pom.xml 편집)
		System.out.println("2");
		String imageList = "";
		System.out.println("3");
		try {
			System.out.println("imageList 뽑기 전까지는 왔네");
			imageList = mapper.writeValueAsString(imageMap);
			System.out.println(imageList);
		} catch (Exception e) {
			e.getMessage();
		}
		
		System.out.println("getOnUserList OUT");
		return imageList;
	}


}
