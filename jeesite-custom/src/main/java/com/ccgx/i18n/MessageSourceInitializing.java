package com.ccgx.i18n;

import org.springframework.beans.factory.InitializingBean;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 * 项目加载完成后才去执行messageSource的reload方法。
		默认在messageSource加载时执行reload，但是当时还没有初始化service类，会空指针，因此放在这里进行初始化
 * @author huangyun
 *
 */
@Service
public class MessageSourceInitializing implements InitializingBean {
	@Autowired
	private MessageResource messageSource;
	@Override
	public void afterPropertiesSet() throws Exception {
        //------------------------------------------------------------
        // 设置国际化多语言
        //------------------------------------------------------------
        messageSource.reload();
	}

}
