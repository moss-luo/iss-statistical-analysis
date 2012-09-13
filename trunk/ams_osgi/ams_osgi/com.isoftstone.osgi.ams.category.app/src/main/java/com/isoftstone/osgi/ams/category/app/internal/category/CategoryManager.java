package com.isoftstone.osgi.ams.category.app.internal.category;

import java.util.List;

import org.springframework.stereotype.Service;

import com.isoftstone.osgi.ams.category.app.category.Category;
import com.isoftstone.osgi.ams.category.app.category.ICategoryManager;
@Service
public class CategoryManager implements ICategoryManager {

	@Override
	public List<Category> list() throws Exception{
		System.out.println("category manager");
		return null;
	}
	
}
