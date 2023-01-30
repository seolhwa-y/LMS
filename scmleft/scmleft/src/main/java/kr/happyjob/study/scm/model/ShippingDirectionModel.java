package kr.happyjob.study.scm.model;

public class ShippingDirectionModel {

	private int jord_code; //주문서코드  jord_code or jordCode 표기
	private int dir_code; //지시서코드   
	private int model_code; //모델코드  
	private String pd_name; //주문제품  
	private String jord_date; // 주문일자 
	private String pd_corp; // 제조사 
	private int jord_amt; // 주문 개수 
	private String jord_wishdate; // 배송희망 일자 
	private String sh_type; // 배송상태 
	private String group_code;// 그룹코드 
	private String wh_name;// 창고명 
	private int wh_code;// 창고코드 
	private String jord_in; //입금여부	
	private String loginID; 
	private String name;  	
	private int currentPage;  
	private int pageSize;  
	private int pageIndex; 
	

	@Override
	public String toString() {
		return "ShippingDirectionModel [jord_code=" + jord_code + ", dir_code=" + dir_code + ", model_code="
				+ model_code + ", pd_name=" + pd_name + ", jord_date=" + jord_date + ", pd_corp=" + pd_corp
				+ ", jord_amt=" + jord_amt + ", jord_wishdate=" + jord_wishdate + ", sh_type=" + sh_type
				+ ", group_code=" + group_code + ", wh_name=" + wh_name + ", wh_code=" + wh_code + ", jord_in="
				+ jord_in + ", loginID=" + loginID + ", name=" + name + ", currentPage=" + currentPage + ", pageSize="
				+ pageSize + ", pageIndex=" + pageIndex + "]";
	}
	
	public int getJord_code() {
		return jord_code;
	}
	public void setJord_code(int jord_code) {
		this.jord_code = jord_code;
	}
	public int getDir_code() {
		return dir_code;
	}
	public void setDir_code(int dir_code) {
		this.dir_code = dir_code;
	}
	public int getModel_code() {
		return model_code;
	}
	public void setModel_code(int model_code) {
		this.model_code = model_code;
	}
	public String getPd_name() {
		return pd_name;
	}
	public void setPd_name(String pd_name) {
		this.pd_name = pd_name;
	}
	public String getJord_date() {
		return jord_date;
	}
	public void setJord_date(String jord_date) {
		this.jord_date = jord_date;
	}
	public String getPd_corp() {
		return pd_corp;
	}
	public void setPd_corp(String pd_corp) {
		this.pd_corp = pd_corp;
	}
	public int getJord_amt() {
		return jord_amt;
	}
	public void setJord_amt(int jord_amt) {
		this.jord_amt = jord_amt;
	}
	public String getJord_wishdate() {
		return jord_wishdate;
	}
	public void setJord_wishdate(String jord_wishdate) {
		this.jord_wishdate = jord_wishdate;
	}
	public String getSh_type() {
		return sh_type;
	}
	public void setSh_type(String sh_type) {
		this.sh_type = sh_type;
	}
	public String getGroup_code() {
		return group_code;
	}
	public void setGroup_code(String group_code) {
		this.group_code = group_code;
	}
	public String getWh_name() {
		return wh_name;
	}
	public void setWh_name(String wh_name) {
		this.wh_name = wh_name;
	}
	public int getWh_code() {
		return wh_code;
	}
	public void setWh_code(int wh_code) {
		this.wh_code = wh_code;
	}
	public String getJord_in() {
		return jord_in;
	}
	public void setJord_in(String jord_in) {
		this.jord_in = jord_in;
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
