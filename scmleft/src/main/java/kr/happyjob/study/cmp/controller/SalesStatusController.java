package kr.happyjob.study.cmp.controller;

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

import kr.happyjob.study.cmp.model.SalesStatusModel;
import kr.happyjob.study.cmp.service.SalesStatusService;

@Controller
@RequestMapping("/cmp/")
public class SalesStatusController {
	
	@Autowired
	SalesStatusService SalesStatusService; 

	// Set logger
	private final Logger logger = LogManager.getLogger(this.getClass());

	// Get class name for logger
	private final String className = this.getClass().toString();

	// 매출현황 초기화면
	@RequestMapping("salesStatus.do")
	public String saleStatus(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {


		return "/cmp/salesStatus";
	}

	// 검색버튼 클릭 시 거래내역 리스트값 가져오기
	@RequestMapping("transactionHistory.do")
	public String transactionHistory(Model model, @RequestParam Map<String, Object> paramMap,
			HttpServletRequest request, HttpServletResponse response, HttpSession session) throws Exception {

		  logger.info("+ Start " + className + ".initComnCod");
		  logger.info("   - paramMap : " + paramMap);
			
			  String comName = (String)paramMap.get("comName"); 
			  String stDate =  (String)paramMap.get("stDate"); 
			  String edDate =  (String)paramMap.get("edDate");
			  
			  int clickpagenum = Integer.parseInt(
			  String.valueOf(paramMap.get("clickpagenum"))) ; int pageSize =
			  Integer.parseInt( String.valueOf(paramMap.get("pageSize"))); int pageIndex =
			  (clickpagenum - 1) * pageSize;
			  
			  paramMap.put("pageIndex", pageIndex); paramMap.put("pageSize", pageSize);
			  paramMap.put("comName", comName); paramMap.put("stDate", stDate);
			  paramMap.put("edDate", edDate);
			  
			  
			  logger.info("   - paramMap ssss  : " + paramMap);
			  
				
				  List<SalesStatusModel> SalesStatusModel =  SalesStatusService.transactionHistory(paramMap);
				  model.addAttribute("SalesStatusModel", SalesStatusModel);
				  
				  // 목록 수 추출해서 보내기 int transactionHistoryCnt = 
				  int transactionHistoryCnt =  SalesStatusService.transactionHistoryCnt(paramMap);
				  
				  model.addAttribute("transactionHistoryCnt", transactionHistoryCnt);
				  model.addAttribute("pageSize", pageSize);
				  model.addAttribute("currentPage",pageIndex);
				   
			  logger.info("+ End " + className + ".initComnCod");
			 
		return "/cmp/transactionHistory";
				
	}
	
	// 기업명 클릭시 상세정보 리스트 출력
		@RequestMapping("dtlList.do")
		public String dtlList(Model model, @RequestParam Map<String, Object> paramMap,
				HttpServletRequest request, HttpServletResponse response, HttpSession session) throws Exception {

			  logger.info("+ Start " + className + ".initComnCod");
			  logger.info("   - paramMap : " + paramMap);
				
				  String comName2 = (String)paramMap.get("comName2"); 

				  
				  int clickpagenum = Integer.parseInt(String.valueOf(paramMap.get("clickpagenum"))) ; 
				  int pageSize = Integer.parseInt( String.valueOf(paramMap.get("pageSize")));
				  int pageIndex = (clickpagenum - 1) * pageSize;
				  
				  paramMap.put("pageIndex", pageIndex);
				  paramMap.put("comName2", comName2); 
				  
				  logger.info("   - paramMap ssss  : " + paramMap);
				  
				  List<SalesStatusModel> dtlList =  SalesStatusService.dtlList(paramMap);
				  model.addAttribute("dtlList", dtlList);
				  
				  // 목록 수 추출해서 보내기 
				  int dtlLisCnt =  SalesStatusService.dtlLisCnt(paramMap);
				  
				  model.addAttribute("dtlLisCnt", dtlLisCnt);
				  model.addAttribute("pageSize", pageSize);
				  model.addAttribute("currentPage",pageIndex);
					   
				  logger.info("+ End " + className + ".initComnCod");
				 
			return "/cmp/dtlList";
					
		}

}