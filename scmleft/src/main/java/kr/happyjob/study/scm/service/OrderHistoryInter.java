package kr.happyjob.study.scm.service;

import java.util.HashMap;

import javax.servlet.http.HttpSession;

import org.springframework.ui.Model;

public interface OrderHistoryInter {
	public void backController (HttpSession session, Model model, int serviceCode);
	public void backController (HttpSession session, HashMap<String, Object> map, int serviceCode);
}
