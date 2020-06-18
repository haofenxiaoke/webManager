package com.kjs.web.controller.LeTV;

import com.kjs.common.bean.ParamUtil;
import com.kjs.common.bean.ResponseJsonModel;
import com.kjs.common.utils.CcDevloperV2;
import com.kjs.common.utils.LetvCloudV1;
import org.json.JSONObject;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

/**
 * Created by admin on 2016/3/22.
 */
@Controller
@RequestMapping("/letv")
public class LetvVideoController{
    @ResponseBody
    @RequestMapping(value = "/validate")
    public  String checkVideo(Integer videoId){
        try{
            LetvCloudV1 client = new LetvCloudV1(ParamUtil.letvUserUnique, ParamUtil.letvSecretKey);
            String response4 = client.videoGet(videoId);
            System.out.println(response4);
            return response4;
        }catch (Exception e){
            JSONObject json = new JSONObject();
            json.put("code","-1");
            json.put("message","系统发生异常，请刷新重试！");
            return json.toString();
        }
    }

    @ResponseBody
    @RequestMapping(value = "/cc/validate")
    public ResponseJsonModel checkVideoByCC(String videoId){
        ResponseJsonModel model=new ResponseJsonModel() ;
        try{
            model.setResult(new CcDevloperV2().videoGet(videoId));
            System.out.println(model);
        }catch (Exception e){
            model.setCode("-1");
            model.setMsg("系统发生异常，请刷新重试！");
        }
        return model;
    }

}
