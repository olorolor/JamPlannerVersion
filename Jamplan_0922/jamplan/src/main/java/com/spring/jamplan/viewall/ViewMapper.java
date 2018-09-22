package com.spring.jamplan.viewall;

import java.util.ArrayList;

import com.spring.jamplan.model.PlanTableVO;
import com.spring.jamplan.model.PlanVO;

public interface ViewMapper {
	ArrayList<PlanVO> getViewAll(PlanVO planVO);
	ArrayList<PlanTableVO> getPlanTables(PlanTableVO planTableVO);

	void insertViewAll(PlanVO planVO);
	   
	   
	/*int savePlanTable (PlanTableVO planTableVO);*/
	
	int fileUpload(PlanVO planVO);
	int updatePlanName(PlanVO planVO);
	int updateViewAll(PlanVO planVO);
	
	
	
}
