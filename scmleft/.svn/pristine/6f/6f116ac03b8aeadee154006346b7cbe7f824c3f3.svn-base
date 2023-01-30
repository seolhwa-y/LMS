package kr.happyjob.study.scm.service;

import java.io.PrintWriter;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.happyjob.study.scm.dao.UserInfoDao;
import kr.happyjob.study.scm.model.UserInfoModel;

@Service
public class UserInfoServiceImpl implements UserInfoService {
	//빌립담당
	
	@Autowired
	UserInfoDao userInfoDao;

	// 회원 목록 조회
	@Override
	public List<UserInfoModel> listUser(Map<String, Object> paramMap) throws Exception {
		
		List<UserInfoModel> listUser = userInfoDao.listUser(paramMap);
		
		return listUser;
	}
	
	
	// 회원 수 조회
	@Override
	public int countListUser(Map<String, Object> paramMap) throws Exception {
		
		int totalCnt = userInfoDao.userTotalCnt(paramMap);
		
		return totalCnt;
	}
	
	//상세 정보 조회
	@Override
	public UserInfoModel detailUser(Map<String, Object> paramMap) throws Exception {
		UserInfoModel detailUser = userInfoDao.detailUser(paramMap);
		
		return detailUser;
	}

	//회원 정보 업데이트
	@Override
	public int updateUser(Map<String, Object> paramMap) throws Exception {
		
		int resultCnt = userInfoDao.updateUser(paramMap);
		
		return resultCnt;
	}
	
	//회원 정보 삭제
	@Override
	public int deleteUser(Map<String, Object> paramMap) throws Exception {
		
		int resultCnt = userInfoDao.deleteUser(paramMap);
		
		return resultCnt;
	}
	
	
	@Override
	public int comebackUser(Map<String, Object> paramMap) throws Exception {
		int resultCnt = userInfoDao.comebackUser(paramMap);
		
		return resultCnt;
	}
	
	// 회원 정보 삽입
	@Override
	public int insertUser(Map<String, Object> paramMap) throws Exception {

		int resultCnt = userInfoDao.insertUser(paramMap);
		
		return resultCnt;
	}
	
	// 담당업무 select하기
	@Override
	public List<UserInfoModel> listChaCD(Map<String, Object> paramMap) throws Exception {
		List<UserInfoModel> listChaCD = userInfoDao.listChaCD(paramMap);
		return listChaCD;
	}
	
	@Override
	public List<UserInfoModel> listBankName(Map<String, Object> paramMap) throws Exception {
		List<UserInfoModel> listBankName = userInfoDao.listBankName(paramMap);
		return listBankName;
	}
	
	// 배송담당자 ID 
	@Override
	public List<UserInfoModel> listDeliID(Map<String, Object> paramMap) throws Exception {
		List<UserInfoModel> listDeliID = userInfoDao.listDeliID(paramMap);
		return listDeliID;
	}
	
	// 배송담당자 창고조회
	@Override
	public List<UserInfoModel> listDeliWarehouse(Map<String, Object> paramMap) throws Exception {
		List<UserInfoModel> listDeliWarehouse = userInfoDao.listDeliWarehouse(paramMap);
		return listDeliWarehouse;
	}
	
	// loginID 체크
	@Override
	public int check_loginID(UserInfoModel model) throws Exception {
		int result = userInfoDao.check_loginID(model);
		return result;
	}
	
	// 배송담당자 창고 이관
	@Override
	public int deliTransfer(Map<String, Object> paramMap) throws Exception {
		
		int result = userInfoDao.deliTransfer(paramMap);
		return result;
	}
	
	// 회원 승인
	@Override
	public int approvalUser(Map<String, Object> paramMap) throws Exception {
		int result = userInfoDao.approvalUser(paramMap);
		return result;
	}
		
}
