package com.gpu.nipa.xpu.form;

import org.springframework.stereotype.Repository;

@Repository
public class XpuForm {
	private String time;
	private String type;
	private int no;
	private int per;
	
	public void setTime(String time) {
		this.time = time;
	}
	
	public void setType(String type) {
		this.type = type;
	}
	
	public void setNo(int no) {
		this.no = no;
	}
	
	public void setPer(int per) {
		this.per = per;
	}
	
	public String getTime() {
		return time;
	}
	
	public String getType() {
		return type;
	}
	
	public int getNo() {
		return no;
	}
	
	public int getPer() {
		return per;
	}
}
