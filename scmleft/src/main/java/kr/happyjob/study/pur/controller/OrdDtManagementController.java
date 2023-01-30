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
	@ResponseBody
	public Map<String, Object> ordDtManagementList(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
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
		
		Map<String, Object> resultmap = new HashMap<String, Object>();
		
		resultmap.put("listOrdDtManagement", listOrdDtManagement);
		
		// 주문내역 카운트 조회
		int totalCnt = ordDtManagementService.ordDtManagementTotalCnt(paramMap);
		resultmap.put("totalCnt", totalCnt);		
		resultmap.put("pageSize", pageSize);
		
		logger.info("+ End " + className + ".ordDtManagementList");
		
		return resultmap;
	}	
	
	//발주지시서 단건조회
	@RequestMapping("ordDtManagementSelect.do")
	@ResponseBody
	public Map<String, Object> ordDtManagementSelect(Model model, @RequestParam Map<String, Object> paramMap) throws Exception {
		
		logger.info("+ Start " + className + ".ordDtManagementSelect");
		logger.info("     paramMap :  " + paramMap);
									
//		Map<String, Object> resultMap = new HashMap<>();
//		
//		OrdDtManagementVO ordDtManagementVO = ordDtManagementService.ordDtManagementSelect(paramMap);
//		resultMap.put("ordDtManagementVO", ordDtManagementVO);
		
		String result = "";

		// 선택된 게시판 1건 조회
		OrdDtManagementVO ordDtManagementVO = ordDtManagementService.ordDtManagementSelect(paramMap);

		if (ordDtManagementVO != null) {
			result = "SUCCESS"; // 성공시 찍습니다.
		} else {
			result = "FAIL / 불러오기에 실패했습니다."; // null이면 실패입니다.
		}

		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("resultMsg", result); // success 용어 담기
		resultMap.put("result", ordDtManagementVO); // 리턴 값 해쉬에 담기
		// resultMap.put("resultComments", comments);
		System.out.println(ordDtManagementVO);

		logger.info("+ End " + className + ".ordDtManagementVO");
		
		return  resultMap;
	}	
	
		@RequestMapping("updateList.do")
		@ResponseBody
		public Map<String, Object> updateList(Model model, @RequestParam Map<String, Object> paramMap,
				HttpServletRequest request, HttpServletResponse response, HttpSession session) throws Exception{
			logger.info("+ Start " + className + ".updateList");
			logger.info("   - paramMap : " + paramMap);
			
			String action = (String) paramMap.get("action");
			String result="";
			
//			int currentPage=Integer.parseInt((String) paramMap.get("currentPage"));
//			int pageSize=Integer.parseInt((String) paramMap.get("pageSize"));
//			int pageIndex=(currentPage-1)*pageSize;
//			
			paramMap.put("loginId", session.getAttribute("loginId"));
			logger.info("loginId : " + paramMap.get("loginId"));
//			logger.info("sendRefundFinalConfirm.do => paramMap : "+paramMap);
			
			// 
			if("U".equals(action)){
				ordDtManagementService.updateBordType(paramMap);
				result = "UPDATED";
				System.out.println(paramMap);
			} else {
				result = "FALSE : 등록에 실패하였습니다.";
			}
			Map<String, Object> resultMap = new HashMap<String, Object>();
			resultMap.put("result", result);
			
			return resultMap;
		}

		
}
