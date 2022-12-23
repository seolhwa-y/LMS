package kr.happyjob.study.cor.model;

import org.springframework.stereotype.Repository;

//lombok 사용 X
@Repository
public class OrderStatusModel {
	private String startDate;
	private String endDate;
	
	private String jordNo; // 전체 주문코드
	private int cnt; // 주문 수량
	private long total; // 총주문금액
	private String jordDate; // 주문일자
	private String jordWishdate; // 주문희망일자
	private String jordIn; // 입금여부 (0 - 미입금, 1 - 입금)
	private String shType; // 배송여부 (0 - 미배송, 1 - 배송완료, 2 - 배송중)
	
	private String modelName; // 모델분류
	private String pdName; // 제품이름
	private String pdCode; // 제품코드
	private String pdCorp; // 제품 제조사
	private int pdPrice; // 제품 가격
	private String jordAmt; // 주문한 수량
	
	private String loginId; // 기업회원코드
	private String bankCode; // 은행코드
	private String bankName; // 은행명
	private String account; // 계좌번호
	
	private String reCode; // 반품코드
	private String dirCode; // 지시서코드
	private String jordCode; // 제품별 주문코드
	private String whCode; // 창고코드
	private String modelCode; // 제품별코드
	private String bordCode; // 발주코드
	private int reAmt; // 반품수량
	private String reDate; // 반품완료일자
	private String reType; // 반품 승인여부 (0 - 미승인, 1 - 승인, 2 - 반려)
	private int reOut; // 송금여부
	
	// 파라미터 값 나중에 추가하기
	public String getStartDate() {
		return startDate;
	}
	public void setStartDate(String startDate) {
		this.startDate = startDate;
	}
	public String getEndDate() {
		return endDate;
	}
	public void setEndDate(String endDate) {
		this.endDate = endDate;
	}
	public String getJordNo() {
		return jordNo;
	}
	public void setJordNo(String jordNo) {
		this.jordNo = jordNo;
	}
	public int getCnt() {
		return cnt;
	}
	public void setCnt(int cnt) {
		this.cnt = cnt;
	}
	public long getTotal() {
		return total;
	}
	public void setTotal(long total) {
		this.total = total;
	}
	public String getJordDate() {
		return jordDate;
	}
	public void setJordDate(String jordDate) {
		this.jordDate = jordDate;
	}
	public String getJordWishdate() {
		return jordWishdate;
	}
	public void setJordWishdate(String jordWishdate) {
		this.jordWishdate = jordWishdate;
	}
	public String getJordIn() {
		return jordIn;
	}
	public void setJordIn(String jordIn) {
		this.jordIn = jordIn;
	}
	public String getShType() {
		return shType;
	}
	public void setShType(String shType) {
		this.shType = shType;
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
	public String getPdCode() {
		return pdCode;
	}
	public void setPdCode(String pdCode) {
		this.pdCode = pdCode;
	}
	public String getPdCorp() {
		return pdCorp;
	}
	public void setPdCorp(String pdCorp) {
		this.pdCorp = pdCorp;
	}
	public int getPdPrice() {
		return pdPrice;
	}
	public void setPdPrice(int pdPrice) {
		this.pdPrice = pdPrice;
	}
	public String getJordAmt() {
		return jordAmt;
	}
	public void setJordAmt(String jordAmt) {
		this.jordAmt = jordAmt;
	}
	public String getLoginId() {
		return loginId;
	}
	public void setLoginId(String loginId) {
		this.loginId = loginId;
	}
	public String getBankCode() {
		return bankCode;
	}
	public void setBankCode(String bankCode) {
		this.bankCode = bankCode;
	}
	public String getBankName() {
		return bankName;
	}
	public void setBankName(String bankName) {
		this.bankName = bankName;
	}
	public String getAccount() {
		return account;
	}
	public void setAccount(String account) {
		this.account = account;
	}
	public String getReCode() {
		return reCode;
	}
	public void setReCode(String reCode) {
		this.reCode = reCode;
	}
	public String getDirCode() {
		return dirCode;
	}
	public void setDirCode(String dirCode) {
		this.dirCode = dirCode;
	}
	public String getJordCode() {
		return jordCode;
	}
	public void setJordCode(String jordCode) {
		this.jordCode = jordCode;
	}
	public String getWhCode() {
		return whCode;
	}
	public void setWhCode(String whCode) {
		this.whCode = whCode;
	}
	public String getModelCode() {
		return modelCode;
	}
	public void setModelCode(String modelCode) {
		this.modelCode = modelCode;
	}
	public String getBordCode() {
		return bordCode;
	}
	public void setBordCode(String bordCode) {
		this.bordCode = bordCode;
	}
	public int getReAmt() {
		return reAmt;
	}
	public void setReAmt(int reAmt) {
		this.reAmt = reAmt;
	}
	public String getReDate() {
		return reDate;
	}
	public void setReDate(String reDate) {
		this.reDate = reDate;
	}
	public String getReType() {
		return reType;
	}
	public void setReType(String reType) {
		this.reType = reType;
	}
	public int getReOut() {
		return reOut;
	}
	public void setReOut(int reOut) {
		this.reOut = reOut;
	}
	
}
