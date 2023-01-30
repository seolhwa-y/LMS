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

import kr.happyjob.study.cor.service.ShoppingCartService;

@Controller
@RequestMapping("/cor/")
public class ShoppingCartController {
	@Autowired
	ShoppingCartService scs;
	
	// 장바구니 현황 페이지 이동
	@RequestMapping("shoppingCart.do")
	public String moveSoppingCartPage(Model model, HttpSession session)  throws Exception {	
		String page = "login/login";
		
		if(session.getAttribute("loginId") != null) page = "cor/shoppingCart";
		this.scs.backController(session, model, 1);
		
		return page;
	}
	
	// 선택 항목 장바구니 목록 삭제
	@ResponseBody
	@PostMapping("delBasketProduct")
	public HashMap<String, Object> deleteSoppingCart(HttpSession session, @RequestParam HashMap<String, Object> map) {
		map.put("loginId", session.getAttribute("loginId"));
		this.scs.backController(session, map, 1);
		
		return map;
	}

	// 주문하기	
	@ResponseBody
	@PostMapping("insJorder")
	public HashMap<String, Object> insertJorderInfo(HttpSession session, @RequestParam HashMap<String, Object> map) {
		map.put("loginId", session.getAttribute("loginId"));
		this.scs.backController(session, map, 2);
		
		return map;
	}
}
