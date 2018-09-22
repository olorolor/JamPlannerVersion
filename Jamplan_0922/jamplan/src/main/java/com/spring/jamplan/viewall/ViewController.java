package com.spring.jamplan.viewall;

import java.io.File;
import java.util.ArrayList;
import java.util.UUID;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.spring.jamplan.model.PlanTableVO;
import com.spring.jamplan.model.PlanVO;

@Controller
public class ViewController {

   
   @Autowired
   private ViewService viewService;
   
   //getViewAll
   @RequestMapping(value = "moveViewAll.view", method = RequestMethod.POST, produces="application/json;charset=utf-8")
   @ResponseBody
   public String insertViewAll(HttpSession session, PlanTableVO planTableVO, PlanVO planVO) {
      System.out.println("moveViewAll컨트롤러 입장!");
      
      
      
      
       int planNo = (int)session.getAttribute("planNo");
	   System.out.println("planNo%%%%%%%%%%%%%%%%%%%" + planNo);
	   planVO.setPlanNo(planNo);
      
      
      
      
      System.out.println("pt1");
      ArrayList getViewList = viewService.insertViewAll(planTableVO, planVO);
      System.out.println("pt2");
      
      String str = "";
      
      ObjectMapper mapper = new ObjectMapper();
      try {
         str = mapper.writeValueAsString(getViewList);
      }
      catch (Exception e)
      {
         System.out.println("firest() mapper :" + e.getMessage());
      }
      
      System.out.println("str:" + str);
      return str;
      
   }
   
 /*  //savePlanTable : 저장
   @RequestMapping(value = "savePlanTable.plan", method = RequestMethod.POST, produces="application/json;charset=utf-8")
   @ResponseBody
   public String savePlanTable (HttpSession session, PlanTableVO planTableVO) {
      System.out.println("memo의값  = " + planTableVO.getMemo());
      System.out.println("save1");
      
      session.setAttribute("no", "1");
      String no = (String)session.getAttribute("no");
      int planNo = Integer.parseInt(no);
      planTableVO.setPlanNo(planNo);
      
      ArrayList savePlanList = planService.savePlanTable(planTableVO);
      
      String str = "";
      
      ObjectMapper mapper = new ObjectMapper();
      try {
         str = mapper.writeValueAsString(savePlanList);
      }
      catch (Exception e)
      {
         System.out.println("firest() mapper :" + e.getMessage());
      }
      
      System.out.println("str:" + str);
      return str;
   
      
      
   }*/
   
   @RequestMapping("fileUpload.view")
	public String fileUpload(MultipartHttpServletRequest multiRequest, PlanVO planVO, HttpSession session) throws Exception {
		
	   int planNo = (int)session.getAttribute("planNo");
	   System.out.println("planNo%%%%%%%%%%%%%%%%%%%" + planNo);
	   planVO.setPlanNo(planNo);
	   System.out.println("!@#!@#!@#!@#planName=" + planVO.getPlanName());
	   //planName update
	   viewService.updatePlanName(planVO);
	   
		//fileUpload
	   MultipartFile mf = multiRequest.getFile("file");
		
		String uploadPath = "C:\\BigDeep\\upload\\";
				//"C:\\Users\\Playdata\\Downloads\\0805ProjectHan\\jamplan2\\src\\main\\webapp\\resources\\search\\image\\";
		
		String originalFileExtension = mf.getOriginalFilename().substring(
				mf.getOriginalFilename().lastIndexOf("."));
		String storedFileName = UUID.randomUUID().toString().replaceAll("-", "") + originalFileExtension;
		
		if(mf.getSize() != 0) {
			mf.transferTo(new File(uploadPath+storedFileName));
			
			planVO.setImage(storedFileName);
		}
		
		int check = viewService.fileUpload(planVO);
		
		return "redirect:/plan.search";
	}
   
   /*@RequestMapping("updatePlanName.view")
   public void updatePlanName(PlanVO planVO) {
	   System.out.println("!@#!@#!@#!@#planName=" + planVO.getPlanName());
	   //planName update
	   viewService.updatePlanName(planVO);
   }*/
   
   
   
   
}