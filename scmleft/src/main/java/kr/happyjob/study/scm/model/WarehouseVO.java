package kr.happyjob.study.scm.model;

public class WarehouseVO {

	private int WH_NO;
	private int WH_CODE;
	private String loginID;
	private String WH_TYPE;
	private int WH_AMT;
	private String WH_DATE;
	private String WH_NAME;
	private String WH_ZIP;
	private String WH_ADDR;
	private String WH_ADDR_DTL;
	private int WH_STOCK;
	private int MODEL_CODE;
	private String ware_name;  //창고 선택을 위해 추가함!! 
	private String origin_ware_no;
	private int re_code;
	private String name;
	
	
	public int getRe_code() {
		return re_code;
	}
	public void setRe_code(int re_code) {
		this.re_code = re_code;
	}
	public String getWare_name() {
		return ware_name;
	}
	public void setWare_name(String ware_name) {
		this.ware_name = ware_name;
	}
	public String getOrigin_ware_no() {
		return origin_ware_no;
	}
	public void setOrigin_ware_no(String origin_ware_no) {
		this.origin_ware_no = origin_ware_no;
	}
	public int getWH_NO() {
		return WH_NO;
	}
	public void setWH_NO(int wH_NO) {
		WH_NO = wH_NO;
	}
	public int getWH_CODE() {
		return WH_CODE;
	}
	public void setWH_CODE(int wH_CODE) {
		WH_CODE = wH_CODE;
	}
	public String getLoginID() {
		return loginID;
	}
	public void setLoginID(String loginID) {
		this.loginID = loginID;
	}
	public String getWH_TYPE() {
		return WH_TYPE;
	}
	public void setWH_TYPE(String wH_TYPE) {
		WH_TYPE = wH_TYPE;
	}
	public int getWH_AMT() {
		return WH_AMT;
	}
	public void setWH_AMT(int wH_AMT) {
		WH_AMT = wH_AMT;
	}
	public String getWH_DATE() {
		return WH_DATE;
	}
	public void setWH_DATE(String wH_DATE) {
		WH_DATE = wH_DATE;
	}
	public String getWH_NAME() {
		return WH_NAME;
	}
	public void setWH_NAME(String wH_NAME) {
		WH_NAME = wH_NAME;
	}
	public String getWH_ZIP() {
		return WH_ZIP;
	}
	public void setWH_ZIP(String wH_ZIP) {
		WH_ZIP = wH_ZIP;
	}
	public String getWH_ADDR() {
		return WH_ADDR;
	}
	public void setWH_ADDR(String wH_ADDR) {
		WH_ADDR = wH_ADDR;
	}
	public String getWH_ADDR_DTL() {
		return WH_ADDR_DTL;
	}
	public void setWH_ADDR_DTL(String wH_ADDR_DTL) {
		WH_ADDR_DTL = wH_ADDR_DTL;
	}
	public int getWH_STOCK() {
		return WH_STOCK;
	}
	public void setWH_STOCK(int wH_STOCK) {
		WH_STOCK = wH_STOCK;
	}
	public int getMODEL_CODE() {
		return MODEL_CODE;
	}
	public void setMODEL_CODE(int mODEL_CODE) {
		MODEL_CODE = mODEL_CODE;
	}
	@Override
	public String toString() {
		return "WarehouseVO [WH_NO=" + WH_NO + ", WH_CODE=" + WH_CODE + ", loginID=" + loginID + ", WH_TYPE=" + WH_TYPE
				+ ", WH_AMT=" + WH_AMT + ", WH_DATE=" + WH_DATE + ", WH_NAME=" + WH_NAME + ", WH_ZIP=" + WH_ZIP
				+ ", WH_ADDR=" + WH_ADDR + ", WH_ADDR_DTL=" + WH_ADDR_DTL + ", WH_STOCK=" + WH_STOCK + ", MODEL_CODE="
				+ MODEL_CODE + ", ware_name=" + ware_name + ", origin_ware_no=" + origin_ware_no + ", re_code="
				+ re_code + "]";
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	
	
	
}
