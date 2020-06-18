package com.kjs.common.utils.excel;

import com.kjs.common.bean.annotation.ExcelBean;
import com.kjs.common.bean.annotation.ExcelColumn;
import org.apache.poi.hssf.usermodel.*;
import org.apache.poi.hssf.util.HSSFColor;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.util.CollectionUtils;

import java.io.IOException;
import java.lang.reflect.Field;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

/**
 * @author: liuhuan
 * @Description: excel导出功能工具类
 * @date: 2019/8/8
 */
public class ExcelUtils {

    private static Logger logger = LoggerFactory.getLogger(ExcelUtils.class);
    /**
     * @Author liuhuan
     * @Description 创建excel表
     * @Date  2019/08/08
     * @Param [list]
     * @return org.apache.poi.hssf.usermodel.HSSFWorkbook
     **/
    public static HSSFWorkbook CreateExcel(List<? extends BaseExcel> list) throws IOException {
        if(CollectionUtils.isEmpty(list)){
            return null;
        }
        //创建HSSFWorkbook对象(excel的文档对象)
        HSSFWorkbook wb = new HSSFWorkbook();
        String sheetName = list.get(0).getClass().getAnnotation(ExcelBean.class).sheetName();
        creatSheet(wb,sheetName,list);
        return wb;
    }

    /**
     * @Author liuhuan
     * @Description 创建sheet表
     * @Date  2019/08/08
     * @Param [wb, sheetName, list]
     * @return org.apache.poi.hssf.usermodel.HSSFWorkbook
     **/
    public static HSSFWorkbook creatSheet(HSSFWorkbook wb,String sheetName,List<? extends BaseExcel> list){

        //建立新的sheet对象（excel的表单）
        HSSFSheet sheet = wb.createSheet(sheetName);
        //在sheet里创建第一行
        HSSFRow row=sheet.createRow(0);
        // 获取需要导出的字段列表
        List<Field> fields = getEffectiveFields(list.get(0).getClass());
        //设置单元格样式
        HSSFCellStyle styleTitle = creatStyle(wb, "宋体", 12, HSSFCellStyle.ALIGN_CENTER,false,true);
        for (int i = 0; i < fields.size(); i++) {
            sheet.autoSizeColumn(i);
            // 解决自动设置列宽中文失效的问题
            sheet.setColumnWidth(i, sheet.getColumnWidth(i) * 17 / 10);
            // 创建单元格
            HSSFCell cellTitle=row.createCell(i);
            // 设置单元格样式
            cellTitle.setCellStyle(styleTitle);
            // 获取字段ExcelColumn注解的name值
            String name = fields.get(i).getAnnotation(ExcelColumn.class).name();
            //设置单元格内容
            cellTitle.setCellValue(name);
        }
        try {
            // 外循环，遍历出需要导出的数据
            for (int i = 0; i < list.size(); i++) {
                // 创建出第二、三、四.....行
                HSSFRow contentRow=sheet.createRow(i+1);
                BaseExcel excel = list.get(i);
                // 内循环，循环创建出单元格，将对象的值填入excel中
                for (int j = 0; j < fields.size(); j++) {
                    // 创建出单元格
                    HSSFCell rowCell = contentRow.createCell(j);
                    // 取出对象对应的字段
                    Field contentField = excel.getClass().getDeclaredField(fields.get(j).getName());
                    // 设置通行
                    contentField.setAccessible(true);
                    // 取值
                    Object o = contentField.get(excel);
                    // 日期处理
                    if(null == o){
                        rowCell.setCellValue("");
                        continue;
                    }
                    if(o instanceof Date){
                        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
                        String format = dateFormat.format(o);
                        rowCell.setCellValue(format);

                    }else{
                        rowCell.setCellValue(String.valueOf(o));
                    }
                }
            }
        } catch (Exception e) {
            logger.error(e.getMessage(),e );
        }
        return wb;
    }

    /**
     * @Author liuhuan
     * @Description 设置单元格样式
     * @Date  2019/08/08
     * @Param [wb, fontName, fontHeightInPoints, alignment, border, boldweight]
     * @return org.apache.poi.hssf.usermodel.HSSFCellStyle
     **/
    public static HSSFCellStyle creatStyle(HSSFWorkbook wb, String fontName, int fontHeightInPoints, short alignment, boolean border, boolean boldweight){

        //设置内容字体
        HSSFFont fontContent = wb.createFont();
        if (boldweight){
            // 字体加粗
            fontContent.setBoldweight(HSSFFont.BOLDWEIGHT_BOLD);
        }
        fontContent.setFontName(fontName);
        fontContent.setFontHeightInPoints((short) fontHeightInPoints);
        //创建内容样式
        HSSFCellStyle styleContent = wb.createCellStyle();
        styleContent.setFont(fontContent);
        styleContent.setWrapText(true);
        styleContent.setAlignment(alignment);
        styleContent.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);
        if (border){
            styleContent.setBorderBottom(HSSFCellStyle.BORDER_THIN);
            styleContent.setBottomBorderColor(HSSFColor.BLACK.index);
            styleContent.setBorderLeft(HSSFCellStyle.BORDER_THIN);
            styleContent.setLeftBorderColor(HSSFColor.BLACK.index);
            styleContent.setBorderRight(HSSFCellStyle.BORDER_THIN);
            styleContent.setRightBorderColor(HSSFColor.BLACK.index);
            styleContent.setBorderTop(HSSFCellStyle.BORDER_THIN);
            styleContent.setTopBorderColor(HSSFColor.BLACK.index);
        }
        return styleContent;
    }

    /**
     * @Author liuhuan
     * @Description 获取类的所有标注了ExcelColumn私有字段
     * @Date  2019/08/08
     * @Param [clazz]
     * @return java.util.List<java.lang.reflect.Field>
     **/
    public static List<Field> getEffectiveFields(Class<? extends BaseExcel> clazz) {
        List<Field> resultList = new ArrayList<Field>();
        Field[] fields = clazz.getDeclaredFields();
        for (Field field : fields) {
            if (null != field.getAnnotation(ExcelColumn.class)) {
                resultList.add(field);
            }
        }
        return resultList;
    }
}
