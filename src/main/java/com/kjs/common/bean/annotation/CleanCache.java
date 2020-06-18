package com.kjs.common.bean.annotation;

import java.lang.annotation.*;

/**
 * Created by 李恒名 on 2016/7/19.
 */
@Target(ElementType.TYPE)
@Retention(RetentionPolicy.RUNTIME)
@Documented
public @interface CleanCache {
    String key();
}
