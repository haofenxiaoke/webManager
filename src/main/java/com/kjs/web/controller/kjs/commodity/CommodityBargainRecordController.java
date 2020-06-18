package com.kjs.web.controller.kjs.commodity;

import com.kjs.common.bean.DataTablePageModel;
import com.kjs.common.bean.ResponseJsonModel;
import com.kjs.common.bean.annotation.PermissionAnn;
import com.kjs.common.constant.HttpConstant;
import com.kjs.common.dto.excel.CommodityExcelDTO;
import com.kjs.common.utils.ShiroUtils;
import com.kjs.common.utils.excel.ExcelUtils;
import com.kjs.orm.model.CategoryDirection;
import com.kjs.orm.model.CategoryIndustry;
import com.kjs.service.kjs.category.spi.ICategoryDirectionService;
import com.kjs.service.kjs.category.spi.ICategoryIndustryService;
import com.kjs.service.kjs.commodity.spi.ICommodityBargainRecordService;
import com.kjs.web.serach.kjs.commodity.CommodityBargainRecordConditionBean;
import org.apache.commons.lang.StringUtils;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.InputStream;
import java.net.URLEncoder;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

/**
 * @author: liuhuan
 * @Description: 商品砍价发券记录控制层
 * @date: 2019/8/6
 */
@Controller
@RequestMapping("/commodityBargain")
public class CommodityBargainRecordController {

    Logger logger = LoggerFactory.getLogger(CommodityBargainRecordController.class);

    @Autowired
    private ICommodityBargainRecordService commodityBargainRecordService;

    @Autowired
    private ICategoryDirectionService categoryDirectionService;

    /**
     * @Author liuhuan
     * @Description 跳转到商品砍价发券记录页面
     * @Date  2019/08/06
     * @Param [model]
     * @return java.lang.String
     **/
    @PermissionAnn(menuCode = "commodity-bargain",msg = "你没有商品砍价发券记录的查询权限!")
    @GetMapping("/list")
    public String list(Model model){
        Long id = ShiroUtils.getSessionUser().getId();
        List<CategoryDirection> categoryDirections = categoryDirectionService.findByUserIdAndResourceCodeAndOperationCode(id,"commodity-bargain","view");
        model.addAttribute("categoryDirections", categoryDirections);
        return "commodity/commodityBargainRecord";
    }

    /**
     * @Author liuhuan
     * @Description 商品砍价发券记录页面数据加载
     * @Date  2019/08/06
     * @Param [model, conditionBean]
     * @return com.kjs.common.bean.ResponseJsonModel
     **/
    @PostMapping("/page")
    @ResponseBody
    public DataTablePageModel page(Model model, CommodityBargainRecordConditionBean conditionBean){
        DataTablePageModel tablePageModel = commodityBargainRecordService.buildModelBySearch(conditionBean);
        return tablePageModel;
    }

    /**
     * @Author liuhuan
     * @Description excel导出
     * @Date  2019/08/09
     * @Param [request, response, conditionBean]
     * @return void
     **/
    @PermissionAnn(menuCode = "commodity-bargain",operCode = "excel-export",msg = "你没有商品砍价发券记录的导出权限!")
    @GetMapping(value = "/exportCommodityExcel")
    public void exportVipInfoExcel(HttpServletRequest request , HttpServletResponse response, CommodityBargainRecordConditionBean conditionBean) {

        ServletOutputStream outputStream = null;
        try {
            String fileName = "商品砍价发券记录表.xls";
            String agent = request.getHeader("USER-AGENT");
            // firefox
            if(agent != null && agent.indexOf("Firefox") != -1) {
                fileName = new String(fileName.getBytes("UTF-8"),"ISO-8859-1");
            }else{// others
                fileName = URLEncoder.encode(fileName, "UTF-8");
            }
            // 设置响应头及类型
            response.setHeader("Content-Disposition", "attachment;fileName=" +
                    fileName);
            response.setContentType("application/octet-stream");
            //数据库数据查询
            List<CommodityExcelDTO> excelExportData = commodityBargainRecordService.getExcelExportData(conditionBean);
            // 初始化一些导出数据
            for (int i = 0; i < excelExportData.size(); i++) {
                CommodityExcelDTO excelDTO = excelExportData.get(i);
                excelDTO.setNum(i+1);
                excelDTO.init();
            }
            //执行刷新文件下载
            outputStream = response.getOutputStream();
            //执行导出Excel输入流结果的封装
            HSSFWorkbook workbook = ExcelUtils.CreateExcel(excelExportData);
            workbook.write(outputStream);

        }catch (Exception e){
            logger.error("商品砍价发券记录导出异常,{}",e);
        }finally {
            if (null != outputStream) {
                try {
                    outputStream.flush();
                    outputStream.close();
                } catch (IOException e) {
                    e.printStackTrace();
                }
            }
        }
    }
}
