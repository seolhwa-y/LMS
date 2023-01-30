package kr.happyjob.study.scm.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.happyjob.study.scm.model.SupplierInfoModel;
import kr.happyjob.study.scm.service.SupplierInfoService;

@Controller
@RequestMapping("/scm/")
public class SupplierInfoController {
	@Autowired // 묶어준다
	SupplierInfoService supplierInfoService;

	private static final Logger logger = LoggerFactory.getLogger(SupplierInfoController.class);
	private final String className = this.getClass().toString();

	// 초기화면
	@RequestMapping("supplierInfo.do")
	public String supplierInfo(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {

		String loginID = (String) session.getAttribute("loginId");
		paramMap.put("loginId", loginID);

		return "scm/supplierInfo";

	}

	// 납품업체 목록 조회
	@RequestMapping("SupplierListVue.do")
	@ResponseBody
	public Map<String, Object> supplierList(Model model, @RequestParam Map<String, Object> paramMap,
			HttpServletRequest request, HttpServletResponse response, HttpSession Session) throws Exception {

		logger.info("+ Start " + className + ".SupplierListVue");

		int currentPage = Integer.parseInt(String.valueOf(paramMap.get("currentPage")));
		int pageSize = Integer.parseInt(String.valueOf(paramMap.get("pageSize")));
		int pageIndex = (currentPage - 1) * pageSize;

		paramMap.put("pageSize", pageSize);
		paramMap.put("pageIndex", pageIndex);

		logger.info("   - paramMap ssss  : " + paramMap);

		List<SupplierInfoModel> SupplierList = supplierInfoService.SupplierList(paramMap);

		int SupplierCnt = supplierInfoService.SupplierCnt(paramMap);

		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("SupplierList", SupplierList);
		resultMap.put("SupplierCnt", SupplierCnt);
		resultMap.put("pageSize", pageSize);
		resultMap.put("currentPage", currentPage);

		logger.info("+ End " + className + ".SupplierListVue");
		logger.info("resultMap : " + resultMap);
		return resultMap;
	}

	@RequestMapping("DetailSupplier.do")
	@ResponseBody
	public Map<String, Object> DetailSupplier(Model model, @RequestParam Map<String, Object> paramMap,
			HttpServletRequest request, HttpServletResponse response, HttpSession Session) throws Exception {

		logger.info("+ Start " + className + ".DetailSupplier");
		logger.info("   - paramMap : " + paramMap);
		
		String result = "";
		
		SupplierInfoModel DetailSupplier = supplierInfoService.DetailSupplier(paramMap);
		
		if(DetailSupplier != null){
			result = "SUCCESS";
		}else {
			result ="불러오기 실패";
		}
		
		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("resultMsg", result);
		resultMap.put("result", DetailSupplier);
		
		logger.info("+ End "+ className + ".DetailSupplier");

		return resultMap;
	}

	// 납품 업체 저장 및 수정
	@RequestMapping("SupplierSave.do")
	@ResponseBody
	public Map<String, Object> SupplierSave(Model model, @RequestParam Map<String, Object> paramMap,
			HttpServletRequest request, HttpServletResponse response, HttpSession Session) throws Exception {

		logger.info("+ Start " + className + ".SupplierSave");
		logger.info("  - paramMap " + paramMap);

		String action = (String) paramMap.get("action");
		String resultMsg = "";

		// 사용자 정보 설정
		paramMap.put("loginId", Session.getAttribute("loginId"));

		logger.info("loginId : " + paramMap.get("loginId"));

		if ("I".equals(action)) {
			supplierInfoService.InsertSupplier(paramMap);

			resultMsg = "SUCCESS";
		} else if ("U".equals(action)) {
			supplierInfoService.UpdateSupplier(paramMap);

			resultMsg = "UPDATE";
		} else {
			resultMsg = "등록에 실패";
		}

		// 결과값 전송
		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("resultMsg", resultMsg);

		return resultMap;
	}

	// 제품 정보 목록
	@RequestMapping("ProductListVue.do")
	@ResponseBody
	public Map<String, Object> ProductList(Model model, @RequestParam Map<String, Object> paramMap,
			HttpServletRequest request, HttpServletResponse response, HttpSession Session) throws Exception {

		logger.info("+ Start " + className + ".ProductListVue");

		int currentPage = Integer.parseInt(String.valueOf(paramMap.get("currentPage")));
		int pageSize = Integer.parseInt(String.valueOf(paramMap.get("pageSize")));
		int pageIndex = (currentPage - 1) * pageSize;

		paramMap.put("pageSize", pageSize);
		paramMap.put("pageIndex", pageIndex);

		logger.info("   - paramMap ssss  : " + paramMap);

		List<SupplierInfoModel> ProductList = supplierInfoService.ProductList(paramMap);

		int ProductCnt = supplierInfoService.ProductCnt(paramMap);

		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("ProductList", ProductList);
		resultMap.put("ProductCnt", ProductCnt);
		resultMap.put("pageSize", pageSize);
		resultMap.put("currentPage", currentPage);

		logger.info("+ End " + className + ".SupplierListVue");
		logger.info("resultMap : " + resultMap);
		return resultMap;
	}

}
