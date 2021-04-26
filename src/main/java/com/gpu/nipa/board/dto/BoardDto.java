package com.gpu.nipa.board.dto;

import org.springframework.stereotype.Repository;

@Repository
public class BoardDto {
	private int num_cpu;
	private double cpu;
	private double memory_FreeData;
	private double memory_MaxData;
	
	public void setNum_cpu(int num_cpu) {
		this.num_cpu = num_cpu;
	}
	
	public void setCpu(double cpu) {
		this.cpu = cpu;
	}
	
	public void setMemory_FreeData(double memory_FreeData) {
		this.memory_FreeData = memory_FreeData;
	}
	
	public void setMemory_MaxData(double memory_MaxData) {
		this.memory_MaxData = memory_MaxData;
	}
	
	public int getNum_cpu() {
		return num_cpu;
	}
	
	public double getCpu() {
		return cpu;
	}
	
	public double getMemory_FreeData() {
		return memory_FreeData;
	}
	
	public double getMemory_MaxData() {
		return memory_MaxData;
	}

}

