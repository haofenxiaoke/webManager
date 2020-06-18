package com.kjs.web.controller.common;

import com.google.common.collect.Maps;
import com.kjs.common.bean.ParamUtil;
import com.kjs.common.bean.ResponseJsonModel;
import com.kjs.common.constant.HttpConstant;
import com.kjs.common.utils.DateUtils;
import com.kjs.common.utils.Pdf2swfUtil;
import org.apache.commons.lang.StringUtils;
import org.apache.commons.lang.time.DateFormatUtils;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import javax.imageio.ImageIO;
import javax.imageio.ImageReadParam;
import javax.imageio.ImageReader;
import javax.imageio.stream.ImageInputStream;
import javax.servlet.ServletException;
import java.awt.*;
import java.awt.image.BufferedImage;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.UUID;

/**
 * 文件上传控制器
 * 需要扩展其他文件上传的话可以增加新的方法
 * Created by lihengming on 2016/6/2.
 */
@Controller
@RequestMapping("/upload")
public class FileUploadController {
    private static final int IMAGE_FILE_MAX_SIZE = 2;//图片文件最大尺寸 单位MB.
    private static final int PDF_FILE_MAX_SIZE=50;//pdf文件不得超过50M
    private static final int SJN_IMAGE_MAX_SIZE=10;//设计牛单张图片大小不得超过10M
    private static final int SJN_RAR_MAX_SIZE=500;//设计牛压缩包大小不得超过500M
    private static final int KJS_APP_IMAGE_MAX_SIZE=1;//会计狮app轮播图、通知上传图片最大文件限制1M

