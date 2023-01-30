package kr.happyjob.study.cor.model;

public class ProductInfoModel {

	private int model_code; //모델코드  
	private String model_name; //모델명
	private String pd_name; // 제품명  
	private String pd_corp; // 제조사 
	private String pd_code; // 제품no 
	private String pd_price; // 제품가격		
	private int pdfile_code; //파일코드
	private String pdfile_name; //파일명
	private String pd_nadd; //논리주소
	private String pd_madd; //물리주소
	private String pd_size; //파일크기	
	private String loginID; 
	private String name;  	
	private int currentPage;  
	private int pageSize;  
	private int pageIndex;
	
	@Override
	public String toString() {
		return "ProductInfoModel [model_code=" + model_code + ", model_name=" + model_name + ", pd_name=" + pd_name
				+ ", pd_corp=" + pd_corp + ", pd_code=" + pd_code + ", pd_price=" + pd_price + ", pdfile_code="
				+ pdfile_code + ", pdfile_name=" + pdfile_name + ", pd_nadd=" + pd_nadd + ", pd_madd=" + pd_madd
				+ ", pd_size=" + pd_size + ", loginID=" + loginID + ", name=" + name + ", currentPage=" + currentPage
				+ ", pageSize=" + pageSize + ", pageIndex=" + pageIndex + "]";
	}
	
	public int getModel_code() {
		return model_code;
	}
	public void setModel_code(int model_code) {
		this.model_code = model_code;
	}
	public String getModel_name() {
		return model_name;
	}
	public void setModel_name(String model_name) {
		this.model_name = model_name;
	}
	public String getPd_name() {
		return pd_name;
	}
	public void setPd_name(String pd_name) {
		this.pd_name = pd_name;
	}
	public String getPd_corp() {
		return pd_corp;
	}
	public void setPd_corp(String pd_corp) {
		this.pd_corp = pd_corp;
	}
	public String getPd_code() {
		return pd_code;
	}
	public void setPd_code(String pd_code) {
		this.pd_code = pd_code;
	}
	public String getPd_price() {
		return pd_price;
	}
	public void setPd_price(String pd_price) {
		this.pd_price = pd_price;
	}
	public int getPdfile_code() {
		return pdfile_code;
	}
	public void setPdfile_code(int pdfile_code) {
		this.pdfile_code = pdfile_code;
	}
	public String getPdfile_name() {
		return pdfile_name;
	}
	public void setPdfile_name(String pdfile_name) {
		this.pdfile_name = pdfile_name;
	}
	public String getPd_nadd() {
		return pd_nadd;
	}
	public void setPd_nadd(String pd_nadd) {
		this.pd_nadd = pd_nadd;
	}
	public String getPd_madd() {
		return pd_madd;
	}
	public void setPd_madd(String pd_madd) {
		this.pd_madd = pd_madd;
	}
	public String getPd_size() {
		return pd_size;
	}
	public void setPd_size(String pd_size) {
		this.pd_size = pd_size;
	}
	public String getLoginID() {
		return loginID;
	}
	public void setLoginID(String loginID) {
		this.loginID = loginID;
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
