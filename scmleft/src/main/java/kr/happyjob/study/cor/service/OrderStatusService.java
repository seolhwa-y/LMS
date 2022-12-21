package kr.happyjob.study.cor.service;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.servlet.ModelAndView;

import kr.happyjob.study.cor.model.OrderStatusModel;

@Service
public class OrderStatusService implements OrderStatusInter {
	
	private final Logger logger = LogManager.getLogger(this.getClass());
	private final String className = this.getClass().toString();

	@Autowired
	private SqlSessionTemplate sql;
	@Autowired(required = true)
	OrderStatusModel osm;
	
	public OrderStatusService() {}

	public void backController (ModelAndView mav, int serviceCode) {
		System.err.println("현재 실행되고 있는 클래스 이름 : " + className + " : " + serviceCode);
		
		switch (serviceCode) {
		case 1 : this.showOrderStatusCtl(mav); break; // 주문내역 불러오기

		default : break;
		}
	}

	public void backController (Model model, int serviceCode) {
		System.err.println("현재 실행되고 있는 클래스 이름 : " + className + " : " + serviceCode);
		
		switch (serviceCode) {
		case 1 : this.getDetailOrderCtl(model); break; // 상세 주문내역 불러오기
		case 2 : this.insertReturnInfoCtl(model); break; // 반품신청
		
		default : break;
		}
	}
	
	
	// 주문내역 불러오기
	private void showOrderStatusCtl(ModelAndView mav) {

		
	}

	// 상세주문내역 불러오기
	private void getDetailOrderCtl(Model model) {

		
	}

	// 반품신청
	@Transactional
	private void insertReturnInfoCtl(Model model) {

		
	}
	
	// Insert / Update / Delete
	private Boolean convertToBoolean(int booleanCheck){
		return booleanCheck == 0 ? false : true;
	}
}
