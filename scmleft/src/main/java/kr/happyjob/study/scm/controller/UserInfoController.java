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
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.happyjob.study.scm.model.UserInfoModel;
import kr.happyjob.study.scm.service.UserInfoServiceImpl;

@Controller
@RequestMapping("/scm/")
public class UserInfoController {
	//빌립담당
	@Autowired
	UserInfoServiceImpl userInfoService;
	
	// Set logger
	private final Logger logger = LogManager.getLogger(this.getClass());

	// Get class name for logger
	private final String className = this.getClass().toString();
	/**
	 * 사용자관리 초기화면(관리자가 해주는 회원관리)
	 */
	
	@RequestMapping("UserInfo.do")
	public String initUser(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start " + className + ".initUser");
		
		String loginID = (String) session.getAttribute("loginId");
		paramMap.put("loginID", loginID);
			
		logger.info("   - loginID : " + loginID);
		logger.info("+ End " + className + ".listChaCD");

		return "scm/UserInfo";
	}
	
	
	/**
	 * 사용자관리 목록 조회
	 */
	@RequestMapping("UserInfoList.do")
	@ResponseBody
	public Map<String, Object> listUser(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start " + className + ".listUser");
		logger.info("   - (UserInfoList.do)paramMap : " + paramMap);
		
		
		int currentPage = Integer.parseInt((String)paramMap.get("currentPage"));	// 현재 페이지 번호
		int pageSize = Integer.parseInt((String)paramMap.get("pageSize"));			// 페이지 사이즈
		int pageIndex = (currentPage-1)*pageSize;												// 페이지 시작 row 번호
				
		paramMap.put("pageIndex", pageIndex);
		paramMap.put("pageSize", pageSize);
		
		// 공지사항 목록 조회
		List<UserInfoModel> listUser = userInfoService.listUser(paramMap);
					
		// 목록 수 추출해서 보내기
		int totalCount = userInfoService.countListUser(paramMap);
		
		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("listUser", listUser); // success 용어 담기 
		resultMap.put("totalCount", totalCount); // 리턴 값 해쉬에 담기 
		

		resultMap.put("pageSize", pageSize);
		resultMap.put("currentPage",currentPage);
	    
	    return resultMap;
	}
	
	// 사용자 상세 조회
			@RequestMapping("detailUser.do")
			@ResponseBody
			public Map<String,Object> detailNotice(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request, HttpServletResponse response, HttpSession session) throws Exception {
				
				//System.out.println("상세정보 보기를 위한 param에서 넘어온 값을 찍어봅시다.: " + paramMap);
				  logger.info("+ Start " + className + ".detailUser");
				  logger.info("   - paramMap : " + paramMap);
				  
				String result="";
				
				// 선택된 게시판 1건 조회 
				UserInfoModel detailUser = userInfoService.UserDetail(paramMap);
				
				if(detailUser != null) {
					result = "SUCCESS";  // 성공시 찍습니다. 
				}else {
					result = "FAIL / 불러오기에 실패했습니다.";  // null이면 실패입니다.
				}
				
				Map<String, Object> resultMap = new HashMap<String, Object>();
				resultMap.put("resultMsg", result); // success 용어 담기 
				resultMap.put("result", detailUser); // 리턴 값 해쉬에 담기 
				
				//resultMap.put("resultComments", comments);
				
				logger.info("+ End " + className + ".detailUser");
			    
			    return resultMap;
			}
			
		// 사용자 신규등록, 업데이트
		@RequestMapping("userSave.do")
		@ResponseBody
		public Map<String, Object> userSave(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request, HttpServletResponse response, HttpSession session) throws Exception {
			
			logger.info("+ Start " + className + ".userSave");
			logger.info("   - paramMap : " + paramMap);
			
			String action = (String)paramMap.get("action");
			String resultMsg = "";
			
			
			// 사용자 정보 설정
			paramMap.put("rloginId", paramMap.get("rloginId"));
			
			
			if ("I".equals(action)) {
				// 사용자 신규 등록
				userInfoService.insertUser(paramMap);
				resultMsg = "SUCCESS";
	
			} else if("U".equals(action)) {
				// 사용자 저장
				userInfoService.updateUser(paramMap);
				resultMsg = "UPDATED";
				System.out.println(paramMap);
			} else {
				resultMsg = "FALSE : 등록에 실패하였습니다.";
			}
			
			//결과 값 전송
			Map<String, Object> resultMap = new HashMap<String, Object>();
			resultMap.put("resultMsg", resultMsg);
		    
		    return resultMap;
		}		
		
		@RequestMapping("check_loginID.do")
		@ResponseBody
		public Map<String, Object> check_loginID(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request, HttpServletResponse response, HttpSession session) throws Exception 
		{
			logger.info("+ Start " + className + ".check_loginID");
			logger.info("   - paramMap : " + paramMap);
			
			//logger.info("   - checkid : " + paramMap.get("checkid"));
			
			int result = userInfoService.idcheck(paramMap);
			
			Map<String, Object> resultMap = new HashMap<String, Object>();
			resultMap.put("result", result);
			
			return resultMap;
		}
}
