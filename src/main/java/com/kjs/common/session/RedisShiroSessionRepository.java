package com.kjs.common.session;

import com.kjs.common.constant.SessionConstant;
import com.kjs.common.exception.session.RedisSessionException;
import org.apache.shiro.session.Session;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.data.redis.core.ValueOperations;

import java.io.Serializable;
import java.util.Collection;
import java.util.concurrent.TimeUnit;

/**
 * Redis Shiro-session仓库
 * 实现了shiro-session 持久化到redis中
 * Created by wangsongpeng on 2016/4/18.
 */
public class RedisShiroSessionRepository implements ShiroSessionRepository{
    private static final Logger logger = LoggerFactory.getLogger(RedisShiroSessionRepository.class);

    private String keyPrefix = SessionConstant.REDIS_SESSION_KEY_PREFIX;//redis中sessionKey前缀

    private RedisTemplate redisTemplate;

    /**
     * 持久化session到redis中
     * @param session
     */
    @Override
    public void saveSession(Session session) {
       try {
           if(null == session || null ==  session.getId()){
               throw new NullPointerException("session 为空");
           }
           ValueOperations uvd  =this.getRedisTemplate().opsForValue();
           String sid = buildReidSessionKey(session.getId());
           uvd.set(sid,session);
           this.redisTemplate.expire(sid,session.getTimeout(),TimeUnit.MILLISECONDS);
       }catch (Exception e){
           logger.error("保存Session时出现异常!:",e);
           throw new RedisSessionException("保存session异常,session信息"+session,e);
       }

    }

    /**
     * 根据sessionId删除redis中的session
     * @param sessionId
     */
    @Override
    public void deleteSession(Serializable sessionId) {
        try {
            if(null ==sessionId){
                throw new NullPointerException("sessionID 为空");
            }
            String sid = buildReidSessionKey(sessionId);
            if(!this.redisTemplate.hasKey(sid)){
                //如果不存在当前session Key
                logger.warn("删除:sessionID不存在:"+sessionId);
            }else{
                this.redisTemplate.delete(sid);
            }
        }catch (Exception e){
            logger.error("删除Session时出现异常!:",e);
            throw new RedisSessionException("删除session异常,sessionId:"+sessionId,e);
        }
    }

    /**
     * 根据sessionId获取session对象
     * @param sessionId
     * @return
     */
    @Override
    public Session getSession(Serializable sessionId) {
        Session session = null;
        try {
            if(null ==sessionId){
                throw new NullPointerException("sessionID 为空");
            }
            String sid = buildReidSessionKey(sessionId);
            if(!this.redisTemplate.hasKey(sid)){
                //如果不存在当前session Key
                logger.warn("获取:sessionID不存在:"+sessionId);
            }else{
               session  =  (Session) this.redisTemplate.opsForValue().get(sid);
            }
        }catch (Exception e){
            logger.error("删除Session时出现异常!:",e);
            throw new RedisSessionException("删除session异常,sessionId:"+sessionId,e);
        }
        return session;
    }

    /**
     * 获取所有的session
     * @return
     */
    @Override
    public Collection<Session> getAllSessions() {
        return null;
    }

    /**
     * 创建redis Session Key
     */
    private String buildReidSessionKey(Serializable sessionId){
      return  this.keyPrefix+sessionId;
    }


    public RedisTemplate getRedisTemplate() {
        return redisTemplate;
    }

    public void setRedisTemplate(RedisTemplate redisTemplate) {
        this.redisTemplate = redisTemplate;
    }

    public String getKeyPrefix() {
        return keyPrefix;
    }

    public void setKeyPrefix(String keyPrefix) {
        this.keyPrefix = keyPrefix;
    }
}
