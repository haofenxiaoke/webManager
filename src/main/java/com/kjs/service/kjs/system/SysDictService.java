package com.kjs.service.kjs.system;

import com.kjs.common.utils.SortUtils;
import com.kjs.orm.mapper.SysDictMapper;
import com.kjs.orm.model.SysDict;
import com.kjs.service.core.BaseService;
import com.kjs.service.kjs.system.spi.ISysDictService;
import org.springframework.stereotype.Service;
import org.springframework.util.CollectionUtils;

import javax.annotation.Resource;
import java.util.HashMap;
import java.util.List;
import java.util.Map;


/**
 * Service Implementation:SysDic
 * @author duia_builder
 * @date 2016-5-23
 */
@Service
public class SysDictService extends BaseService<SysDict,Long> implements ISysDictService {
    @Resource
    private SysDictMapper sysDictDao;
    @Override
    public  Map queryAllDicts() {
        Map dictMap = new HashMap();
        SysDict sysDict = new SysDict();
        sysDict.setType(1);
        List<SysDict> dictList = this.sysDictDao.search(sysDict);
        if(!CollectionUtils.isEmpty(dictList))
        {
            SortUtils.sortTheList(dictList, "id", SortUtils.SORT_ORDER_ASC);
            for(SysDict dict:dictList){
                int index = dictList.indexOf(dict)+1;
                dictMap.put("id"+index,dict.getId());
                dictMap.put("hot"+index,dict.getContent());
            }
        }
        return dictMap;
    }

    @Override
    public void deleteObj(Integer type) {
        this.sysDictDao.deleteObj(type);
    }
}
