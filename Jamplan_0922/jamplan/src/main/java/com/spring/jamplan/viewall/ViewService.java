package com.spring.jamplan.viewall;

import java.util.ArrayList;

import com.spring.jamplan.model.PlanTableVO;
import com.spring.jamplan.model.PlanVO;


public interface ViewService {
	   ArrayList insertViewAll(PlanTableVO planTableVO, PlanVO planVO);
	   /*ArrayList savePlanTable (PlanTableVO planTableVO);*/
	   int fileUpload(PlanVO planVO);
	   int updatePlanName(PlanVO planVO);
}
