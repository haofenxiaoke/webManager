package com.kjs.common.bean.annotation;

import java.lang.annotation.ElementType;
import java.lang.annotation.Retention;
import java.lang.annotation.RetentionPolicy;
import java.lang.annotation.Target;

/**
 * @author: liuhuan
 * @Description: excel导出类注解
 * @date: 2019/8/8
 */
@Target(ElementType.TYPE)
@Retention(RetentionPolicy.RUNTIME)
public @interface ExcelBean {

    /**
     *  sheet的名称
     */
    String sheetName();

}
