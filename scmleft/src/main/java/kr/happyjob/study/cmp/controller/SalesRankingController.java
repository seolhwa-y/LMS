package kr.happyjob.study.cmp.controller;

import java.util.HashMap;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import kr.happyjob.study.cmp.service.SalesRankingService;

@Controller
@RequestMapping("/cmp/")
public class SalesRankingController {
	@Autowired
	SalesRankingService srs;
	
	/* 1. 매출 TOP10 보기
	 * 2. 기간 재선택 (x) */
	
	// 매출 상위 10개 업체 페이지 이동
	@RequestMapping("salesRanking.do")
	public ModelAndView moveSalesRankingPage(ModelAndView mav, HttpSession session)  throws Exception {
		/* 담당자 : 염설화
		 * 개발기간 : 2022-12-22 ~ 2022-12-22
		 * 비고 : Service 단에서 기간별 매출 TOP10 내역을 가져와서 페이지에 보내준다. */
		
		this.srs.backController(session, mav, 1); // 매출 TOP10 내역 불러오기
		
		return mav;
	}
	
	//
	@ResponseBody
	@PostMapping("/searchRank")
	public HashMap<String, Object> showDetailOrder(HttpSession session, @RequestParam HashMap<String, Object> map) {
		/* 담당자 : 염설화
		 * 개발기간 : 2022-12-22 ~ 2022-12-22
		 * 비고 : Service 단에서 회원의 주문내역 제품들을 가져와서 페이지에 보내준다. */
		this.srs.backController(map, 1);
	
		return map;
	}
}
