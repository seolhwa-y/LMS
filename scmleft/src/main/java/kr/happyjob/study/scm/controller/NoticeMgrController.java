package kr.happyjob.study.scm.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.google.gson.Gson;

import kr.happyjob.study.scm.service.NoticeMgrInter;

@Controller
@RequestMapping("/scm/")
public class NoticeMgrController {
	
	@Autowired
	NoticeMgrInter ni;

	
	// 페이지 로드시 리스트 및 카운트
	@RequestMapping("noticeMgr.do")
	public String moveNoticePage (Model model, @RequestParam HashMap<String, Object> map, HttpSession session) throws Exception {
		Gson gson = new Gson();

		map.put("pageNum", "1");
	    map.put("listCount", "10");
		model.addAttribute("result", gson.toJson(ni.getNoticeList(map)));
		model.addAttribute("loginId", session.getAttribute("loginId"));
		model.addAttribute("name", session.getAttribute("userNm"));

		return "scm/noticeMgr";
	}
	
	// 검색 :: 셀렉트 및 날짜
	@ResponseBody
	@RequestMapping("/searchNoticeList")
	public HashMap<String, Object> searchNoticeCtl (@RequestParam HashMap<String, Object> map, HttpSession session) throws Exception {	
		HashMap<String, Object> resultMap = new HashMap<String, Object>();

		resultMap.put("loginId", session.getAttribute("loginId"));
		resultMap.put("result", ni.getNoticeList(map));
		
		return resultMap;
	}
	
	// 조회 :: 게시글 눌렀을 때 
	@ResponseBody
	@RequestMapping("/checkNoticeList")
	public HashMap<String, Object> checkNoticeCtl (@RequestParam HashMap<String, Object> map, HttpSession session) throws Exception {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();

		resultMap.put("loginId", session.getAttribute("loginId"));
		resultMap.put("result", ni.updateNotice(map));

		return resultMap;
	}
	
	// 등록
	@ResponseBody
	@RequestMapping("/insertNotice")
	public HashMap<String, Object> insertNoticeCtl (@RequestParam HashMap<String, Object> map, HttpSession session) throws Exception {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();

		map.put("loginId", session.getAttribute("loginId"));
		resultMap.put("result", ni.insertNotice(map));

		return resultMap;
	}
	
	// 수정
	@ResponseBody
	@RequestMapping("/updateNotice")
	public HashMap<String, Object> updateNoticeCtl (@RequestParam HashMap<String, Object> map, HttpSession session) throws Exception {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		
		resultMap.put("result", ni.updateNotice(map));

		return resultMap;
	}
	
	// 삭제
	@ResponseBody
	@RequestMapping("/deleteNotice")
	public HashMap<String, Object> deleteNoticeCtl (@RequestParam HashMap<String, Object> map, HttpSession session) throws Exception {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		
		resultMap.put("result", ni.deleteNotice(map));

		return resultMap;
	}
	
	
}
