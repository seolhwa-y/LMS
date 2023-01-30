package kr.happyjob.study.scm.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.happyjob.study.scm.dao.SupplierInfoDao;
import kr.happyjob.study.scm.model.SupplierInfoModel;

@Service
public class SupplierInfoServiceImpl implements SupplierInfoService {
	
	@Autowired
	SupplierInfoDao supplierInfoDao;
	
	// 납품 업체 목록
	@Override
	public List<SupplierInfoModel> SupplierList(Map<String, Object> paramMap) throws Exception {
		
		List<SupplierInfoModel> SupplierList = supplierInfoDao.SupplierList(paramMap);
		return SupplierList;
	}
	
	// 납품 업체 갯수
	@Override
	public int SupplierCnt(Map<String, Object> paramMap) throws Exception {
		int SupplierCnt = supplierInfoDao.SupplierCnt(paramMap);
		return SupplierCnt;
	}
	
	// 납품 업체 단건 조회
	@Override
	public SupplierInfoModel DetailSupplier(Map<String, Object> paramMap) throws Exception {
		SupplierInfoModel DetailSupplier = supplierInfoDao.DetailSupplier(paramMap);
		return DetailSupplier;
	}
	
	// 납품 업체 저장
	@Override
	public int InsertSupplier(Map<String, Object> paramMap) throws Exception {
		int InsertSupplier = supplierInfoDao.InsertSupplier(paramMap);
		int InsertNapinfo = supplierInfoDao.InsertNapinfo(paramMap);
		return InsertNapinfo;
	}
	
	// 납품 업체 수정
	@Override
	public int UpdateSupplier(Map<String, Object> paramMap) throws Exception {
		int UpdateSupplier = supplierInfoDao.UpdateSupplier(paramMap);
		return UpdateSupplier;
	}
	
	
	// 제품 목록 조회
	@Override
	public List<SupplierInfoModel> ProductList(Map<String, Object> paramMap) throws Exception {
		List<SupplierInfoModel> ProductList = supplierInfoDao.ProductList(paramMap);
		return ProductList;
	}
	
	// 제품 목록 갯수
	@Override
	public int ProductCnt(Map<String, Object> paramMap) throws Exception {
		int ProductCnt = supplierInfoDao.ProductCnt(paramMap);
		return ProductCnt;
	}

	

	

	

	
	

	
	
}