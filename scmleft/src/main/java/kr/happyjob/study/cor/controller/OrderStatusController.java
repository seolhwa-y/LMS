package kr.happyjob.study.cor.controller;

import java.util.HashMap;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.happyjob.study.cor.service.OrderStatusService;

@Controller
@RequestMapping("/cor/")
public class OrderStatusController {
	@Autowired
	OrderStatusService oss;

	// 주문현황 페이지 이동
	@RequestMapping("orderStatus.do")
	public String moveOrderStatusPage(Model model, HttpSession session)  throws Exception {
		String page = "login/login";
		
		if(session.getAttribute("loginId") != null) page ="cor/orderStatus";
		this.oss.backController(session, model, 1);
		
		return page;
	}
	
	// 주문 상세내역 불러오기
	@ResponseBody
	@PostMapping("/refundHistory")
	public HashMap<String, Object> showDetailOrder(HttpSession session, @RequestParam HashMap<String, Object> map) {
		map.put("loginId", session.getAttribute("loginId"));
		this.oss.backController(session, map, 1);
	
		return map;
	}
	
	// 입금 상태 변경
	@ResponseBody
	@PostMapping("/updJorderStatus")
	public HashMap<String, Object> updateJordetStatus(HttpSession session, @RequestParam HashMap<String, Object> map) {
		map.put("loginId", session.getAttribute("loginId"));
		this.oss.backController(session, map, 2);
	
		return map;
	}
	
	// 선택한 상품 반품요청
	@ResponseBody
	@PostMapping("/insReturnProduct")
	public HashMap<String, Object> insertReturnInfo(HttpSession session, @RequestParam HashMap<String, Object> map) {
		this.oss.backController(session, map, 3);
	
		return map;
	}
	
	// 검색
	@ResponseBody
	@PostMapping("/searchOrderList")
	public HashMap<String, Object> searchNewOrderList(HttpSession session, @RequestParam HashMap<String, Object> map) {
		map.put("loginId", session.getAttribute("loginId"));
		this.oss.backController(session, map, 4);
		
		return map;
	}
}
