package kr.happyjob.study.cmp.controller;

import java.util.HashMap;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.google.gson.Gson;

import kr.happyjob.study.cmp.service.OrderConfirmService;

@Controller
@RequestMapping("/cmp/")
public class OrderConfirmController {
	@Autowired
	OrderConfirmService ocs; 

	@RequestMapping("orderConfirm.do") 
	public String moveOrderConfirmPage (Model model, @RequestParam HashMap<String, Object> map, HttpSession session) throws Exception {
		Gson gson = new Gson();
	    String page = "/login/login";
	
	    if(session.getAttribute("loginId") != null) page = "/cmp/orderConfirmMgt";
	    
		map.put("pageNum", "1");
	    map.put("listCount", "10");
	    model.addAttribute("result", gson.toJson(ocs.orderConfirmList(map)));
	      
	    return page;
	}
	   
	@ResponseBody
	@RequestMapping("/searchOrderConfirmlist") 
	public HashMap<String, Object> searchOrderConfirmCtl (@RequestParam HashMap<String, Object> map, HttpSession session) throws Exception {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		
		resultMap.put("result", ocs.orderConfirmList(map));
	      
	    return resultMap;
	}
	
	@ResponseBody
	@RequestMapping("/updateBorderType") 
	public HashMap<String, Object> updateBorderTypeCtl (@RequestParam HashMap<String, Object> map, HttpSession session) throws Exception {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		
		if(ocs.updateBorderType(map) > 0) resultMap.put("message", "처리가 완료되었습니다.");
		else resultMap.put("message", "처리가 실패하였습니다.");
	      
	    return resultMap;
	}
	
//	private final Logger logger = LogManager.getLogger(this.getClass());
//
//	// Get class name for logger
//	private final String className = this.getClass().toString();
//
//
//	   @RequestMapping("orderConfirm.do") 
//	   public String orderConfirm(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
//	         HttpServletResponse response, HttpSession session) throws Exception {
//	      
//	      logger.info("+ Start " + className + ".orderConfirm");
//	      logger.info("   - paramMap : " + paramMap);
//	      
//	      logger.info("+ End " + className + ".orderConfirm");
//	
//	      return "cmp/orderConfirmMgt";
//	   }
//	   
//		@RequestMapping("orderConfirmMgt.do")	
//		public String orderConfirmMgt(Model model, @RequestParam Map<String, Object> paramMap,
//				HttpServletRequest request, HttpServletResponse response, HttpSession session) throws Exception {
//
//			logger.info("+ Start " + className + ".orderConfirmMgt");
//			logger.info("   - paramMap : " + paramMap);
//
//			int clickpagenum = Integer.parseInt(String.valueOf(paramMap.get("clickpagenum")));
//			int pagesize = Integer.parseInt(String.valueOf(paramMap.get("pagesize")));
//			int startnum = (clickpagenum - 1) * pagesize;
//			
//			String loginID = (String) session.getAttribute("loginId");
//			
//			logger.info("loginId ??????????????????????????????????" + loginID);
//			
//			paramMap.put("startnum", startnum);
//
//			paramMap.put("pagesize", pagesize);
//
//			paramMap.put("loginID", loginID);
//
//			List<OrderConfirmModel> orderConfirmlist = orderconfirmservice.orderConfirmMgt(paramMap);
//			model.addAttribute("orderConfirmlist", orderConfirmlist);
//
//			int orderConfirmMgtcnt = orderconfirmservice.orderConfirmMgtcnt(paramMap);
//			model.addAttribute("orderConfirmMgtcnt", orderConfirmMgtcnt);
//
//			logger.info("+ End " + className + ".orderConfirmMgt");
//
//			return "cmp/orderConfirmlist";
//		}
}
	