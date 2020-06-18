package com.kjs.common.utils;

/**
 * Created by zhenghui on 2016/6/20.
 */
//比较器类
public class ComparatorUtil implements java.util.Comparator<String> {
    public int compare(String str1, String str2) {
        return str1.compareTo(str2);
    }
}
