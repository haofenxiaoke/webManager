package com.kjs.common.bean.annotation;

import java.lang.annotation.ElementType;
import java.lang.annotation.Retention;
import java.lang.annotation.RetentionPolicy;
import java.lang.annotation.Target;

/**
 * @author: liuhuan
 * @Description: excel导出类字段注解
 * @date: 2019/8/8
 */
@Target(ElementType.FIELD)
@Retention(RetentionPolicy.RUNTIME)
public @interface ExcelColumn {

    /**
     *  对应excel单元格的列名
     */
    String name();



}
