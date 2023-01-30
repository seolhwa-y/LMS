package kr.happyjob.study.scm.controller;

import java.io.PrintWriter;
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
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import kr.happyjob.study.scm.model.WHInventoryFormModel;
import kr.happyjob.study.scm.service.WHInventoryFormService;


@Controller
@RequestMapping("/scm/")
public class WHInventoryFormController {

	//Set logger
	private final Logger logger = LogManager.getLogger(this.getClass());

	//Get class name for logger
	private final String className = this.getClass().toString();
		
	@Autowired
	private WHInventoryFormService service;
	
	/**
	 * 초기화면
	 */
	@RequestMapping("whInventoryForm.do")
	public String initComnCod(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
	
		return "scm/lecListMgt";
	}
	
	
	
//	  강의 목록 조회

	@RequestMapping("listLecList.do")
	public String listComnDtlCod(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start " + className + ".listComnDtlCod");
		logger.info("   - paramMap : " + paramMap);
		
		
		int currentPage = Integer.parseInt((String)paramMap.get("currentPage"));	// 현재 페이지 번호
		int pageSize = Integer.parseInt((String)paramMap.get("pageSize"));			// 페이지 사이즈
		int pageIndex = (currentPage-1)*pageSize;												// 페이지 시작 row 번호
		

		paramMap.put("pageIndex", pageIndex);
		paramMap.put("pageSize", pageSize);
		
		// 공통 상세코드 목록 조회
		List<WHInventoryFormModel> WHInventoryFormModel = service.getList(paramMap);
		model.addAttribute("WHInventoryFormModel", WHInventoryFormModel);
		
		// 공통 상세코드 목록 카운트 조회
		int totalCount = service.countList(paramMap);
		model.addAttribute("totalCntAdmsmtLecList", totalCount);
		
		model.addAttribute("pageSize", pageSize);
		model.addAttribute("currentPageComnDtlCod",currentPage);
		
		logger.info("+ End " + className + ".listComnDtlCod");

		return "/scm/lecListMgtList";
	}	

	
	
	/**
	 * 수강인원 목록 조회
	 */
	@RequestMapping("listLecPersonList.do")
	public String listComnGrpCod(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start " + className + ".listComnGrpCod");
		logger.info("   - paramMap : " + paramMap);
		 
		
		
		int currentPage = Integer.parseInt((String)paramMap.get("currentPage"));	// 현재 페이지 번호
		int pageSize = Integer.parseInt((String)paramMap.get("pageSize"));			// 페이지 사이즈
		int pageIndex = (currentPage-1)*pageSize;												// 페이지 시작 row 번호
				
		paramMap.put("pageIndex", pageIndex);
		paramMap.put("pageSize", pageSize);
		
		// 공통 그룹코드 목록 조회
		List<WHInventoryFormModel> admsmtLecPersonListMgtModel = service.SgetList(paramMap);
		model.addAttribute("admsmtLecPersonListMgtModel", admsmtLecPersonListMgtModel);
		
		// 공통 그룹코드 목록 카운트 조회
		int totalCount = service.ScountList(paramMap);
		model.addAttribute("totalCntAdmsmtLecPersonList", totalCount);
		
		model.addAttribute("pageSize", pageSize);
		model.addAttribute("currentPageAdmsmtLecList",currentPage);
		
		logger.info("+ End " + className + ".listComnGrpCod");
		

		return "/scm/lecListMgtPersonList";
	}	


	


	
	
	
}