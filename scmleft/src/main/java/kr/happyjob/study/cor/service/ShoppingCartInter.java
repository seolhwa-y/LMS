package kr.happyjob.study.cor.service;

import org.springframework.ui.Model;
import org.springframework.web.servlet.ModelAndView;

public interface ShoppingCartInter {
	public void backController (ModelAndView mav, int serviceCode);
	public void backController (Model model, int serviceCode);
}
