package com.kjs.service.kjs.authority;

import com.kjs.orm.model.AuthorityUserActionState;
import com.kjs.service.core.BaseService;
import com.kjs.service.kjs.authority.spi.IAuthorityUserActionStateService;
import org.springframework.stereotype.Service;

/**
 * Service Implementation:AuthorityUserActionState
 * @author duia_builder
 * @date 2016-5-23
 */
@Service
public class AuthorityUserActionStateService extends BaseService<AuthorityUserActionState,Long> implements IAuthorityUserActionStateService {
}
