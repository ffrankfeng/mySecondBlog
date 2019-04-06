package com.fengf.bms.service;

import com.fengf.bms.mapper.AdminMapper;
import com.fengf.bms.pojo.Admin;
import com.fengf.bms.pojo.AdminQueryVo;
import com.fengf.bms.pojo.Users;
import com.fengf.common.utils.Page;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

@Service
public class AdminServiceImpl implements  AdminService {

    @Autowired
    private AdminMapper adminMapper;
    public String getupDate() throws ParseException {
        SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        String date=sdf.format(new Date());
        return date;
    }
    @Override
    public Admin login(String userName, String userPwd, String ip) {
        Admin admin = new Admin();
        admin.setUsername(userName);
        admin.setPassword(userPwd);
        Admin admin1 = adminMapper.login(admin);
        System.out.println("login sucess? "+admin1);
        if (admin1 != null){
            admin.setIp(ip);
            try {
                admin.setLasttime(getupDate());
            } catch (ParseException e) {
                e.printStackTrace();
            }finally {
                System.out.println("adminp = "+admin);
                int flag = adminMapper.updateByPrimaryKey(admin);
                return admin1;
            }
        }else return admin1 ;
    }

    @Override
    public Page<Admin> selectAllPage(AdminQueryVo vo) {
        Page<Admin> page=new Page<Admin>();
        //每页数
        page.setSize(10);
        vo.setSize(10);

        if(vo!=null ){
            //判断当前页
            if(vo.getPage()!=null){
                page.setPage(vo.getPage());
                vo.setStartRow((vo.getPage()-1)*vo.getSize());
            }
            //总条数
            page.setTotal(adminMapper.adminCountByQueryVo(vo));
            page.setRows(adminMapper.selectAdminListByQueryVo(vo));
        }
        return page;
    }

    @Override
    public int getIndexAdminCount() {
        List<Admin> lists = adminMapper.selectAllUser();
        System.out.println(lists.toArray());
        return lists.size();
    }
}
