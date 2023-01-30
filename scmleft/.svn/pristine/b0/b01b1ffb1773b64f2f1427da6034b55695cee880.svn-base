package kr.happyjob.study.scm.controller;

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

import kr.happyjob.study.scm.model.ProductInfoModel;
import kr.happyjob.study.scm.model.ShippingDirectionModel;
import kr.happyjob.study.scm.service.ProductInfoService;

@Controller
@RequestMapping("scm")
public class ProductInfoController {
	
	@Autowired 
	ProductInfoService productInfoService;	
	
	// Set logger
	private final Logger logger = LogManager.getLogger(this.getClass());
		
	// Get class name for logger
	private final String className = this.getClass().toString();
	
	// 1. 제품정보 관리 초기페이지	
	@RequestMapping("productInfo")
	private String productInfo(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start " + className + ".productInfo");
		logger.info("   - paramMap : " + paramMap);
		logger.info("+ End " + className + ".productInfo");
		
		return "scm/productInfo";
	}
	
	// 제품정보관리 리스트값 가져오기
			@RequestMapping("productInfoList.do")
			public String productInfoList(Model model, @RequestParam Map<String, Object> paramMap,
					HttpServletRequest request, HttpServletResponse response, HttpSession session) throws Exception {

				  logger.info("+ Start " + className + ".productInfoList");
				  logger.info("   - paramMap : " + paramMap);
					
				  
				  int currentPage = Integer.parseInt((String)paramMap.get("currentPage")); 
				  int pageSize = Integer.parseInt((String)paramMap.get("pageSize"));
				  int pageIndex = (currentPage - 1)*pageSize; //페이지 시작  row번호
					  
				  paramMap.put("pageIndex", pageIndex);
				  paramMap.put("pageSize", pageSize);
				  
				  List<ProductInfoModel> productInfoList = productInfoService.productInfoList(paramMap);
				  model.addAttribute("productInfoList", productInfoList);	
						  
				  // 목록 수 추출해서 보내기 int 
				  int totalCnt =  productInfoService.productInfoListCnt(paramMap);
				  
				  model.addAttribute("totalCnt", totalCnt);
				  model.addAttribute("pageSize", pageSize);
				  model.addAttribute("currentPage",pageIndex);
						   
				  logger.info("+ End " + className + ".productInfoList");
					 
				return "/scm/productInfoList";
		
			}
			
		//제품정보관리 상세 단건 조회  
			   @RequestMapping("productOne.do")
			   @ResponseBody
			   public HashMap<String, Object> productOne(Model model, @RequestParam Map<String, Object> paramMap, 
					   HttpServletRequest request, HttpServletResponse response, HttpSession session) throws Exception {
			     
				  logger.info("+ Start " + className + ".productOne");
			      logger.info("   - paramMap : " + paramMap);
			      		      
			      ProductInfoModel productOne = productInfoService.productOne(paramMap);
			      
			      HashMap<String, Object> returnMap = new HashMap<String, Object>();
			      
			      returnMap.put("result", productOne);
			      
			      logger.info("   - result : " + productOne);
			      logger.info("   - returnmap : " + returnMap);
			      
			      logger.info("+ End " + className + ".productOne");
			      
			      return returnMap;
			   }	
}