    /**上传PDF文件（章节资料）
     * @param pdfFile 上文文件的name要和 input元素内name 配置一致
     * @return ResponseJsonModel
     * @throws IOException
     * @throws ServletException
     * @Date 2016年6月3日 10:04:06
     */
    @RequestMapping("/pdf")
    @ResponseBody
    public ResponseJsonModel uploadPDF(@RequestParam MultipartFile pdfFile)  {
        ResponseJsonModel model = new ResponseJsonModel();
        model.setCode(HttpConstant.ERROR_CODE);
        System.out.println(pdfFile.getContentType());
        //校验类型
        if(pdfFile.getContentType().indexOf("pdf")==-1){
            model.setMsg("上传失败，仅支持PDF类型！");
            model.setCode("500");
        }else if(pdfFile.getSize()  > (PDF_FILE_MAX_SIZE * 1024 * 1024)){
            model.setMsg("上传失败，文件大小不能超过"+PDF_FILE_MAX_SIZE+"MB！");
            model.setCode("500");
        }else{
            String dateDIR = DateUtils.dateToString(new Date(), "yyyyMMdd");

            String fileServiceRealPath = ParamUtil.imageServiceRealPath;//图片服务器磁盘目录路径 eg: /home/htdocs/static-mars/
            String fileServicePath = ParamUtil.imageServicePath;//图片服务器访问路径 eg:http://tu.so.duia.com/
            String path = ParamUtil.lecturePDF + dateDIR + "/" ;//文件分类目录路径 eg:coursePic/20160603/

            // 为上传的文件进行重命名（避免同名文件的相互覆盖）使用UUID + 文件后缀
            String suffix = pdfFile.getOriginalFilename().substring(pdfFile.getOriginalFilename().lastIndexOf("."));
            String  randomNum = UUID.randomUUID().toString();
            String fileName = randomNum + suffix ;

            File file = new File(fileServiceRealPath + path +  fileName);
            if(!file.getParentFile().exists())
                file.mkdirs();
            try {
                //将临时文件保存到磁盘
                pdfFile.transferTo(file);
                model.setCode(HttpConstant.SUCCESS_CODE);
                model.setMsg("文件上传成功！");
                HashMap<Object, Object> result = Maps.newHashMap();
                //pdf文件转换成swf文件
                String  swfDir = ParamUtil.SERVER_SWF_PATH + dateDIR + "/" +randomNum+"/";
                String fileString = fileServiceRealPath + path +  fileName;
                Pdf2swfUtil d = new Pdf2swfUtil(fileString,swfDir);
                //转换
                if(d.conver()){
                    //获取转换后的路径
                    result.put("fileLength",pdfFile.getSize());
                    result.put("swfPath", d.getShowPath(swfDir));
                    result.put("path", fileServicePath + path + fileName);
                    model.setResult(result);
                }else{
                    model.setMsg("PDF讲义上传失败，请检查讲义格式然后重新上传！");
                    model.setCode("500");
                }

            } catch (IOException e) {
                model.setMsg("上传失败,服务器内部错误:"+e.getMessage());
            }
        }

        return model;
    }

    
    @RequestMapping("/goodspdf")
    @ResponseBody
    public ResponseJsonModel uploadGoodsPDF(@RequestParam MultipartFile pdfFile)  {
        ResponseJsonModel model = new ResponseJsonModel();
        System.out.println("~~~~~~~~~~~~~~~~~~~~~~~~~~~yes");
        model.setCode(HttpConstant.ERROR_CODE);
        System.out.println(pdfFile.getContentType());
        //校验类型
        if(pdfFile.getContentType().indexOf("pdf")==-1){
            model.setMsg("上传失败，仅支持PDF类型！");
            model.setCode("500");
        }else if(pdfFile.getSize()  > (PDF_FILE_MAX_SIZE * 1024 * 1024)){
            model.setMsg("上传失败，文件大小不能超过"+PDF_FILE_MAX_SIZE+"MB！");
            model.setCode("500");
        }else{
            String dateDIR = DateUtils.dateToString(new Date(), "yyyyMMdd");

            String fileServiceRealPath = ParamUtil.imageServiceRealPath;//图片服务器磁盘目录路径 eg: /home/htdocs/static-mars/
            String fileServicePath = ParamUtil.imageServicePath;//图片服务器访问路径 eg:http://tu.so.duia.com/
            String path = ParamUtil.lecturePDF + dateDIR + "/" ;//文件分类目录路径 eg:coursePic/20160603/

//            // 为上传的文件进行重命名（避免同名文件的相互覆盖）使用UUID + 文件后缀
//            String suffix = pdfFile.getOriginalFilename().substring(pdfFile.getOriginalFilename().lastIndexOf("."));
//            String  randomNum = UUID.randomUUID().toString();
//            String fileName = randomNum + suffix ;

            //保存文件
            transferFile(pdfFile, model, fileServiceRealPath, fileServicePath, path);
        }

        return model;
    }

    /**上传设计牛资料文件
     * @param pdfFile 上文文件的name要和 input元素内name 配置一致
     * @return ResponseJsonModel
     * @throws IOException
     * @throws ServletException
     * @Date 2016年6月3日 10:04:06
     */
    @RequestMapping("/sjnImg")
    @ResponseBody
    public ResponseJsonModel uploadImgOrRar(@RequestParam MultipartFile pdfFile)  {
        ResponseJsonModel model = new ResponseJsonModel();
        model.setCode(HttpConstant.ERROR_CODE);
        //校验类型
        if(pdfFile.getContentType().indexOf("image")==-1&& pdfFile.getOriginalFilename().indexOf("rar")==-1){
            if(model.getMsg()==null ||model.getMsg().equals("")){
                model.setMsg("上传失败，仅支持图片或rar类型！");
            }
            model.setCode("500");
        }else if(pdfFile.getOriginalFilename().indexOf("rar")!=-1 && pdfFile.getSize()  > (SJN_RAR_MAX_SIZE * 1024 * 1024)){
            model.setMsg("上传失败，压缩文件大小不能超过"+SJN_RAR_MAX_SIZE+"MB！");
            model.setCode("500");
        }else if(pdfFile.getContentType().indexOf("image")!=-1 && pdfFile.getSize()  > (SJN_IMAGE_MAX_SIZE * 1024 * 1024)){
            model.setMsg("上传失败，图片文件大小不能超过"+SJN_IMAGE_MAX_SIZE+"MB！");
            model.setCode("500");
        }else{
            String dateDIR = DateUtils.dateToString(new Date(), "yyyyMMdd");

            String fileServiceRealPath = ParamUtil.imageServiceRealPath;//图片服务器磁盘目录路径 eg: /home/htdocs/static-mars/
            String fileServicePath = ParamUtil.imageServicePath;//图片服务器访问路径 eg:http://tu.so.duia.com/
            String path = ParamUtil.lecturePDF + dateDIR + "/" ;//文件分类目录路径 eg:coursePic/20160603/

            //保存文件
            transferFile(pdfFile, model, fileServiceRealPath, fileServicePath, path);

        }



        return model;
    }

