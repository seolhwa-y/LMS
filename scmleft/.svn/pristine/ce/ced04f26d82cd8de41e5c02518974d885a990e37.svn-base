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

import kr.happyjob.study.scm.model.ShippingDirectionModel;
import kr.happyjob.study.scm.service.ShippingDirectionService;


@Controller
@RequestMapping("/scm/")
public class ShippingDirectionController {
	
	@Autowired
	ShippingDirectionService shippingDirectionService; 

	// Set logger
	private final Logger logger = LogManager.getLogger(this.getClass());

	// Get class name for logger
	private final String className = this.getClass().toString();

	// 배송 지시서 초기페이지
	@RequestMapping("shippingDirection.do")
	public String shippingDir(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start " + className + ".shippingDir");
				
		logger.info("+ End " + className + ".shippingDir");

		return "/scm/shippingDirection";
	}
	
	// 배송 지시서 리스트값 가져오기
		@RequestMapping("shippingDirectionList.do")
		public String shippingDirectionList(Model model, @RequestParam Map<String, Object> paramMap,
				HttpServletRequest request, HttpServletResponse response, HttpSession session) throws Exception {

			  logger.info("+ Start " + className + ".shippingDirectionList");
			  logger.info("   - paramMap : " + paramMap);
				
			  
			  int currentPage = Integer.parseInt((String)paramMap.get("currentPage")); 
			  int pageSize = Integer.parseInt((String)paramMap.get("pageSize"));
			  int pageIndex = (currentPage - 1)*pageSize; //페이지 시작  row번호
				  
			  paramMap.put("pageIndex", pageIndex);
			  paramMap.put("pageSize", pageSize);
			  
			  List<ShippingDirectionModel> shippingDirectionList = shippingDirectionService.shippingDirectionList(paramMap);
			  model.addAttribute("shippingDirectionList", shippingDirectionList);	
					  
			  // 목록 수 추출해서 보내기 int 
			  int totalCnt =  shippingDirectionService.shippingDirectionListCnt(paramMap);
			  
			  model.addAttribute("totalCnt", totalCnt);
			  model.addAttribute("pageSize", pageSize);
			  model.addAttribute("currentPage",pageIndex);
					   
			  logger.info("+ End " + className + ".shippingDirectionList");
				 
			return "/scm/shippingDirectionList";
	
		}
		
		
		//배송지시서 상세 단건 조회  
		   @RequestMapping("shippingDirOne.do")
		   @ResponseBody
		   public HashMap<String, Object> shippingDirOne(Model model, @RequestParam Map<String, Object> paramMap, 
				   HttpServletRequest request, HttpServletResponse response, HttpSession session) throws Exception {
		     
			  logger.info("+ Start " + className + ".shippingDirOne");
		      logger.info("   - paramMap : " + paramMap);
		      		      
		      ShippingDirectionModel shippingDirectionListOne = shippingDirectionService.shippingDirectionListOne(paramMap);
		      
		      HashMap<String, Object> returnMap = new HashMap<String, Object>();
		      
		      returnMap.put("result", shippingDirectionListOne);
		      
		      logger.info("   - result : " + shippingDirectionListOne);
		      logger.info("   - returnmap : " + returnMap);
		      
		      logger.info("+ End " + className + ".shippingDirOne");
		      
		      return returnMap;
		   }
		   		
		
/*		
		@RequestMapping(value= "/order/{orderNo}", method = RequestMethod.GET)
		@ResponseBody
		public Map<String, Object> getUserInfo(@PathVariable(value="orderNo") int orderNo){

			Map<String, Object> resultMap = new HashMap<>();
			
			ShippingRequestDTO shippingRequestDTO = new ShippingRequestDTO();
			
			shippingRequestDTO.setOrder_no(orderNo);
			
			List<ShippingOrderDetailDTO> shippingOrderDetailList = shippingDirectionServiceImpl.getShippingOrderDetailList(shippingRequestDTO);
			
			resultMap.put("shippingOrderDetailList", shippingOrderDetailList);
			
			return resultMap;
		}*/
}


