package kr.happyjob.study.scm.model;

import java.sql.Date;

public class RefundInfoVO {
	private String MODEL_NAME;
	private String RE_DATE;
	private int PD_PRICE;
	private int RE_AMT;
	private long RE_PRICE;

	private Date sdate;
	private Date edate;
	private int JORD_CODE;
	private int MODEL_CODE;
	
	private String WH_NAME;
	private int WH_CODE;
	
	private int re_code;
	
	private int dir_code;
	private int BORD_CODE;
	private int RE_TYPE;
	private int RE_OUT;
	
	
	
	public int getDir_code() {
		return dir_code;
	}
	public void setDir_code(int dir_code) {
		this.dir_code = dir_code;
	}
	public int getBORD_CODE() {
		return BORD_CODE;
	}
	public void setBORD_CODE(int bORD_CODE) {
		BORD_CODE = bORD_CODE;
	}
	public int getRE_TYPE() {
		return RE_TYPE;
	}
	public void setRE_TYPE(int rE_TYPE) {
		RE_TYPE = rE_TYPE;
	}
	public int getRE_OUT() {
		return RE_OUT;
	}
	public void setRE_OUT(int rE_OUT) {
		RE_OUT = rE_OUT;
	}
	public int getRe_code() {
		return re_code;
	}
	public void setRe_code(int re_code) {
		this.re_code = re_code;
	}
	public String getWH_NAME() {
		return WH_NAME;
	}
	public void setWH_NAME(String wH_NAME) {
		WH_NAME = wH_NAME;
	}
	public int getWH_CODE() {
		return WH_CODE;
	}
	public void setWH_CODE(int wH_CODE) {
		WH_CODE = wH_CODE;
	}
	public int getJORD_CODE() {
		return JORD_CODE;
	}
	public void setJORD_CODE(int jORD_CODE) {
		JORD_CODE = jORD_CODE;
	}
	public int getMODEL_CODE() {
		return MODEL_CODE;
	}
	public void setMODEL_CODE(int mODEL_CODE) {
		MODEL_CODE = mODEL_CODE;
	}
	public int getRE_AMT() {
		return RE_AMT;
	}
	public void setRE_AMT(int rE_AMT) {
		RE_AMT = rE_AMT;
	}
	public long getRE_PRICE() {
		return RE_PRICE;
	}
	public void setRE_PRICE(long rE_PRICE) {
		RE_PRICE = rE_PRICE;
	}
	public String getMODEL_NAME() {
		return MODEL_NAME;
	}
	public void setMODEL_NAME(String mODEL_NAME) {
		MODEL_NAME = mODEL_NAME;
	}
	public String getRE_DATE() {
		return RE_DATE;
	}
	public void setRE_DATE(String rE_DATE) {
		RE_DATE = rE_DATE;
	}
	public int getPD_PRICE() {
		return PD_PRICE;
	}
	public void setPD_PRICE(int pD_PRICE) {
		PD_PRICE = pD_PRICE;
	}

	public Date getSdate() {
		return sdate;
	}
	public void setSdate(Date sdate) {
		this.sdate = sdate;
	}
	public Date getEdate() {
		return edate;
	}
	public void setEdate(Date edate) {
		this.edate = edate;
	}
	@Override
	public String toString() {
		return "RefundInfoVO [MODEL_NAME=" + MODEL_NAME + ", RE_DATE=" + RE_DATE + ", PD_PRICE=" + PD_PRICE
				+ ", RE_AMT=" + RE_AMT + ", RE_PRICE=" + RE_PRICE + ", sdate=" + sdate + ", edate=" + edate
				+ ", JORD_CODE=" + JORD_CODE + ", MODEL_CODE=" + MODEL_CODE + ", WH_NAME=" + WH_NAME + ", WH_CODE="
				+ WH_CODE + ", re_code=" + re_code + ", dir_code=" + dir_code + ", BORD_CODE=" + BORD_CODE
				+ ", RE_TYPE=" + RE_TYPE + ", RE_OUT=" + RE_OUT + "]";
	}
	
}
