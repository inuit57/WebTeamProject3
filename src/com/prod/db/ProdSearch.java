package com.prod.db;

public class ProdSearch {
	private String item ;
	private String search_type ;
	private String search_text ;
	private String min_price ;
	private String max_price ;
	public String getItem() {
		return item;
	}
	public void setItem(String item) {
		this.item = item;
	}
	public String getSearch_type() {
		return search_type;
	}
	public void setSearch_type(String search_type) {
		this.search_type = search_type;
	}
	public String getSearch_text() {
		return search_text;
	}
	public void setSearch_text(String search_text) {
		this.search_text = search_text;
	}
	public String getMin_price() {
		return min_price;
	}
	public void setMin_price(String min_price) {
		this.min_price = min_price;
	}
	public String getMax_price() {
		return max_price;
	}
	public void setMax_price(String max_price) {
		this.max_price = max_price;
	}
	
	@Override
	public String toString() {
		return "ProdSearch [item=" + item + ", search_type=" + search_type + ", search_text=" + search_text
				+ ", min_price=" + min_price + ", max_price=" + max_price + "]";
	} 
	
	
}
