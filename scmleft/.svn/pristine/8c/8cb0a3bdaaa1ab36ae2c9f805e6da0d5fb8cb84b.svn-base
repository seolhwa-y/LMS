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

import kr.happyjob.study.scm.model.RefundInfoVO;
import kr.happyjob.study.scm.model.WarehouseVO;
import kr.happyjob.study.scm.service.RefundInfoService;

@Controller
@RequestMapping("/scm/")
public class RefundInfoController {
	
	@Autowired
	RefundInfoService refundInfoService;

	private final Logger logger = LogManager.getLogger(this.getClass());
	private final String className = this.getClass().toString();
	
	
	@RequestMapping("refundInfo.do")
	public String refundInfo(){
		logger.info("+ Start" + className + ".RefundInfo");
		return "scm/refundInfo";

	}
	
	
	@RequestMapping("refundInfoList.do")
	public String refundInfoList(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session ) throws Exception{

		logger.info("+ Start" + className + ".refundInfoList");
		
		int currentPage = Integer.parseInt((String)paramMap.get("currentPage")); 
		int pageSize = Integer.parseInt((String)paramMap.get("pageSize"));
		int pageIndex = (currentPage -1)*pageSize;
		
		paramMap.put("pageIndex", pageIndex);
		paramMap.put("pageSize", pageSize);
		
		String pdname = (String)paramMap.get("pdname");
		String sdate = (String)paramMap.get("sdate");
		String edate = (String)paramMap.get("edate");
		String searchKey = (String)paramMap.get("searchKey");
		
		paramMap.put(pdname, pdname);
		paramMap.put(sdate, sdate);
		paramMap.put(edate, edate);
		paramMap.put(searchKey, searchKey);
		
		//logger.info(" - paramMap :" + paramMap);
		
		List<RefundInfoVO> refundInfoList = refundInfoService.refundInfoList(paramMap);
		model.addAttribute("refundInfoList", refundInfoList);
		model.addAttribute("paramMap", paramMap);
		
		int totalCnt = refundInfoService.countRefundInfoList(paramMap);
		model.addAttribute("totalCnt", totalCnt);
		model.addAttribute("pageSize", pageSize);
		model.addAttribute("currentPage", currentPage);

		
		logger.info("+ End" + className + ".refundInfoList");
		
		return "scm/refundInfoList";
	}
	
	//배송지시서 상세 모달 
	   @RequestMapping("refundDtModal.do")
	   @ResponseBody
	   public Map<String, Object> refundDtModal(Model model, @RequestParam Map<String, Object> paramMap, 
			   HttpServletRequest request, HttpServletResponse response, HttpSession session) throws Exception {
	     
		  logger.info("+ Start " + className + ".refundDtModalList");
	     // logger.info("   - paramMap : " + paramMap);
	      Map<String, Object> resultMap = new HashMap<String, Object>();
	      
	      RefundInfoVO rDtModal = refundInfoService.refundDtModalList(paramMap);
	      List<WarehouseVO> wareInfo = refundInfoService.selectWareInfo(paramMap);
	      
	      resultMap.put("loginId", session.getAttribute("loginId"));
	      resultMap.put("result", rDtModal);
	      resultMap.put("wareInfo", wareInfo);
	      
	      //logger.info("   - result : " + rDtModal);
	     // logger.info("   - returnmap : " + resultMap);
	      
	      logger.info("+ End " + className + ".refundDtModalList");
	      
	      return resultMap;
	   }
	
	   //업데이트
		@RequestMapping("updateRefund.do")
		@ResponseBody
		public Map<String, Object> updateRefund(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
				HttpServletResponse response, HttpSession session) throws Exception {
			
			logger.info("+ Start " + className + ".updateRefund");
			logger.info("jhgfhjfhjghj    ::: " + paramMap);
			
			///String loginId = (String)session.getAttribute("loginId");	
			//paramMap.put("loginId",loginId);
			
			paramMap.put("loginId", session.getAttribute("loginId"));
			
		       Map<String, Object> returnmap = new HashMap<String, Object>(); 
		       returnmap.put("result", "SUCEESS");

			
			logger.info("+ End " + className + ".updateRefund");
			
			refundInfoService.updateRefund(paramMap);
			
			return returnmap;
			
		}
		
}
