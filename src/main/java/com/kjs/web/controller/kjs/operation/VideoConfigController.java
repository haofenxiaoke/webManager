package com.kjs.web.controller.kjs.operation;

import com.kjs.common.bean.ResponseJsonModel;
import com.kjs.common.bean.annotation.PermissionAnn;
import com.kjs.common.constant.SystemConstant;
import org.apache.ibatis.annotations.Param;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

/**
 * Created by admin on 2017/7/18.
 */
@Controller
@RequestMapping("/video/config")
public class VideoConfigController {
    @Autowired
    private RedisTemplate redisTemplate;

    @PermissionAnn(menuCode = "video-config", msg = "你没有进入视频配置页面的权限！")
    @RequestMapping("/manager")
    public String list(Model model){
        Object object=redisTemplate.opsForValue().get(SystemConstant.videoConfigOption) ;
        String option=0+"";
        if (object!=null){
            option=String.valueOf(object);
        }
        model.addAttribute("option",option);
        return "/videoConfig/video-config";
    }

    @RequestMapping("/update")
    @ResponseBody
    public ResponseJsonModel update(@Param("option") String option){
        redisTemplate.opsForValue().set(SystemConstant.videoConfigOption,option);
        ResponseJsonModel model = new ResponseJsonModel();
        model.setCode("200");
        model.setResult("配置成功");
        return model;
    }
}
