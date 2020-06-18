package com.kjs.common.session;

import org.apache.shiro.session.Session;
import org.apache.shiro.session.UnknownSessionException;
import org.apache.shiro.session.mgt.eis.AbstractSessionDAO;

import java.io.Serializable;
import java.util.Collection;

/**
 * Shiro的SessionDao,shiro组件,实现session的持久化
 * Created by wangsongpeng on 2016/4/18.
 */
public class ShiroSessionDao extends AbstractSessionDAO {

    private ShiroSessionRepository shiroSessionRepository;

    /**
     * 修改了Session的值
     * @param session
     * @throws UnknownSessionException
     */
    @Override
    public void update(Session session) throws UnknownSessionException {
        this.shiroSessionRepository.saveSession(session);
    }

    @Override
    public void delete(Session session) {
       if(null != session) {
            this.shiroSessionRepository.deleteSession(session.getId());
       }
    }

    @Override
    public Collection<Session> getActiveSessions() {
        return this.shiroSessionRepository.getAllSessions();
    }

    @Override
    protected Serializable doCreate(Session session) {
        Serializable sessionId =  this.generateSessionId(session);
        this.assignSessionId(session,sessionId);
        this.shiroSessionRepository.saveSession(session);
        return sessionId;
    }

    @Override
    protected Session doReadSession(Serializable sessionId) {
        return this.shiroSessionRepository.getSession(sessionId);
    }


    public ShiroSessionRepository getShiroSessionRepository() {
        return shiroSessionRepository;
    }

    public void setShiroSessionRepository(ShiroSessionRepository shiroSessionRepository) {
        this.shiroSessionRepository = shiroSessionRepository;
    }
}
