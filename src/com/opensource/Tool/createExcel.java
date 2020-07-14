package com.opensource.Tool;

import java.io.File;
import java.io.IOException;
import java.lang.reflect.Field;
import java.lang.reflect.Method;
import java.text.SimpleDateFormat;
import java.util.List;
import java.util.ArrayList;
import java.util.Date;

import jxl.Cell;
import jxl.Sheet;
import jxl.Workbook;
import jxl.read.biff.BiffException;
import jxl.write.Label;
import jxl.write.WritableSheet;
import jxl.write.WritableWorkbook;
import jxl.write.WriteException;
public class createExcel {
	/**
     * 将list集合转成Excel文件
     * @param list  对象集合
     * @param path  输出路径
     * @return   返回文件路径
     */
	public static String getExcel(List<? extends Object> list,String path){
        String result = "";
        if(list.size()==0||list==null){
            result = "没有对象信息";
        }else{
            Object o = list.get(0);
            Class<? extends Object> clazz = o.getClass();
            String className = clazz.getSimpleName();
            Field[] fields=clazz.getDeclaredFields();    //这里通过反射获取字段数组
            File folder = new File(path);
            if(!folder.exists()){
                folder.mkdirs();
            }
            SimpleDateFormat formatdate =new SimpleDateFormat("yyyyMMdd-HHmmssSSS" );
            Date date= new Date();
            String fileName = formatdate.format(date);;
            String name = fileName.concat(".xls");
            WritableWorkbook book = null;
            File file = null;
            try {
                file = new File(path.concat(File.separator).concat(name));
                book = Workbook.createWorkbook(file);  //创建xls文件
                WritableSheet sheet  =  book.createSheet(className,0);
                int i = 0;  //列
                int j = 0;  //行
                for(Field f:fields){
                	sheet.addCell(new Label(0, 0, "许可证名"));
                    sheet.addCell(new Label(1, 0, "简称"));
                    sheet.addCell(new Label(2, 0, "类型"));
                    sheet.addCell(new Label(3, 0, "摘要"));
                    sheet.addCell(new Label(4, 0, "权利"));
                    sheet.addCell(new Label(5, 0, "义务"));
                    sheet.addCell(new Label(6, 0, "禁止"));
                    sheet.addCell(new Label(7, 0, "源地址"));
                    sheet.addCell(new Label(8, 0, "拥有者"));
                   // j = 1;
                   // Label label = new Label(i, j,f.getName());   //这里把字段名称写入excel第一行中
                   // sheet.addCell(label);
                    j = 1;
                    for(Object obj:list){
                        Object temp = getFieldValueByName(f.getName(),obj);
                        String strTemp = "";
                        if(temp!=null){
                            strTemp = temp.toString();
                        }
                        sheet.addCell(new Label(i,j,strTemp));  //把每个对象此字段的属性写入这一列excel中
                        j++;
                    }
                    i++;
                }
                book.write();
                result = file.getPath();
            } catch (Exception e) {
                // TODO Auto-generated catch block
                result = "SystemException";
                e.printStackTrace();
            }finally{
                fileName = null;
                name = null;
                folder = null;
                file = null;
                if(book!=null){
                    try {
                        book.close();
                    } catch (WriteException e) {
                        // TODO Auto-generated catch block
                        result = "WriteException";
                        e.printStackTrace();
                    } catch (IOException e) {
                        // TODO Auto-generated catch block
                        result = "IOException";
                        e.printStackTrace();
                    }
                }
            }

        }
        return result;   //最后输出文件路径
    }
    private static Object getFieldValueByName(String fieldName, Object o) {
        try {
            String firstLetter = fieldName.substring(0, 1).toUpperCase();    
            String getter = "get" + firstLetter + fieldName.substring(1);    //获取方法名
            Method method = o.getClass().getMethod(getter, new Class[] {});  //获取方法对象
            Object value = method.invoke(o, new Object[] {});    //用invoke调用此对象的get字段方法
                return value;  //返回值
        } catch (Exception e) {
            e.printStackTrace();
            return null;    
        }    
    }
    public static boolean deleteFile(String fileName) {
        File file = new File(fileName);
        // 如果文件路径所对应的文件存在，并且是一个文件，则直接删除
        if (file.exists() && file.isFile()) {
            if (file.delete()) {
                System.out.println("删除单个文件" + fileName + "成功！");
                return true;
            } else {
                System.out.println("删除单个文件" + fileName + "失败！");
                return false;
            }
        } else {
            System.out.println("删除单个文件失败：" + fileName + "不存在！");
            return false;
        }
    }
    
    public static List<List> readExcel(String type,String admin,String filename) throws BiffException, IOException
    {
		long time = System.currentTimeMillis();
		SimpleDateFormat simple = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
    	List<List> alldata=new ArrayList<List>();
        Workbook book = Workbook.getWorkbook(new File(filename));
        Sheet sheet = book.getSheet(0);
        //for (int i = 0; i < sheets.length; i++) {// 进入sheet
            int rows = sheet.getRows();
            int cols = sheet.getColumns();
            System.out.println("rows:"+rows+",cols:"+cols);
            for (int i = 1; i < rows; i++) {
                    List <String> datalist=new ArrayList<String>();//将每一行的数据添加到list中
                    for(int j=0;j<cols;j++)
                    {
                		Cell c2 = sheet.getCell(j,i);
                		String temp = c2.getContents();
                        datalist.add(temp);
                    }
                    if(type.equals("fqa"))
                    {
	                    datalist.add(admin);
	                    datalist.add(simple.format(time).toString());
                    }
                    else if(type.equals("license"))
                    {
                    	System.out.println("type=license");
                    	datalist.add(admin);
                    }
                    else if(type.equals("article"))
                    {
                    	datalist.add(admin);
	                    datalist.add(simple.format(time).toString());
                    }
                    alldata.add(datalist);
                }
           // }
	        System.out.println("alldata.size:"+alldata.size());
	        book.close();
        //}
		return alldata;
    }
}