package kr.happyjob.study.scm.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.mail.Session;
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

import kr.happyjob.study.scm.model.WarehouseVO;
import kr.happyjob.study.scm.service.wHouseInfoFormService;

@Controller
@RequestMapping("/scm/")
public class wHouseInfoFormController {

	@Autowired
	wHouseInfoFormService wHouseInfoFormService;
	
	//Set logger
		private final Logger logger = LogManager.getLogger(this.getClass());

		//Get class name for logger
		private final String className = this.getClass().toString();
		
		@RequestMapping("whinfo.do")
		public String whinfo (Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
				HttpServletResponse response, HttpSession session) throws Exception {
			
			 logger.info("+ Start " + className + ".counsel");
		      logger.info("   - paramMap : " + paramMap);
		      
		      logger.info("+ End " + className + ".counsel");
		
		      String loginID = (String) session.getAttribute("loginId");
				paramMap.put("loginID", loginID);
				System.out.println(loginID);
			
			return "scm/wHouseInfoForm";
		}
		// 창고등록 리스트 출력
		@RequestMapping("listWhvue.do")
		@ResponseBody
		public Map<String, Object> WhListVue(Model model, @RequestParam Map<String, Object> paramMap,
				HttpServletRequest request, HttpServletResponse response, HttpSession session) throws Exception {
			
			logger.info("   -paramMap: " + paramMap);
				String search = (String) paramMap.get("search");
				
			int currentPage = Integer.parseInt((String) paramMap.get("currentPage")); // 현재 페이지
			int pageSize = Integer.parseInt((String) paramMap.get("pageSize"));
			int pageIndex = (currentPage - 1) * pageSize;
			
			paramMap.put("pageIndex", pageIndex);
			paramMap.put("pageSize", pageSize);
			paramMap.put("search", search);
			
			//  창고등록 목록 조회
			List<WarehouseVO> WhList = wHouseInfoFormService.WhList(paramMap);
		
			// 목록 수 추출해서 보내기
			int WhCnt = wHouseInfoFormService.WhCnt(paramMap);
			
			Map<String, Object> resultMap = new HashMap<String, Object>();
			resultMap.put("WhList",WhList);
			resultMap.put("WhCnt",WhCnt);
			resultMap.put("currentPage", currentPage);
			
			return resultMap;
		}
		
		//창고등록 상세 조회
		 @RequestMapping("detailWh.do")
		 @ResponseBody
		 public Map<String, Object> detailWh(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
				 HttpServletResponse response, HttpSession sess) throws Exception {
			 
			 logger.info(" + Start " + className + ".detailWh");
			 logger.info("  -paramMap: "+ paramMap);
			 
			 String result ="";
			 //  선택된 게시판 1건 조회
			 WarehouseVO detailWh = wHouseInfoFormService.WhDetail(paramMap);
			 System.out.println("전달해야 하는 매개변수 : "+paramMap);
			 if(detailWh != null){
				 result = "SUCCESS";
			 }else{
				 result=" FAIL/ 불러오기에 실패했습니다."; //null 이면 실패
			 }
			 
			 Map<String, Object> resultMap = new HashMap<String, Object>();
			 resultMap.put("resultMsg", result); // success 용어 담기
			 resultMap.put("result", detailWh); //리턴 값 해쉬에 담기
			 System.out.println("이것이 무엇이다냐 디테일이다: "+detailWh);
			 
			 logger.info("+ End " + className + ". detailWh");
			 
			 return resultMap;
		 }
		// 공지사항 신규등록, 업데이트
			@RequestMapping("WhSave.do")
			@ResponseBody
			public Map<String, Object> noticeSave(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request, HttpServletResponse response, HttpSession session) throws Exception {
				
				logger.info("+ Start " + className + ".WhSave");
				logger.info("   - paramMap : " + paramMap);
				
				String action = (String)paramMap.get("action");
				String resultMsg = "";
				
				// 사용자 정보 설정
				paramMap.put("loginId", session.getAttribute("loginId"));
				
				logger.info("loginId : " + paramMap.get("loginId"));
				
				if ("I".equals(action)) {
					// 그룹코드 신규 저장
					wHouseInfoFormService.insertWh(paramMap);
					resultMsg = "SUCCESS";
				} else if("U".equals(action)) {
					// 그룹코드 수정 저장
					wHouseInfoFormService.updateWh(paramMap);
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
			
			// 창고등록 삭제
			@RequestMapping("WhDelete.do")
			@ResponseBody
			public Map<String, Object> noticeDelete(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
					HttpServletResponse response, HttpSession session) throws Exception {
				
				logger.info("+ Start " + className + ".noticeDelete");
				logger.info("   - paramMap : " + paramMap);

				String result = "SUCCESS";
				String resultMsg = "삭제 되었습니다.";
				
				//삭제
				wHouseInfoFormService.deleteWh(paramMap);
				
				Map<String, Object> resultMap = new HashMap<String, Object>();
				resultMap.put("result", result);
				resultMap.put("resultMsg", resultMsg);
				
				logger.info("+ End " + className + ".WhDelete");
				
				return resultMap;
			}
}
