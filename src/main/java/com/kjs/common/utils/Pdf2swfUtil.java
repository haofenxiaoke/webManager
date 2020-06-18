package com.kjs.common.utils;

import com.kjs.common.bean.ParamUtil;
import com.kjs.service.kjs.course.CourseLectureService;
import org.apache.log4j.Logger;

import java.io.*;


/**
 * 
* @ClassName: Office2swfUtil 
* @Description: office文件转换为swf文件 (office --> pdf --> swf)
* @author wangyaoshu 
* @date 2013-3-12 下午03:47:00 
*
 */
public class Pdf2swfUtil {
	private Logger logger = Logger.getLogger(CourseLectureService.class);
	private static final String SWFTOOL_WIN_PATH = ParamUtil.SWFTOOL_WIN_PATH;
	private static final String SWFTOOL_LINUX_PATH = ParamUtil.SWFTOOL_LINUX_PATH;
	private String outputPath = "";//转成swf文件的路径
	private File pdfFile;  //pdf文件路径
	private File srcFile;  //文件路径 
	private String serverPath;//服务器相对地址

	public Pdf2swfUtil(String fileString,String dateDir) {
		ini(fileString,dateDir);
	}

	/**
	 * 初始化
	 * fileString：转换文件
	 * destPath：存储绝对目录
	 * serverPath： url绝对目录
	 * @date 2013-3-14
	 */
	private void ini(String fileString,String dateDir) {
		
		srcFile = new File(fileString);
		this.outputPath = ParamUtil.imageServiceRealPath+ dateDir;
		this.pdfFile = new File(fileString);
		this.serverPath = ParamUtil.imageServicePath;
		
	}
	
	/**
	 * 
	 * @Title: pdf2swf 
	 * @Description: pdf转swf
	 * @author wangyaoshu   
	 * @date 2013-3-12 下午04:03:23  
	 * @throws Exception     
	 * @return void    返回类型
	 */
	private void pdf2swf() throws Exception {
		Runtime r = Runtime.getRuntime();
		
			if (pdfFile.exists()) {
				// windows环境处理
				if (isWindowsSystem())
				{
					try {
						String cmd_str = SWFTOOL_WIN_PATH+" "
							+ pdfFile.getPath() + " -o "+this.outputPath + File.separator +"Paper%.swf "
							+" -f -T 9 -t -s storeallcharacters";
						logger.debug("pdf2swf:"+cmd_str);
						Process p = r.exec(cmd_str);	
						loadStream(p.getInputStream());
						loadStream(p.getErrorStream());
						loadStream(p.getInputStream());
					} catch (Exception e) {
						logger.error("pdf2swf出错:"+e);
						throw e;
					}
				}else// linux环境处理
				{
					try {
						String cmd_str = SWFTOOL_LINUX_PATH+" "
						+ pdfFile.getPath() + " -o "+this.outputPath+ File.separator+"Paper%.swf ";
						logger.info("pdf2swf:"+cmd_str);
					    Process p = r.exec(cmd_str);
						loadStream(p.getInputStream());
						loadStream(p.getErrorStream());
					} catch (Exception e) {
						logger.error("pdf2swf出错:"+e);
						throw e;
					}
				}
			} else {
				logger.debug("****pdf不存在，无法转换****");
			}
		
	}
	
	static String loadStream(InputStream in) throws IOException {
		int ptr = 0;
		in = new BufferedInputStream(in);
		StringBuffer buffer = new StringBuffer();

		while ((ptr = in.read()) != -1) {
			buffer.append((char) ptr);
		}
		return buffer.toString();
	}

	/**
	 * 
	 * @Title: conver 
	 * @Description: 转换主方法 失败返回空字符串，成功返回flexpaper展示路径
	 * @author wangyaoshu   
	 * @date 2013-3-12 下午03:57:27  
	 * @return     
	 * @return boolean    返回类型
	 */
	public boolean conver() {
				   
        //源文件不存在则返回    
        if (!this.srcFile.exists()) 
        	return false;  
        //存储目录不存在，生成存储目录
		File dest = new File(outputPath);   
        if (!dest.exists()) dest.mkdirs();  
		try {
			boolean flag = false;
			if (dest.exists()){
				logger.error("目录创建成功："+outputPath);
				pdf2swf();
				if(getSwfSize() <= 0)
					return false;
				flag = true;
			}
			return flag;
		} catch (Exception e) {

			logger.error("转换出错:"+e);
			return false;
		}	

	}

	/**
	 * 
	 * @Title: getswfPath 
	 * @Description: 返回swf生成的文件目录地址
	 * @author wangyaoshu   
	 * @date 2013-3-12 下午04:13:21  
	 * @return     
	 * @return String    返回类型
	 */
	public String getswfPath() {
		//目前不做其它计算
		File file = new File(outputPath);
		return file.getPath().replaceAll("\\\\", "/");
	}
	
	/**
	 * 
	 * @Title: getSwfSize 
	 * @Description: 返回生成的swf文件个数
	 * @author wangyaoshu   
	 * @date 2013-3-11 下午02:00:36  
	 * @return     
	 * @return int    返回类型
	 */
	public int getSwfSize(){
		File dest = new File(outputPath);
		if (!dest.exists())
			return 0;
		//过滤swf文件
		File[] fileList = dest.listFiles(new FileFilter() {

			public boolean accept(File pathname) {
				return pathname.getName().endsWith(".swf");
			}
		});
		if (fileList == null)
			return 0;

		return fileList.length;
	}
	
	/**
	 * 
	 * 返回swf显示路径表达式
	 * @author wangyaoshu   
	 * @date 2013-3-14
	 */
	public String getShowPath(String dateDir){
		
		StringBuffer returnPath = new StringBuffer(this.serverPath+dateDir);
		//http://tu.so.duia.com/videopic/+this.outputPath
		returnPath.append("{Paper[*,0].swf,");
		returnPath.append(this.getSwfSize()).append("}");
		String returnPathStr = returnPath.toString().replaceAll("\\\\", "/");
		if(returnPathStr.indexOf("/") == 0)
			returnPathStr = returnPathStr.substring(1);//去除第一个 “/”
		return returnPathStr;
	}
	
	/**
	 * 
	 * @Title: isWindowsSystem 
	 * @Description: 是否为window
	 * @author wangyaoshu   
	 * @date 2013-3-11 下午02:22:11  
	 * @return     
	 * @return boolean    返回类型
	 */
	private boolean isWindowsSystem() {
		String p = System.getProperty("os.name");
		return p.toLowerCase().indexOf("windows") >= 0 ? true : false;
	 }

}
