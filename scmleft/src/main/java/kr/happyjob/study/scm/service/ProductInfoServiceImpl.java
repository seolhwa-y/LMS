package kr.happyjob.study.scm.service;

import java.io.File;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import kr.happyjob.study.common.comnUtils.FileUtilCho;
import kr.happyjob.study.scm.dao.ProductInfoDao;
import kr.happyjob.study.scm.model.ProductInfoModel;

@Service
public class ProductInfoServiceImpl implements ProductInfoService {
	
	//private final Logger logger = LogManager.getLogger(this.getClass());
	
	@Autowired
	ProductInfoDao productInfoDao;
	
	//fileUpload.rootPath=X:\\FileRepository
	@Value("${fileUpload.rootPath}")
	private String rootPath;
	
	//fileUpload.virtualRootPath=/serverfile
	@Value("${fileUpload.virtualRootPath}")
	private String virtualRootPath;
	
	//fileUpload.prducimage=product
	@Value("${fileUpload.prducimage}")
	private String prducimage;
	
	
	//제품정보관리 리스트 조회 
	@Override
	public List<ProductInfoModel> productInfoList(Map<String, Object> paramMap) throws Exception {
		return productInfoDao.productInfoList(paramMap);
		
	}

	//제품정보관리 목록 수 조회 
	@Override
	public int productInfoListCnt(Map<String, Object> paramMap) throws Exception {
		
		return productInfoDao.productInfoListCnt(paramMap);
	}
	
	//제품정보관리 단건 조회
	@Override
	public ProductInfoModel productOne(Map<String, Object> paramMap) throws Exception {
		
		return productInfoDao.productOne(paramMap);				
	}

	//제품정보관리 수정
	@Override
	public int updateProduct(Map<String, Object> paramMap, HttpServletRequest request) throws Exception {

		// 1. upload 할   폴더  정보  & Upload
		// 2. Upload 된 파일의 정보를 얻어서 DB 처리(paramMap)
		
		//수정 할 파일 단건 조회하기  
		ProductInfoModel oldinfo = productInfoDao.productOne(paramMap);
				
		String ppath = oldinfo.getPdMadd();    
		if (ppath != null && !"".equals(ppath)) {
			File fold = new File(ppath);
			fold.delete();
			
			//1.파일이름 삭제
			productInfoDao.clearfile(paramMap);
			//2.실제 파일 삭제 
			productInfoDao.clearpdinfo(paramMap);			
		}
	
		
		//3. 다시 업데이트(저장)해주기 
		
		//다중 파일 업로드 
		MultipartHttpServletRequest multireq = (MultipartHttpServletRequest) request; //캐스팅
		
		//fileUpload.rootPath=X:\\FileRepository
		//rootPath 윈도우 => 물리주소 
		
		//fileUpload.virtualRootPath=/serverfile
		//virtualRootPath 논리주소 (톰캣에  설정한 주소 )
		
		//fileUpload.prducimage=product
		//prducimage (이미지가 저장 될 공간의 폴더명)
		
		//map.put("file_nm", file_nm);
        //map.put("file_size", file_Size);
        //map.put("file_loc", file_loc);
        //map.put("fileExtension", fileExtension);
       
		//물리공간 경로 지정 =>\\
		String itemFilePath = File.separator + prducimage + File.separator;
		
		//다중파일 저장(multireq) + 물리공간 경로지정 + 하위 디렉토리 = 리턴 해준다 
		FileUtilCho fileup = new FileUtilCho(multireq, rootPath, itemFilePath); //rootPath File.separator + prducimage + File.separator
		
		//내장메소드  사용해서 파일 업로드 시키기 (uploadFiles()) 리턴 받는다 
		Map<String,Object> fileinfo = fileup.uploadFiles();
		
		//가상공간(논리주소를 만들어서 넣어준다 url) + 논리공간 경로 설정 + 파일이름 저장  
		// logpath = key, virtualRootPath + itemFilePath + fileinfo.get("file_nm") = value
		fileinfo.put("logpath", virtualRootPath + itemFilePath + fileinfo.get("file_nm"));
		
		//파일이름을 String으로 변경 
		// FilNm 사용해서 
        String FilNm = (String)fileinfo.get("file_nm");
		
        // 1.파일업로드가 되었을때 저장 "Y"(xml에서 처리:max값 일때만 저장되게 함 )
        // 2.파일이 없을때도 저장 ()
        // 3.저장이 안되는 경우   "N"
		if (FilNm != null && !"".equals(FilNm)) {
			paramMap.put("fileyn", "Y");
			productInfoDao.insertFile(fileinfo);
		} else {
			paramMap.put("fileyn", "N");
		}
		
		return productInfoDao.updateProduct(paramMap);
	}

