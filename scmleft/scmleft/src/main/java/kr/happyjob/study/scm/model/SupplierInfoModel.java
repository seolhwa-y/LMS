package kr.happyjob.study.scm.model;


public class SupplierInfoModel {
	
	private String model_code;
	private String model_name;
	private String pd_corp;
	private int pd_price;
	private int jord_amt;
	private String jord_in;
	private String jord_date;
	private int pageIndex;
	private int pageSize;
	private String macul;
	private int price;
	private String dtldate;
	
	
	public String getDtldate() {
		return dtldate;
	}

	public void setDtldate(String dtldate) {
		this.dtldate = dtldate;
	}

	public int getPrice() {
		return price;
	}

	public void setPrice(int price) {
		this.price = price;
	}

	public String getMacul() {
		return macul;
	}

	public void setMacul(String macul) {
		this.macul = macul;
	}

	public String getModel_code() {
		return model_code;
	}

	public void setModel_code(String model_code) {
		this.model_code = model_code;
	}

	public String getModel_name() {
		return model_name;
	}

	public void setModel_name(String model_name) {
		this.model_name = model_name;
	}

	public String getPd_corp() {
		return pd_corp;
	}

	public void setPd_corp(String pd_corp) {
		this.pd_corp = pd_corp;
	}

	public int getPd_price() {
		return pd_price;
	}

	public void setPd_price(int pd_price) {
		this.pd_price = pd_price;
	}

	public int getJord_amt() {
		return jord_amt;
	}

	public void setJord_amt(int jord_amt) {
		this.jord_amt = jord_amt;
	}

	public String getJord_in() {
		return jord_in;
	}

	public void setJord_in(String jord_in) {
		this.jord_in = jord_in;
	}

	public String getJord_date() {
		return jord_date;
	}

	public void setJord_date(String jord_date) {
		this.jord_date = jord_date;
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
