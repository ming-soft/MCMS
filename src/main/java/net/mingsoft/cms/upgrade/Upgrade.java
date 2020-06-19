package net.mingsoft.cms.upgrade;

import cn.hutool.core.util.StrUtil;
import net.mingsoft.basic.util.BasicUtil;
import net.mingsoft.basic.util.SpringUtil;
import net.mingsoft.cms.biz.ICategoryBiz;
import net.mingsoft.cms.entity.CategoryEntity;
import net.mingsoft.cms.util.PinYinUtil;

import java.util.List;

/**
 * @author by 铭飞开源团队
 * @Description TODO
 * @date 2020/6/19 15:58
 */
public class Upgrade {

    /**
     * 菜单拼音升级
     */
    public void upgrade(){
        ICategoryBiz categoryBiz = SpringUtil.getBean(ICategoryBiz.class);
        List<CategoryEntity> list = categoryBiz.queryAll();
        //先更新所有栏目的拼音
        list.forEach(x->{
            String pingYin = PinYinUtil.getPingYin(x.getCategoryTitle());
            CategoryEntity category=new CategoryEntity();
            category.setCategoryPinyin(pingYin);
            category.setAppId(BasicUtil.getAppId());
            CategoryEntity categoryBizEntity = (CategoryEntity)categoryBiz.getEntity(category);
            x.setCategoryPinyin(pingYin);
            //拼音存在则拼接id
            if(categoryBizEntity!=null&&!categoryBizEntity.getId().equals(x.getId())){
                x.setCategoryPinyin(pingYin+x.getId());
            }
            categoryBiz.update(x);
        });
        //再更新路径
        list.forEach(x->{
            if(StrUtil.isBlank(x.getCategoryId())||x.getCategoryId().equals("0")){
                categoryBiz.updateEntity(x);
            }
        });

    }
}
