package com.mingsoft.constant;

public enum SessionConst {
	
	
	/**
	 * 用户的session
	 */
	PEOPLE_SESSION("people_session"),
	
	/**
	 *用户取回密码的session
	 */
	PEOPLE_GET_PASSWORD_SESSION("people_get_password_session"),
	
	/**
	 * 用户更改手机号码的session
	 */
	PEOPEL_SET_PHONE_SESSION("people_set_phone_seesion"),
	
	/**
	 * 模块idsession
	 */
	MODEL_ID_SESSION("model_id_session"),
	
	/**
	 * 模块名称  
	 */
	MODEL_TITLE_SESSION("model_title_session"),
	
	/**
	 * 普通管理员的sesison
	 */
	MANAGER_ESSION("manager_session"),
	
	/**
	 * 验证码session
	 */
	CODE_SESSION("rand_code"),
	
	/**
	 * 普通管理员角色菜单的sesison
	 */
	MANAGER_ROLE_MODEL_ESSION("manager_role_model_session"),
	
	
	/**
	 * 模块编号
	 */
	MANAGER_MODEL_CODE("manager_model_code"),

	/**
	 * QQ登录保存当前用户点击地址的session
	 */
	API_LOGIN_QQ_URL("api_login_qq_url");

/**微信相关开始*/

/**微信相关结束*/

	
	SessionConst(String attr) {
		this.attr = attr;
	}
	
	
	
	private String attr;



	/* (non-Javadoc)
	 * @see java.lang.Enum#toString()
	 */
	@Override
	public String toString() {
		// TODO Auto-generated method stub
		return attr;
	}
	
}
