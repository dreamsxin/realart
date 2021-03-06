<%@ page import="com.realart.dao.QrCodeDao" %>
<%@ page import="com.realart.entities.QrCode" %>
<%@ page import="java.util.List" %>
<%@ page import="com.realart.interfaces.QrCodeInterface" %>
<%@ page import="org.apache.struts2.ServletActionContext" %>
<%@ page import="java.io.File" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="adminHeader.jsp" %>
    <%
        //外层
        outLayer = "序列号模块";
        //内层
        inLayer = "序列号维护";
        //开始Id
        String startId = StringUtils.trimToEmpty(request.getParameter("startId"));
        //结束Id
        String endId = StringUtils.trimToEmpty(request.getParameter("endId"));
        //开始日期
        String startDate = StringUtils.trimToEmpty(request.getParameter("startDate"));
        //结束日期
        String endDate = StringUtils.trimToEmpty(request.getParameter("endDate"));
        //选择序列号
        String uuid = StringUtils.trimToEmpty(request.getParameter("uuid"));
        //当前状态
        String stateStr = StringUtils.trimToEmpty(request.getParameter("state"));
        //状态
        int state;
        try {
            state = Integer.parseInt(stateStr);
        } catch (Exception e) {
            state = 0;
        }
        //当前页数
        String pageStr = StringUtils.trimToEmpty(request.getParameter("pageNum"));
        //当前页数
        int pageNum;
        try {
            pageNum = Integer.parseInt(pageStr);
        } catch (Exception e) {
            pageNum = 1;
        }
        //二维码页面大小
        int pageSize = Integer.parseInt(PropertyUtil.getInstance().getProperty(BaseInterface.QR_CODE_PAGE_SIZE));
        /**
         * 根据状态查二维码量
         * 如果state>0带上作为条件
         */
        int count = QrCodeDao.countQrCodesByUuidAndState(startId, endId, startDate, endDate, uuid, state);
        //是否为空
        boolean isEmpty = count == 0;
        //总页数
        int pageCount = (count - 1) / pageSize + 1;
        //删除最后一条，可能会少掉一页
        if(pageNum > pageCount){
            pageNum = pageCount;
        }
        //根据序列号，状态，页码查二维码
        List<QrCode> qrCodes = QrCodeDao.queryQrCodesByUuidAndStateAndPayNum(startId, endId, startDate, endDate, uuid, state, pageNum);
        //获取 默认二维码配置 和 默认二维码相关信息
        String defaultQrCode = StringUtils.trimToEmpty(ParamUtil.getInstance().getValueByName(ParamInterface.DEFAULT_QR_CODE));
        String defaultQrCodeInfo = StringUtils.trimToEmpty(ParamUtil.getInstance().getValueByName(ParamInterface.DEFAULT_QR_CODE_INFO));
    %>
