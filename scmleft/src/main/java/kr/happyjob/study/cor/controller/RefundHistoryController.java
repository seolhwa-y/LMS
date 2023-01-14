package kr.happyjob.study.cor.controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.google.gson.Gson;

import kr.happyjob.study.cor.service.RefundHistoryInter;

@Controller
@RequestMapping("/cor/")
public class RefundHistoryController {

	@Autowired
	RefundHistoryInter rhi;
	
	// 페이지 로딩시 리스트 가져오기
		@RequestMapping("refundHistory.do")
		public String moveReturnHistoryPage (HttpSession session, Model model, @RequestParam HashMap<String, Object> map) throws Exception {
			Gson gson = new Gson();
			String page = "/login/login";
			
			if(session.getAttribute("loginId") != null) page = "/cor/refundHistory";
			
			map.put("pageNum", "1");
		    map.put("listCount", "10");
			model.addAttribute("result", gson.toJson(rhi.getReturnList(map)));
			System.out.println(rhi.getReturnList(map));
			return page;
		}
		
		// 페이징시 리스트 가져오기
		@ResponseBody
		@RequestMapping("/searchReturnList")
		public  HashMap<String, Object> searchReturnListCtl (@RequestParam HashMap<String, Object> map, HttpSession session) throws Exception {	
			HashMap<String, Object> resultMap = new HashMap<String, Object>();

			resultMap.put("result", rhi.getReturnList(map));

			return map;
		}
		
		// 상세 반품현황 가져오기
		@ResponseBody
		@RequestMapping("/getReturnDetail")
		public  HashMap<String, Object> getReturnDetailCtl (@RequestParam HashMap<String, Object> map, HttpSession session) throws Exception {	
			HashMap<String, Object> resultMap = new HashMap<String, Object>();

			resultMap.put("result", rhi.getReturnList(map));
			
			return map;
		}
}
