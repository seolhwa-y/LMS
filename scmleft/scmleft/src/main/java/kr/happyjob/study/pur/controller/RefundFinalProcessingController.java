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

import kr.happyjob.study.pur.model.RefundFinalProcessingModel;
import kr.happyjob.study.pur.service.RefundFinalProcessingService;



@Controller
@RequestMapping("/pur/")
public class RefundFinalProcessingController {

	@Autowired
	RefundFinalProcessingService rps;
	
	private final Logger logger = LoggerFactory.getLogger(RefundFinalProcessingController.class);
	private final String className = this.getClass().toString();

	//반품내역관리
	@RequestMapping("refundFinalProcessing.do")
	public String refundFinalProcessing(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request, HttpServletResponse response, HttpSession session) throws Exception{
		
		logger.info("+ Start " + className + ".refundFinalProcessing");
		System.out.println("test");
		logger.info("+ End " + className + ".refundFinalProcessing");
		
		
		return "/pur/refundFinalProcessing";
	}
	
	//리스트페이지
	@RequestMapping("refundFinalProcessingList.do")
	public String refundFinalProcessingList(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request, HttpServletResponse response, HttpSession Session) throws Exception{
		
		logger.info("+ Start " + className + ".refundFinalProcessingList");
		logger.info(" - paramMap : " + paramMap);
		
		int currentPage = Integer.parseInt((String)paramMap.get("currentPage"));	// 현재 페이지 번호
		int pageSize = Integer.parseInt((String)paramMap.get("pageSize"));			// 페이지 사이즈
		int pageIndex = (currentPage-1)*pageSize;									// 페이지 시작 row 번호
				
		paramMap.put("pageIndex", pageIndex);
		paramMap.put("pageSize", pageSize);
		
		// 주문내역조회
		List<RefundFinalProcessingModel> refundFinalProcessingList = rps.refundFinalProcessingList(paramMap);
		model.addAttribute("refundFinalProcessingList", refundFinalProcessingList);
		
		// 주문내역 카운트 조회
		int totalCnt = rps.returnOrderCnt(paramMap);
		
		model.addAttribute("totalCnt", totalCnt);		
		model.addAttribute("pageSize", pageSize);
		model.addAttribute("currentPageComnGrpCod",currentPage);
		
		logger.info("+ End " + className + ".refundFinalProcessingList");
		
	
		return "/pur/refundFinalProcessingList";
	}	

	// 리스트 클릭
	@RequestMapping("refundFinalProcessOne.do")
	@ResponseBody
	public HashMap<String, Object> refundFinalProcessOne(Model model, @RequestParam Map<String, Object> paramMap) throws Exception {
		
		logger.info("+ Start " + className + ".refundFinalProcessOne");
		logger.info(" - paramMap : " + paramMap);
									
		RefundFinalProcessingModel refundFinalProcessOne = rps.refundFinalProcessOne(paramMap);
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		
		resultMap.put("result", refundFinalProcessOne);
		
		logger.info(" - result : " + refundFinalProcessOne);
		logger.info(" - resultMap : " + resultMap);
		
		logger.info("+ End " + className + ".refundFinalProcessOne");
		
		return  resultMap;
	}	

//	//반품지시서 단건 상세조회
//	@RequestMapping("returnOrderDetailMd.do")
//	@ResponseBody
//	public String returnOrderDetailMd(Model model, @RequestParam Map<String, Object> paramMap) throws Exception {
//		
//		logger.info("+ Start " + className + ".returnOrderDetailMd");
//									
//		List<returnPurchaseModel> returnOrderDetail = returnpurchaseService.returnOrderDetail(paramMap);
//		model.addAttribute("returnOrderDetail", returnOrderDetail);
//		
//		// 주문내역 카운트 조회
//		int modalTotalCnt = returnpurchaseService.orderCount(paramMap);
//		model.addAttribute("modalTotalCnt", modalTotalCnt);		
//		
//		
//		logger.info("+ End " + className + ".returnOrderDetailMd");
//		
//		return  "/pur/modalOrdDtlList";
//	}	
	
}
