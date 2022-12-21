package kr.happyjob.study.cor.controller;

import java.util.HashMap;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import kr.happyjob.study.cor.service.OrderStatusService;
import kr.happyjob.study.cor.model.OrderStatusModel;

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
		 * 개발기간 : 2022-12-23 ~ 
		 * 비고 : Service 단에서 기간별 매출 TOP10 내역을 가져와서 페이지에 보내준다. */
		
		this.oss.backController(mav, 1);
		
		mav.setViewName("cor/orderStatus");
		
		return mav;
	}
	
	// 주문 상세내역 불러오기
	@ResponseBody
	public HashMap<String, Object> showDetailOrder(Model model, HashMap<String, Object> map, @ModelAttribute OrderStatusModel osm) {
		this.oss.backController(model, 1);
	
		return map;
	}
	
	// 선책한 상품 반품요청
	@ResponseBody
	public HashMap<String, Object> insertReturnInfo(Model model, HashMap<String, Object> map, @ModelAttribute OrderStatusModel osm) {
		this.oss.backController(model, 2);
	
		return map;
	}
	
	// 모델명 검색 (x)
	// 구매일 재선택 (x)
}
