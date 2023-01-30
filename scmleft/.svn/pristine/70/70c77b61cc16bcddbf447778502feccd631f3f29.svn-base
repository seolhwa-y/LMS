package kr.happyjob.study.adm.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.happyjob.study.adm.model.ApprovalModel;
import kr.happyjob.study.adm.service.ApprovalService;
import kr.happyjob.study.dashboard.service.DashboardService;
import kr.happyjob.study.system.model.ComnDtlCodModel;
import kr.happyjob.study.system.model.ComnGrpCodModel;
import kr.happyjob.study.system.model.NoticeModel;
import kr.happyjob.study.system.service.NoticeService;

@Controller
@RequestMapping("/adm/")
public class ApprovalController {
	
	@Autowired
	ApprovalService approvalService;
	
	// Set logger
	private final Logger logger = LogManager.getLogger(this.getClass());

	// Get class name for logger
	private final String className = this.getClass().toString();
	
	/************ *********************** ************/
	// 신고서 목록/조회/승인 메인 페이지
	@RequestMapping("decList.do")
	public String initApproval(Model model, @RequestParam Map<String, Object> paramMap) throws Exception {
		
		logger.info("+ Start " + className + ".initApproval");
		logger.info("   - paramMap : " + paramMap);
		
		logger.info("+ End " + className + ".initApproval");

		return "adm/approval";

	}
	
	/************ 신고서 목록 리스트 출력 ************/
	@RequestMapping("listApproval.do")
	@ResponseBody
	public Map<String, Object> listApproval(Model model, @RequestParam Map<String, Object> paramMap) throws Exception {
		
		logger.info("+ Start " + className + ".listApproval");
		logger.info("   - paramMap : " + paramMap);
		
		int currentPage = Integer.parseInt((String)paramMap.get("currentPage"));	// 현재 페이지 번호
		int pageSize = Integer.parseInt((String)paramMap.get("pageSize"));			// 페이지 사이즈
		int pageIndex = (currentPage-1)*pageSize;									// 페이지 시작 row 번호
				
		paramMap.put("pageIndex", pageIndex);
		paramMap.put("pageSize", pageSize);
		
		// 공통 그룹코드 목록 조회
		List<ApprovalModel> approvalList = approvalService.listApproval(paramMap);
		
		// 공통 그룹코드 목록 카운트 조회
		int approvalCnt = approvalService.approvalCnt(paramMap);
		
	    Map<String, Object> resultMap = new HashMap<String, Object>();
	    resultMap.put("approvalList", approvalList);
		resultMap.put("approvalCnt", approvalCnt);
		resultMap.put("pageSize", pageSize);
		resultMap.put("currentPage",currentPage);
	    
		logger.info("+ End " + className + ".listApproval");

		return resultMap;
	}
	
	/************ 신고서 단건 조회 코드 ************/
	@RequestMapping("selectApprovalCod.do")
	@ResponseBody
	public Map<String, Object> selectApprovalCod (Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start " + className + ".selectApprovalCod");
		logger.info("   - paramMap : " + paramMap);

		String result = "SUCCESS";
		String resultMsg = "조회 되었습니다.";
		
		// 공통 그룹 코드 단건 조회
		ApprovalModel ApprovalModel = approvalService.selectApprovalCod(paramMap);
		
		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("result", result);
		resultMap.put("resultMsg", resultMsg);
		resultMap.put("ApprovalModel", ApprovalModel);
		
		logger.info("+ End " + className + ".selectApprovalCod");
		
		return resultMap;
	}
	
	/************ 신고서 단건 입력용 빈코드 ************/
	@RequestMapping("selectEmptyCod.do")
	@ResponseBody
	public Map<String, Object> selectEmptyCod (Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start " + className + ".selectEmptyCod");
		logger.info("   - paramMap : " + paramMap);

		String result = "SUCCESS";
		String resultMsg = "조회 되었습니다.";
		
		ApprovalModel selectEmptyCod = new ApprovalModel();
		
		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("result", result);
		resultMap.put("resultMsg", resultMsg);
		resultMap.put("selectEmptyCod", selectEmptyCod);
		
		logger.info("+ End " + className + ".selectEmptyCod");
		
		return resultMap;
	}
	
