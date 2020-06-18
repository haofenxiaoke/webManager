package com.kjs.common.aop;

import com.kjs.common.bean.annotation.CleanCache;
import org.aspectj.lang.JoinPoint;
import org.aspectj.lang.annotation.AfterReturning;
import org.aspectj.lang.annotation.Aspect;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.stereotype.Component;

import javax.annotation.Resource;
import java.lang.reflect.Proxy;

/**
 * Created by 李恒名 on 2016/7/19.
 *
 * 由于前后在搭建时台包结构不一致，为了前台可以正常使用缓存，故做此切面，在更新、删除操作时刷新缓存。
 */
//@Component
//@Aspect
public class RedisCacheAspectj {
    @Resource
    private RedisTemplate redisTemplate;

    @AfterReturning("execution(* com.kjs.orm.mapper.*.delete*(..)) || execution(* com.kjs.orm.mapper.*.update*(..)) || execution(* com.kjs.orm.mapper.*.*insert*(..))|| execution(* com.kjs.orm.mapper.*.*save*(..))")
    public void cleanCache(JoinPoint jp ){
        Proxy proxy = (Proxy) jp.getThis();
        Class<?>[] interfaces = proxy.getClass().getInterfaces();
        CleanCache annotation = interfaces[0].getAnnotation(CleanCache.class);
        if(annotation !=null){
            String key = annotation.key();
            if( redisTemplate.hasKey(key)){
                redisTemplate.delete(key);
            }
        }
    }
}
