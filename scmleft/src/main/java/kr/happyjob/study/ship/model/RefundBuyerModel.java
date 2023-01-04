package kr.happyjob.study.ship.model;

public class RefundBuyerModel {
	
	private int re_code;		// 반품코드
	private int dir_code;		// 지시서코드
	private int jord_code;		// 주문코드
	private int wh_code;		// 창고코드
	private int model_code;		// 모델코드
	private int bord_code;		// 발주코드
	private int re_amt;			// 수량
	private String re_date;		// 날짜
	private String re_type;		// 승인여부
	private String re_out;		// 송금여부	
	private String pdcorp;		// 업체명
	private String company;
	private long sum;
	private String model_name; 	// 제품명
	private String wh_name;		// 창고명
	private int pageIndex;
	private int pageSize;
	private String pd_name;
	private String pd_code;
	private String loginID;
	
	
	public String getLoginID() {
		return loginID;
	}
	public void setLoginID(String loginID) {
		this.loginID = loginID;
	}
	public String getPd_code() {
		return pd_code;
	}
	public void setPd_code(String pd_code) {
		this.pd_code = pd_code;
	}
	public String getPd_name() {
		return pd_name;
	}
	public void setPd_name(String pd_name) {
		this.pd_name = pd_name;
	}
	public long getPd_price() {
		return pd_price;
	}
	public void setPd_price(long pd_price) {
		this.pd_price = pd_price;
	}
	private long pd_price;
	
	
	
	public String getPdcorp() {
		return pdcorp;
	}
	public void setPdcorp(String pdcorp) {
		this.pdcorp = pdcorp;
	}

	public String getCompany() {
		return company;
	}
	public void setCompany(String company) {
		this.company = company;
	}
	public long getSum() {
		return sum;
	}
	public void setSum(long sum) {
		this.sum = sum;
	}
	public int getRe_code() {
		return re_code;
	}
	public void setRe_code(int re_code) {
		this.re_code = re_code;
	}
	public int getDir_code() {
		return dir_code;
	}
	public void setDir_code(int dir_code) {
		this.dir_code = dir_code;
	}
	public int getJord_code() {
		return jord_code;
	}
	public void setJord_code(int jord_code) {
		this.jord_code = jord_code;
	}
	public int getWh_code() {
		return wh_code;
	}
	public void setWh_code(int wh_code) {
		this.wh_code = wh_code;
	}
	public int getModel_code() {
		return model_code;
	}
	public void setModel_code(int model_code) {
		this.model_code = model_code;
	}
	public int getBord_code() {
		return bord_code;
	}
	public void setBord_code(int bord_code) {
		this.bord_code = bord_code;
	}
	public int getRe_amt() {
		return re_amt;
	}
	public void setRe_amt(int re_amt) {
		this.re_amt = re_amt;
	}
	public String getRe_date() {
		return re_date;
	}
	public void setRe_date(String re_date) {
		this.re_date = re_date;
	}
	public String getRe_type() {
		return re_type;
	}
	public void setRe_type(String re_type) {
		this.re_type = re_type;
	}
	public String getRe_out() {
		return re_out;
	}
	public void setRe_out(String re_out) {
		this.re_out = re_out;
	}
	
	public String getModel_name() {
		return model_name;
	}
	public void setModel_name(String model_name) {
		this.model_name = model_name;
	}
	public String getWh_name() {
		return wh_name;
	}
	public void setWh_name(String wh_name) {
		this.wh_name = wh_name;
	}
	public int getPageIndex() {
		return pageIndex;
	}
	public void setPageIndex(int pageIndex) {
		this.pageIndex = pageIndex;
	}
	public int getPageSize() {
		return pageSize;
	}
	public void setPageSize(int pageSize) {
		this.pageSize = pageSize;
	}

}
