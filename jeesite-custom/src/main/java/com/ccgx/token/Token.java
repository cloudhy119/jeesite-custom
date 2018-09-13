package com.ccgx.token;

import java.lang.annotation.ElementType;
import java.lang.annotation.Retention;
import java.lang.annotation.RetentionPolicy;
import java.lang.annotation.Target;

@Target(ElementType.METHOD)  
@Retention(RetentionPolicy.RUNTIME) 
public @interface Token {
	
	boolean create() default false;  
	  
    boolean validate() default false;  

}
