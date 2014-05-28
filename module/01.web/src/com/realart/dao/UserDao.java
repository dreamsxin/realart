package com.realart.dao;

import com.realart.entities.User;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

/**
 * 用户实体操作类
 *
 * @author Gxx
 * @module oa
 * @datetime 14-3-29 20:22
 */
public class UserDao {
    /**
     * 根据用户类型查询用户
     *
     * @return
     * @throws Exception
     */
    public static List<User> queryUsersByUserType(int userType) throws Exception {
        List<User> list = new ArrayList<User>();
        String sql = "SELECT id,name,password,cert_name,title_photo,head_photo," +
                "info,state,reason,register_date,register_time,register_ip FROM user WHERE user_type=" +
                userType + " order by id";
        Connection c = DB.getConn();
        Statement stmt = DB.createStatement(c);
        ResultSet rs = DB.executeQuery(c, stmt, sql);
        try {
            if (rs == null) {
                throw new RuntimeException("数据库操作出错，请重试！");
            }
            while (rs.next()) {
                int id = rs.getInt("id");
                String name = rs.getString("name");
                String password = rs.getString("password");
                String certName = rs.getString("cert_name");
                String titlePhoto = rs.getString("title_photo");
                String headPhoto = rs.getString("head_photo");
                String info = rs.getString("info");
                int state = rs.getInt("state");
                String reason = rs.getString("reason");
                String registerDate = rs.getString("register_date");
                String registerTime = rs.getString("register_time");
                String registerIp = rs.getString("register_ip");
                User user = new User(id, name, userType, password, certName, titlePhoto,
                        headPhoto, info, state, reason, registerDate, registerTime, registerIp);
                list.add(user);
            }
            return list;
        } finally {
            DB.close(rs);
            DB.close(stmt);
            DB.close(c);
        }
    }

    /**
     * 根据用户类型和用户状态查询用户
     *
     * @return
     * @throws Exception
     */
    public static List<User> queryUsersByUserTypeAndState(int userType, int state) throws Exception {
        List<User> list = new ArrayList<User>();
        String sql = "SELECT id,name,password,cert_name,title_photo,head_photo," +
                "info,reason,register_date,register_time,register_ip FROM user WHERE user_type=" +
                userType + " AND state=" + state + " order by id";
        Connection c = DB.getConn();
        Statement stmt = DB.createStatement(c);
        ResultSet rs = DB.executeQuery(c, stmt, sql);
        try {
            if (rs == null) {
                throw new RuntimeException("数据库操作出错，请重试！");
            }
            while (rs.next()) {
                int id = rs.getInt("id");
                String name = rs.getString("name");
                String password = rs.getString("password");
                String certName = rs.getString("cert_name");
                String titlePhoto = rs.getString("title_photo");
                String headPhoto = rs.getString("head_photo");
                String info = rs.getString("info");
                String reason = rs.getString("reason");
                String registerDate = rs.getString("register_date");
                String registerTime = rs.getString("register_time");
                String registerIp = rs.getString("register_ip");
                User user = new User(id, name, userType, password, certName, titlePhoto,
                        headPhoto, info, state, reason, registerDate, registerTime, registerIp);
                list.add(user);
            }
            return list;
        } finally {
            DB.close(rs);
            DB.close(stmt);
            DB.close(c);
        }
    }

    /**
     * 根据id查用户
     *
     * @param id
     * @return
     * @throws Exception
     */
    public static User getUserById(int id) throws Exception {
        String sql = "SELECT name,user_type,password,cert_name,title_photo," +
                "head_photo,info,state,reason,register_date,register_time,register_ip FROM user " +
                "WHERE id=" + id;
        Connection c = DB.getConn();
        Statement stmt = DB.createStatement(c);
        ResultSet rs = DB.executeQuery(c, stmt, sql);
        try {
            if (rs == null) {
                throw new RuntimeException("数据库操作出错，请重试！");
            }
            while (rs.next()) {
                String name = rs.getString("name");
                int userType = rs.getInt("user_type");
                String password = rs.getString("password");
                String certName = rs.getString("cert_name");
                String titlePhoto = rs.getString("title_photo");
                String headPhoto = rs.getString("head_photo");
                String info = rs.getString("info");
                int state = rs.getInt("state");
                String reason = rs.getString("reason");
                String registerDate = rs.getString("register_date");
                String registerTime = rs.getString("register_time");
                String registerIp = rs.getString("register_ip");
                User user = new User(id, name, userType, password, certName, titlePhoto,
                        headPhoto, info, state, reason, registerDate, registerTime, registerIp);
                return user;
            }
            return null;
        } finally {
            DB.close(rs);
            DB.close(stmt);
            DB.close(c);
        }
    }

