package net.mingsoft.cms.biz;

public interface ICacheBiz {

    void set(String cacheName, String key, Object value);

    <T> T get(String cacheName, String key, Class<T> cls);

    void del(String cacheName, String key);

}