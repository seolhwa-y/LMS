package kr.happyjob.study.pur.controller;

import java.util.HashMap;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.google.gson.Gson;

import kr.happyjob.study.pur.service.ReturnPurchaseInter;

@Controller
@RequestMapping("/pur/")
public class ReturnPurchaseController {
	@Autowired
	ReturnPurchaseInter prdi;
	
	@RequestMapping("returnPurchase")
	public String moveReturnPurchasePage (@RequestParam HashMap<String, Object> map, Model model, HttpSession session) throws Exception {
		Gson gson = new Gson();
		String page = "/login/login";
		
		if(session.getAttribute("loginId") != null) page = "/pur/returnPurchaseDirection";
		
		map.put("pageNum", "1");
		map.put("listCount", "10");
		model.addAttribute("result", gson.toJson(prdi.getPurReturnDirectionList(map)));

		return page;
	}
	
	@ResponseBody
	@RequestMapping("/searchReturnPurchase")
	public HashMap<String, Object>  getReturnPurchaseList (@RequestParam HashMap<String, Object> map, HttpSession session) throws Exception {
		HashMap<String, Object> resultMap = new HashMap<String, Object> ();

		resultMap.put("result", prdi.getPurReturnDirectionList(map));
		
		return resultMap;
	}
	
	@ResponseBody
	@RequestMapping("/updateReturnPurchase")
	public HashMap<String, Object>  updateReturnPurchase (@RequestParam HashMap<String, Object> map, HttpSession session) throws Exception {
		HashMap<String, Object> resultMap = new HashMap<String, Object> ();

		resultMap.put("result", prdi.updatePurReturnDirection(map));
		
		return resultMap;
	}
}
