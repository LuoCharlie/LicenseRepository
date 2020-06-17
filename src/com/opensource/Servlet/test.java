package com.opensource.Servlet;

import java.io.File;
import java.util.ArrayList;
import java.util.List;

import org.junit.Test;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;

import com.opensource.Domain.downloadLicense;
import com.opensource.Domain.user;
import com.opensource.Tool.*;

public class test
{
	@Test
	public void excel()
	{
		createExcel createExcel = new createExcel();
		downloadLicense test1 = new downloadLicense();
		File excel = new File("d:\\","text.xlsx");
		List<downloadLicense> downtable=new ArrayList<>();
		test1.setName("test1");
		test1.setAbbreviation("1");
		test1.setObligation("asdasdasd");
		downtable.add(test1);
		downtable.add(test1);
		String url = com.opensource.Tool.createExcel.createExcel(downtable,"./");
		System.out.println(url);
	}
}