<html>
<head>
    <title>序列号维护</title>
    <script type="text/javascript" src="<%=baseUrl%>scripts/jquery-min.js"></script>
    <script type="text/javascript" src="<%=baseUrl%>scripts/base.js"></script>
    <script type="text/javascript" src="<%=baseUrl%>scripts/qrCode.js"></script>
    <!-- jQuery 颜色选择器 Spectrum -->
    <script type="text/javascript" src="<%=baseUrl%>scripts/spectrum.js"></script>
    <link rel="stylesheet" href="css/spectrum.css" type="text/css" media="screen"/>
    <!--日期控件-->
    <link type="text/css" rel="stylesheet" href="css/jquery-ui.css"/>
    <script type="text/javascript" src="<%=baseUrl%>scripts/jquery-ui.min.js"></script>
    <!-- 页面样式 -->
    <link rel="stylesheet" href="css/reset.css" type="text/css" media="screen"/>
    <link rel="stylesheet" href="css/style.css" type="text/css" media="screen"/>
    <link rel="stylesheet" href="css/invalid.css" type="text/css" media="screen"/>
    <script type="text/javascript" src="scripts/simpla.jquery.configuration.js"></script>
    <script type="text/javascript" src="scripts/facebox.js"></script>
    <script type="text/javascript">
        //当前页数
        var pageNum = <%=pageNum%>;
        //选择logo
        var chooseLogo = 0;
        //默认配置
        var defaultAntiError = EMPTY;
        var defaultSize = EMPTY;
        var defaultBgColor = EMPTY;
        var defaultFrontColor = EMPTY;
        var defaultType = EMPTY;
        var defaultQrLogo = EMPTY;
        var defaultLogoBorderType = EMPTY;
        var defaultLogoBorderColor = EMPTY;
        //为默认配置赋值
        <%
            //antiError=M&size=3&bgColor=#ffffff&frontColor=#000000&type=1&qrLogo=0&logoBorderType=1&logoBorderColor=#00ff00
            if(StringUtils.isNotBlank(defaultQrCode)){
            defaultQrCode += "&";//最后加个&
            String temp = defaultQrCode.substring(defaultQrCode.indexOf("antiError") + "antiError".length() + 1);
        %>
        defaultAntiError = "<%=temp.substring(0, temp.indexOf("&"))%>";
        <%
           temp = defaultQrCode.substring(defaultQrCode.indexOf("size") + "size".length() + 1);
        %>
        defaultSize = "<%=temp.substring(0, temp.indexOf("&"))%>";
        <%
           temp = defaultQrCode.substring(defaultQrCode.indexOf("bgColor") + "bgColor".length() + 1);
        %>
        defaultBgColor = "<%=temp.substring(0, temp.indexOf("&"))%>";
        <%
           temp = defaultQrCode.substring(defaultQrCode.indexOf("frontColor") + "frontColor".length() + 1);
        %>
        defaultFrontColor = "<%=temp.substring(0, temp.indexOf("&"))%>";
        <%
           temp = defaultQrCode.substring(defaultQrCode.indexOf("type") + ("type" +
            "").length() + 1);
        %>
        defaultType = "<%=temp.substring(0, temp.indexOf("&"))%>";
        <%
           temp = defaultQrCode.substring(defaultQrCode.indexOf("qrLogo") + "qrLogo".length() + 1);
        %>
        defaultQrLogo = "<%=temp.substring(0, temp.indexOf("&"))%>";
        <%
           temp = defaultQrCode.substring(defaultQrCode.indexOf("logoBorderType") + "logoBorderType".length() + 1);
        %>
        defaultLogoBorderType = "<%=temp.substring(0, temp.indexOf("&"))%>";
        <%
           temp = defaultQrCode.substring(defaultQrCode.indexOf("logoBorderColor") + "logoBorderColor".length() + 1);
        %>
        defaultLogoBorderColor = "<%=temp.substring(0, temp.indexOf("&"))%>";
        <%
            }
        %>
        //艺术品绑定二维码地址前缀
        var qrCodeUrlPrefix = "<%=qrCodeUrlPrefix%>";
        //初始化起始日期
        var initStartDate = "<%=startDate%>";
        //初始化终止日期
        var initEndDate = "<%=endDate%>";
    </script>
    <style type="text/css">
        #selectTable td {
            text-align: center;
        }
        #selectTable th {
            text-align: center;
        }
        #cwr_table td {
            text-align: center;
        }
        #cwr_table th {
            text-align: center;
        }
    </style>
</head>
<body>
<div id="body-wrapper">
<div id="sidebar">
    <div id="sidebar-wrapper">
        <h1 id="sidebar-title"><a href="#">真艺网</a></h1>
        <div align="center">
            <img id="logo" src="images/realart_logo.png" width="50" alt="Simpla Admin logo"/>
        </div>
        <div id="profile-links">
            Hello, [<%=adminUserName%>],真艺网欢迎您！
            <br/>
            <br/>
            <a href="javascript: logOut()" title="Sign Out">退出</a>
        </div>
        <%@ include file="layers.jsp" %>
    </div>
