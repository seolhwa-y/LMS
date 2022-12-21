package kr.happyjob.study.cmp.service;

import org.springframework.ui.Model;
import org.springframework.web.servlet.ModelAndView;

public interface SalesRankingInter {
	public void backController (ModelAndView mav, int serviceCode);
	public void backController (Model model, int serviceCode);
}
