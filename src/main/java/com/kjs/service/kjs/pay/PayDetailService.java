package com.kjs.service.kjs.pay;

import com.kjs.orm.model.PayDetail;
import com.kjs.service.core.BaseService;
import com.kjs.service.kjs.pay.spi.IPayDetailService;
import org.springframework.stereotype.Service;

@Service
public class PayDetailService extends BaseService<PayDetail,Long> implements IPayDetailService {
}
