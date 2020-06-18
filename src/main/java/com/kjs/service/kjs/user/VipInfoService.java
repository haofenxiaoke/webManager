package com.kjs.service.kjs.user;

import com.kjs.common.utils.RequestParamUtils;
import com.kjs.common.utils.ShiroUtils;
import com.kjs.common.utils.StringUtil;
import com.kjs.orm.mapper.VipInfoMapper;
import com.kjs.orm.model.VipInfo;
import com.kjs.service.core.BaseService;
import com.kjs.service.kjs.user.spi.IVipInfoService;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import java.util.*;


/**
 * Service Implementation:VipInfo
 * @author duia_builder
 * @date 2016-5-23
 */
@Service
public class VipInfoService extends BaseService<VipInfo,Long> implements IVipInfoService {
    @Resource
    private VipInfoMapper vipInfoDao;

    @Override
    public Map switchDataToObject(Map paramMap) {
        Map listMap = new HashMap();
        Iterator<Map.Entry<String, String>> it = paramMap.entrySet().iterator();
        while (it.hasNext()) {
            Map.Entry<String, String> entry = it.next();
            Object laststr = entry.getKey().charAt(entry.getKey().length() - 1);
            VipInfo vipInfo = new VipInfo();
            //首次赋值
            if(entry.getKey().contains("id")) vipInfo.setId(RequestParamUtils.switchToLong(entry.getValue()));
            if(entry.getKey().contains("name")) vipInfo.setPrice(RequestParamUtils.switchToInteger(entry.getValue()));
            if(listMap.containsKey(laststr)){
                vipInfo = (VipInfo)listMap.get(laststr);
                if(entry.getKey().contains("id")) vipInfo.setId(RequestParamUtils.switchToLong(entry.getValue()));
                if(entry.getKey().contains("name")) vipInfo.setPrice(RequestParamUtils.switchToInteger(entry.getValue()));
                listMap.put(laststr,vipInfo);
            }else{
                listMap.put(laststr,vipInfo);
            }
        }
        return  listMap;
    }

    @Override
    public List<VipInfo> queryAll() {
        return vipInfoDao.queryAll();
    }

    @Override
    public void saveEmp(Map<String, VipInfo> map) {
        if(map!=null && map.size()>0){
            Date now = new Date();
            Integer userid = ShiroUtils.getSessionUser().getId().intValue();
            for (Map.Entry entry : map.entrySet()) {
                VipInfo vipInfo = (VipInfo)entry.getValue();
                vipInfo.setAddTime(now);
                vipInfo.setAddUserid(userid);
                if(StringUtil.isNotEmpty(vipInfo.getId())){
                    this.vipInfoDao.update(vipInfo);
                }else{
                    this.vipInfoDao.save(vipInfo);

                }
            }
        }
    }
}
