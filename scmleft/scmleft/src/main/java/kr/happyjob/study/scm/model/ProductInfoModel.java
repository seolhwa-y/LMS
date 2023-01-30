package kr.happyjob.study.scm.model;

public class ProductInfoModel {

	private int modelCode; //모델코드   카멜표기법으로 다시 수정함 model_code --> modelCode
	private String modelName; //모델명
	private String pdName; // 제품명  
	private String pdCorp; // 제조사 
	private String pdCode; // 제품no 
	private String pdPrice; // 제품가격		
	private int pdfileCode; //파일코드
	private String pdfileName; //파일명
	private String pdNadd; //논리주소
	private String pdMadd; //물리주소
	private String pdSize; //파일크기	
	private String loginId; 
	private String name;  	
	private int currentPage;  
	private int pageSize;  
	private int pageIndex;
	
	
	
	@Override
	public String toString() {
		return "ProductInfoModel [modelCode=" + modelCode + ", modelName=" + modelName + ", pdName=" + pdName
				+ ", pdCorp=" + pdCorp + ", pdCode=" + pdCode + ", pdPrice=" + pdPrice + ", pdfileCode=" + pdfileCode
				+ ", pdfileName=" + pdfileName + ", pdNadd=" + pdNadd + ", pdMadd=" + pdMadd + ", pdSize=" + pdSize
				+ ", loginId=" + loginId + ", name=" + name + ", currentPage=" + currentPage + ", pageSize=" + pageSize
				+ ", pageIndex=" + pageIndex + "]";
	}
	
	public int getModelCode() {
		return modelCode;
	}
	public void setModelCode(int modelCode) {
		this.modelCode = modelCode;
	}
	public String getModelName() {
		return modelName;
	}
	public void setModelName(String modelName) {
		this.modelName = modelName;
	}
	public String getPdName() {
		return pdName;
	}
	public void setPdName(String pdName) {
		this.pdName = pdName;
	}
	public String getPdCorp() {
		return pdCorp;
	}
	public void setPdCorp(String pdCorp) {
		this.pdCorp = pdCorp;
	}
	public String getPdCode() {
		return pdCode;
	}
	public void setPdCode(String pdCode) {
		this.pdCode = pdCode;
	}
	public String getPdPrice() {
		return pdPrice;
	}
	public void setPdPrice(String pdPrice) {
		this.pdPrice = pdPrice;
	}
	public int getPdfileCode() {
		return pdfileCode;
	}
	public void setPdfileCode(int pdfileCode) {
		this.pdfileCode = pdfileCode;
	}
	public String getPdfileName() {
		return pdfileName;
	}
	public void setPdfileName(String pdfileName) {
		this.pdfileName = pdfileName;
	}
	public String getPdNadd() {
		return pdNadd;
	}
	public void setPdNadd(String pdNadd) {
		this.pdNadd = pdNadd;
	}
	public String getPdMadd() {
		return pdMadd;
	}
	public void setPdMadd(String pdMadd) {
		this.pdMadd = pdMadd;
	}
	public String getPdSize() {
		return pdSize;
	}
	public void setPdSize(String pdSize) {
		this.pdSize = pdSize;
	}
	public String getLoginId() {
		return loginId;
	}
	public void setLoginId(String loginId) {
		this.loginId = loginId;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public int getCurrentPage() {
		return currentPage;
	}
	public void setCurrentPage(int currentPage) {
		this.currentPage = currentPage;
	}
	public int getPageSize() {
		return pageSize;
	}
	public void setPageSize(int pageSize) {
		this.pageSize = pageSize;
	}
	public int getPageIndex() {
		return pageIndex;
	}
	public void setPageIndex(int pageIndex) {
		this.pageIndex = pageIndex;
	}
	
	
}
