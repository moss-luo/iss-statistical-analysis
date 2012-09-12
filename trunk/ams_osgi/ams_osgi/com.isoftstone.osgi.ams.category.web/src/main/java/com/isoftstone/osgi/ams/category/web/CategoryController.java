package com.isoftstone.osgi.ams.category.web;

import javax.annotation.Resource;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.isoftstone.osgi.ams.category.app.category.ICategoryManager;

@Controller
@RequestMapping
public class CategoryController {
	
	@Resource
	private ICategoryManager manager;
	
	@RequestMapping
	public void list(){
		System.out.println("web");
		manager.list();
	}
}
