package net.mingsoft.cms.biz.impl;

import com.alibaba.fastjson.JSONObject;
import net.mingsoft.cms.biz.ICacheBiz;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.cache.CacheManager;
import org.springframework.stereotype.Service;

@Service("abc")
public class EhcacheBizImpl implements ICacheBiz {

    @Autowired
    private CacheManager cacheManager;

    @Override
    public void set(String cacheName, String key, Object value) {
        this.cacheManager.getCache(cacheName).put(key, JSONObject.toJSONString(value));
    }

    @Override
    public <T> T get(String cacheName, String key, Class<T> cls) {
        String str = this.cacheManager.getCache(cacheName).get(key, String.class);
        if (StringUtils.isBlank(str)) {
            return null;
        }

        return JSONObject.parseObject(str, cls);
    }

    @Override
    public void del(String cacheName, String key) {
        this.cacheManager.getCache(cacheName).evictIfPresent(key);
    }
}