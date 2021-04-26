package com.gpu.nipa.board.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.gpu.nipa.board.dto.BoardDto;
import com.gpu.nipa.board.form.BoardForm;
import com.gpu.nipa.board.service.BoardService;

@Controller
@RequestMapping(value = "/board")
public class BoardController {
    @Autowired
    BoardService boardService;

    @RequestMapping(value = "/getBoardList")
    @ResponseBody
    public List<BoardDto> getBoardList(HttpServletRequest request, HttpServletResponse response, BoardForm boardForm) throws Exception {
        List<BoardDto> list = boardService.getBoardList(boardForm);
        return list;
    }
    
    @RequestMapping(value = "/getCpu")
    @ResponseBody
    public BoardForm getCpu(HttpServletRequest request, HttpServletResponse response, BoardForm boardForm) throws Exception {
    	
    	return boardService.getCpu(boardForm);
    }
    
}

