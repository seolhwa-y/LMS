package kr.happyjob.study.cor.service;

import java.util.HashMap;

import javax.servlet.http.HttpSession;

import org.springframework.ui.Model;
import org.springframework.web.servlet.ModelAndView;

import kr.happyjob.study.cor.model.OrderStatusModel;

public interface OrderStatusInter {
	public void backController (HttpSession session, ModelAndView mav, int serviceCode);
	public void backController (HttpSession session, HashMap<String, Object> map, int serviceCode);
}
