package com.gpu.nipa.xpu.dao;

import java.util.List;

import javax.annotation.Resource;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.gpu.nipa.xpu.form.XpuForm;

@Repository
public class XpuDao {
	@Resource(name = "sqlSession")
    private SqlSession sqlSession;
	
	private static final String NAMESPACE = "com.gpu.nipa.BoardMapper";
	
	public List<XpuForm> getXpu(XpuForm xpuForm) throws Exception{
		
		return sqlSession.selectList(NAMESPACE + ".getXpu", xpuForm);
	}
}
