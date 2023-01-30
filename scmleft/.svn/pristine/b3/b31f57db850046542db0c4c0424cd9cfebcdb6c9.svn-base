package kr.happyjob.study.ship.controller;

import java.util.*;

import javax.servlet.http.HttpSession;

import org.json.simple.parser.JSONParser;
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
	
	// 페이지 이동 및 리스트 가져오기
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
	
	// 검색 리스트 가져오기
	@ResponseBody
	@RequestMapping("/searchOrderReturn")
	public HashMap<String, Object> getOrderReturnListCtl(@RequestParam HashMap<String, Object> map, HttpSession session) throws Exception {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		
		System.err.println(" searchOrderReturn map check :::   " + map);
		resultMap.put("result", ori.getOrderReturnList(map));
		
		return resultMap;
	}
	
	// 상세내역 가져오기
	@ResponseBody
	@RequestMapping("/searchOrderReturnDetail")
	public HashMap<String, Object> getOrderReturnDetailListCtl(@RequestParam HashMap<String, Object> map, HttpSession session) throws Exception {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		
		System.err.println(" searchOrderReturnDetail map check :::   " + map);
		resultMap.put("result", ori.getOrderReturnDetailList(map));
		
		return resultMap;
	}
	
	// 반품신청
	@ResponseBody
	@SuppressWarnings("unchecked")
	@RequestMapping("/insertOrderReturn")
	public Map<String, Object> insertOrderReturnCtl(@RequestParam(required = false) Map<String, Object> map,  HttpSession session) throws Exception {
		HashMap<String, Object> newMap = new HashMap<String, Object>();
		JSONParser parse =new JSONParser();
		Object object = parse.parse(map.get("ormList").toString());
		
		map.put("list", object);
		map = (Map<String, Object>) map.get("list");
		
		Iterator<String> iterKey = map.keySet().iterator();
		
		System.err.println("  insertOrderReturn     JSONParser     Object    ::::::   " + object);
		System.err.println("     insertOrderReturn     listMap :: " + map.get("list"));
		System.err.println("   insertOrderReturn      listMap size :: " + map.size());

		while (iterKey.hasNext()) {
			String key = iterKey.next();
			
			newMap.put(key.toLowerCase(), map.get(key));
		}
		
		System.err.println("    insertOrderReturn     newMap check ::" + newMap);
		
		for(int i = 0; i < newMap.size(); i++) {
			System.err.println("     insertOrderReturn    newMap  ::   size Data :::: " + newMap.get(Integer.toString(i)));
			ori.insertBorderReturn((HashMap<String, Object>) newMap.get(Integer.toString(i)));
		}
		
		return newMap;
	}
	
	// 재고처리
	@ResponseBody
	@SuppressWarnings("unchecked")
	@RequestMapping("/updateOrderReturn")
	public Map<String, Object> updateOrderReturnCtl(@RequestParam(required = false) Map<String, Object> map, HttpSession session) throws Exception {
		HashMap<String, Object> newMap = new HashMap<String, Object>();
		JSONParser parse =new JSONParser();
		Object object = parse.parse(map.get("ormList").toString());
		
		map.put("list", object);
		map = (Map<String, Object>) map.get("list");
		
		Iterator<String> iterKey = map.keySet().iterator();
		
		System.err.println("  updateBorderStock     JSONParser     Object    ::::::   " + object);
		System.err.println(" updateBorderStock   listMap :: " + map.get("list"));
		System.err.println(" updateBorderStock   listMap size :: " + map.size());

		while (iterKey.hasNext()) {
			String key = iterKey.next();
			
			newMap.put(key.toLowerCase(), map.get(key));
		}
		
		System.err.println(" updateBorderStock newMap check ::" + newMap);
		
		for(int i = 0; i < newMap.size(); i++) {
			System.err.println(" updateBorderStock    newMap  ::   size Data :::: " + newMap.get(Integer.toString(i)));
			ori.updateBorderStock((HashMap<String, Object>) newMap.get(Integer.toString(i)));
		}
		
		return newMap;
	}
}
