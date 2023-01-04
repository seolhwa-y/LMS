package kr.happyjob.study.ship.controller;

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

import kr.happyjob.study.ship.model.RefundBuyerModel;
import kr.happyjob.study.ship.service.RefundBuyerService;

@Controller
@RequestMapping("/ship/")
public class RefundBuyerController {
	
	@Autowired
	RefundBuyerService RefundBuyerService;
	
	// Set logger
	private final Logger logger = LogManager.getLogger(this.getClass());

	// Get class name for logger
	private final String className = this.getClass().toString();
	
	
	
	// 반품지시서 초기화
	@RequestMapping("refundBuyer.do")
	public String refundBuyer(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session){
		
		return "ship/refundBuyer";
	}
	
	// 검색버튼 클릭 시 반품지시서 내역 가져오기
	@RequestMapping("refundList.do")
	public String refundList(Model model, @RequestParam Map<String, Object> paramMap,
			HttpServletRequest request, HttpServletResponse response, HttpSession session) throws Exception {

		  	logger.info("+ Start " + className + ".initComnCod");
		  
		  	  String loginID = (String) session.getAttribute("loginId");
			  String sname = (String)paramMap.get("sname"); 
			  String stDate =  (String)paramMap.get("stDate"); 
			  String edDate =  (String)paramMap.get("edDate");
			  
			  int clickpagenum = Integer.parseInt(String.valueOf(paramMap.get("clickpagenum"))) ;
			  int pageSize = Integer.parseInt( String.valueOf(paramMap.get("pageSize"))); 
			  int pageIndex = (clickpagenum - 1) * pageSize;
			  
			  paramMap.put("pageIndex", pageIndex); 
			  paramMap.put("pageSize", pageSize);
			  paramMap.put("sname", sname);
			  paramMap.put("stDate", stDate);
			  paramMap.put("edDate", edDate);
			  paramMap.put("loginID", loginID);
			  
			  
			  logger.info("   - paramMap ssss  : " + paramMap);
			  
			
			  List<RefundBuyerModel> refundBuyerModel =  RefundBuyerService.refundList(paramMap);
			  model.addAttribute("RefundBuyerModel", refundBuyerModel);
			  
			  // 목록 수 추출해서 보내기 
			  int refundListCnt =  RefundBuyerService.refundListCnt(paramMap);	
			  
			  model.addAttribute("refundListCnt", refundListCnt);
			  model.addAttribute("pageSize", pageSize);
			  model.addAttribute("currentPage",pageIndex);
				   
			  logger.info("+ End " + className + ".initComnCod");
			 
		return "/ship/refundList";
					
		}

	// 반품번호 클릭 시 상세내역 가져오기
	@RequestMapping("refundDtlList.do")
	public String refundDtlList(Model model, @RequestParam Map<String, Object> paramMap,
			HttpServletRequest request, HttpServletResponse response, HttpSession session) throws Exception {

		  	logger.info("+ Start " + className + ".initComnCod");
		  
			
			  String re_code = (String)paramMap.get("re_code"); 
			  
			  int clickpagenum = Integer.parseInt(String.valueOf(paramMap.get("clickpagenum"))) ;
			  int pageSize = Integer.parseInt( String.valueOf(paramMap.get("pageSize"))); 
			  int pageIndex = (clickpagenum - 1) * pageSize;
			  
			  paramMap.put("pageIndex", pageIndex); 
			  paramMap.put("pageSize", pageSize);
			  paramMap.put("re_code", re_code);


			  logger.info("   - paramMap ssss  : " + paramMap);
			  
			
			  List<RefundBuyerModel> refundBuyerDtlModel =  RefundBuyerService.refundDtlList(paramMap);
			  model.addAttribute("RefundBuyerDtlModel", refundBuyerDtlModel);
			  
			  // 목록 수 추출해서 보내기 
			  int refundDtlListCnt =  RefundBuyerService.refundDtlListCnt(paramMap);
			  
			  model.addAttribute("refundDtlListCnt", refundDtlListCnt);
			  model.addAttribute("pageSize", pageSize);
			  model.addAttribute("currentPage",pageIndex);
				   
			  logger.info("+ End " + className + ".initComnCod");
			 
		return "/ship/refundDtlList";
					
		}
	
	// 재고처리 (업데이트 부분)
	@RequestMapping("refundUpdate.do")
	@ResponseBody
	public Map<String, Object> refundUpdate(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
	    logger.info("@@@@@@@@@@@@@@@@@@@+ Start " + className + ".refundUpdate");
	    logger.info("    + Param :  " + paramMap);	
//	    String loginID = (String) session.getAttribute("loginId");
//	    String dtl_re_code = (String)paramMap.get("dtl_re_code"); 
//	    String model_code = (String)paramMap.get("model_code"); 
//	    String re_amt = (String)paramMap.get("re_amt"); 
	    
	   
	    
	    RefundBuyerService.refundUpdateR(paramMap);
	    RefundBuyerService.refundUpdateW(paramMap);
	    RefundBuyerService.refundInsertW(paramMap);
	    
	    Map<String, Object> returnmap = new HashMap<String, Object>(); 
	    returnmap.put("result", "SUCEESS");
	    
	    logger.info("@@@@@@@@@@@@@@@@@@@+ End " + className + ".refundUpdate");
	    
	    return returnmap;
	}	
	
}
