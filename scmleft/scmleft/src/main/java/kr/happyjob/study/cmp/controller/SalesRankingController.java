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

	// 매출 상위 10개 업체 페이지 이동
	@RequestMapping("salesRanking.do")
	public String moveSalesRankingPage(Model model, HttpSession session)  throws Exception {
		String page = "login/login";
		
		if(session.getAttribute("loginId") != null) page = "cmp/salesRanking";
		this.srs.backController(session, model, 1); // 매출 TOP10 내역 불러오기
		
		return page;
	}
	
	// 조회
	@ResponseBody
	@PostMapping("/searchRank")
	public HashMap<String, Object> showDetailOrder(HttpSession session, @RequestParam HashMap<String, Object> map) {
		this.srs.backController(map, 1);
	
		return map;
	}
}
