<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" contentType="text/html; UTF-8" %>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title></title>
		<link rel="stylesheet" href="/resources/css/rest.css" />
		<link rel="stylesheet" href="/resources/css/curriculum.css" />
		<%--<script type="text/javascript" src="/js/jquery-1.9.1.js" ></script>--%>
	<%--	<script type="text/javascript" src="/resources/base/course/respond.js" ></script><!--兼容IE6-8@media勿删-->
		<script type="text/javascript" src="/resources/ueditor/ueditor.parse.js"></script>--%>
	</head>
	<body>
		<div class="inside">
			<div class="curriculum-nav">
				<a href="#" style="padding-left: 0px;">首页</a>><a href="#">全部课程</a>><a href="#">管理会计</a>><a href="#">财务分析</a>><a href="#">外企财务达人</a>
			</div>
			<div class="curriculum-bottom">
				<div class="ccbottom-left"><img src="/resources/common/images/kaoyan.png"></div>
				<div class="ccbottom-right">
						<div class="zhuti">
							<span>预览模板</span>
							<div class="fx">
							<img src="/resources/common/images/fx.png">
							<div class="duihua">
								<a href="#"><div class="weixin"></div></a>
								<a href="#"><div class="kongjian"></div></a>
							</div>
							</div>
						</div>
						<div class="haoping">
							<span>好评:</span><div class="xingxing"></div>
						</div>
						<div class="rs">
							<p><img src="/resources/common/images/xingxing_10.png"/>已购买人数<span>1598</span></p>
						</div>
						<div class="rs">
							<p>版本号：<span class="rsBan">第二版</span></p>
						</div>
						<div class="duixiang">
							<div class="dx-top"><span>适合对象:</span><div class="dximg"><img src="/resources/common/images/xxz_03.png"/></div></div>
							<div class="kc"><span>课程优势:</span>
								<ul>
								<li>系统学习</li>
								<li>讲师答疑</li>
								<li>作业批改</li>
								<li>资料下载</li>
								</ul>
							</div>
						</div>
						<div class="st">
							<div class="huiyuan">会员免费</div>
							<div class="shiting">试听课程</div>
						</div>
				</div>

			</div>


			<div class="curriculum-teach">
				<div class="xuanxiangka">
					<div class="xxk">
						<ul>
							<li class="crouse_l_nav"><a>课程介绍</a></li>
							<li><a>课程目录</a></li>
							<li><a>学员评价</a></li>
						</ul>

					</div>
					<div class="chi">
						<div class="one" name="jieshao">
							<div class="brief">
								<p class="firstb"><span class="firsts">简</span>介</p>
								<div class="lastb" id="courseBrief">${courseBrief}</div>
								<div class="cle"></div>
							</div>
							<c:if test="${pid=='kjs'}">
								<div class="brief">
									<p class="firstb">岗位职责</p>
									<div class="lastb" id="jobDuty">${jobDuty}
									</div>
									<div class="cle"></div>
								</div>
							</c:if>
							<div class="brief brieF brieff">
								<p class="firstb">老师介绍</p>
								<div class="lastb">
									<p class="briefImg" id="teacherImgUrl"><img src='${teacher.imgUrl}'></p>
									<div class="teach">
										<p class="teachD" id="teacherName">${teacher.name}</p>

										<div >${teacher.introduction}</div>
									</div>
									<div class="cle"></div>
								</div>
								<div class="cle"></div>
							</div>
						</div>
						<div class="one" style="display: none;">

						<ul class="catalog">
								<li>
									<p>
										<img src="/resources/common/images/sign.png">
										<span>了解出纳<span>（3分钟）</span></span>
										<button>试听</button>
									</p>
								</li>
								<li>
									<p>
										<img src="/resources/common/images/sign.png">
										<span>技能1-管理保险柜<span>（4分钟）</span></span>
										<button>试听</button>
									</p>
								</li>
								<li>
									<p>
										<img src="/resources/common/images/sign.png">
										<span>技能2-现金管理和清查<span>（5分钟）</span></span>
										<button>试听</button>
									</p>
								</li>
								<li>
									<p>
										<img src="/resources/common/images/sign.png">
										<span>技能3-识别钞票及点钞<span>（7分钟）</span></span>
									</p>
								</li>
								<li>
									<p>
										<img src="/resources/common/images/sign.png">
										<span>技能3-识别钞票及点钞<span>（7分钟）</span></span>
									</p>
								</li>
								<li>
									<p>
										<img src="/resources/common/images/sign.png">
										<span>技能3-识别钞票及点钞<span>（7分钟）</span></span>
									</p>
								</li>
								<li>
									<p>
										<img src="/resources/common/images/sign.png">
										<span>技能3-识别钞票及点钞<span>（7分钟）</span></span>
									</p>
								</li>
								<li>
									<p>
										<img src="/resources/common/images/sign.png">
										<span>技能3-识别钞票及点钞<span>（7分钟）</span></span>
									</p>
								</li>
								<li>
									<p>
										<img src="/resources/common/images/sign.png">
										<span>技能3-识别钞票及点钞<span>（7分钟）</span></span>
									</p>
								</li>
								<li>
									<p>
										<img src="/resources/common/images/sign.png">
										<span>技能3-识别钞票及点钞<span>（7分钟）</span></span>
									</p>
								</li>
								<li>
									<p>
										<img src="/resources/common/images/sign.png">
										<span>技能4-盲打计算器<span>（3分钟）</span></span>
									</p>
								</li>
								<li>
									<p>
										<img src="/resources/common/images/sign.png">
										<span>技能5-印章的使用与管理<span>（6分钟）</span></span>
									</p>
								</li>
								<li>
									<p>
										<img src="/resources/common/images/sign.png">
										<span>技能6-大小写金额及日期的书写<span>（8分钟）</span></span>
									</p>
								</li>
							<li>
								<p>
									<img src="/resources/common/images/sign.png">
									<span>技能6-大小写金额及日期的书写<span>（8分钟）</span></span>
								</p>
							</li>
							<li>
								<p>
									<img src="/resources/common/images/sign.png">
									<span>技能6-大小写金额及日期的书写<span>（8分钟）</span></span>
								</p>
							</li>
							<li>
								<p>
									<img src="/resources/common/images/sign.png">
									<span>技能6-大小写金额及日期的书写<span>（8分钟）</span></span>
								</p>
							</li>
							<li>
								<p>
									<img src="/resources/common/images/sign.png">
									<span>技能6-大小写金额及日期的书写<span>（8分钟）</span></span>
								</p>
							</li>
							<li>
								<p>
									<img src="/resources/common/images/sign.png">
									<span>技能6-大小写金额及日期的书写<span>（8分钟）</span></span>
								</p>
							</li>
							<li>
								<p>
									<img src="/resources/common/images/sign.png">
									<span>技能6-大小写金额及日期的书写<span>（8分钟）</span></span>
								</p>
							</li>
							<li>
								<p>
									<img src="/resources/common/images/sign.png">
									<span>技能6-大小写金额及日期的书写<span>（8分钟）</span></span>
								</p>
							</li>
							<li>
								<p>
									<img src="/resources/common/images/sign.png">
									<span>技能6-大小写金额及日期的书写<span>（8分钟）</span></span>
								</p>
							</li>
							<li>
								<p>
									<img src="/resources/common/images/sign.png">
									<span>技能6-大小写金额及日期的书写<span>（8分钟）</span></span>
								</p>
							</li>
							</ul>

						</div>
						<div class="one" style="display: none;">
							<ul class="commen">
								<li>
									<div><img src="/resources/common/images/header.png"><span>史密斯</span></div>
									<ul>
										<li class="xing">
											<span></span>
											<span></span>
											<span></span>
											<span></span>
											<span class="anxing"></span>
										</li>
										<li class="lastLi">课程讲得非常详细，感觉自己要学的东西太多了，以后要经常来听课学习。</li>
									</ul>
									<span class="date">2016-08-30</span>

								</li>

								<li>
									<div><img src="/resources/common/images/header.png"><span>漂流的鱼</span></div>
									<ul>
										<li class="xing">
											<span></span>
											<span></span>
											<span></span>
											<span></span>
											<span class="anxing"></span>
										</li>
										<li class="lastLi">很喜欢大象老师讲课的风格！赞</li>
									</ul>
									<span class="date">2016-08-30</span>

								</li>

								<li>
									<div><img src="/resources/common/images/header.png"><span>Mlimli</span></div>
									<ul>
										<li class="xing">
											<span></span>
											<span></span>
											<span></span>
											<span></span>
											<span></span>
										</li>
										<li class="lastLi">学习了第一节，兴趣起来了，可不晓得从没学过，还能不能学得会。</li>
									</ul>
									<span class="date">2016-08-27</span>

								</li>

								<li>
									<div><img src="/resources/common/images/header.png"><span>小幸运</span></div>
									<ul>
										<li class="xing">
											<span></span>
											<span></span>
											<span></span>
											<span class="anxing"></span>
											<span class="anxing"></span>
										</li>
										<li class="lastLi">声音太小了。</li>
									</ul>
									<span class="date">2016-08-26</span>

								</li>
								<li>
									<div><img src="/resources/common/images/header.png"><span>小幸运</span></div>
									<ul>
										<li class="xing">
											<span></span>
											<span></span>
											<span></span>
											<span class="anxing"></span>
											<span class="anxing"></span>
										</li>
										<li class="lastLi">声音太小了。</li>
									</ul>
									<span class="date">2016-08-26</span>

								</li>
								<li>
									<div><img src="/resources/common/images/header.png"><span>小幸运</span></div>
									<ul>
										<li class="xing">
											<span></span>
											<span></span>
											<span></span>
											<span class="anxing"></span>
											<span class="anxing"></span>
										</li>
										<li class="lastLi">声音太小了。</li>
									</ul>
									<span class="date">2016-08-26</span>

								</li>
								<li>
									<div><img src="/resources/common/images/header.png"><span>小幸运</span></div>
									<ul>
										<li class="xing">
											<span></span>
											<span></span>
											<span></span>
											<span class="anxing"></span>
											<span class="anxing"></span>
										</li>
										<li class="lastLi">声音太小了。</li>
									</ul>
									<span class="date">2016-08-26</span>

								</li>
								<li>
									<div><img src="/resources/common/images/header.png"><span>小幸运</span></div>
									<ul>
										<li class="xing">
											<span></span>
											<span></span>
											<span></span>
											<span class="anxing"></span>
											<span class="anxing"></span>
										</li>
										<li class="lastLi">声音太小了。</li>
									</ul>
									<span class="date">2016-08-26</span>

								</li>
								<li>
									<div><img src="/resources/common/images/header.png"><span>小幸运</span></div>
									<ul>
										<li class="xing">
											<span></span>
											<span></span>
											<span></span>
											<span class="anxing"></span>
											<span class="anxing"></span>
										</li>
										<li class="lastLi">声音太小了。</li>
									</ul>
									<span class="date">2016-08-26</span>

								</li>
								<li>
									<div><img src="/resources/common/images/header.png"><span>小幸运</span></div>
									<ul>
										<li class="xing">
											<span></span>
											<span></span>
											<span></span>
											<span class="anxing"></span>
											<span class="anxing"></span>
										</li>
										<li class="lastLi">声音太小了。</li>
									</ul>
									<span class="date">2016-08-26</span>

								</li>
								<li>
									<div><img src="/resources/common/images/header.png"><span>小幸运</span></div>
									<ul>
										<li class="xing">
											<span></span>
											<span></span>
											<span></span>
											<span class="anxing"></span>
											<span class="anxing"></span>
										</li>
										<li class="lastLi">声音太小了。</li>
									</ul>
									<span class="date">2016-08-26</span>

								</li>
								<li>
									<div><img src="/resources/common/images/header.png"><span>小幸运</span></div>
									<ul>
										<li class="xing">
											<span></span>
											<span></span>
											<span></span>
											<span class="anxing"></span>
											<span class="anxing"></span>
										</li>
										<li class="lastLi">声音太小了。</li>
									</ul>
									<span class="date">2016-08-26</span>

								</li>
								<li style="border-bottom:0px">
									<div><img src="/resources/common/images/header.png"><span>Wenxye</span></div>
									<ul>
										<li class="xing">
											<span></span>
											<span></span>
											<span></span>
											<span></span>
											<span class="anxing"></span>
										</li>
										<li class="lastLi">老师很漂亮，讲的很认真。</li>
									</ul>
									<span class="date">2016-08-26</span>

								</li>
							</ul>
							<div class="no_Spe">
								<div class='no_Img'><img src="/resources/common/images/norepeat.png"></div>
								<p>暂无学员评论</p>
							</div>
						</div>
					</div>
				</div>
				<div style="width: 372px;float: right;">
					<div class="allsee">
						<div class="like">大家都在看</div>
						<div class="like-nr">
							<div class="nr-start">
								<div class="stratLeft">
									<img src="/resources/common/images/sihai_06.png" />
								</div>
								<div class="startRight">
									<span class="btbt">外企财务达人</span>
									<p>
										<img src="/resources/common/images/sihai_11.png" />
										<span style="margin-right: 25px;">557226</span>
										<img src="/resources/common/images/sihai_13.png" />
										<span>234</span>
									</p>
								</div>
							</div>
							<div class="zanwu" style="display: none;">
								<img src="/resources/common/images/zanwu_03.png" />
								<p>暂无视频</p>
							</div>
						</div>

						<div class="like-nr">
							<div class="nr-start">
								<div class="stratLeft">
									<img src="/resources/common/images/shihai-000.png" />
								</div>
								<div class="startRight">
									<span class="btbt">外企财务达人</span>
									<p>
										<img src="/resources/common/images/sihai_11.png" />
										<span style="margin-right: 25px;">557226</span>
										<img src="/resources/common/images/sihai_13.png" />
										<span>234</span>
									</p>
								</div>
							</div>
						</div>

						<div class="like-nr">
							<div class="nr-start">
								<div class="stratLeft">
									<img src="/resources/common/images/sihai_18.png" />
								</div>
								<div class="startRight">
									<span class="btbt">外企财务达人</span>
									<p>
										<img src="/resources/common/images/sihai_11.png" />
										<span style="margin-right: 25px;">557226</span>
										<img src="/resources/common/images/sihai_13.png" />
										<span>234</span>
									</p>
								</div>
							</div>
						</div>


					</div>
				</div>
			</div>





</div>
			<%--<script type="text/javascript" src="/resources/base/course/curriculum.js" ></script>--%>
		<%--<link href="/resources/ueditor/third-party/SyntaxHighlighter/shCoreDefault.css" rel="stylesheet" type="text/css" />
		<script type="text/javascript" src="/resources/ueditor/third-party/SyntaxHighlighter/shCore.js"></script>--%>

	</body>
	<%--<script>
			uParse('#courseBrief', {
				rootPath: '/resources/'
			})
			<c:if test="${pid=='kjs'}">
				uParse('#jobDuty', {
					rootPath: '/resources/'
				})
			</c:if>
	</script>--%>
</html>
