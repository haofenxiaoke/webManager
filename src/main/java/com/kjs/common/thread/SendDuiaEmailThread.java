package com.kjs.common.thread;

import com.kjs.common.utils.EmailUtils;
import com.kjs.orm.model.AuthorityUsers;

/**发送对啊263邮箱的线程执行对象
 * Created by wangsongpeng on 2016/3/30.
 */
public class SendDuiaEmailThread implements  Runnable{

    private AuthorityUsers user;


    public SendDuiaEmailThread(){

    }

    public SendDuiaEmailThread(AuthorityUsers u){
         this.user = u;
    }

    /**
     * 线程执行体
     */
    @Override
    public void run() {
        EmailUtils.sendEmpDuiaEmail(user);//发送对啊员工密码邮箱
    }
}
