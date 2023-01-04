package kr.happyjob.study.cmp.controller;

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

import kr.happyjob.study.cmp.model.RefundConfirmModel;
import kr.happyjob.study.cmp.service.RefundConfirmService;

@Controller
@RequestMapping("/cmp/")
public class RefundConfirm {
	
	@Autowired
	RefundConfirmService refundconfirmservice;
	private final Logger logger = LogManager.getLogger(this.getClass());

	// Get class name for logger
	private final String className = this.getClass().toString();


	   @RequestMapping("refundConfirm.do") 
	   public String refundConfirm(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
	         HttpServletResponse response, HttpSession session) throws Exception {
	      
	      logger.info("+ Start " + className + ".refundConfirm");
	      logger.info("   - paramMap : " + paramMap);
	      
	      logger.info("+ End " + className + ".refundConfirm");
	
	      return "cmp/refundConfirmMgt";
	   }
	   
		@RequestMapping("refundConfirmMgt.do")	
		public String refundConfirmMgt(Model model, @RequestParam Map<String, Object> paramMap,
				HttpServletRequest request, HttpServletResponse response, HttpSession session) throws Exception {

			logger.info("+ Start " + className + ".refundConfirmMgt");
			logger.info("   - paramMap : " + paramMap);

			
			int clickpagenum = Integer.parseInt(String.valueOf(paramMap.get("clickpagenum")));
			int pagesize = Integer.parseInt(String.valueOf(paramMap.get("pagesize")));
			int startnum = (clickpagenum - 1) * pagesize;
			
			String loginID = (String) session.getAttribute("loginId");
			
			logger.info("loginId ??????????????????????????????????" + loginID);
			
			paramMap.put("startnum", startnum);

			paramMap.put("pagesize", pagesize);

			paramMap.put("loginID", loginID);

			List<RefundConfirmModel> refundConfirmlist = refundconfirmservice.refundConfirmMgt(paramMap);
			model.addAttribute("refundConfirmlist", refundConfirmlist);

			int refundConfirmMgtcnt = refundconfirmservice.refundConfirmMgtcnt(paramMap);
			model.addAttribute("refundConfirmMgtcnt", refundConfirmMgtcnt);

			logger.info("+ End " + className + ".refundConfirmMgt");
			
			
			return "cmp/refundConfirmlist";
		}
		
		@RequestMapping("SclickRefundConfirm.do")
		@ResponseBody
		public Map<String, Object> SclickRefundConfirm(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
				HttpServletResponse response, HttpSession session) throws Exception {
			
		    logger.info("@@@@@@@@@@@@@@@@@@@+ Start " + className + ".SclickRefundConfirm");
		    logger.info("    + Param :  " + paramMap);	
		    
		    refundconfirmservice.SclickRefundConfirm(paramMap);
		    
		    Map<String, Object> returnmap = new HashMap<String, Object>(); 
		    returnmap.put("result", "SUCEESS");
		    
		    logger.info("@@@@@@@@@@@@@@@@@@@+ End " + className + ".SclickRefundConfirm");
		    
		    return returnmap;
		}	
}
	