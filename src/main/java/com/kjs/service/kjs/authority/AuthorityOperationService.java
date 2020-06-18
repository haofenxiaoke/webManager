package com.kjs.service.kjs.authority;

import com.kjs.orm.mapper.AuthorityOperationMapper;
import com.kjs.orm.mapper.AuthorityPermissionMapper;
import com.kjs.common.dto.auth.OperTreeDto;
import com.kjs.orm.model.AuthorityOperation;
import com.kjs.service.core.BaseService;
import com.kjs.service.kjs.authority.spi.IAuthorityOperationService;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.CollectionUtils;

import javax.annotation.Resource;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Service Implementation:AuthorityOperation
 * @author duia_builder
 * @date 2016-1-20
 */
@Transactional(rollbackFor=Exception.class)
@Service
public class AuthorityOperationService extends BaseService<AuthorityOperation,Long> implements IAuthorityOperationService {
    @Resource
    private AuthorityOperationMapper authorityOperationDao;
    @Resource
    private AuthorityPermissionMapper authorityPermissionDao;

    /**
     * 查询菜单下的所有操作树,并根据角色权限,对操作设置勾选状态
     * @param menuId
     * @param roleId
     * @return
     */
    @Override
    public OperTreeDto  findMenuOperByRoleID(Long menuId, Long roleId) {
        //操作默认的根级
        OperTreeDto root = new OperTreeDto(-1L,"全部操作",true);
        List<AuthorityOperation> operations = this.authorityOperationDao.getAuthOperListByMenuId(menuId);//获取所有操作
        if(!CollectionUtils.isEmpty(operations)){
            Map map = new HashMap<>();
            map.put("menuId",menuId);
            map.put("roleId",roleId);
            List<Long> operIds = this.authorityPermissionDao.getOperIdByRoleMenu(map);//获取当前角色当前菜单下的操作ID
            for(AuthorityOperation oper:operations){
                 OperTreeDto operTreeDto = new OperTreeDto();
                 operTreeDto.setId(oper.getId());
                 operTreeDto.setName(oper.getName());
                 operTreeDto.setChecked(operIds.contains(oper.getId()));
                 operTreeDto.setCode(oper.getCode());
                 operTreeDto.setParent(false);
                 root.getChildren().add(operTreeDto);
            }

        }
        return root;
    }

    /**
     * 验证菜单下操作码的唯一性
     * @param operation
     * @return
     */
    @Override
    public boolean checkOperUnique(AuthorityOperation operation) {
        return this.authorityOperationDao.checkOperUnique(operation)==0?true:false;
    }
}
