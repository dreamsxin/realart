<%@ page import="com.realart.utils.BaseUtil" %>
<%@ page import="com.realart.interfaces.UserInterface" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="headerWithOutCheckLogin.jsp" %>
<%
    //判登录
    if(!BaseUtil.isLogin(request) || user.getUserType() != UserInterface.USER_TYPE_REVIEW)
    {
        //域名链接
        response.sendRedirect(baseUrl + "loginReview.jsp");
        return;
    }
%>