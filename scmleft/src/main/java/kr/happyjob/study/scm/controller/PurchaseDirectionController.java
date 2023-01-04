package kr.happyjob.study.scm.controller;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;


@Controller
@RequestMapping("scm")
public class PurchaseDirectionController {
	
	
	// Set logger
	private final Logger logger = LogManager.getLogger(this.getClass());
		
	// Get class name for logger
	private final String className = this.getClass().toString();
	
	// 1. 발주 지시서 초기페이지
	
	@RequestMapping("purchaseDirection.do")
	private String purchaseDirection(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start " + className + ".purchaseDirection");
		logger.info("   - paramMap : " + paramMap);
		logger.info("+ End " + className + ".courseMng");
		
		return "scm/purchaseDirection";
	}
	
	
	

}
