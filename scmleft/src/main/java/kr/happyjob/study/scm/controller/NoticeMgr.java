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
import org.springframework.web.servlet.ModelAndView;

@Controller
@RequestMapping("/scm/")
public class NoticeMgr {
	
	private final Logger logger = LogManager.getLogger(this.getClass());

	// Get class name for logger
	private final String className = this.getClass().toString();

	public NoticeMgr() {
		// TODO Auto-generated constructor stub
	}

	   @RequestMapping("noticeMgr.do")
	   public String noticeMgr(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
	         HttpServletResponse response, HttpSession session) throws Exception {
	      
	      logger.info("+ Start " + className + ".counsel");
	      logger.info("   - paramMap : " + paramMap);
	      
	      logger.info("+ End " + className + ".counsel");
	
	      return "scm/noticeMgr";
	   }


}
