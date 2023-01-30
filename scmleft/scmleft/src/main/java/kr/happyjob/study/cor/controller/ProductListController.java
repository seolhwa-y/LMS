package kr.happyjob.study.cor.controller;

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

import kr.happyjob.study.cor.service.ProductListInterService;
import kr.happyjob.study.cor.model.ProductInfoModel;

@Controller
@RequestMapping("/cor/")
public class ProductListController {
	
	@Autowired
	ProductListInterService productListService;

	private final Logger logger = LogManager.getLogger(this.getClass());
	private final String className = this.getClass().toString();
		
	/*기업회원
	 * 제품목록 로딩시 리스트 가져오기
	 */
	@RequestMapping("pList.do")
	public String Product(Model model, @RequestParam Map<String, Object> paramMap,
			HttpServletResponse response, HttpServletRequest request, HttpSession session){
		
		logger.info("=====Start" + className + "제품목록로딩");
		  
		return "cor/productList";
	} 
	
	// 제품목록 조회
	@RequestMapping("productList.do")
	@ResponseBody
	public Map<String, Object> ProductList(Model model, @RequestParam Map<String, Object> paramMap, 
			HttpServletResponse response, HttpServletRequest request, HttpSession session) throws Exception{
		
		logger.info("=====Start" + className + "제품목록조회");
	    logger.info("paramMap: " + paramMap);
	    
	    //페이징 처리
	    int currentPage = Integer.parseInt((String)paramMap.get("currentPage"));
	    int pageSize = Integer.parseInt((String)paramMap.get("pageSize"));
	    int pageIndex = (currentPage-1) * pageSize;
	    
	    paramMap.put("pageIndex", pageIndex);
	    paramMap.put("pageSize", pageSize);
	    
	    //제품목록 조회
	    List<ProductInfoModel> productList = productListService.productList(paramMap);
	    logger.info("제품목록productList : " + productList);
	    //제품목록 수 추출해서 보내기 
	    int totalCnt = productListService.productTotalCnt(paramMap);
	    
	    Map<String, Object> resultMap = new HashMap<String, Object>();
	      resultMap.put("product", productList);
		   resultMap.put("totalCnt", totalCnt);
		   resultMap.put("pageSize", pageSize);
		   resultMap.put("currentPage", currentPage);
	    
		return resultMap;
	}
	
	
	// 제품상세정보
	@RequestMapping("detailproduct.do")
	@ResponseBody
	public Map<String, Object> detailProduct(Model model, @RequestParam Map<String, Object> paramMap, 
			HttpServletRequest request, HttpServletResponse response, HttpSession session) throws Exception{
		
		logger.info("=========detailProduct Strart ===============");
		logger.info("  - paramMap : " + paramMap);
		
		String resultMsg="";
		
		ProductInfoModel detailProduct = productListService.selecProductDetail(paramMap);
		
		if(detailProduct != null){
			
			resultMsg = "SUCCESS";
		}else {
			resultMsg = "FAIL - 상세정보 불러오기 실패";
		}
		
		Map <String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("result", detailProduct);
		resultMap.put("resultMsg", resultMsg);
		
		return resultMap;
		
	}
	


}
