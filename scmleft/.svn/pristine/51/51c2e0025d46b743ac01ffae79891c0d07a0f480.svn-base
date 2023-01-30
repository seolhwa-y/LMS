package kr.happyjob.study.scm.controller;

import java.io.File;
import java.net.URLEncoder;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.io.FileUtils;
import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;


import kr.happyjob.study.scm.model.ProductInfoModel;
import kr.happyjob.study.scm.service.ProductInfoService;

@Controller
@RequestMapping("/scm/")
public class ProductInfoController {
	
	@Autowired 
	ProductInfoService productInfoService;	
	
	// Set logger
	private final Logger logger = LogManager.getLogger(this.getClass());
		
	// Get class name for logger
	private final String className = this.getClass().toString();
	
	// 1. 제품정보 관리 초기페이지	
	@RequestMapping("productInfo")
	private String productInfo(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start " + className + ".productInfo");
		logger.info("   - paramMap : " + paramMap);
		logger.info("+ End " + className + ".productInfo");
		
		return "scm/productInfo";
	}
	
	// 제품정보관리 리스트 조회 
		@RequestMapping("productInfoList.do")
		@ResponseBody
		public HashMap<String, Object> productInfoList(Model model, @RequestParam Map<String, Object> paramMap,
				HttpServletRequest request, HttpServletResponse response, HttpSession session) throws Exception {

			HashMap<String, Object> returnMap = new HashMap<String, Object>();
			  logger.info("+ Start " + className + ".productInfoList");
			  logger.info("   - paramMap : " + paramMap);
				
			  
			  int currentPage = Integer.parseInt((String)paramMap.get("currentPage")); 
			  int pageSize = Integer.parseInt((String)paramMap.get("pageSize"));
			  int pageIndex = (currentPage - 1)*pageSize; //페이지 시작  row번호
				  
			  paramMap.put("pageIndex", pageIndex);
			  paramMap.put("pageSize", pageSize);
			  
			  List<ProductInfoModel> productInfoList = productInfoService.productInfoList(paramMap);
			  returnMap.put("productInfoList", productInfoList);	
					  
			  // 목록 수 추출해서 보내기 int 
			  int totalCnt =  productInfoService.productInfoListCnt(paramMap);
			  
			  returnMap.put("totalCnt", totalCnt);
			  returnMap.put("pageSize", pageSize);
			  returnMap.put("currentPage",pageIndex);
					   
			  logger.info("+ End " + className + ".productInfoList");
				 
			return returnMap;
		
			}
			
		  //제품정보관리 상세 단건 조회  
		   @RequestMapping("productOne.do")
		   @ResponseBody
		   public HashMap<String, Object> productOne(Model model, @RequestParam Map<String, Object> paramMap, 
				   HttpServletRequest request, HttpServletResponse response, HttpSession session) throws Exception {
		     
			  logger.info("+ Start " + className + ".productOne");
		      logger.info("   - paramMap : " + paramMap);
		      		      
		      ProductInfoModel productOne = productInfoService.productOne(paramMap);
		      
		      HashMap<String, Object> returnMap = new HashMap<String, Object>();
		      
		      returnMap.put("result", productOne);
		      
		      logger.info("   - result : " + productOne);
		      logger.info("   - returnmap : " + returnMap);
		      
		      logger.info("+ End " + className + ".productOne");
		      
		      return returnMap;
		   }
		   
		// 제품정보관리 수정(update),신규등록 (insert)
			@RequestMapping("productSave.do")
			@ResponseBody
			public Map<String, Object> productSave(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request, HttpServletResponse response, HttpSession session) throws Exception {
				
				logger.info("+ Start " + className + ".productSave");
				logger.info("   - paramMap : " + paramMap);
				
				String action = (String)paramMap.get("action");
				String resultMsg = "";
				
				// 사용자 정보 설정
				//paramMap.put("loginId", session.getAttribute("loginId"));
				
				logger.info("loginId : " + paramMap.get("loginId"));
				
				if ("I".equals(action)) {
					// 신규 저장
					productInfoService.insertProduct(paramMap,request);// request=파일정보 
					resultMsg = "SUCCESS";
				} else if("U".equals(action)) {
					// 수정 저장
					productInfoService.updateProduct(paramMap,request);
					resultMsg = "UPDATED";
					System.out.println(paramMap);
				} else {
					resultMsg = "FALSE : 등록에 실패하였습니다.";
				}
								
				//결과 값 전송
				Map<String, Object> resultMap = new HashMap<String, Object>();
				resultMap.put("resultMsg", resultMsg);
			    
			    return resultMap;
			}
			
			
			//파일 다운로드 
			@RequestMapping("fileDown.do")
			public void downloadBbsAtmtFil(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
					HttpServletResponse response, HttpSession session) throws Exception {
			
				logger.info("+ Start " + className + ".downloadBbsAtmtFil");
				logger.info("   - paramMap : " + paramMap);
				
				// 첨부파일 조회(단건 상세 조회하기)
				ProductInfoModel productOne = productInfoService.productOne(paramMap);
				
				// productOne.getPdMadd() 단건조회  저장 
				byte fileByte[] = FileUtils.readFileToByteArray(new File( productOne.getPdMadd() ));
				
				response.setContentType("application/octet-stream");
			    response.setContentLength(fileByte.length);
			    response.setHeader("Content-Disposition", "attachment; fileName=\"" + URLEncoder.encode( productOne.getPdfileName() ,"UTF-8")+"\";");
			    response.setHeader("Content-Transfer-Encoding", "binary");
			    response.getOutputStream().write(fileByte);
			     
			    response.getOutputStream().flush();
			    response.getOutputStream().close();

				logger.info("+ End " + className + ".fileDown");
			}
			
		   
/*		   //제품정보관리 수정(업데이트만!)
			@RequestMapping("updateProduct.do")
			@ResponseBody
			public Map<String, Object> updateProduct(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request, HttpServletResponse response, HttpSession session) throws Exception {
				
				logger.info("+ Start " + className + ".updateProduct");
				logger.info("   - paramMap : " + paramMap);
				
				//String action = (String)paramMap.get("action");
				
				String result = "SUCCESS";
				String resultMsg = "삭제 되었습니다.";
				
				// 사용자 정보 설정
				paramMap.put("loginId", session.getAttribute("loginId"));
				
				logger.info("loginId : " + paramMap.get("loginId"));
								
				productInfoService.updateProduct(paramMap);				
				
				//결과 값 전송
				Map<String, Object> resultMap = new HashMap<String, Object>();
				resultMap.put("result", result);
				resultMap.put("resultMsg", resultMsg);
				
				logger.info("+ End " + className + ".updateProduct");
			    
			    return resultMap;
			}*/
			
			/*// 공지사항 삭제
			@RequestMapping("deleteProduct.do")
			@ResponseBody
			public Map<String, Object> deleteProduct(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
					HttpServletResponse response, HttpSession session) throws Exception {
				
				logger.info("+ Start " + className + ".deleteProduct");
				logger.info("   - paramMap : " + paramMap);

				String result = "SUCCESS";
				String resultMsg = "삭제 되었습니다.";
				
				productInfoService.deleteProduct(paramMap);
				
				Map<String, Object> resultMap = new HashMap<String, Object>();
				resultMap.put("result", result);
				resultMap.put("resultMsg", resultMsg);
				
				logger.info("+ End " + className + ".deleteProduct");
				
				return resultMap;
			}*/
		   
		   
}