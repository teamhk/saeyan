package com.hk.saeyan.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.hk.saeyan.dto.Product;
import com.hk.saeyan.service.MainService;

@Controller
@RequestMapping("/main")
public class MainController {

	@Autowired
	MainService mainService;
	
	@GetMapping("/price")
	public String price(Product product,Model model) {
		
		model.addAttribute("price",mainService.price());
		return "main/price";
	}
	
		
		
	
	
}
