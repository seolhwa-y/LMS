package kr.happyjob.study.pur.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.happyjob.study.pur.model.OrdDtManagementVO;
import kr.happyjob.study.pur.service.OrdDtManagementService;
import kr.happyjob.study.system.model.ComnGrpCodModel;


@Controller
@RequestMapping("/pur/")
public class OrdDtManagementController {
	
	@Autowired //묶어준다
	OrdDtManagementService ordDtManagementService;
	
	private final Logger logger = LoggerFactory.getLogger(OrdDtManagementController.class);
	private final String className = this.getClass().toString();
	
	@RequestMapping("ordDtManagement.do")
	public String ordDtManagement(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession Session) throws Exception{
		
		logger.info("+ Start " + className + ".ordDtManagement");
		
		return "pur/ordDtManagement";
		
	}
	
	
	
	//주문내역조회
	@RequestMapping("ordDtManagementList.do")
	public String ordDtManagementList(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start " + className + ".ordDtManagementList");
		logger.info("   - paramMap : " + paramMap);
		
		
		int currentPage = Integer.parseInt((String)paramMap.get("currentPage"));	// 현재 페이지 번호
		int pageSize = Integer.parseInt((String)paramMap.get("pageSize"));			// 페이지 사이즈
		int pageIndex = (currentPage-1)*pageSize;									// 페이지 시작 row 번호
				
		paramMap.put("pageIndex", pageIndex);
		paramMap.put("pageSize", pageSize);
		
		// 주문내역조회
		List<OrdDtManagementVO> listOrdDtManagement = ordDtManagementService.ordDtManagementList(paramMap);
		model.addAttribute("listOrdDtManagement", listOrdDtManagement);
		
		// 주문내역 카운트 조회
		int totalCnt = ordDtManagementService.ordDtManagementTotalCnt(paramMap);
		model.addAttribute("totalCnt", totalCnt);		
		model.addAttribute("pageSize", pageSize);
		model.addAttribute("currentPageComnGrpCod",currentPage);
		
		logger.info("+ End " + className + ".ordDtManagementList");
		

		return "/pur/ordDtManagementList";
	}	
	
	//발주지시서 단건조회
	@RequestMapping("ordDtManagementSelect.do")
	@ResponseBody
	public Map<String, Object> ordDtManagementSelect(Model model, @RequestParam Map<String, Object> paramMap) throws Exception {
		
		logger.info("+ Start " + className + ".ordDtManagementSelect");
									
		Map<String, Object> resultMap = new HashMap<>();
		
		OrdDtManagementVO ordDtManagementVO = ordDtManagementService.ordDtManagementSelect(paramMap);
		resultMap.put("ordDtManagementVO", ordDtManagementVO);
		
		return  resultMap;
	}	
	
	//발주지시서 단건 상세조회
		@RequestMapping("modalOrdDtl.do")
		@ResponseBody
		public String modalOrdDtl(Model model, @RequestParam Map<String, Object> paramMap) throws Exception {
			
			logger.info("+ Start " + className + ".modalOrdDtl");
										
			List<OrdDtManagementVO> ordDtlList = ordDtManagementService.ordDtlList(paramMap);
			model.addAttribute("ordDtlList", ordDtlList);
			
			// 주문내역 카운트 조회
			int modalTotalCnt = ordDtManagementService.countOrdDtlList(paramMap);
			model.addAttribute("modalTotalCnt", modalTotalCnt);		
			
			
			logger.info("+ End " + className + ".modalOrdDtl");
			
			return  "/pur/modalOrdDtlList";
		}	
}
