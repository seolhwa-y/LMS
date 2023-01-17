package kr.happyjob.study.ship.controller;

import java.util.HashMap;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.happyjob.study.ship.service.OrderReturnInter;

@Controller
@RequestMapping("/ship/")
public class OrderReturnController {
	
	@Autowired
	OrderReturnInter ori;
	
	@RequestMapping("borderReturn")
	public String moveOrderReturnPage(@RequestParam HashMap<String, Object> map, Model model, HttpSession session) {
		return null;
	}
	
	@ResponseBody
	@RequestMapping("searchBorderReturn")
	public HashMap<String, Object> getOrderReturnListCtl(@RequestParam HashMap<String, Object> map, Model model, HttpSession session) {
		return map;
	}
	
	@ResponseBody
	@RequestMapping("searchBorderReturnDetail")
	public HashMap<String, Object> getOrderReturnDetailListCtl(@RequestParam HashMap<String, Object> map, Model model, HttpSession session) {
		return map;
	}
	
	@ResponseBody
	@RequestMapping("insertBorderReturn")
	public HashMap<String, Object> insertOrderReturnCtl(@RequestParam HashMap<String, Object> map, Model model, HttpSession session) {
		// 멀티
		return map;
	}
	
	@ResponseBody
	@RequestMapping("updateBorderReturn")
	public HashMap<String, Object> updateOrderReturnCtl(@RequestParam HashMap<String, Object> map, Model model, HttpSession session) {
		// 멀티
		return map;
	}
}
