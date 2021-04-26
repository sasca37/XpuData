package com.gpu.nipa.board.dao;

import java.util.List;

import javax.annotation.Resource;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.gpu.nipa.board.dto.BoardDto;
import com.gpu.nipa.board.form.BoardForm;

@Repository
public class BoardDao {
    @Resource(name = "sqlSession")
    private SqlSession sqlSession;

    private static final String NAMESPACE = "com.gpu.nipa.BoardMapper";

    public List<BoardDto> getBoardList(BoardForm boardForm) throws Exception {
        return sqlSession.selectList(NAMESPACE + ".getBoardList", boardForm);
    }

	public BoardForm getCpu(BoardForm boardForm) throws Exception{
		
		return sqlSession.selectOne(NAMESPACE + ".getCpu", boardForm);
	}
    
}

