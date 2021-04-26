package com.gpu.nipa.board.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.gpu.nipa.board.dao.BoardDao;
import com.gpu.nipa.board.dto.BoardDto;
import com.gpu.nipa.board.form.BoardForm;

@Service
public class BoardService {
    @Autowired
    private BoardDao boardDao;

    public List<BoardDto> getBoardList(BoardForm boardForm) throws Exception {
        return boardDao.getBoardList(boardForm);
    }
    
    public BoardForm getCpu(BoardForm boardForm) throws Exception {
    		
    	return boardDao.getCpu(boardForm); 
    }
    
}

