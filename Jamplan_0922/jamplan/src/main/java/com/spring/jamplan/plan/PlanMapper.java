package com.spring.jamplan.plan;

import java.util.ArrayList;

import com.spring.jamplan.model.MapVO;
import com.spring.jamplan.model.PlanTableVO;

public interface PlanMapper {
   ArrayList<PlanTableVO> getplanTable(PlanTableVO planTableVO);
   /*ArrayList<PlanCalendarVO> getPlanCalendar(PlanCalendarVO planCalendarVO);*/
   ArrayList<MapVO> getPlanMap(MapVO mapVO);

   void insertPlanTable(PlanTableVO planTableVO);
   
   
   int savePlanTable (PlanTableVO planTableVO);
   
}