package kr.happyjob.study.scm.controller;

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

import kr.happyjob.study.scm.model.SupplierInfoModel;
import kr.happyjob.study.scm.service.SupplierInfoService;




@Controller
@RequestMapping("/scm")
public class SupplierInfoController {
	@Autowired //묶어준다
	SupplierInfoService supplierInfoService;
	
	private static final Logger logger = LoggerFactory.getLogger(SupplierInfoController.class);
	private final String className = this.getClass().toString();
	
	// 초기화면
	@RequestMapping("supplierInfo.do")
	public String supplierInfo() throws Exception{
		
		return "scm/supplierInfo";
		
	}
	// 납품회사 검색
	@RequestMapping("supplierList.do")
	public String supplierList(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession Session) throws Exception{
		
		logger.info("+ Start " + className + ".initSupplierInfo");

		  String searchKey = (String)paramMap.get("searchKey"); 
		  String sname =  (String)paramMap.get("sname"); 
		  
		  int clickpagenum = Integer.parseInt(String.valueOf(paramMap.get("clickpagenum"))) ; 
		  int pageSize = Integer.parseInt( String.valueOf(paramMap.get("pageSize"))); 
		  int pageIndex = (clickpagenum - 1) * pageSize;
		  
		  paramMap.put("searchKey", searchKey);
		  paramMap.put("sname", sname);
		  paramMap.put("pageSize", pageSize); 
		  paramMap.put("pageIndex", pageIndex);

		  
		  
		  logger.info("   - paramMap ssss  : " + paramMap);
		  
			
//			  List<SupplierInfoModel> supplierList = supplierInfoService.supplierList(paramMap) ;
//			  model.addAttribute("supplierList", supplierList);
//			  
//			  // 목록 수 추출해서 보내기 int transactionHistoryCnt = 
//			  int supplierListCnt =  supplierInfoService.supplierLisCnt(paramMap);
//			  
//			  model.addAttribute("supplierListCnt", supplierListCnt);
			  model.addAttribute("pageSize", pageSize);
			  model.addAttribute("pageIndex",pageIndex);
			   

		logger.info("+ End " + className + ".initSupplierInfo");
		
		return "scm/supplierList";
		
	}

}