    /**
     * 根据姓名和用户类型查用户
     *
     * @param name
     * @return
     * @throws Exception
     */
    public static User getUserByNameAndUserType(String name, int userType) throws Exception {
        String sql = "SELECT id,password,cert_name,title_photo," +
                "head_photo,info,state,reason,register_date,register_time,register_ip FROM user " +
                "WHERE name='" + name + "' AND user_type=" + userType;
        Connection c = DB.getConn();
        Statement stmt = DB.createStatement(c);
        ResultSet rs = DB.executeQuery(c, stmt, sql);
        try {
            if (rs == null) {
                throw new RuntimeException("数据库操作出错，请重试！");
            }
            while (rs.next()) {
                int id = rs.getInt("id");
                String password = rs.getString("password");
                String certName = rs.getString("cert_name");
                String titlePhoto = rs.getString("title_photo");
                String headPhoto = rs.getString("head_photo");
                String info = rs.getString("info");
                int state = rs.getInt("state");
                String reason = rs.getString("reason");
                String registerDate = rs.getString("register_date");
                String registerTime = rs.getString("register_time");
                String registerIp = rs.getString("register_ip");
                User user = new User(id, name, userType, password, certName, titlePhoto,
                        headPhoto, info, state, reason, registerDate, registerTime, registerIp);
                return user;
            }
            return null;
        } finally {
            DB.close(rs);
            DB.close(stmt);
            DB.close(c);
        }
    }

    /**
     * 判该名字和用户类型是否已存在
     *
     * @param name
     * @return
     * @throws Exception
     */
    public static boolean isNameExist(String name, int userType) throws Exception {
        User user = getUserByNameAndUserType(name, userType);
        return user != null;
    }

    /**
     * 新增用户
     *
     * @param user
     * @throws Exception
     */
    public static void insertUser(User user) throws Exception {
        String sql = "insert into user" +
                "(id,name,user_type,password,cert_name,title_photo," +
                "head_photo,info,state,reason,register_date,register_time,register_ip)" +
                "values" +
                "(null,'" + user.getName() + "'," + user.getUserType() + ",'" + user.getPassword() + "','" +
                user.getCertName() + "','" + user.getTitlePhoto() + "','" + user.getHeadPhoto() + "','" + user.getInfo() + "'," +
                user.getState() + ",'" + user.getReason() + "','" + user.getRegisterDate() + "','" + user.getRegisterTime() + "','" +
                user.getRegisterIp() + "')";
        DB.executeUpdate(sql);

        //根据姓名和用户类型查用户
        user = getUserByNameAndUserType(user.getName(), user.getUserType());
    }

    /**
     * 更新用户密码
     *
     * @param user
     * @throws Exception
     */
    public static void updateUserPassword(User user) throws Exception {
        String sql = "update user set password='" + user.getPassword() + "' where id=" + user.getId();
        DB.executeUpdate(sql);
    }

    /**
     * 更新用户状态
     *
     * @param user
     * @throws Exception
     */
    public static void updateUserState(User user) throws Exception {
        String sql = "update user set state=" + user.getState() + ",reason='" + user.getReason() + "' where id=" + user.getId();
        DB.executeUpdate(sql);
    }

    /**
     * 更新用户信息
     *
     * @param user
     * @throws Exception
     */
    public static void updateUserInfo(User user) throws Exception {
        String sql = "update user set cert_name='" + user.getCertName() + "',title_photo='" +
                user.getTitlePhoto() + "',head_photo='" + user.getHeadPhoto() + "',info='" +
                user.getInfo() + "',reason='" + user.getReason() + "' where id=" + user.getId();
        DB.executeUpdate(sql);
    }
}
