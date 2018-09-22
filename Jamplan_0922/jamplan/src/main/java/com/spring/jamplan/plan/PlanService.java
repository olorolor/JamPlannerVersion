package com.spring.jamplan.plan;

import java.util.ArrayList;

import com.spring.jamplan.model.MapVO;
import com.spring.jamplan.model.PlanTableVO;



public interface PlanService {
   ArrayList planTable(PlanTableVO planTableVO, MapVO mapVO);
   ArrayList savePlanTable (PlanTableVO planTableVO);
}