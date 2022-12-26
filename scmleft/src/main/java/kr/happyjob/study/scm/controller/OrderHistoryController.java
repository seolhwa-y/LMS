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
import org.springframework.web.servlet.ModelAndView;

import kr.happyjob.study.scm.model.OrderHistoryModel;
import kr.happyjob.study.scm.service.OrderHistoryService;

@Controller
@RequestMapping("/scm/")
public class OrderHistoryController {
	@Autowired
	OrderHistoryService ohs;
	
	/* 1. 일별 수주 내역 (기간별)
	 * 2. 발주지시서 보기
	 * 3. 발주지시서 완료
	 * 4. 배송지시서 보기
	 * 5. 배송지시서 완료
	 * 6. 기간 재선택 (x)
	 * 7. 입금된 목록만 보기 (x) */
	
	// 일별 수주 내역 페이지
	@RequestMapping("orderHistory.do")
	public ModelAndView moveOrderHistoryPage(ModelAndView mav, HttpSession session)  throws Exception {
		/* 담당자 : 염설화
		 * 개발기간 : 2022-12-21 ~ 2022-12-21
		 * 비고 : Service 단에서 현재 주문내역을 가져와서 페이지에 보내준다. */

		this.ohs.backController(session, mav, 1); // 일별 주수 내역 불러오기
		
		return mav;
	}
	
	// 지시서 보기
	@ResponseBody
	@PostMapping("showDirection")
	public HashMap<String, Object> showDirectionInfo (HttpSession session, @RequestParam HashMap<String, Object> map) {
		/* 담당자 : 염설화
		 * 개발기간 : 2022-12-21 ~ 
		 * 비고 : Service 단에서 SCM 담당자가 클릭한 발주지시서의 재고가 있는 창고 리스트를 가져와서 보내준다. */
		map.put("loginId", session.getAttribute("loginId"));
		this.ohs.backController(session, map, 1);
		
		return map;
	}
	
	// 발주지시서 작성완료
	@ResponseBody
	public HashMap<String, Object> insertBorderDirection (HttpSession session, @RequestParam HashMap<String, Object> map) {
		/* 담당자 : 염설화
		 * 개발기간 : 2022-12-21 ~ 
		 * 비고 : Service 단에서 SCM 담당자가 작성한 발주지시서를 DB에 Insert 한다. */
		
		this.ohs.backController(session, map, 2);
		
		return map;
	}
	
	// 배송지시서 보기
	@ResponseBody
	public HashMap<String, Object> showShipWarehouseInfoCtl (Model model, HashMap<String, Object> map, HttpSession session, @ModelAttribute OrderHistoryModel ohm) {
		/* 담당자 : 염설화
		 * 개발기간 : 2022-12-21 ~ 
		 * 비고 : Service 단에서 SCM 담당자가 클릭한 배송지시서의 재고가 있는 창고 리스트를 가져와서 보내준다. */
		
		this.ohs.backController(session, map, 3);
		
		return map;
	}
	
	// 배송지시서 작성완료
	@ResponseBody
	public HashMap<String, Object> insertShipDirectionCtl (Model model, HashMap<String, Object> map, HttpSession session, @ModelAttribute OrderHistoryModel ohm) {
		/* 담당자 : 염설화
		 * 개발기간 : 2022-12-21 ~ 
		 * 비고 : Service 단에서 SCM 담당자가 작성한 배송지시서를 DB에 Insert 한다. */
		this.ohs.backController(session, map, 4);
		
		return map;
	}
	
	// 기간 재선택 (x)
	@ResponseBody
	@PostMapping("/searchOrderHistoryList")
	public HashMap<String, Object> searchOrderHistoryCtl (Model model, @RequestParam HashMap<String, Object> map, HttpSession session, @ModelAttribute OrderHistoryModel ohm) {
		/* 담당자 : 염설화
		 * 개발기간 : 2022-12-21 ~ 
		 * 비고 : Service 단에서 SCM 담당자가 작성한 배송지시서를 DB에 Insert 한다. */
		
		this.ohs.backController(session, map, 5);
		return map;
	}
	// 입금된 목록만 보기 (x)
}
