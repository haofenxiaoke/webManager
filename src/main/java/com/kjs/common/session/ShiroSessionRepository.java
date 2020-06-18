package com.kjs.common.session;
import org.apache.shiro.session.Session;
import java.io.Serializable;
import java.util.Collection;

/**
 * Shiro session仓库接口,定义了如何将
 * Shiro session 放入到 仓库的方法
 * 以及Shiro session的管理
 * Created by wangsongpeng on 2016/4/18.
 */
public interface ShiroSessionRepository {
    void saveSession(Session session);

    void deleteSession(Serializable sessionId);

    Session getSession(Serializable sessionId);

    Collection<Session> getAllSessions();
}
