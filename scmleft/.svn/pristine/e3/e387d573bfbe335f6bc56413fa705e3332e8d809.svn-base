package kr.happyjob.study.scm.service;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import kr.happyjob.study.scm.model.ProductInfoModel;

public interface ProductInfoService {

	// 제품정보관리 리스트 가져오기		
	public List<ProductInfoModel> productInfoList(Map<String, Object> paramMap) throws Exception;

	//제품정보관리 목록 수 조회 
	public int productInfoListCnt(Map<String, Object> paramMap) throws Exception;

	//제품정보관리 단건 조회
	public ProductInfoModel productOne(Map<String, Object> paramMap)throws Exception;
	
	//제품정보관리 수정
	public int updateProduct(Map<String, Object> paramMap, HttpServletRequest request) throws Exception;
		
	//제품정보관리 삭제
	public int deleteProduct(Map<String, Object> paramMap) throws Exception;

	//제품정보관리  저장
	public int insertProduct(Map<String, Object> paramMap ,HttpServletRequest request) throws Exception;	
		
}
