<%@ page import="com.realart.dao.UserDao" %>
<%@ page import="com.realart.interfaces.UserInterface" %>
<%@ page import="com.realart.entities.Review" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.List" %>
<%@ page import="com.realart.dao.ReviewDao" %>
<%@ page import="com.realart.utils.BaseUtil" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="headerWithOutCheckLogin.jsp" %>
<%
    List<User> reviewUsers = UserDao.queryUsersByUserType(UserInterface.USER_TYPE_REVIEW);
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>评论页面</title>
    <script type="text/javascript" src="scripts/jquery-min.js"></script>
    <script type="text/javascript" src="scripts/base.js"></script>
    <script type="text/javascript" src="scripts/pinyin.js"></script>
    <script type="text/javascript" src="scripts/reviewUsers.js"></script>
    <!-- 页面样式 -->
    <link rel="stylesheet" href="css/reset.css" type="text/css" media="screen"/>
    <link rel="stylesheet" href="css/style.css" type="text/css" media="screen"/>
    <link rel="stylesheet" href="css/invalid.css" type="text/css" media="screen"/>
    <script type="text/javascript" src="scripts/simpla.jquery.configuration.js"></script>
    <style type="text/css">
        body {
            font-family: Arial, Helvetica, sans-serif;
            color: #555;
            background: #ffffff url('images/b.png') top left repeat-y;
            font-size: 12px;
        }
        .leftTd{
            text-align : right;
            width : 100px;
        }
        .rightTd{
            width : 300px;
        }
    </style>
    <script type="text/javascript">
        //用户集合json串
        var userJsonStr = "<%=BaseUtil.getJsonArrayFromUsers(reviewUsers)%>";
    </script>
</head>
<body>
<div align="center" style="background: url('images/realart_bg.jpg');
    vertical-align: middle;
    background-size: 100%;
    background-position: center;">
    <img src="images/realart_logo.png" height="100" alt="真艺网">
    <img src="images/realart.png" height="100" alt="真艺网">
</div>
<div style="background-color: rgb(212, 212, 204);" align="center">
    <div style="width: 600px; background-color: rgb(212, 212, 204);" align="left">
        <br>
        <br>
        <div>陶瓷评论</div>
        <div>
            <%
                for(Review review : ReviewDao.queryReviewsByType("hyzlTop")){
            %>
            <a href="/showReview.jsp?id=<%=review.getId()%>"><img src="/<%=review.getPhoto()%>" alt="<%=review.getTitle()%>" width="100"></a>
            <%
                }
            %>
        </div>
        <br>
        <div>会员专栏</div>
        <div>
            <br>
            <div id="letter_div"></div>
            <div id="detail_div"></div>
        </div>
        <br>
        <br>
    </div>
</div>
<div align="center" style="background-color: gray;">
    <a href="#"><img width="40" src="images/button/1.jpg" alt=""></a>
    <a href="#"><img width="40" src="images/button/2.jpg" alt=""></a>
    <a href="#"><img width="40" src="images/button/3.jpg" alt=""></a>
    <a href="#"><img width="40" src="images/button/4.jpg" alt=""></a>
    <a href="#"><img width="40" src="images/button/5.jpg" alt=""></a>
    <a href="#"><img width="40" src="images/button/6.jpg" alt=""></a>
    <a href="#"><img width="40" src="images/button/7.jpg" alt=""></a>
    <a href="#"><img width="40" src="images/button/8.jpg" alt=""></a>
    <a href="#"><img width="40" src="images/button/9.jpg" alt=""></a>
    <a href="#"><img width="40" src="images/button/10.jpg" alt=""></a>
</div>
</body>
</html>