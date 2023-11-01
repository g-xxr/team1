package vo;

public class Goods {
	/*
	 * 접근제한자 4개가 대표적인 접근제한자👻
	 * public (완전공개 : 누구나 다 접근가능하고 수정할 수 있음)
	 * protected
	 * default
	 * private (Java의 모든 vo 타입은 다 private 씀, 허가된 사람들만 수정 가능하게)
	 * 아 그래서 getter, setter 자동으로 만들어짐! source 들어가면 있지롱
	 */
	
	private int goodsNo;
	private String goodsTitle;
	private int goodsPrice;
	private String soldout;
	private String goodsMemo;
	private String createdate;
	private String updatedate;
	
	public int getGoodsNo() {
		return goodsNo;
	}
	public void setGoodsNo(int goodsNo) {
		this.goodsNo = goodsNo;
	}
	public String getGoodsTitle() {
		return goodsTitle;
	}
	public void setGoodsTitle(String goodsTitle) {
		this.goodsTitle = goodsTitle;
	}
	public int getGoodsPrice() {
		return goodsPrice;
	}
	public void setGoodsPrice(int goodsPrice) {
		this.goodsPrice = goodsPrice;
	}
	public String getSoldout() {
		return soldout;
	}
	public void setSoldout(String soldout) {
		this.soldout = soldout;
	}
	public String getGoodsMemo() {
		return goodsMemo;
	}
	public void setGoodsMemo(String goodsMemo) {
		this.goodsMemo = goodsMemo;
	}
	public String getCreatedate() {
		return createdate;
	}
	public void setCreatedate(String createdate) {
		this.createdate = createdate;
	}
	public String getUpdatedate() {
		return updatedate;
	}
	public void setUpdatedate(String updatedate) {
		this.updatedate = updatedate;
	}
	
}
