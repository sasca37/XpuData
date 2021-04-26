package com.gpu.nipa.xpu.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.gpu.nipa.xpu.dao.XpuDao;
import com.gpu.nipa.xpu.form.XpuForm;

@Service
public class XpuService {
	@Autowired
	private XpuDao xpuDao;
	
	public List<XpuForm> getXpu(XpuForm xpuForm) throws Exception {
		
		return xpuDao.getXpu(xpuForm);
	}
}
