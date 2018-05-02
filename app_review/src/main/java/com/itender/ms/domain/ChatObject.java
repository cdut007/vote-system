package com.itender.ms.domain;

public class ChatObject {

	private String userName;
	private String message;
	private long timestamp;

	public ChatObject() {
	}

	public ChatObject(String userName, String message,long timestamp) {
		super();
		this.timestamp = timestamp;
		this.userName = userName;
		this.message = message;
	}

	public void setTimestamp(long timestamp) {
		this.timestamp = timestamp;
	}

	public long getTimestamp() {
		return timestamp;
	}

	public String getUserName() {
		return userName;
	}
	public void setUserName(String userName) {
		this.userName = userName;
	}

	public String getMessage() {
		return message;
	}
	public void setMessage(String message) {
		this.message = message;
	}

}
