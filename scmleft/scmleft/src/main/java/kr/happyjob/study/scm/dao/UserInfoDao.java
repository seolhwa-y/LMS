package kr.happyjob.study.scm.dao;

import java.util.List;
import java.util.Map;

import kr.happyjob.study.scm.model.UserInfoModel;

public interface UserInfoDao {
	//빌립담당
	
	// 유저 정보 긁어오기
	public List<UserInfoModel> listUser(Map<String, Object> paramMap) throws Exception;
	
	// 유저 총 숫자 가져오기
	public int userTotalCnt(Map<String, Object> paramMap)throws Exception;
	
	// 상세정보 가져오기
	public UserInfoModel detailUser(Map<String, Object> paramMap) throws Exception;
	
	// 정보 업데이트
	public int updateUser(Map<String, Object> paramMap) throws Exception;
	
	// 정보 삭제
	public int deleteUser(Map<String, Object> paramMap) throws Exception;
	
	// 정보 복구
	public int comebackUser(Map<String, Object> paramMap) throws Exception;
	
	// 정보 삽입
	public int insertUser(Map<String, Object> paramMap) throws Exception;
	
	// 담당업무 select 리스트
	public List<UserInfoModel> listChaCD(Map<String, Object> paramMap) throws Exception;
	
	// 은행 select 리스트
	public List<UserInfoModel> listBankName(Map<String, Object> paramMap) throws Exception;
	
	// 배송담당자 ID 리스트
	public List<UserInfoModel> listDeliID(Map<String, Object> paramMap) throws Exception;
	
	// 배송담당자의 담당창고 리스트
	public List<UserInfoModel> listDeliWarehouse(Map<String, Object> paramMap) throws Exception;
	
	// 회원 등록시 id 체크
	public int check_loginID(UserInfoModel model) throws Exception;
	
	// 배송담당자 창고 이관
	public int deliTransfer(Map<String, Object> paramMap) throws Exception;
	
	// 회원 승인
	public int approvalUser(Map<String, Object> paramMap) throws Exception;
}
