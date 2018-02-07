package com.itender.interceptor;

import java.util.ArrayList;
import java.util.List;

import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.stereotype.Component;

@Component
@ConfigurationProperties(prefix="privilege-uri-init")
public class PropertiesConfig {
	
	public String no_permission_uri;
	public List<String> always_unreturn_uri = new ArrayList<String>();
	public List<String> always_uncheck_uri = new ArrayList<String>();
	public List<String> login_uncheck_uri = new ArrayList<String>();
	public String backend_login_uri;
	public String frontend_login_uri;
	public String backend_check_prefix;
	public String frontend_check_prefix;

	public String getNo_permission_uri() {
		return no_permission_uri;
	}

	public void setNo_permission_uri(String no_permission_uri) {
		this.no_permission_uri = no_permission_uri;
	}

	public List<String> getAlways_unreturn_uri() {
		return always_unreturn_uri;
	}

	public void setAlways_unreturn_uri(List<String> always_unreturn_uri) {
		this.always_unreturn_uri = always_unreturn_uri;
	}

	public List<String> getAlways_uncheck_uri() {
		return always_uncheck_uri;
	}

	public void setAlways_uncheck_uri(List<String> always_uncheck_uri) {
		this.always_uncheck_uri = always_uncheck_uri;
	}

	public List<String> getLogin_uncheck_uri() {
		return login_uncheck_uri;
	}

	public void setLogin_uncheck_uri(List<String> login_uncheck_uri) {
		this.login_uncheck_uri = login_uncheck_uri;
	}

	public String getBackend_login_uri() {
		return backend_login_uri;
	}

	public void setBackend_login_uri(String backend_login_uri) {
		this.backend_login_uri = backend_login_uri;
	}

	public String getFrontend_login_uri() {
		return frontend_login_uri;
	}

	public void setFrontend_login_uri(String frontend_login_uri) {
		this.frontend_login_uri = frontend_login_uri;
	}

	public String getBackend_check_prefix() {
		return backend_check_prefix;
	}

	public void setBackend_check_prefix(String backend_check_prefix) {
		this.backend_check_prefix = backend_check_prefix;
	}

	public String getFrontend_check_prefix() {
		return frontend_check_prefix;
	}

	public void setFrontend_check_prefix(String frontend_check_prefix) {
		this.frontend_check_prefix = frontend_check_prefix;
	}
}