    /**
     * 上传图片文件（课程图片）
     * @param imageFile 上文文件的name要和 input元素内name 配置一致
     * @return ResponseJsonModel
     * @throws IOException
     * @throws ServletException
     * @Autor 李恒名
     * @Date 2016年6月3日 10:04:06
     */
    @RequestMapping("/image")
    @ResponseBody
    public ResponseJsonModel uploadImage(@RequestParam MultipartFile imageFile,String dirName)  {
        ResponseJsonModel model = new ResponseJsonModel();
        //校验类型
        if(validateImageFile(imageFile,model)){
            String dateDIR = DateUtils.dateToString(new Date(), "yyyyMMdd");

            String fileServiceRealPath = ParamUtil.imageServiceRealPath;//图片服务器磁盘目录路径 eg: /home/htdocs/static-mars/
            String fileServicePath = ParamUtil.imageServicePath;//图片服务器访问路径 eg:http://tu.so.duia.com/
            String path;
            if(StringUtils.isNotEmpty(dirName)){
                path = dirName + "/" + dateDIR + "/";
            }else{
                path = ParamUtil.coursePictureBackPic + dateDIR + "/" ;//文件分类目录路径 eg:coursePic/20160603/
            }
            transferFile(imageFile, model, fileServiceRealPath, fileServicePath, path);
        }
        return model;
    }

    /**
     * 上传图片文件（app轮播图，通知图片）
     * @param imageFile 上文文件的name要和 input元素内name 配置一致
     * @return ResponseJsonModel
     * @throws IOException
     * @throws ServletException
     * @Date 2017年1月9日 10:04:06
     */
    @RequestMapping("/appImage")
    @ResponseBody
    public ResponseJsonModel uploadAppImage(@RequestParam MultipartFile imageFile,String dirName)  {
        ResponseJsonModel model = new ResponseJsonModel();
        //校验类型
        boolean pass = false;
        if (imageFile.getContentType().indexOf("image") == -1) {
            model.setMsg("上传失败，仅支持图片格式！");
            model.setCode(HttpConstant.ERROR_CODE);
        } else if (imageFile.getSize() > (KJS_APP_IMAGE_MAX_SIZE * 1024 * 1024)) {
            model.setCode(HttpConstant.ERROR_CODE);
            model.setMsg("上传失败，文件大小不能超过" + KJS_APP_IMAGE_MAX_SIZE + "MB！");
        } else {
            pass = true;
        }

        if(pass){
            String dateDIR = DateUtils.dateToString(new Date(), "yyyyMMdd");

            String fileServiceRealPath = ParamUtil.imageServiceRealPath;//图片服务器磁盘目录路径 eg: /home/htdocs/static-mars/
            String fileServicePath = ParamUtil.imageServicePath;//图片服务器访问路径 eg:http://tu.so.duia.com/
            String path;
            if(StringUtils.isNotEmpty(dirName)){
                path = dirName + "/" + dateDIR + "/";
            }else{
                path = ParamUtil.coursePictureBackPic + dateDIR + "/" ;//文件分类目录路径 eg:coursePic/20160603/
            }
            transferFile(imageFile, model, fileServiceRealPath, fileServicePath, path);
        }
        return model;
    }

