package kr.happyjob.study.cmp.service;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;
import org.springframework.web.servlet.ModelAndView;

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

	public void backController (ModelAndView mav, int serviceCode) {
		System.err.println("현재 실행되고 있는 클래스 이름 : " + className + " : " + serviceCode);
		
		switch (serviceCode) {
		case 1 : this.showSaleRankCtl(mav); break; // 매출 TOP10 불러오기
		
		default : break;
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
	private void showSaleRankCtl(ModelAndView mav) {

		
	}

}
