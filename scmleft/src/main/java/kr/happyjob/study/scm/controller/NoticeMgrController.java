package kr.happyjob.study.scm.controller;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.google.gson.Gson;

import kr.happyjob.study.scm.service.NoticeMgrInter;

@Controller
@RequestMapping("/scm/")
public class NoticeMgrController {
	
	@Autowired
	NoticeMgrInter ni;

	@RequestMapping("noticeMgr.do")
	public String noticeMgr(Model model, @RequestParam Map<String, Object> map, HttpSession session) throws Exception {
		Gson gson = new Gson();
		String page = "/login/login";
		
	    if(session.getAttribute("loginId") != null) page = "scm/noticeMgr";
	    map.put("startPage", 0);
	    map.put("endPage", 10);

		model.addAttribute("noticeList", gson.toJson(ni.getNoticeList(map)));
		
		return page;
	}

}