    private boolean validateImageFile(MultipartFile imageFile,ResponseJsonModel model){
        model.setCode(HttpConstant.ERROR_CODE);
        boolean pass = false;
        //校验类型
        if (imageFile.getContentType().indexOf("image") == -1) {
            model.setMsg("上传失败，仅支持图片类型！");
        } else if (imageFile.getSize() > (IMAGE_FILE_MAX_SIZE * 1024 * 1024)) {
            model.setMsg("上传失败，文件大小不能超过" + IMAGE_FILE_MAX_SIZE + "MB！");
        } else {
            pass = true;
        }
        return pass;
    }


    private void transferFile(MultipartFile uploadFile, ResponseJsonModel model, String fileServiceRealPath, String fileServicePath, String path) {
        // 为上传的文件进行重命名（避免同名文件的相互覆盖）使用UUID + 文件后缀
        String suffix = uploadFile.getOriginalFilename().substring(uploadFile.getOriginalFilename().lastIndexOf("."));
        String fileName = UUID.randomUUID().toString() + suffix ;

        File file = new File(fileServiceRealPath + path +  fileName);
        if(!file.getParentFile().exists())
            file.mkdirs();
        try {
            //将临时文件保存到磁盘
            uploadFile.transferTo(file);
            model.setCode(HttpConstant.SUCCESS_CODE);
            model.setMsg("文件上传成功！");
            HashMap<Object, Object> result = Maps.newHashMap();
            result.put("path", fileServicePath + path + fileName);
            result.put("fileLength",uploadFile.getSize());
            model.setResult(result);

        } catch (IOException e) {
            model.setMsg("上传失败,服务器内部错误:"+e.getMessage());
        }
    }

    /**
     * 上传图像裁剪预览
     * @param model
     * @param imgUrl
     * @return
     */
    @RequestMapping(value = "/preview")
    public String imagePreview(Model model,String imgUrl){
        model.addAttribute("imgUrl", imgUrl);
        return "common/preview_clip";
    }

    /**
     * 上传裁剪后的图像文件
     * @param src
     * @param x
     * @param y
     * @param w
     * @param h
     * @return
     */
    @RequestMapping("/clip")
    @ResponseBody
    public ResponseJsonModel uploadClipImage(String src,int x,int y,int w,int h){
        ResponseJsonModel model = new ResponseJsonModel();
        try{
            String suffix = src.substring(src.lastIndexOf(".")+1);
            String fileName = UUID.randomUUID().toString() +"."+ suffix ;
            String dateDIR =  DateFormatUtils.format(new Date(), "yyyyMMdd");
            String dirName = "teacher/";
            String path = dirName + "/" + dateDIR + "/";
            String oldPath = src.replace(ParamUtil.imageServicePath,ParamUtil.imageServiceRealPath);
            String destPath = ParamUtil.imageServiceRealPath + path +  fileName;
            cutImage(oldPath,destPath,x,y,w,h);
            model.setResult(ParamUtil.imageServicePath+path+fileName);
        }catch (Exception e){
            e.printStackTrace();
        }

        return model;
    }


    /**
     * 图片裁剪通用接口
     * src：图片位置，dest：图片保存位置
     * 若要覆盖原图片，只需src == dest即可
     * @param src
     * @param dest
     * @param x
     * @param y
     * @param w
     * @param h
     * @throws IOException
     */
    public void cutImage(String src,String dest,int x,int y,int w,int h) throws IOException{

        File srcImg =new File(src);
        //获取后缀名
        String suffix = srcImg.getName().substring(srcImg.getName().lastIndexOf(".") + 1);
        //根据不同的后缀获取图片读取器
        Iterator iterator = ImageIO.getImageReadersBySuffix(suffix);
        ImageReader reader = (ImageReader)iterator.next();

        InputStream in=new FileInputStream(src);
        ImageInputStream iis = ImageIO.createImageInputStream(in);

        reader.setInput(iis, true);
        ImageReadParam param = reader.getDefaultReadParam();

        //设置裁剪位置
        Rectangle rect = new Rectangle(x, y, w,h);
        param.setSourceRegion(rect);

        //保存裁剪后的图片
        BufferedImage bi = reader.read(0,param);
        ImageIO.write(bi, suffix, new File(dest));
    }
}
