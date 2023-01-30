package kr.happyjob.study.scm.dao;

import java.util.List;
import java.util.Map;

import kr.happyjob.study.scm.model.SupplierInfoModel;

public interface SupplierInfoDao {
	
	// 납품 업체 목록
	public List<SupplierInfoModel> SupplierList(Map<String, Object> paramMap) throws Exception;
	
	// 납품 업체 목록 수 구하기
	public int SupplierCnt(Map<String, Object> paramMap) throws Exception;
	
	// 납품 업체 단건 조회
	public SupplierInfoModel DetailSupplier(Map<String, Object> paramMap) throws Exception;
	
	// 납품 업체 저장
	public int InsertSupplier(Map<String, Object> paramMap) throws Exception;
	
	// 납품업체(NAP_INFO) 저장
	public int InsertNapinfo(Map<String, Object> paramMap) throws Exception;
	
	// 납품업체 수정
	public int UpdateSupplier(Map<String, Object> paramMap) throws Exception;
	
	// 제품 정보 목록
	public List<SupplierInfoModel> ProductList(Map<String, Object> paramMap) throws Exception;
	
	// 제품 정보 수 구하기
	public int ProductCnt(Map<String, Object> paramMap) throws Exception;
	
}
