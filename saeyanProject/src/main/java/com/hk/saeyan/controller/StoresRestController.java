package com.hk.saeyan.controller;

import org.apache.ibatis.annotations.Param;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.hk.saeyan.dto.Members;
import com.hk.saeyan.service.MainService;

@RestController
public class StoresRestController {

	@Autowired
	MainService mainService;
	
	@RequestMapping(path="/likeStore", method=RequestMethod.POST, produces=MediaType.APPLICATION_JSON_VALUE)
	public int likeStore(@RequestParam("id") String id, @RequestParam("snum") String snum) {
		System.out.println("관심점포ajax");
		System.out.println("snum은"+snum);
		return mainService.likeStore(id, snum);
	}
}
