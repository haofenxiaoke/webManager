package com.kjs.common.utils;

import org.apache.commons.beanutils.BeanComparator;
import org.apache.commons.collections.ComparatorUtils;
import org.apache.commons.collections.comparators.ComparableComparator;
import org.apache.commons.collections.comparators.ComparatorChain;
import org.apache.commons.lang.StringUtils;

import java.util.*;

/**排序工具类
 * Created by wangsongpeng on 2016/3/30.
 */
public class SortUtils {

    /**
     * 正序
     */
    public static final String SORT_ORDER_ASC = "asc";

    /**
     *  逆序
     */
    public static final String SORT_ORDER_DESC = "desc";

    /**
     * 方法名称：sortTheList
     * 内容摘要：根据指定的字段数组对List中的对象进行排序
     * @param list
     * @param sortFields
     * @param sortOrder
     */
    public static void sortTheList(List list, String[] sortFields, String sortOrder)
    {
        if(sortFields == null || sortFields.length <= 0)
        {
            return;
        }

        if(list==null || list.size()==0){
            return;
        }

        ArrayList sorts = new ArrayList();

        java.util.Comparator c = ComparableComparator.getInstance();
        c = ComparatorUtils.nullLowComparator(c);  //允许null
        if (StringUtils.equals(sortOrder, SortUtils.SORT_ORDER_DESC))
        {
            c = ComparatorUtils.reversedComparator(c); //逆序
        }

        String sortField = null ;
        for(int i=0 ; i< sortFields.length ; i++)
        {
            sortField = sortFields[i];
            if(StringUtils.isNotEmpty(sortField))
            {
                sorts.add(new BeanComparator(sortField,c));
            }
        }

        ComparatorChain multiSort = new ComparatorChain(sorts);

        Collections.sort(list, multiSort);
    }

    /**
     * 方法名称：sortTheList
     * 内容摘要：根据指定的字段对List中的对象进行排序
     * @param list
     * @param sortFiled
     * @param sortOrder
     */
    public static void sortTheList(List list, String sortFiled, String sortOrder)
    {
        if(StringUtils.isEmpty(sortFiled))
        {
            return;
        }

        if(list==null || list.size()==0){
            return;
        }

        String[] sortFields = new String[]{sortFiled};

        sortTheList(list, sortFields, sortOrder);
    }
    /**
     * 使用 Map按key进行排序
     * @param map
     * @return
     */
    public static Map<String, String> sortMapByKey(Map<String, String> map) {
        if (map == null || map.isEmpty()) {
            return null;
        }
        Map<String, String> sortMap = new TreeMap<String, String>(new ComparatorUtil(){

        });
        sortMap.putAll(map);
        return sortMap;
    }

}
