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

import kr.happyjob.study.cmp.service.OrderConfirmService;
import kr.happyjob.study.cmp.model.OrderConfirmModel;

@Controller
@RequestMapping("/cmp/")
public class OrderConfirm {
	@Autowired
	OrderConfirmService orderconfirmservice; 
	
	private final Logger logger = LogManager.getLogger(this.getClass());

	// Get class name for logger
	private final String className = this.getClass().toString();


	   @RequestMapping("orderConfirm.do") 
	   public String orderConfirm(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
	         HttpServletResponse response, HttpSession session) throws Exception {
	      
	      logger.info("+ Start " + className + ".orderConfirm");
	      logger.info("   - paramMap : " + paramMap);
	      
	      logger.info("+ End " + className + ".orderConfirm");
	
	      return "cmp/orderConfirmMgt";
	   }
	   
		@RequestMapping("orderConfirmMgt.do")	
		public String orderConfirmMgt(Model model, @RequestParam Map<String, Object> paramMap,
				HttpServletRequest request, HttpServletResponse response, HttpSession session) throws Exception {

			logger.info("+ Start " + className + ".orderConfirmMgt");
			logger.info("   - paramMap : " + paramMap);

			int clickpagenum = Integer.parseInt(String.valueOf(paramMap.get("clickpagenum")));
			int pagesize = Integer.parseInt(String.valueOf(paramMap.get("pagesize")));
			int startnum = (clickpagenum - 1) * pagesize;
			
			String loginID = (String) session.getAttribute("loginId");
			
			logger.info("loginId ??????????????????????????????????" + loginID);
			
			paramMap.put("startnum", startnum);

			paramMap.put("pagesize", pagesize);

			paramMap.put("loginID", loginID);

			List<OrderConfirmModel> orderConfirmlist = orderconfirmservice.orderConfirmMgt(paramMap);
			model.addAttribute("orderConfirmlist", orderConfirmlist);

			int orderConfirmMgtcnt = orderconfirmservice.orderConfirmMgtcnt(paramMap);
			model.addAttribute("orderConfirmMgtcnt", orderConfirmMgtcnt);

			logger.info("+ End " + className + ".orderConfirmMgt");

			return "cmp/orderConfirmlist";
		}
}
	