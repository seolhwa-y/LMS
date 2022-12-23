package kr.happyjob.study.cor.controller;

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
import org.springframework.web.servlet.ModelAndView;

import kr.happyjob.study.cor.model.OrderStatusModel;
import kr.happyjob.study.cor.service.OrderStatusService;

@Controller
@RequestMapping("/cor/")
public class OrderStatusController {
	@Autowired
	OrderStatusService oss;
	
	/* 1. 주문내역 불러오기
	 * 2. 주문 상세내역 불러오기
	 * 3. 선택한 상품 반품요청
	 * 4. 모델명으로 검색 (x)
	 * 5. 구매날짜 재선택 (x) */
	
	// 주문현황 페이지 이동
	@RequestMapping("orderStatus.do")
	public ModelAndView moveOrderStatusPage(ModelAndView mav, HttpSession session)  throws Exception {
		/* 담당자 : 염설화
		 * 개발기간 : 2022-12-22 ~ 2022-12-22
		 * 비고 : Service 단에서 회원의 주문내역을 가져와서 페이지에 보내준다. */
		
		this.oss.backController(session, mav, 1);
		
		return mav;
	}
	
	// 주문 상세내역 불러오기
	@ResponseBody
	@PostMapping("/refundHistory")
	public HashMap<String, Object> showDetailOrder(HttpSession session, @RequestParam HashMap<String, Object> map) {
		/* 담당자 : 염설화
		 * 개발기간 : 2022-12-22 ~ 2022-12-22
		 * 비고 : Service 단에서 회원의 주문내역 제품들을 가져와서 페이지에 보내준다. */
		map.put("loginId", session.getAttribute("loginId"));
		this.oss.backController(session, map, 1);
	
		return map;
	}
	
	// 선택한 상품 반품요청
	@ResponseBody
	@PostMapping("/")
	public HashMap<String, Object> insertReturnInfo(Model model, HttpSession session, @RequestParam HashMap<String, Object> map) {
		this.oss.backController(session, map, 2);
	
		return map;
	}
	
	// 모델명 검색 (x)
	// 구매일 재선택
	@ResponseBody
	@PostMapping("/searchOrderList")
	public HashMap<String, Object> searchNewOrderList(HttpSession session, @RequestParam HashMap<String, Object> map) {
		map.put("loginId", session.getAttribute("loginId"));
		this.oss.backController(session, map, 3);
		
		return map;
	}
}
