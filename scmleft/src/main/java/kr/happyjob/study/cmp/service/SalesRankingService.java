package kr.happyjob.study.cmp.service;

import java.util.HashMap;

import javax.servlet.http.HttpSession;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;

import com.google.gson.Gson;

import kr.happyjob.study.cmp.model.SalesRankingModel;

@Service
public class SalesRankingService implements SalesRankingInter {

	@Autowired
	private SqlSessionTemplate sql;
	@Autowired(required = true)
	SalesRankingModel srm;
	
	public SalesRankingService() {}

	public void backController (HttpSession session, Model model, int serviceCode) {
		switch (serviceCode) {
		case 1 : this.showSaleRankCtl(model); break;
			
		default : break;
		}
	}
	
	public void backController (HashMap<String, Object> map, int serviceCode) {
		switch (serviceCode) {
		case 1 : this.searchSalesRanking(map); break;

		default : break;
		}
	}

	

	// 매출 순위 Select
	private void showSaleRankCtl(Model model) {
		Gson gson = new Gson();
		
		model.addAttribute("salesRankList", gson.toJson(this.sql.selectList("getSalesRankingList", null)));
	}
	
	// 기간별 검색 Select
	private void searchSalesRanking(HashMap<String, Object> map) {
		map.put("searchRankList", this.sql.selectList("getSalesRankingList", map));
	}

}
