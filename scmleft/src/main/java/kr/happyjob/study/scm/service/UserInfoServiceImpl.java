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
public class UserInfoServiceImpl {
	@Autowired
	UserInfoDao userDao;

	public List<UserInfoModel> listUser(Map<String, Object> paramMap) {
		List<UserInfoModel> listUser = userDao.listUser(paramMap);
		return listUser;
	}

	public int countListUser(Map<String, Object> paramMap) {
		int userCnt = userDao.countListUser(paramMap);
		return userCnt;
	}

	public UserInfoModel UserDetail(Map<String, Object> paramMap) {
		UserInfoModel User = userDao.UserDetail(paramMap);
		return User;
	}

	public int insertUser(Map<String, Object> paramMap) throws Exception {

		int insertUser = userDao.insertUser(paramMap);
		
		return insertUser;
	}

	public int updateUser(Map<String, Object> paramMap) {
		int updateUser = userDao.updateUser(paramMap);
		
		return updateUser;
	}

	public int idcheck(Map<String, Object> paramMap) {
		int idcheck = userDao.idcheck(paramMap);
		return idcheck;
	}
}
