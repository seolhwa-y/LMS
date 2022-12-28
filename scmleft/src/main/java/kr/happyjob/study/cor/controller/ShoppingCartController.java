package kr.happyjob.study.cor.controller;

import java.util.HashMap;
import java.util.List;

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

import kr.happyjob.study.cor.model.ShoppingCartModel;
import kr.happyjob.study.cor.service.ShoppingCartService;


@Controller
@RequestMapping("/cor/")
public class ShoppingCartController {
	@Autowired
	ShoppingCartService scs;
	
	/* 1. 장바구니 목록 불러오기
	 * 2. 선택 항목 장바구니에서 삭제하기
	 * 3. 주문하기 */
	
	// 장바구니 현황 페이지 이동
	@RequestMapping("shoppingCart.do")
	public ModelAndView moveSoppingCartPage(ModelAndView mav, HttpSession session)  throws Exception {	
		/* 담당자 : 염설화
		 * 개발기간 : 2022-12-22 ~ 2022-12-22
		 * 비고 : Service 단에서 장바구니 내역 가져와서 페이지에 보내준다. */
		this.scs.backController(session, mav, 1); // 장바구니 목록 불러오기
		
		return mav;
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
		System.err.println(map);
		
		this.scs.backController(session, map, 2);
		
		return map;
	}
}
