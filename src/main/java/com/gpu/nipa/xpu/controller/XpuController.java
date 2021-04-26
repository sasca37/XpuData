package com.gpu.nipa.xpu.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.gpu.nipa.xpu.form.XpuForm;
import com.gpu.nipa.xpu.service.XpuService;

@Controller
@RequestMapping(value = "/xpu")
public class XpuController {
	@Autowired
	XpuService xpuService;

	@RequestMapping(value = "/getXpu")
	@ResponseBody
    public List<XpuForm> getXpu(HttpServletRequest request, HttpServletResponse response, XpuForm xpuForm) throws Exception {
		List<XpuForm> list = xpuService.getXpu(xpuForm);
    	
    	return list;
    }
}
