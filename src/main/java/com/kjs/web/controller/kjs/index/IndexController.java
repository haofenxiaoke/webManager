package com.kjs.web.controller.kjs.index;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;


/**
 * 首页控制器
 * Created by wangsongpeng on 2015/11/10.
 */
@Controller
public class IndexController {


    @RequestMapping(value = "/")
    public String index(){
    	System.out.println("123~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~");
        return "index/index";
    }
}
