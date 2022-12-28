package kr.happyjob.study.cor.model;

import org.springframework.stereotype.Repository;

//lombok 사용 X
@Repository
public class OrderStatusModel {
	private String startDate;
	private String endDate;
	
	private int jordNo; // 전체 주문코드
	private int count;
	private int cnt; // 주문 수량
	private long total; // 총주문금액
	private String jordDate; // 주문일자
	private String jordWishdate; // 주문희망일자
	private String jordIn; // 입금여부 (0 - 미입금, 1 - 입금)
	private String shDate;
	private String shType; // 배송여부 (0 - 미배송, 1 - 배송완료, 2 - 배송중)
	
	private String modelName; // 모델분류
	private String pdName; // 제품이름
	private String pdCode; // 제품코드
	private String pdCorp; // 제품 제조사
	private int pdPrice; // 제품 가격
	private String jordAmt; // 주문한 수량
	
	private String loginId; // 기업회원코드
	private int bankCode; // 은행코드
	private String bankName; // 은행명
	private String account; // 계좌번호
	
	private int shCode;
	private int reCode; // 반품코드
	private int dirCode; // 지시서코드
	private int jordCode; // 제품별 주문코드
	private int whCode; // 창고코드
	private int modelCode; // 제품별코드
	private int bordCode; // 발주코드
	private int reAmt; // 반품수량
	private String reDate; // 반품완료일자
	private String reType; // 반품 승인여부 (0 - 미승인, 1 - 승인, 2 - 반려)
	private String reOut; // 송금여부
	
	
		
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
	public int getJordNo() {
		return jordNo;
	}
	public void setJordNo(int jordNo) {
		this.jordNo = jordNo;
	}
	public int getCount() {
		return count;
	}
	public void setCount(int count) {
		this.count = count;
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
	public String getShDate() {
		return shDate;
	}
	public void setShDate(String shDate) {
		this.shDate = shDate;
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
	public int getBankCode() {
		return bankCode;
	}
	public void setBankCode(int bankCode) {
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
	public int getShCode() {
		return shCode;
	}
	public void setShCode(int shCode) {
		this.shCode = shCode;
	}
	public int getReCode() {
		return reCode;
	}
	public void setReCode(int reCode) {
		this.reCode = reCode;
	}
	public int getDirCode() {
		return dirCode;
	}
	public void setDirCode(int dirCode) {
		this.dirCode = dirCode;
	}
	public int getJordCode() {
		return jordCode;
	}
	public void setJordCode(int jordCode) {
		this.jordCode = jordCode;
	}
	public int getWhCode() {
		return whCode;
	}
	public void setWhCode(int whCode) {
		this.whCode = whCode;
	}
	public int getModelCode() {
		return modelCode;
	}
	public void setModelCode(int modelCode) {
		this.modelCode = modelCode;
	}
	public int getBordCode() {
		return bordCode;
	}
	public void setBordCode(int bordCode) {
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
	public String getReOut() {
		return reOut;
	}
	public void setReOut(String reOut) {
		this.reOut = reOut;
	}
}
