package com.kjs.common.utils;

import com.github.kevinsawicki.http.HttpRequest;
import com.google.gson.Gson;
import org.apache.commons.codec.digest.DigestUtils;

import java.net.URLEncoder;
import java.util.Arrays;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;


public class CcDevloperV2 {
    private String userid = "83A12B9E94EB4438";
    private String restUrl = "http://spark.bokecc.com/api/video";
    public String format = "json";
    private String salt = "vi2YxND1LJlGqVvtvESam2j0adU0NRnM";

    /**
     * 获取单个视频信息
     * @param videoid 视频id
     * @return
     * @throws Exception
     */
    public String videoGet(String videoid) throws Exception{
        HashMap <Object, Object> params = new HashMap<Object, Object>();
        params.put("videoid", videoid+"");
        return makeRequest(params);
    }
    //构造请求串
    public String makeRequest(HashMap<Object, Object> params) throws Exception{
        //签名
        params.put("userid", this.userid);
        long time = new Date().getTime();
        params.put("format", this.format);
        params.put("hash", generateSign(params,time));
        params.put("time",String.valueOf(time));

        //构造请求URL
        String url = this.restUrl + "?" + mapToQueryString(params);
        
        System.out.println("restUrl->"+url);
        String result = HttpRequest.get(url)
                .contentType("application/json")
                .body();
        return result;
    }

    //将 map 中的参数及对应值转换为查询字符串
    private String mapToQueryString(HashMap<Object, Object> params) throws Exception{
        Object[] array = params.keySet().toArray();
        Arrays.sort(array);
        StringBuffer sbf = new StringBuffer();
        for(int i = 0; i < array.length;i++){
            String key = array[i].toString();
            sbf.append(key+"="+URLEncoder.encode((String)params.get(key),"UTF-8")+"&");
        }
        return sbf.toString();
    }
    /**
     * 构造CC视频Sign
     * @param params 业务参数
     * @return string
     * @throws Exception
     */
    public String generateSign(HashMap<Object, Object> params,Long time) throws Exception{
        Object[] array = params.keySet().toArray();
        Arrays.sort(array);
        StringBuffer sbf = new StringBuffer();
        for (int i = 0; i < array.length; i++) {
            String key = String.valueOf(array[i]);
            sbf.append(key + "=" + URLEncoder.encode((String) params.get(key), "UTF-8") + "&");
        }
        sbf.append("time" + "=" + time + "" + "&");
        sbf.append("salt" + "=" + this.salt);
        return DigestUtils.md5Hex(sbf.toString());
    }

    /**
     * 获取视频长度
     * @param videoUnique
     * @return
     */
    public String getDuration(String videoUnique){
        Integer duration = 0;
        try {
            String response4 = new CcDevloperV2().videoGet(videoUnique);
            Gson gson = new Gson();
            Map<Object, Object> map = gson.fromJson(response4, Map.class);
            Object[] objects = map.values().toArray();
            Map jsonMap =  gson.fromJson(gson.toJson(objects[0]),Map.class);
            Object[] results = jsonMap.values().toArray();
            Double d = Double.parseDouble(results[4].toString());
            duration = d.intValue();
        }catch (Exception e){
            e.printStackTrace();
        }
        return String.valueOf(duration);
    }
}
