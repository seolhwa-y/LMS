package kr.happyjob.study.ship.controller;

import java.util.*;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.google.gson.Gson;

import kr.happyjob.study.ship.model.OrderReturnModel;
import kr.happyjob.study.ship.service.OrderReturnInter;

@Controller
@RequestMapping("/ship/")
public class OrderReturnController {
	
	@Autowired
	OrderReturnInter ori;
	
	@RequestMapping("orderReturn")
	public String moveOrderReturnPage(@RequestParam HashMap<String, Object> map, Model model, HttpSession session) throws Exception {
		Gson gson = new Gson();
		String page = "/login/login";
		
		if(session.getAttribute("loginId") != null) page = "/ship/orderReturn";
		
		map.put("pageNum", "1");
		map.put("listCount", "5");
		model.addAttribute("result", gson.toJson(ori.getOrderReturnList(map)));

		return page;
	}
	
	@ResponseBody
	@RequestMapping("/searchOrderReturn")
	public HashMap<String, Object> getOrderReturnListCtl(@RequestParam HashMap<String, Object> map, HttpSession session) throws Exception {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		
		System.err.println(" searchOrderReturn map check :::   " + map);
		resultMap.put("result", ori.getOrderReturnList(map));
		
		return resultMap;
	}
	
	@ResponseBody
	@RequestMapping("/searchOrderReturnDetail")
	public HashMap<String, Object> getOrderReturnDetailListCtl(@RequestParam HashMap<String, Object> map, HttpSession session) throws Exception {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		
		System.err.println(" searchOrderReturnDetail map check :::   " + map);
		resultMap.put("result", ori.getOrderReturnDetailList(map));
		
		return resultMap;
	}
	
	@ResponseBody
	@RequestMapping("/insertOrderReturn")
	public Map<String, Object> insertOrderReturnCtl(@RequestParam(required = false) Map<String, Object> map,  HttpSession session) throws Exception {
		List<OrderReturnModel> ormList = new ArrayList<OrderReturnModel>();
		Gson gson = new Gson();
		
		System.err.println("  map check :::   " + map);
		System.err.println("  map check :::   " + map.get("ormList"));
		System.err.println(" gson map check :::   " + gson.toJson(map));
		System.err.println(" gson map check :::   " + gson.toJson(map.get("ormList")));
		System.err.println(" insertOrderReturn map check :::   " + gson.fromJson(gson.toJson(map), Map.class));

		map = gson.fromJson(gson.toJson(map), Map.class);

		System.err.println(" insertOrderReturn gson map ormList check :::   " + map.get("ormList"));

		//resultMap.put("result", ori.insertBorderReturn(map));
		
		return map;
	}
	
	@ResponseBody
	@RequestMapping("/updateOrderReturn")
	public HashMap<String, Object> updateOrderReturnCtl(@RequestBody HashMap<String, Object> map, HttpSession session) throws Exception {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		
		System.err.println(" updateOrderReturn map check :::   " + map);
		//resultMap.put("result", ori.updateBorderStock(map));
		
		return resultMap;
	}
}
