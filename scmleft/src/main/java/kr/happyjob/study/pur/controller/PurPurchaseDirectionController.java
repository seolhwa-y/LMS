package kr.happyjob.study.pur.controller;

import java.util.HashMap;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.google.gson.Gson;

import kr.happyjob.study.pur.service.PurPurchaseDirectionInter;

@Controller
@RequestMapping("/pur/")
public class PurPurchaseDirectionController {
	@Autowired
	PurPurchaseDirectionInter pdi;
	
	// 페이지 로드시 리스트 + 카운트
	@RequestMapping("purchaseDirection.do")
	public String movePurchaseDirectionPage(Model model, @RequestParam HashMap<String, Object> paramMap, HttpSession session) throws Exception {
		Gson gson = new Gson();
		String page = "/login/login";
		
		if(session.getAttribute("loginId") != null) page = "/pur/purchaseDirection";
		
		paramMap.put("pageNum", "1");
		paramMap.put("listCount", "10");
		model.addAttribute("result", gson.toJson(pdi.getPurDirectionList(paramMap)));
		System.err.println("data check :: ");
		System.err.println(pdi.getPurDirectionList(paramMap));
		return page;
	}
	
	// 기간별 조회 및 검색어
	@ResponseBody
	@RequestMapping("/searchPurDirectionList")
	public HashMap<String, Object> searchPurDirectionListCtl(Model model, @RequestParam HashMap<String, Object> paramMap, HttpSession session) throws Exception {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();

		resultMap.put("result", pdi.getPurDirectionList(paramMap));
		
		return resultMap;
	}
	
	// 해당 발주지시서 상세보기
	@ResponseBody
	@RequestMapping("/searchPurDirectionDetail")
	public HashMap<String, Object> searchPurDirectionDetailCtl(Model model, @RequestParam HashMap<String, Object> paramMap, HttpSession session) throws Exception {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();

		resultMap.put("result", pdi.getPurDirectionList(paramMap));
		
		return resultMap;
	}
	
	// 발주지시서 입금처리
	@ResponseBody
	@RequestMapping("/updateBorderDirection")
	public HashMap<String, Object> updateBorderDirectionCtl(Model model, @RequestParam HashMap<String, Object> paramMap, HttpSession session) throws Exception {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();

		resultMap.put("result", pdi.updatePurDirectionType(paramMap));
		
		return resultMap;
	}
}
