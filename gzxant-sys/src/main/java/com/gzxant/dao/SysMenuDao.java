package com.gzxant.dao;


import java.util.List;

import com.gzxant.base.dao.TreeDao;
import com.gzxant.entity.SysMenu;

/**
 * Created by chen on 2017/3/13.
 * <p>
 * Email 122741482@qq.com
 * <p>
 * Describe: 菜单dao
 */
public interface SysMenuDao extends TreeDao<SysMenu> {
    /**
     * 查询 用户的所有菜单
     *
     * @param userId
     * @return
     */
    List<SysMenu> selectMenusByUserId(Long userId);
}