</div>
<div id="main-content">
    <div id="message_id" class="notification information png_bg" style="display: none;">
        <a href="#" class="close">
            <img src="images/icons/cross_grey_small.png" title="关闭" alt="关闭"/>
        </a>

        <div id="message_id_content"> 提示信息！</div>
    </div>
    <div class="content-box">
        <div class="content-box-header">
            <h3>生成序列号并生成二维码</h3>
        </div>
        <div class="content-box-content">
            <div class="tab-content default-tab">
                <span style="display: none;">
                    <form name="uploadQrCodeLogoForm" method="post" autocomplete="off"
                          action="uploadQrCodeLogo.do?token=<%=token%>" enctype="multipart/form-data">
                        <input type="file" name="qrLogo" id="upload_qr_code_logo"
                               onchange="document.forms['uploadQrCodeLogoForm'].submit()">
                    </form>
                    <form name="deleteQrCodeLogoForm" method="post" action="deleteQrCodeLogo.do?token=<%=token%>">
                        <input type="hidden" name="qrLogo" id="delete_qr_code_logo">
                    </form>
                    <form name="saveDefaultQrCodeForm" method="post" action="saveDefaultQrCode.do?token=<%=token%>">
                        <textarea name="defaultQrCode" id="save_default_qr_code"></textarea>
                        <textarea name="defaultInfo" id="save_default_qr_code_info"></textarea>
                    </form>
                    <form name="deleteQrCodeForm" method="post" action="deleteQrCode.do?token=<%=token%>">
                        <input type="hidden" name="qrCode" id="delete_qr_code">
                    </form>
                </span>
                <form name="generateQrCodeForm" method="post" action="generateQrCode.do?token=<%=token%>">
                    <table>
                        <tr>
                            <td>二维码排错率</td>
                            <td>
                                <select class="text-input small-input" name="antiError" id="antiError">
                                    <option value="L">低(7%)</option>
                                    <option value="M" selected="selected">中(15%)</option>
                                    <option value="Q">稍高(25%)</option>
                                    <option value="H">高(30%)</option>
                                </select>(排错率越高可存储的信息越少，但对二维码清晰度的要求越小)
                            </td>
                        </tr>
                        <tr>
                            <td>二维码尺寸</td>
                            <td>
                                <select class="text-input small-input" name="size" id="size">
                                    <option value="1">1</option>
                                    <option value="2">2</option>
                                    <option value="3" selected="selected">3</option>
                                    <option value="4">4</option>
                                    <option value="5">5</option>
                                    <option value="6">6</option>
                                    <option value="7">7</option>
                                    <option value="8">8</option>
                                    <option value="9">9</option>
                                    <option value="10">10</option>
                                    <option value="11">11</option>
                                    <option value="12">12</option>
                                    <option value="13">13</option>
                                    <option value="14">14</option>
                                    <option value="15">15</option>
                                    <option value="16">16</option>
                                    <option value="17">17</option>
                                    <option value="18">18</option>
                                    <option value="19">19</option>
                                    <option value="20">20</option>
                                    <option value="21">21</option>
                                    <option value="22">22</option>
                                    <option value="23">23</option>
                                    <option value="24">24</option>
                                    <option value="25">25</option>
                                    <option value="26">26</option>
                                    <option value="27">27</option>
                                    <option value="28">28</option>
                                    <option value="29">29</option>
                                    <option value="30">30</option>
                                    <option value="31">31</option>
                                    <option value="32">32</option>
                                    <option value="33">33</option>
                                    <option value="34">34</option>
                                    <option value="35">35</option>
                                    <option value="36">36</option>
                                    <option value="37">37</option>
                                    <option value="38">38</option>
                                    <option value="39">39</option>
                                    <option value="40">40</option>
                                </select>(取值范围1-40，值越大尺寸越大，可存储的信息越大)
                            </td>
                        </tr>
                        <tr>
                            <td>背景颜色</td>
                            <td><input type='text' id="bgColor" name="bgColor"/></td>
                        </tr>
                        <tr>
                            <td>前景颜色</td>
                            <td><input type='text' id="frontColor" name="frontColor"/></td>
                        </tr>
                        <tr>
                            <td>形态</td>
                            <td>
                                <select class="text-input small-input" name="type" id="type">
                                    <option value="1" selected="selected">液态</option>
                                    <option value="2">直角</option>
                                    <option value="3">圆形</option>
                                </select>
                            </td>
                        </tr>
                        <tr>
                            <input type="hidden" name="qrLogo" id="qrLogo">
                            <td>插入logo(可选)</td>
                            <td id="qr_logos">
                                <%
                                    File file = new File(ServletActionContext.getServletContext().getRealPath("images/qr_logo/") + "/");
                                    String[] files = file.list();
                                    for(int i=0;i<files.length;i++){
                                        String tempFile = files[i];
                                %>
                                <img onclick="chooseQrCodeLogo(this, <%=i+1%>)" class="choose_logo"
                                     src="images/qr_logo/<%=tempFile%>" width="50" style="cursor: pointer;">
                                <%
                                    }
                                %>
                                <input class="button" type="button" onclick="clearQrCodeLogo();" value="取消logo" />
                                <input class="button" type="button" onclick="uploadQrCodeLogo();" value="上传" />
                                <input class="button" type="button" onclick="deleteQrCodeLogo();" value="删除" />
                            </td>
                        </tr>
                        <tr>
                            <td>logo边缘(可选)</td>
                            <td>
                                <select class="text-input small-input" name="logoBorderType" id="logoBorderType">
                                    <option value="1" selected="selected">无边框</option>
                                    <option value="2">直角</option>
                                    <option value="3">圆角</option>
                                </select>
                            </td>
                        </tr>
                        <tr>
                            <td>logo边缘颜色(可选)</td>
                                <td><input type='text' id="logoBorderColor" name="logoBorderColor"/></td>
                        </tr>
                        <tr>
                            <td>相关信息</td>
                            <td><textarea class="text-input large-input" name="info" id="info"><%=defaultQrCodeInfo%></textarea></td>
                        </tr>
                        <tr>
                            <td>生成序列号</td>
                            <td>
                                <input class="button" type="button" onclick="saveDefaultQrCode();" value="保存默认配置" />
                                <input class="button" type="button" onclick="preViewQrCode();" value="预览" />
                                <input class="button" type="button" onclick="generateQrCode();" value="批量生成" />
                                <input type="text" name="num" id="num" value="1"
                                       style="text-align: center;" class="text-input little-small-input">个
                            </td>
                        </tr>
                    </table>
                </form>
            </div>
        </div>
    </div>

    <a id="showBigImgA" class="shortcut-button" href="#bigImgDiv" rel="modal" style="display: none;"></a>
    <div id="bigImgDiv" style="display: none;" align="center">
        <img id="bigImg" width="450">
        <div id="qrCodeUrl" style="display: none;"></div>
    </div>

    <div class="content-box">
        <div class="content-box-header">
            <h3>序列号</h3>
        </div>
        <div class="content-box-content">
            <div class="tab-content default-tab">
                <form>
                    <div align="center">
                        <table id="selectTable">
                            <tr>
                                <td>
                                    ID从<input type="text" class="text-input small-input" id="startId" value="<%=startId%>">
                                    到<input type="text" class="text-input small-input" id="endId" value="<%=endId%>">
                                </td>
                                <td>
                                    日期从<input type="text" class="text-input small-input" id="startDate" value="<%=startDate%>">
                                    到<input type="text" class="text-input small-input" id="endDate" value="<%=endDate%>">
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    序列号<input type="text" class="text-input medium-input" id="uuid" value="<%=uuid%>">
                                </td>
                                <td>
                                    状态
                                    <select class="text-input medium-input" id="state">
                                        <option value="0">全部</option>
                                        <option value="<%=QrCodeInterface.STATE_NOT_USE%>"<%=QrCodeInterface.STATE_NOT_USE==state?" selected":""%>>未被使用</option>
                                        <option value="<%=QrCodeInterface.STATE_USED%>"<%=QrCodeInterface.STATE_USED==state?" selected":""%>>已被使用</option>
                                    </select>
                                </td>
                            </tr>
                        </table>
                        <input class="button" type="button" onclick="jump2page(1);" value="查询" />
                        <input class="button" type="button" onclick="downloadQrCode();" value="下载" />
                    </div>


                    <table id="cwr_table">
                        <thead>
                        <tr>
                            <th>ID</th>
                            <th>序列号</th>
                            <th>二维码</th>
                            <th>绑定艺术品</th>
                            <th>日期</th>
                            <th>相关信息</th>
                            <th>操作</th>
                        </tr>
                        </thead>
                        <tfoot>
                        <tr>
                            <td colspan="7">
                                <div class="pagination">
                                    <a href="javascript: jump2page(1)" title="首页">&laquo; 首页</a>
                                    <%
                                        if(pageNum > 1){
                                    %>
                                    <a href="javascript: jump2page(<%=pageNum-1%>)" title="上一页">&laquo; 上一页</a>
                                    <%
                                        }
                                    %>
                                    <%
                                        //显示前2页，本页，后2页
                                        for(int i=pageNum-2;i<pageNum+3;i++){
                                            if(i >= 1 && i <= pageCount){
                                    %>
                                    <a href="javascript: jump2page(<%=i%>)" class="number<%=(i==pageNum)?" current":""%>" title="<%=i%>"><%=i%></a>
                                    <%
                                            }
                                        }
                                    %>
                                    <%
                                        if(pageNum < pageCount){
                                    %>
                                    <a href="javascript: jump2page(<%=pageNum+1%>)" title="下一页">下一页 &raquo;</a>
                                    <%
                                        }
                                    %>
                                    <a href="javascript: jump2page(<%=pageCount%>)" title="尾页">尾页 &raquo;</a>
                                </div>
                                <div class="clear"></div>
                            </td>
                        </tr>
                        </tfoot>
                        <tbody>
                        <%
                            //判是否为空
                            if (isEmpty) {
                        %>
                        <tr>
                            <td colspan="7">
                                没找到序列号
                            </td>
                        </tr>
                        <%
                        } else {//非空
                            for(int i=0;i<qrCodes.size();i++)
                            {
                        %>
                        <tr>
                            <td>
                                <%=qrCodes.get(i).getId()%>
                            </td>
                            <td>
                                <%=qrCodes.get(i).getUuid()%>
                            </td>
                            <td>
                                <img style="cursor: pointer;" src="/<%=qrCodes.get(i).getImgPath()%>" width="50"
                                     onclick="showBigImg('/<%=qrCodes.get(i).getImgPath()%>', '<%=qrCodes.get(i).getUuid()%>')">
                            </td>
                            <td>
                                <%
                                    if(qrCodes.get(i).getState() == QrCodeInterface.STATE_NOT_USE){
                                %>
                                未绑定艺术品
                                <%
                                } else {
                                %>
                                已绑定艺术品[id=<%=qrCodes.get(i).getArtId()%>],<a href="showArt.jsp?id=<%=qrCodes.get(i).getArtId()%>" target="_blank">查看</a>
                                <%--<input class="button" type="button" onclick="showArt(<%=qrCodes.get(i).getArtId()%>)" value="已绑定艺术品[id=<%=qrCodes.get(i).getArtId()%>]">--%>
                                <%
                                    }
                                %>
                            </td>
                            <td>
                                <%=qrCodes.get(i).getCreateDate()%>
                            </td>
                            <td>
                                <textarea class="text-input large-input"><%=qrCodes.get(i).getInfo()%></textarea>
                            </td>
                            <td>
                                <input class="button" type="button" onclick="deleteQrCode(<%=qrCodes.get(i).getId()%>, <%=qrCodes.get(i).getState() == QrCodeInterface.STATE_USED%>);" value="删除">
                            </td>
                        </tr>
                        <%
                                }
                            }
                        %>
                        </tbody>
                    </table>
                </form>
            </div>
        </div>
    </div>

    <div class="clear"></div>
    <div id="footer">
        <small>
            &#169; Copyright 2014 Realart
        </small>
    </div>
</div>
</div>
</body>
</html>