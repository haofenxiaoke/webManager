package com.kjs.service.kjs.voucher;

import com.kjs.service.core.BaseService;
import com.kjs.orm.model.Voucher;
import org.springframework.stereotype.Service;
import com.kjs.service.kjs.voucher.spi.IVoucherService;

/**
 * Service Implementation:Voucher
 * @author kjs_builder
 * @date 2016-8-25
 */
@Service
public class VoucherService extends BaseService<Voucher,Long> implements IVoucherService {
}
