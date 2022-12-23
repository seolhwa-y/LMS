package kr.happyjob.study.scm.service;

import java.util.HashMap;

import javax.servlet.http.HttpSession;

import org.springframework.ui.Model;
import org.springframework.web.servlet.ModelAndView;

public interface OrderHistoryInter {
	public void backController (HttpSession session, ModelAndView mav, int serviceCode);
	public void backController (HttpSession session, HashMap<String, Object> map, int serviceCode);
}
