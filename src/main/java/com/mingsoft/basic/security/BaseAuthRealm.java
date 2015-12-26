package com.mingsoft.basic.security;

import java.util.List;

import org.apache.shiro.authc.AuthenticationException;
import org.apache.shiro.authc.AuthenticationInfo;
import org.apache.shiro.authc.AuthenticationToken;
import org.apache.shiro.authc.SimpleAuthenticationInfo;
import org.apache.shiro.authc.UsernamePasswordToken;
import org.apache.shiro.authc.credential.SimpleCredentialsMatcher;
import org.apache.shiro.authz.AuthorizationInfo;
import org.apache.shiro.authz.SimpleAuthorizationInfo;
import org.apache.shiro.cache.Cache;
import org.apache.shiro.realm.AuthorizingRealm;
import org.apache.shiro.subject.PrincipalCollection;
import org.apache.shiro.subject.SimplePrincipalCollection;
import org.springframework.beans.factory.annotation.Autowired;

import com.mingsoft.base.entity.BaseEntity;
import com.mingsoft.basic.biz.IManagerBiz;
import com.mingsoft.basic.biz.IModelBiz;
import com.mingsoft.basic.entity.ManagerEntity;
import com.mingsoft.basic.entity.ModelEntity;
import com.mingsoft.util.StringUtil;

/**
 * 权限
 * 
 * @author killfenQQ:78750478
 * @version 版本号：<br/>
 *          创建日期：2015年9月9日<br/>
 *          历史修订：<br/>
 */
public class BaseAuthRealm extends AuthorizingRealm {
	
	/**
	 * 管理员业务层
	 */
	@Autowired
	private IManagerBiz managerBiz;
	
	/**
	 * 模块业务层
	 */
	@Autowired
	private IModelBiz modelBiz;

	/**
	 * 构造
	 */
	public BaseAuthRealm() {
		// TODO Auto-generated constructor stub
		super();
		// 设置认证token的实现类
		setAuthenticationTokenClass(UsernamePasswordToken.class);
		// 设置加密算法
		setCredentialsMatcher(new SimpleCredentialsMatcher());
	}

	/**
	 * 功能操作授权
	 */
	protected AuthorizationInfo doGetAuthorizationInfo(PrincipalCollection principalCollection) {
		String loginName = (String) principalCollection.fromRealm(getName()).iterator().next();
		ManagerEntity manager = managerBiz.queryManagerByManagerName(loginName);
		if (null == manager) {
			return null;
		} else {
			SimpleAuthorizationInfo result = new SimpleAuthorizationInfo();
			// 查询管理员对应的角色
			List<BaseEntity> models = modelBiz.queryModelByRoleId(manager.getManagerRoleID());
			for (BaseEntity e:models) {
				ModelEntity me = (ModelEntity) e;
				if (!StringUtil.isBlank(me.getModelUrl())) {
					result.addStringPermission(me.getModelUrl());
				}
			}
			return result;

		}
	}

	/**
	 * 新登用户验证
	 */
	protected AuthenticationInfo doGetAuthenticationInfo(AuthenticationToken token) throws AuthenticationException {
		UsernamePasswordToken upToken = (UsernamePasswordToken) token;
		ManagerEntity manager = managerBiz.queryManagerByManagerName(upToken.getUsername());
		if (manager != null) {
			return new SimpleAuthenticationInfo(manager.getManagerName(), manager.getManagerPassword(), getName());
		}
		return null;
	}

	/**
	 * 更新用户授权信息缓存.
	 */
	public void clearCachedAuthorizationInfo(String principal) {
		SimplePrincipalCollection principals = new SimplePrincipalCollection(principal, getName());
		clearCachedAuthorizationInfo(principals);
	}

	/**
	 * 清除所有用户授权信息缓存.
	 */
	public void clearAllCachedAuthorizationInfo() {
		Cache<Object, AuthorizationInfo> cache = getAuthorizationCache();
		if (cache != null) {
			for (Object key : cache.keys()) {
				cache.remove(key);
			}
		}
	}
}
