package com.spring.jamplan.plan;

import java.util.ArrayList;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.spring.jamplan.model.MapVO;
import com.spring.jamplan.model.PlanTableVO;

@Controller
public class PlanController {

   
   @Autowired
   private PlanService planService;
   
   //메인에서 team방입장 테스트
   @RequestMapping("planMainPage.plan")
   public String movePlanMainPage() {
      return "plan/planMainPage";
   }
   
   //get플랜테이블
   @RequestMapping(value = "planTable.plan", method = RequestMethod.POST, produces="application/json;charset=utf-8")
   @ResponseBody
   public String planTable(HttpSession session, PlanTableVO planTableVO, MapVO mapVO) {
      System.out.println("?");
      /*session체크
      String id = (String)session.getAttribute("id");*/
      
      /*String no = (String)session.getAttribute("plnaNo");
      int planNo = Integer.parseInt(no);
      
      System.out.println("session플랜번호=" + planNo);*/
      session.setAttribute("no", "1");
      String no = (String)session.getAttribute("no");
      int planNo = Integer.parseInt(no);
      
      System.out.println("planNo확인=" + planNo);
      
      planTableVO.setPlanNo(planNo);
      /*planCalendarVO.setPlanNo(planNo);*/
      mapVO.setPlanNo(planNo);
      
      
      
      
      System.out.println("pt1");
      ArrayList getPlanList = planService.planTable(planTableVO,mapVO);
      System.out.println("pt2");
      
      String str = "";
      
      ObjectMapper mapper = new ObjectMapper();
      try {
         str = mapper.writeValueAsString(getPlanList);
      }
      catch (Exception e)
      {
         System.out.println("firest() mapper :" + e.getMessage());
      }
      
      System.out.println("str:" + str);
      return str;
      
   }
   
   //savePlanTable : 저장
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
   
      
      
   }
   
   
   
}