	/************ 의료기기 신청서 신규 등록 ************/
	@RequestMapping("saveApprovalcod.do")
	@ResponseBody
	public Map<String, Object> saveApprovalcod(@RequestParam Map<String, Object> paramMap) throws Exception {
		
		logger.info("+ Start " + className + ".saveApprovalcod");
	    logger.info("   - paramMap : " + paramMap);
	    
	    String action = (String) paramMap.get("action");
		String result = "N";
		String resultMsg = "데이터  저장 시 오류가 발생했습니다."; 
		
		try {
	         if("I".equals(action)) {
	        	 approvalService.insertapprovalcode(paramMap);
	             resultMsg = "데이터가 저장되었습니다.";
	         } else if ("U".equals(action)) {
	 			 approvalService.updateApprovalMedicalCod(paramMap);
	 		 	 resultMsg = "데이터 수정 완료.";
	         }
	         
	         result = "Y";
		} catch(Exception e) {
	         
	      }
		
		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("result", result);
		resultMap.put("resultMsg", resultMsg);
		
		logger.info("+ End " + className + ".saveApprovalcod");
		
		return resultMap;
		
	}
	

	
	/************ 상세 코드 ************/
	// 신고서 상세 출력
	@RequestMapping("listApprovalDtl.do")
	@ResponseBody
	public Map<String, Object> listApprovalDtl (Model model, @RequestParam Map<String, Object> paramMap) throws Exception {
		
		logger.info("+ Start " + className + ".listApprovalDtl");
		logger.info("   - paramMap : " + paramMap);

		String result = "SUCCESS";
		String resultMsg = "조회되었습니다.";
		
		// 상세 코드 단건 조회
		ApprovalModel approvalListDtlCod = approvalService.listApprovalDtl(paramMap);
		
		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("result", result);
		resultMap.put("resultMsg", resultMsg);
		resultMap.put("approvalListDtlCod", approvalListDtlCod);
		
		logger.info("+ End " + className + ".listApprovalDtl");
		
		return resultMap;
	}
	
	
	/************ 승인 및 반려 코드 ************/
	@RequestMapping("updateAgree.do")
	@ResponseBody
	public Map<String, Object> updateAgree(@RequestParam Map<String,Object> paramMap) throws Exception {
		
		logger.info("+ Start " + className + ".updateAgree");
		logger.info("   - paramMap : " + paramMap);
		
		String disoragreeAction = (String)paramMap.get("action");
		
		String result = "SUCCESS";
		String resultMsg = "저장되었습니다.";
		
		if ("U".equals(disoragreeAction)) {
			approvalService.updateApprovalCod(paramMap);
			
		} else {
			result = "FALSE";
			resultMsg = "알 수 없는 요청입니다.";
		}
		
		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("result", result);
		resultMap.put("resultMsg", resultMsg);
		
		logger.info("+ End " + className + ".updateAgree");
		
		return resultMap;
	}
	
	
	/************ 의료기기 수리업 신청서 신규 등록 ************/
	@RequestMapping("saveMedicalRepaircod.do")
	@ResponseBody
	public Map<String, Object> saveMedicalRepaircod(@RequestParam Map<String, Object> paramMap) throws Exception {
		
		logger.info("+ Start " + className + ".saveMedicalRepaircod");
	    logger.info("   - paramMap : " + paramMap);
	    
	    String action = (String) paramMap.get("action");
		String result = "N";
		String resultMsg = "데이터  저장 시 오류가 발생했습니다."; 
		
		try {
	         if("I".equals(action)) {
	        	 approvalService.insertmedicalcode(paramMap);
	             resultMsg = "수리업 데이터가 저장되었습니다.";
	         } else if ("U".equals(action)) {
	 			 approvalService.updateApprovalMedicalCod(paramMap);
	 		 	 resultMsg = "수리업 데이터 수정 완료.";
	         }
	         
	         result = "Y";
		} catch(Exception e) {
	         
	      }
		
		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("result", result);
		resultMap.put("resultMsg", resultMsg);
		
		logger.info("+ End " + className + ".saveMedicalRepaircod");
		
		return resultMap;
		
	}
	
	/************ 의료기기 판매업 신청서 신규 등록 ************/
	@RequestMapping("saveMedicalSaleRentcod.do")
	@ResponseBody
	public Map<String, Object> saveMedicalSaleRentcod(@RequestParam Map<String, Object> paramMap) throws Exception {
		
		logger.info("+ Start " + className + ".saveMedicalSaleRentcod");
	    logger.info("   - paramMap : " + paramMap);
	    
	    String action = (String) paramMap.get("action");
		String result = "N";
		String resultMsg = "데이터  저장 시 오류가 발생했습니다."; 
		
		try {
	         if("I".equals(action)) {
	        	 approvalService.insertSaleRentcode(paramMap);
	             resultMsg = "판매업 데이터가 저장되었습니다.";
	         } else if ("U".equals(action)) {
	 			 approvalService.updateApprovalMedicalCod(paramMap);
	 		 	 resultMsg = "판매업 데이터 수정 완료.";
	         }
	         
	         result = "Y";
		} catch(Exception e) {
	         
	      }
		
		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("result", result);
		resultMap.put("resultMsg", resultMsg);
		
		logger.info("+ End " + className + ".saveMedicalSaleRentcod");
		
		return resultMap;
		
	}
	
}
