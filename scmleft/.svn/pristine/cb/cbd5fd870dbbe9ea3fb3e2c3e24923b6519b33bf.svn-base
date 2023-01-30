package kr.happyjob.study.scm.dao;

import java.util.List;
import java.util.Map;

import kr.happyjob.study.scm.model.ProductInfoModel;

public interface ProductInfoDao {

	//제품정보관리 리스트 조회 
	public List<ProductInfoModel> productInfoList(Map<String, Object> paramMap) throws Exception;

	//제품정보관리 목록 수 조회 
	public int productInfoListCnt(Map<String, Object> paramMap) throws Exception;

	//제품정보관리 단건 조회
	public ProductInfoModel productOne(Map<String, Object> paramMap) throws Exception;
	
	// 제품정보관리 수정
	public int updateProduct(Map<String, Object> paramMap) throws Exception;
	
	// 제품정보관리 삭제
	public int deleteProduct(Map<String, Object> paramMap) throws Exception;
	
	//제품정보관리  저장
	public int insertProduct(Map<String, Object> paramMap) throws Exception;

	//파일업로드 신규저장
	public int insertFile(Map<String, Object> fileinfo)throws Exception;
	
	// 파일 정보 삭제
	public int clearfile(Map<String, Object> fileinfo)throws Exception;
	
	// 제품정보에서 파일번호 Clear
	public int clearpdinfo(Map<String, Object> fileinfo)throws Exception;
		
}