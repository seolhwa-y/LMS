package kr.happyjob.study.scm.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.google.gson.Gson;

import kr.happyjob.study.scm.model.ReturnDirVO;
import kr.happyjob.study.scm.service.ReturnDirService;



@Controller
@RequestMapping("/scm/")
public class ReturnDircontroller {
	
	@Autowired //묶어준다
	ReturnDirService returnDirService;
	
	private final Logger logger = LoggerFactory.getLogger(ReturnDircontroller.class);
	private final String className = this.getClass().toString();

	
	@RequestMapping("refundIns.do")
	public String returnDir(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession Session, Gson gson) throws Exception{
		
		logger.info("+ Start " + className + ".returnDir");
		logger.info("   - paramMap : " + paramMap);
		
		paramMap.put("pageIndex", 1);
		paramMap.put("pageSize", 10);
		
		model.addAttribute("returnDirList", gson.toJson(returnDirService.returnDirList(paramMap)));	
		model.addAttribute("totalCnt", gson.toJson(returnDirService.returnDirTotalCnt(paramMap)));

		
		logger.info("+ End " + className + ".returnDir");
		
		return "scm/returnDirSheet_vue";
		
	}

	@ResponseBody
	@RequestMapping("returnDirList.do")
	public Map<String, Object> returnDirList(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession Session) throws Exception{
		
		logger.info("+ Start " + className + ".returnDirList");
		logger.info("   - paramMap : " + paramMap);
		
		int currentPage = Integer.parseInt((String)paramMap.get("currentPage")); 
		int pageSize = Integer.parseInt((String)paramMap.get("pageSize"));
		int pageIndex = (currentPage - 1)*pageSize; //페이지 시작  row번호
		
		paramMap.put("pageIndex", pageIndex);
		paramMap.put("pageSize", pageSize);
		
		Map<String, Object> resultMap = new HashMap<String, Object>(); 
		List<ReturnDirVO> returnDirList = returnDirService.returnDirList(paramMap);
		resultMap.put("returnDirList", returnDirList);	
		
		int totalCnt = returnDirService.returnDirTotalCnt(paramMap);
		resultMap.put("totalCnt", totalCnt);
		resultMap.put("pageSize", pageSize);
		resultMap.put("currentPage", currentPage);
		
		logger.info("+ End " + className + ".returnDirList");
		
		System.out.println(paramMap + "::" +returnDirList);
		
		return resultMap;
		
	}
	
	
	
	
//	@RequestMapping("refundIns.do")
//	public String returnDir(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
//			HttpServletResponse response, HttpSession Session) throws Exception{
//		
//		logger.info("+ Start " + className + ".returnDir");
//		logger.info("   - paramMap : " + paramMap);
//		
//		logger.info("+ End " + className + ".returnDir");
//		
//		return "scm/returnDirSheet_vue";
//		
//	}
//
//	@RequestMapping("returnDirList.do")
//	public String returnDirList(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
//			HttpServletResponse response, HttpSession Session) throws Exception{
//		
//		logger.info("+ Start " + className + ".returnDirList");
//		logger.info("   - paramMap : " + paramMap);
//		
//		int currentPage = Integer.parseInt((String)paramMap.get("currentPage")); 
//		int pageSize = Integer.parseInt((String)paramMap.get("pageSize"));
//		int pageIndex = (currentPage - 1)*pageSize; //페이지 시작  row번호
//		
//		paramMap.put("pageIndex", pageIndex);
//		paramMap.put("pageSize", pageSize);
//		
//		String cpname = (String)paramMap.get("cpname");
//		String searchKey = (String)paramMap.get("searchKey");
//		String sdate = (String)paramMap.get("sdate");
//		String edate = (String)paramMap.get("edate");
//		
//		paramMap.put(cpname, cpname);
//		paramMap.put(searchKey, searchKey);
//		paramMap.put(sdate, sdate);
//		paramMap.put(edate, edate);
//		
//		List<ReturnDirVO> returnDirList = returnDirService.returnDirList(paramMap);
//		model.addAttribute("returnDirList", returnDirList);	
//		
//		int totalCnt = returnDirService.returnDirTotalCnt(paramMap);
//		model.addAttribute("totalCnt", totalCnt);
//		model.addAttribute("pageSize", pageSize);
//		model.addAttribute("currentPage", currentPage);
//		
//		logger.info("+ End " + className + ".returnDirList");
//		
//		System.out.println(paramMap + "::" +returnDirList);
//		return "scm/returnDirSheetList";
//		
//	}
	

}