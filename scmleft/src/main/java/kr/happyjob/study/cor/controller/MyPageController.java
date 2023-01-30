package kr.happyjob.study.cor.controller;

import java.util.HashMap;
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

import kr.happyjob.study.cor.model.MyPageModel;
import kr.happyjob.study.cor.service.MyPageService;

@Controller
@RequestMapping("/cor/")
public class MyPageController {
	
	@Autowired
	MyPageService myPageService;
	
	// Set logger
	private final Logger logger = LogManager.getLogger(this.getClass());

	// Get class name for logger
	private final String className = this.getClass().toString();
	
	
	//공통초기화면
	@RequestMapping("myPage")
	public String myPage(Model model, @RequestParam Map<String, Object>paramMap, HttpServletRequest request,
						HttpServletResponse response, HttpSession session) throws Exception{
		
		logger.info("+ Start " + className + ".Mypage");
		
		// 사용자 정보 설정
		//paramMap.put("loginID", session.getAttribute("loginId"));
		request.setAttribute("loginID", session.getAttribute("loginID"));
		
		logger.info("+ End " + className + ".Mypage");

		return "cor/myPage";
		
	}
	
	//회원상세정보 뿌리기
	@RequestMapping("detailUser.do")
	@ResponseBody
	public Map<String, Object> detailUser (Model model, @RequestParam Map<String, Object>paramMap, HttpServletRequest request,
										   HttpServletResponse response, HttpSession session) throws Exception{
		
		 logger.info("+ Start " + className + ".detailUser");
		  
		 paramMap.put("loginID", session.getAttribute("loginId"));
		  
		 String result="";
		 
		 //1건조회
		 MyPageModel detailUser = myPageService.detailUser(paramMap);
		 
		 if (detailUser != null) {
			result = "SUCCESS";
		}else {
			result = "fail";
		}
		 
		 Map<String, Object> resultMap = new HashMap<String, Object>();
		 resultMap.put("result", detailUser);
		 resultMap.put("resultMsg", result);
		 
		 logger.info("+ End " + className + ".detailUser");
		 
		 return resultMap;
	}
					
	
	//업데이트
	@RequestMapping("saveUser.do")
	@ResponseBody
	public Map<String, Object> saveUser(Model model, @RequestParam Map<String, Object>paramMap, HttpServletRequest request,
										HttpServletResponse response, HttpSession session)throws Exception{
		
		logger.info("+ Start " + className + ".saveUser");
		logger.info("   - paramMap : " + paramMap);
		logger.info("비번="+paramMap.get("password"));
		
		//String loginID = (String)request.getParameter("rloginID");
		//paramMap.put("loginID", loginID);
		
		myPageService.updateUser(paramMap); // 수정 service
		
		Map<String, Object> resultMap = new HashMap<String, Object>();
		
		logger.info("+ End " + className + ".userSave");
		
		return resultMap;
		
	}
	
	

}
