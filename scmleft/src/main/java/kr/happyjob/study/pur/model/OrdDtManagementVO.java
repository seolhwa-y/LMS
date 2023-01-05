package kr.happyjob.study.pur.model;

import java.sql.Date;

public class OrdDtManagementVO {

	private int BORD_CODE;
	private int BORD_AMT;
	private String loginID;
	private String MODEL_NAME;
	private String BORD_DATE;
	private String BORD_TYPE;
	private String JORD_IN;
	private Date sdate;
	private Date edate;
	private String cpname;
	private String pdname;
	private String approved;
	private String unapproved;
	
	
	public String getCpname() {
		return cpname;
	}
	public void setCpname(String cpname) {
		this.cpname = cpname;
	}
	public String getPdname() {
		return pdname;
	}
	public void setPdname(String pdname) {
		this.pdname = pdname;
	}
	public String getApproved() {
		return approved;
	}
	public void setApproved(String approved) {
		this.approved = approved;
	}
	public String getUnapproved() {
		return unapproved;
	}
	public void setUnapproved(String unapproved) {
		this.unapproved = unapproved;
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
	public int getBORD_CODE() {
		return BORD_CODE;
	}
	public void setBORD_CODE(int bORD_CODE) {
		BORD_CODE = bORD_CODE;
	}
	public int getBORD_AMT() {
		return BORD_AMT;
	}
	public void setBORD_AMT(int bORD_AMT) {
		BORD_AMT = bORD_AMT;
	}
	public String getLoginID() {
		return loginID;
	}
	public void setLoginID(String loginID) {
		this.loginID = loginID;
	}
	public String getMODEL_NAME() {
		return MODEL_NAME;
	}
	public void setMODEL_NAME(String mODEL_NAME) {
		MODEL_NAME = mODEL_NAME;
	}
	public String getBORD_DATE() {
		return BORD_DATE;
	}
	public void setBORD_DATE(String bORD_DATE) {
		BORD_DATE = bORD_DATE;
	}
	public String getBORD_TYPE() {
		return BORD_TYPE;
	}
	public void setBORD_TYPE(String bORD_TYPE) {
		BORD_TYPE = bORD_TYPE;
	}
	public String getJORD_IN() {
		return JORD_IN;
	}
	public void setJORD_IN(String jORD_IN) {
		JORD_IN = jORD_IN;
	}
	@Override
	public String toString() {
		return "OrdDtManagementVO [BORD_CODE=" + BORD_CODE + ", BORD_AMT=" + BORD_AMT + ", loginID=" + loginID
				+ ", MODEL_NAME=" + MODEL_NAME + ", BORD_DATE=" + BORD_DATE + ", BORD_TYPE=" + BORD_TYPE + ", JORD_IN="
				+ JORD_IN + ", sdate=" + sdate + ", edate=" + edate + ", cpname=" + cpname + ", pdname=" + pdname
				+ ", approved=" + approved + ", unapproved=" + unapproved + "]";
	}
	
	
}
