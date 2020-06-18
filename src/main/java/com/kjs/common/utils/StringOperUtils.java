package com.kjs.common.utils;

import org.apache.commons.lang.StringUtils;

import java.io.IOException;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

public class StringOperUtils extends StringUtils {

    public static boolean validateEmail(String email) {
        String check = "^([a-z0-9A-Z]+[-|\\.]?)+[a-z0-9A-Z]@([a-z0-9A-Z]+(-[a-z0-9A-Z]+)?\\.)+[a-zA-Z]{2,}$";
        if (!email.matches(check)) {
            return false;
        }
        if (StringUtils.isBlank(email)) {
            return false;
        }
        return true;
    }

    public static String delHtmlTag(String content) {
        if (isNotBlank(content)) {
            String regEx = "<[^>]+>";
            Pattern p = Pattern.compile(regEx);
            Matcher m = p.matcher(content);
            String result = content;
            if (m.find()) {
                result = m.replaceAll("");
            }
            return result;
        } else {
            return "";
        }
    }

    public static String findKeyWord(String content, String key) {
        String result = "";
        if (isNotBlank(content)) {
            int intPos = content.indexOf("?");
            String str = content.substring(intPos + 1);
            String[] temp = str.split("&");
            for (String i : temp) {
                if (i.startsWith(key)) {
                    int intPosTemp = i.indexOf("=");
                    if (i.substring(0, intPosTemp).length() == 1) {
                        result = i.substring(intPosTemp + 1);
                    }
                }
            }
            return result;
        }
        return result;
    }

    public static String findWebSite(String content) {
        String result = "首次首页注册";
        if (isNotBlank(content)) {
            Pattern p = Pattern.compile("(?<=//|)((\\w)+\\.)+\\w+");
            Matcher m = p.matcher(content);
            if (m.find()) {
                result = m.group();
            }
        }
        if ("www.kjs.com".equals(result) || "kjs.com".equals(result)) {
            result = result + " (收藏/手工输入)";
        }
        return result;
    }

    /**
     * 字符转ASC
     *
     * @param st
     * @return
     */
    public static int getAsc(String st) {
        byte[] gc = st.getBytes();
        int ascNum = (int) gc[0];
        return ascNum;
    }

    /**
     * ASC转字符
     *
     * @param backnum
     * @return
     */
    public static char backChar(int backnum) {
        char strChar = (char) backnum;
        return strChar;
    }

    /**
     * 上下百分之五的评估值最小值
     *
     * @param dou
     * @return
     */
    public static int percentMin(Double dou) {
        Double min = 0d;
        Double floatScore = 2d;
        Double minScore = dou - floatScore;
        if (minScore < min) {
            return min.intValue();
        }
        return minScore.intValue();
    }

    /**
     * 上下百分之五的评估值最大值
     *
     * @param dou
     * @return
     */
    public static int percentMax(Double dou) {
        Double max = 100d;
        Double floatScore = 2d;
        Double maxScore = dou + floatScore;
        if (maxScore > max) {
            return max.intValue();
        }
        return maxScore.intValue();
    }

    public static int percentAssess(Double dou) {
        if (dou >= 95d) {
            return 0;
        } else if (80d <= dou && dou <= 94d) {
            return 1;
        } else if (60d <= dou && dou <= 79d) {
            return 2;
        } else if (59d >= dou) {
            return 3;
        }
        return 4;
    }

    public static String stageSection(Integer countNum) {
        if (countNum == 1) {
            return "one";
        } else if (2 <= countNum && countNum <= 5) {
            return "two";
        } else if (6 <= countNum && countNum <= 10) {
            return "three";
        } else if (11 <= countNum && countNum <= 30) {
            return "four";
        } else if (countNum >= 30) {
            return "five";
        }
        return null;
    }

    /**
     * 拼接字符串
     *
     * @param str       要拼接的字符串数组
     * @param delimiter 分隔符
     * @return
     */
    public static String joinStr(String[] str, String delimiter) {
        String strs = "";
        if (str != null && str.length > 0) {
            for (int i = 0; i < str.length; i++) {
                strs += str[i].trim() + delimiter;
            }
            strs = strs.substring(0, strs.length() - 1);
            return strs;
        }
        return null;
    }

    /**
     * 字符串反转
     *
     * @param s
     */
    public static String reverse(String s) {
        int length = s.length();
        if (length <= 1)
            return s;
        String left = s.substring(0, length / 2);
        String right = s.substring(length / 2, length);
        return reverse(right) + reverse(left);
    }

    private static String htmlEncode(char c) {
        switch (c) {
            case '&':
                return "&amp;";
            case '<':
                return "&lt;";
            case '>':
                return "&gt;";
            case '"':
                return "&quot;";
            case ' ':
                return "&nbsp;";
            default:
                return c + "";
        }
    }

    /**
     * 对传入的字符串str进行Html encode转换
     */

    public static String htmlEncode(String str) {
        if (str == null || str.trim().equals("")) return str;
        StringBuilder encodeStrBuilder = new StringBuilder();
        for (int i = 0, len = str.length(); i < len; i++) {
            encodeStrBuilder.append(htmlEncode(str.charAt(i)));
        }
        return encodeStrBuilder.toString();
    }

    /**
     * 将传入的英文括号转化成中文括号
     * @param str 文件名字符串
     * @return
     */
    public static String replaceBracketsEToC(String str){
        if(str == null)
            return "";
        return str.replace("(","（").replace(")","）");
    }


    public static void main(String[] args) throws IOException {
        String sa = "1_2";
        String[] b=sa.split("_");
        System.out.println(b.length);
    }
}
