package kr.happyjob.study.scm.controller;

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

import com.google.gson.Gson;

import kr.happyjob.study.scm.service.PurchaseDirectionInter;


@Controller
@RequestMapping("scm")
public class PurchaseDirectionController {
	
	@Autowired
	PurchaseDirectionInter pdi;
	
	// 페이지 로드시 리스트 + 카운트
	@RequestMapping("purchaseDirection.do")
	public String purchaseDirectioList(Model model, @RequestParam HashMap<String, Object> paramMap, HttpSession session) throws Exception {
		Gson gson = new Gson();
		String page = "/login/login";
		
		if(session.getAttribute("loginId") != null) page = "/scm/purchaseDirection";
		
		paramMap.put("pageNum", "1");
		paramMap.put("listCount", "10");
		model.addAttribute("result", gson.toJson(pdi.getPurDirectionList(paramMap)));
		
		return page;
	}
	
	// 기간별 조회 및 검색어
	@ResponseBody
	@RequestMapping("/searchPurDirectionList")
	public HashMap<String, Object> searchPurchaseDirectionList(Model model, @RequestParam HashMap<String, Object> paramMap, HttpSession session) throws Exception {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();

		resultMap.put("result", pdi.getPurDirectionList(paramMap));
		
		return resultMap;
	}
	

}
