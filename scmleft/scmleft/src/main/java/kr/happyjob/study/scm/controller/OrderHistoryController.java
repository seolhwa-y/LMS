package kr.happyjob.study.scm.controller;

import java.util.HashMap;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.happyjob.study.scm.model.OrderHistoryModel;
import kr.happyjob.study.scm.service.OrderHistoryService;

@Controller
@RequestMapping("/scm/")
public class OrderHistoryController {
	@Autowired
	OrderHistoryService ohs;
	
	// 일별 수주 내역 페이지
	@RequestMapping("orderHistory.do")
	public String moveOrderHistoryPage(HttpSession session, Model model) throws Exception {
		String page = "scm/orderHistory";
		
		if(session.getAttribute("loginId") == null) page = "/login/login";
		this.ohs.backController(session, model, 1);
		
		return page;
	}
	
	// 검색
	@ResponseBody
	@PostMapping("/searchOrderHistoryList")
	public HashMap<String, Object> searchOrderHistoryCtl (HttpSession session, @RequestParam HashMap<String, Object> map) {
		this.ohs.backController(session, map, 1);
		
		return map;
	}
	
	// 지시서 보기
	@ResponseBody
	@PostMapping("/showDirection")
	public HashMap<String, Object> showDirectionInfo (HttpSession session, @RequestParam HashMap<String, Object> map) {
		map.put("loginId", session.getAttribute("loginId"));
		this.ohs.backController(session, map, 2);
		
		return map;
	}
	
	// 발주지시서 작성완료
	@ResponseBody
	@PostMapping("/insertBorderDirection")
	public HashMap<String, Object> insertBorderDirectionCtl (HttpSession session, @RequestParam HashMap<String, Object> map) {
		map.put("loginId", session.getAttribute("loginId"));
		this.ohs.backController(session, map, 3);
		
		return map;
	}
	
	// 배송지시서 작성완료
	@ResponseBody
	@PostMapping("/insertShipDirection")
	public HashMap<String, Object> insertShipDirectionCtl (HttpSession session, @RequestParam HashMap<String, Object> map) {
		map.put("loginId", session.getAttribute("loginId"));
		this.ohs.backController(session, map, 4);
		
		return map;
	}
	

}