	//제품정보관리  신규저장
	@Override
	public int insertProduct(Map<String, Object> paramMap, HttpServletRequest request) throws Exception {
   
		//다중 파일 업로드 
		MultipartHttpServletRequest multireq = (MultipartHttpServletRequest) request; //캐스팅
		
		//fileUpload.rootPath=X:\\FileRepository
		//rootPath 윈도우 => 물리주소 
		
		//fileUpload.virtualRootPath=/serverfile
		//virtualRootPath 리눅스 => 논리주소 (톰캣에  설정한 주소 )
		
		//fileUpload.prducimage=product
		//prducimage (이미지가 저장 될 공간의 폴더명)
		
		//map.put("file_nm", file_nm);
        //map.put("file_size", file_Size);
        //map.put("file_loc", file_loc);
        //map.put("fileExtension", fileExtension);
       
		//물리공간 경로 지정 =>\\
		String itemFilePath = File.separator + prducimage + File.separator;
		
		//다중파일 저장(multireq) + 물리공간 경로지정 + 하위 디렉토리 = 리턴 해준다 
		FileUtilCho fileup = new FileUtilCho(multireq, rootPath, itemFilePath); //rootPath File.separator + prducimage + File.separator
		
		//내장메소드  사용해서 파일 업로드 시키기 (uploadFiles) 리턴 받는다 
		Map<String,Object> fileinfo = fileup.uploadFiles();
		
		//가상공간(논리주소를 만들어서 넣어준다 url) + 논리공간 경로 설정 + 파일이름 저장  
		// logpath 키 , 
		fileinfo.put("logpath", virtualRootPath + itemFilePath + fileinfo.get("file_nm"));
		
		//파일이름을 String으로 변경 
		// FilNm 사용 
        String FilNm = (String)fileinfo.get("file_nm");
		
        // 1.파일업로드가 되었을때 저장 "Y"(xml에서 처리:max값 일때만 저장되게 함 )
        // 2.파일이 없을때도 저장 ()
        // 3.저장이 안되는 경우   "N"
		if (FilNm != null && !"".equals(FilNm)) {
			paramMap.put("fileyn", "Y");
			productInfoDao.insertFile(fileinfo);
		} else {
			paramMap.put("fileyn", "N");
		}
		
		return productInfoDao.insertProduct(paramMap);
	}

	//제품정보관리 삭제		
	@Override
	public int deleteProduct(Map<String, Object> paramMap) throws Exception {
		
/*		//1. 파일 이름, 실제파일 삭제 
		//2. 글 삭제 
		
		//1. 파일 이름, 실제파일 삭제 
		//삭제 할 파일 단건 조회하기  
		ProductInfoModel oldinfo = productInfoDao.productOne(paramMap);
				
				
		String ppath = oldinfo.getPdMadd();    
		   if (ppath != null && !"".equals(ppath)) {
				File fold = new File(ppath);
				fold.delete();
				
				//1.파일이름 삭제
				productInfoDao.clearfile(paramMap);
				//2.실제 파일 삭제 
				productInfoDao.clearpdinfo(paramMap);	
				}
		*/
		
		//2. 글삭제 
		return productInfoDao.deleteProduct(paramMap);
	}

}
