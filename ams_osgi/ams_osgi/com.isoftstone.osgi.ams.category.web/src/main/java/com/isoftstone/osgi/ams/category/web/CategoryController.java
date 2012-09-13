package com.isoftstone.osgi.ams.category.web;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.isoftstone.osgi.ams.category.app.category.ICategoryManager;

@Controller
@RequestMapping
public class CategoryController {
	
	@Resource
	private ICategoryManager categoryManager;
	
	@RequestMapping
	public void list(){
		System.out.println("web");
		try{
			categoryManager.list();
		}catch(Exception e){
			e.printStackTrace();
		}
	}
}
