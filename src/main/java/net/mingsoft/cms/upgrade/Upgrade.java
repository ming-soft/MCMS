package net.mingsoft.cms.upgrade;

import net.mingsoft.basic.util.SpringUtil;
import net.mingsoft.cms.biz.ICategoryBiz;
import net.mingsoft.cms.entity.CategoryEntity;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * @author by 铭飞开源团队
 * @Description
 * @date 2020/6/19 15:58
 */
public class Upgrade {

    /**
     * 更新栏目分类的顶级节点和叶子节点
     */
    public void upgrade(){
        ICategoryBiz categoryBiz = SpringUtil.getBean(ICategoryBiz.class);
        List<CategoryEntity> list = categoryBiz.queryAll();

        list.forEach(x->{

            //将parentId第一行设为顶级节点
            String topId = "0";
            String parentId = x.getParentids();
            if (parentId != null) {
                topId = parentId.split(",")[0];
            }
            x.setTopId(topId);

            String id = x.getId();
            boolean leaf = true;
            //判断是否叶子，循环查找，如果有节点的父节点中包含该节点的id则判断为否跳出循环
            for (int i = 0; i< list.size(); i++) {
                String pId = list.get(i).getParentids();
                if (pId == null) {
                    continue;
                }
                leaf = !pId.contains(id);
                //如果不是叶子就跳出循环，不需要再判断了
                if (!leaf) {
                    break;
                }
            }
            x.setLeaf(leaf);
            //更新
            Map<String, String> fields = new HashMap<>();
            fields.put("leaf", x.getLeaf()?"1":"0");
            fields.put("top_id", x.getTopId());
            Map<String, String> where = new HashMap<>();
            where.put("id", x.getId());
            categoryBiz.updateBySQL("cms_category", fields, where);
        });

    }
}
