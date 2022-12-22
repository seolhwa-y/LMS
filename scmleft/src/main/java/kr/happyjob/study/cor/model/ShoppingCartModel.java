package kr.happyjob.study.cor.model;

import org.springframework.stereotype.Component;

//lombok 사용 X
@Component
public class ShoppingCartModel {
	private String loginId; // 장바구니 주인 이름 + 주문한 사람
	private String modelCode; // 제품 모델 코드
	private String pdNadd; // 제품 이미지 링크
	private String pdName; // 제품 이름
	private int pdPrice; // 제품 가격
	private int baAmt; // 장바구니 수량
	private long total; // 제품별 합계금액
	private String baWishdate; // 제품별 배송희망일자
	
	private String jordCode; // 제품별 주문코드
	private String jordNo; // 전체 주문코드
	private String jordDate; // 주문일자
	private String jordIn; // 입금여부 (0 - 미입금, 1 - 입금)
	private String jordWishdate; // 배송희망일자
	private int jordAmt; // 주문수량
	
	
	// 파라미터 값 나중에 추가하기
	public String getLoginId() {
		return loginId;
	}
	public void setLoginId(String loginId) {
		this.loginId = loginId;
	}
	public String getModelCode() {
		return modelCode;
	}
	public void setModelCode(String modelCode) {
		this.modelCode = modelCode;
	}
	public String getPdNadd() {
		return pdNadd;
	}
	public void setPdNadd(String pdNadd) {
		this.pdNadd = pdNadd;
	}
	public String getPdName() {
		return pdName;
	}
	public void setPdName(String pdName) {
		this.pdName = pdName;
	}
	public int getPdPrice() {
		return pdPrice;
	}
	public void setPdPrice(int pdPrice) {
		this.pdPrice = pdPrice;
	}
	public int getBaAmt() {
		return baAmt;
	}
	public void setBaAmt(int baAmt) {
		this.baAmt = baAmt;
	}
	public long getTotal() {
		return total;
	}
	public void setTotal(long total) {
		this.total = total;
	}
	public String getBaWishdate() {
		return baWishdate;
	}
	public void setBaWishdate(String baWishdate) {
		this.baWishdate = baWishdate;
	}
	public String getJordCode() {
		return jordCode;
	}
	public void setJordCode(String jordCode) {
		this.jordCode = jordCode;
	}
	public String getJordNo() {
		return jordNo;
	}
	public void setJordNo(String jordNo) {
		this.jordNo = jordNo;
	}
	public String getJordDate() {
		return jordDate;
	}
	public void setJordDate(String jordDate) {
		this.jordDate = jordDate;
	}
	public String getJordIn() {
		return jordIn;
	}
	public void setJordIn(String jordIn) {
		this.jordIn = jordIn;
	}
	public String getJordWishdate() {
		return jordWishdate;
	}
	public void setJordWishdate(String jordWishdate) {
		this.jordWishdate = jordWishdate;
	}
	public int getJordAmt() {
		return jordAmt;
	}
	public void setJordAmt(int jordAmt) {
		this.jordAmt = jordAmt;
	}
	
}
