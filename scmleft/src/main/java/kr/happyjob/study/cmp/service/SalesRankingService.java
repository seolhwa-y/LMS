package kr.happyjob.study.cmp.service;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;
import org.springframework.web.servlet.ModelAndView;

import com.google.gson.Gson;

import kr.happyjob.study.cmp.model.SalesRankingModel;

@Service
public class SalesRankingService implements SalesRankingInter {

	private final Logger logger = LogManager.getLogger(this.getClass());
	private final String className = this.getClass().toString();
	
	@Autowired
	private SqlSessionTemplate sql;
	@Autowired(required = true)
	SalesRankingModel srm;
	
	public SalesRankingService() {}

	public void backController (HttpSession session, ModelAndView mav, int serviceCode) {
		System.err.println("현재 실행되고 있는 클래스 이름 : " + className + " : " + serviceCode);
		
		if(session.getAttribute("loginId") != null) {
			switch (serviceCode) {
			case 1 : this.showSaleRankCtl(mav); break; // 매출 TOP10 불러오기
			
			default : break;
			}
		} else {
			mav.setViewName("/login/login");
		}

	}
	
	public void backController (Model model, int serviceCode) {
		System.err.println("현재 실행되고 있는 클래스 이름 : " + className + " : " + serviceCode);
		
		switch (serviceCode) {
		//case 1 : (model); break; // 기간 재선택

		default : break;
		}
	}

	
	// 매출 순위 Select
	@SuppressWarnings("unchecked")
	private void showSaleRankCtl(ModelAndView mav) {
		/* 담당자 : 염설화
		 * 개발기간 : 2022-12-22 ~ 2022-12-22
		 * 비고 : DB에서 내역을 가져와서 List에 담아 JSON으로 바꿔 화면단에 넘겨준다. */
		Gson gson = new Gson();
		
		List<SalesRankingModel> srList = (List<SalesRankingModel>) this.sql.selectList("getSalesRankingList", srm);
		mav.addObject("salesRankList", gson.toJson(srList));
		mav.setViewName("cmp/salesRanking");
		
		System.err.println(mav.getModel().get("salesRankList"));
	}

}
