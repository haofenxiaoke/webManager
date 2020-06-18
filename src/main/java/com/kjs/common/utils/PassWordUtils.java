package com.kjs.common.utils;

import java.util.Random;

/**
 * 密码工具类
 * Created by wangsongpeng on 2016/3/25.
 */
public class PassWordUtils {


    private static char[] charList = {'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k',
            'l', 'm', 'n', 'o', 'p', 'q', 'r', 's', 't', 'u', 'v', 'w', 'x', 'y', 'z','A',
            'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K',
            'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W',
            'X', 'Y', 'Z','0', '1', '2', '3', '4', '5', '6', '7', '8', '9'};//密码数组

    /**
     * 获取随机生成指定位数的密码
     * @param bit
     */
    public static  String getRandomPwd(int bit){
             Random random = new Random();//随机数对象
             StringBuilder pwd = new StringBuilder();//返回的密码
             for(int i = 0;i<bit;i++){
                 pwd.append(charList[random.nextInt(charList.length-1)]);
             }
             return pwd.toString();
    }



}
