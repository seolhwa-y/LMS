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

import kr.happyjob.study.scm.model.NoticeMgrModel;
import kr.happyjob.study.scm.service.NoticeMgrService;

@Controller
@RequestMapping("/scm/")
public class NoticeMgr {
	
	@Autowired
	NoticeMgrService noticeMgrSerivce;
	
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
	      
	      String loginID = (String)session.getAttribute("loginId");
	      paramMap.put("loginId", loginID);
	      System.out.println(loginID);
	
	      return "scm/noticeMgr";
	   }
	   
	   @RequestMapping("noticeMgrListvue.do")
	   @ResponseBody
	   public Map<String, Object> noticeMgrListvue(Model model, @RequestParam Map<String, Object> paramMap,
			   HttpServletRequest request, HttpServletResponse response, HttpSession session) throws Exception{
		   
		   logger.info("   - paramMap : " + paramMap);
		   String title = (String)paramMap.get("title");
		   
		   int currentPage = Integer.parseInt((String)paramMap.get("currentPage"));
		   int pageSize = Integer.parseInt((String) paramMap.get("pageSize"));
		   int pageIndex = (currentPage - 1) * pageSize;
		   
			
		   paramMap.put("pageIndex", pageIndex);
		   paramMap.put("pageSize", pageSize);
		   paramMap.put("title", title);
		   
		   // 공지사항 목록 조회
		   List<NoticeMgrModel> noticeMgrList = noticeMgrSerivce.noticeMgrList(paramMap);
		   // 목록 조회수 추출해서 보내기
		   int noticeMgrCnt = noticeMgrSerivce.noticeMgrCnt(paramMap);
		   
		   Map<String, Object> resultMap = new HashMap<String, Object>();
		   resultMap.put("noticeMgr", noticeMgrList);
		   resultMap.put("noticeCnt", noticeMgrCnt); // 리턴 값 해쉬에 담기 
		   resultMap.put("pageSize", pageSize);
		   resultMap.put("currentPage",currentPage);
		   
		   return resultMap;
		   
	   }
	   
	   // 공지사항 상세 조회
	   @RequestMapping("detailNoticeMgr.do")
	   @ResponseBody
	   public Map<String, Object> detailNoticeMgr(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request, HttpServletResponse response, HttpSession session) throws Exception {
		   
		   logger.info("+ Start " + className + ".detailNotice");
		   logger.info("   - paramMap : " + paramMap);
		   
		   String result = "";
		   
		   // 선택된 게시판 1건 조회
		   NoticeMgrModel detailNoticeMgr = noticeMgrSerivce.noticeMgrDetail(paramMap);
		   
		   if(detailNoticeMgr != null){
			   result = "SUCCESS";
			   noticeMgrSerivce.noticeMgrViewcont(paramMap);
		   }else{
			   result = "FAIL / 불러오기에 실패했습니다.";
		   }
		   
		   
		   Map<String, Object> resultMap = new HashMap<String, Object>();
		   resultMap.put("resultMsg", result);
		   resultMap.put("result", detailNoticeMgr);
		   
		   System.out.println(detailNoticeMgr);
		   
		   logger.info("+ End "+ className + ".detailNoticeMgr");
		   
		   
		   return resultMap;
	   }
	   
	   // 공지사항 저장 및 수정
	   @RequestMapping("noticeMgrSave.do")
	   @ResponseBody
	   public Map<String, Object> noticeMgrSave(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request, HttpServletResponse response, HttpSession session) throws Exception{
		   
		  // System.out.println("수정 들어옴");
		   logger.info("+ Start " + className + ".noticeMgrSave");
		   logger.info("  - paramMap : " + paramMap);
		   
		   String action = (String)paramMap.get("action");
		   String resultMsg = "";
		   
		   // 사용자 정보 설정
		   paramMap.put("loginId", session.getAttribute("loginId"));
		   
		   logger.info("loginId : " + paramMap.get("loginId"));
		   
		   if("I".equals(action)){
			   // 신규 저장
			   noticeMgrSerivce.insertNoticeMgr(paramMap);
			   resultMsg = "SUCCESS";
		   }else if("U".equals(action)){
			   //수정
			   noticeMgrSerivce.updateNoticeMgr(paramMap);
			   resultMsg = "UPDATE";
		   }else{
			   resultMsg = "FALSE : 등록에 실패";
		   }
		   
		   // 결과 값 전송
		   Map<String, Object> resultMap = new HashMap<String, Object>();
		   resultMap.put("resultMsg", resultMsg);
		   
		   return resultMap;
	   }
	   
	   // 공지사항 삭제
	   @RequestMapping("noticeMgrDelete.do")
	   @ResponseBody
	   public Map<String, Object> noticeMgrDelete(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request, HttpServletResponse response, HttpSession session) throws Exception{
		   
		   logger.info("+ Start " + className + ".noticeMgrDelete");
		   logger.info(" - paramMap " + paramMap);
		   
		   String result = "SUCCESS";
		   String resultMsg = "삭제 되었습니다.";
		   
		   noticeMgrSerivce.deleteNoticeMgr(paramMap);
		   
		   Map<String, Object> resultMap = new HashMap<String, Object>();
		   resultMap.put("result", result);
		   resultMap.put("resultMsg", resultMsg);
		   
		   logger.info("+ End " + className + ".noticeMgrDelete");
		   
		   return resultMap;
	   }

}
