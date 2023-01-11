package kr.happyjob.study.cor.controller;

import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import kr.happyjob.study.cor.service.ProductListInter;

@Controller
@RequestMapping("/cor/")
public class ProductListController {
	
	@Autowired
	ProductListInter pli;

	// 페이지 로딩시 리스트 가져오기
	@RequestMapping("productList.do")
	public String saleStatus(HttpSession session, Model model, @RequestParam Map<String, Object> map) throws Exception {
		String page = "/login/login";
		
		if(session.getAttribute("loginId") != null) page = "/cor/productList";
		
		map.put("productList", pli.getProductList(map));
		map.put("modelList", pli.getModelList(map));
		map.put("manufacturerList", pli.getManufacturerList(map));
		
		model.addAttribute(map);
		
		return page;
	}
	
	// 기업명 클릭시 상세정보 리스트 출력
	@RequestMapping("productListJstl.do")
	public String dtlList(@RequestParam Map<String, Object> paramMap, HttpSession session) throws Exception {


		return "/cor/productListJstl";
	}
	

}
