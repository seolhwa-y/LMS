package kr.happyjob.study.scm.service;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.happyjob.study.scm.model.UserInfoModel;

public interface UserInfoService {

	//빌립담당
	
	public List<UserInfoModel> listUser(Map<String, Object> paramMap) throws Exception;
	public int countListUser(Map<String, Object> paramMap) throws Exception;
	public UserInfoModel detailUser(Map<String, Object> paramMap) throws Exception;
	
	public int updateUser(Map<String, Object> paramMap) throws Exception;
	public int deleteUser(Map<String, Object> paramMap) throws Exception;
	public int insertUser(Map<String, Object> paramMap) throws Exception;
	public int comebackUser(Map<String, Object> paramMap) throws Exception;
	public int approvalUser(Map<String, Object> paramMap) throws Exception;
	
	public List<UserInfoModel> listChaCD(Map<String, Object> paramMap) throws Exception;
	public List<UserInfoModel> listBankName(Map<String, Object> paramMap) throws Exception;
	public List<UserInfoModel> listDeliID(Map<String, Object> paramMap) throws Exception;
	public List<UserInfoModel> listDeliWarehouse(Map<String, Object> paramMap) throws Exception;
	
	public int check_loginID(UserInfoModel model) throws Exception;
	public int deliTransfer(Map<String, Object> paramMap) throws Exception;
	
}
