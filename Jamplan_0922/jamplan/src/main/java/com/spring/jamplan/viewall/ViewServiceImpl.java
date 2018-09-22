package com.spring.jamplan.viewall;

import java.util.ArrayList;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.jamplan.model.PlanTableVO;
import com.spring.jamplan.model.PlanVO;
import com.spring.jamplan.searchcontroller.SearchMapper;

@Service("viewService")
public class ViewServiceImpl implements ViewService{
	
	   @Autowired
	   private SqlSession sqlsession;
	   
	   @Override
	   public ArrayList<PlanVO> insertViewAll(PlanTableVO planTableVO, PlanVO planVO){
		   System.out.println("insertViewAll 임플 입장!");
		   
	      ArrayList<PlanVO> planViewList = null;
	      ArrayList<PlanTableVO> planTableList = null;
	      int i = 0;
	      
	      ViewMapper viewMapper = sqlsession.getMapper(ViewMapper.class);
	      planTableList = viewMapper.getPlanTables(planTableVO);
	      System.out.println("된다!!!!!!!!!!!!!!!!!!!!");
	      System.out.println("planMapList사이즈#####=" + planTableList.size());
	      
	      
	      if(planTableList.size() != 0) {
	    	  planViewList = viewMapper.getViewAll(planVO); //맵퍼 새로만들어야함
	         System.out.println("planViewList의존재#####=" + planViewList.size());

	         if(planViewList.size() == 0) {
	            System.out.println("뷰테이블이0일때 들어오고 플랜테이블리스트가 0이아닐때 들어왔다####");
	            for (i=0; i < planTableList.size(); i++) {
	               System.out.println("for문들어옴!@#!@#!@#");
	               
	               
	               String getPlanDate = planTableList.get(i).getSelectDate();
	               planVO.setSelectDate(getPlanDate);
	               System.out.println("planPlanDate확인view==="+planVO.getSelectDate());
	               String getPlaceName = planTableList.get(i).getPlaceName();
	               planVO.setPlaceName(getPlaceName);
	               System.out.println("planPlaceName확인view==="+planVO.getPlaceName());
	               //memo get set
	               String getMemo = planTableList.get(i).getMemo();
	               System.out.println("pTmemo확인view" + planTableList.get(i).getMemo());
	               planVO.setMemo(getMemo);
	               System.out.println("planVOMemo확인view==="+planVO.getMemo());

	               /*planTableVO.setPlanSeq(i);
	               System.out.println("seq = " + i);*/
	               
	               //겟셋한거 추가시켜주는 맵퍼 만들어야함
	               viewMapper.insertViewAll(planVO);
	               System.out.println("isert완료");
	            
	            }
	            
	            return planViewList;
	         }
	         else {
	        	 System.out.println("else!@#!@$!@$");
	        	 String getMemo = planTableList.get(0).getMemo();
	        	 planVO.setMemo(getMemo);
	        	 viewMapper.updateViewAll(planVO);
	            return planViewList;
	         }
	         
	      }
	      else {
	         System.out.println("다른 경우일때 들어왓다@@@@@@");
	         return null;
	      }
	      
	   }
	   
	   /*@Override
	   public ArrayList<PlanTableVO> savePlanTable (PlanTableVO planTableVO) {
	      System.out.println("save들어왔니?");
	      ArrayList<PlanTableVO> planTableList = null;
	      int i = 0;
	      
	      PlanMapper planMapper = sqlsession.getMapper(PlanMapper.class);
	      
	      planTableList = planMapper.getplanTable(planTableVO);
	      System.out.println("checkList:" + planTableList.get(0).getPlaceName());
	      
	      System.out.println("checkList사이즈="+planTableList.size());
	      
	      
	      //for문 돌리면안됌..?
	      for (i=0; i < planTableList.size(); i++) {
	         System.out.println("메모"+planTableList.get(i).getMemo());
	         System.out.println("시퀀스"+planTableList.get(i).getPlanSeq());
	         System.out.println("플랜넘버"+planTableList.get(i).getPlanNo());
	         planMapper.savePlanTable(planTableVO);
	      }
	      System.out.println("for문");
	      
	      System.out.println("mapper연결되고나옴");
	      
	      return planTableList;
	      
	      
	   }*/
	   
	   @Override
		public int fileUpload(PlanVO planVO) {
			System.out.println("image");
			ViewMapper viewMapper = sqlsession.getMapper(ViewMapper.class);
			int check = viewMapper.fileUpload(planVO);
			System.out.println("returnfile");
			return check;
		}
	   
	   @Override
	   public int updatePlanName(PlanVO planVO) {
		   System.out.println("updatePlanName!@#!@#");
		   ViewMapper viewMapper = sqlsession.getMapper(ViewMapper.class);
		   System.out.println("planName=====" + planVO.getPlanName());
		   int check = viewMapper.updatePlanName(planVO);
		   System.out.println("Mapper나옴!@#!@#");
		   return check;
	   }
	
	
	
}
