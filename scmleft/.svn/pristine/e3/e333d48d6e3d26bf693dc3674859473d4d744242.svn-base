package kr.happyjob.study.ship.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.happyjob.study.ship.model.DeliveryBuyerModel;
import kr.happyjob.study.ship.service.DeliveryBuyerService;

@Controller
@RequestMapping("/ship/")
public class DeliveryBuyerController {

	@Autowired
	DeliveryBuyerService deliveryBuyerService;

	// Set logger
	private final Logger logger = LogManager.getLogger(this.getClass());

	// Get class name for logger
	private final String className = this.getClass().toString();

	// 배송 지시서 초기페이지
	@RequestMapping("deliveryBuyer.do")
	public String deliveryBuyer(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {

		logger.info("+ Start " + className + ".deliveryBuyer");
		logger.info("+ End " + className + ".deliveryBuyer");

		return "/ship/deliveryBuyer";
	}

	// 배송 지시서 리스트값 가져오기
	@RequestMapping("deliveryBuyerList.do")
	public String deliveryBuyerList(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {

		logger.info("+ Start " + className + ".deliveryBuyerList");
		logger.info("   - paramMap : " + paramMap);

		int currentPage = Integer.parseInt((String) paramMap.get("currentPage"));
		int pageSize = Integer.parseInt((String) paramMap.get("pageSize"));		
		paramMap.put("loginID", session.getAttribute("loginId"));
		
		int pageIndex = (currentPage - 1) * pageSize; // 페이지 시작 row번호

		paramMap.put("pageIndex", pageIndex);
		paramMap.put("pageSize", pageSize);

		List<DeliveryBuyerModel> deliveryBuyerList = deliveryBuyerService.deliveryBuyerList(paramMap);
		model.addAttribute("deliveryBuyerList", deliveryBuyerList);

		// 목록 수 추출해서 보내기 int
		int totalCnt = deliveryBuyerService.deliveryBuyerListCnt(paramMap);

		model.addAttribute("totalCnt", totalCnt);
		model.addAttribute("pageSize", pageSize);
		model.addAttribute("currentPage", pageIndex);

		logger.info("+ End " + className + ".deliveryBuyerList");

		return "/ship/deliveryBuyerList";

	}

	// 배송지시서 상세 단건 조회
	@RequestMapping("deliveryListOne.do")
	@ResponseBody
	public HashMap<String, Object> deliveryListOne(Model model, @RequestParam Map<String, Object> paramMap,
			HttpServletRequest request, HttpServletResponse response, HttpSession session) throws Exception {

		logger.info("+ Start " + className + ".deliveryListOne");
		logger.info("   - paramMap : " + paramMap);

		DeliveryBuyerModel deliveryListOne = deliveryBuyerService.deliveryListOne(paramMap);

		HashMap<String, Object> returnMap = new HashMap<String, Object>();

		returnMap.put("result", deliveryListOne);

		logger.info("   - result : " + deliveryListOne);
		logger.info("   - returnmap : " + returnMap);

		logger.info("+ End " + className + ".deliveryListOne");

		return returnMap;
	}

	// insert, update 동시진행
	// insert 결과 메시지 때문에 void로 안함 //여러 건 조회 할 수도 있기 때문에 반환타입 int
	@RequestMapping("insertDelHousing.do")
	@ResponseBody
	@Transactional // insert, update는 꼭 트랜잭션 처리 할 것!
	private Map<String, Object> insertDelHousing(Model model, @RequestParam Map<String, Object> paramMap,
			HttpSession session) throws Exception {

		logger.info("+ Start " + className + ".insertDelHousing");
		logger.info("   - param : " + paramMap);

		String resultMsg = "";

		paramMap.put("wh_amt", Integer.parseInt((String) paramMap.get("wh_amt")));
		paramMap.put("wh_type", 1);
		paramMap.put("sh_type", 1);

		if (deliveryBuyerService.insertDelHousing(paramMap) > 0) { // 출고 insert
			if (deliveryBuyerService.updateDelStock(paramMap) > 0) { // 재고 update
				if (deliveryBuyerService.updateDel(paramMap) > 0) { // 배송여부 update
					resultMsg = "츨고처리가 성공 되었습니다.";
				} else
					resultMsg = "츨고처리가 실패 했습니다.";
				resultMsg = "재고처리가 성공 되었습니다.";
			} else
				resultMsg = "재고처리가 실패 했습니다.";
			resultMsg = "배송 및 재고처리가 완료 되었습니다.";
		} else
			resultMsg = "배송 및 재고처리가 실패 했습니다";

		Map<String, Object> resultMap = new HashMap<String, Object>();

		resultMap.put("resultMsg", resultMsg);

		logger.info("+ End " + className + ".insertDelHousing");

		return resultMap;

	}
}
