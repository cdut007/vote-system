package com.itender.ms.service.impl;

import com.corundumstudio.socketio.*;
import com.corundumstudio.socketio.listener.ConnectListener;
import com.corundumstudio.socketio.listener.DataListener;
import com.corundumstudio.socketio.listener.DisconnectListener;
import com.itender.ms.config.HttpConfig;
import com.itender.ms.controller.ReviewController;
import com.itender.ms.domain.ChatObject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.*;

@Service("socketIoService")
public class SocketIoService {
	private static final Logger logger = LoggerFactory.getLogger(ReviewController.class);

	 SocketIONamespace chat1namespace;
	static SocketIOServer server;
	static Map<String,SocketIOClient> clientsMap  = new HashMap<String, SocketIOClient>();

	@Autowired
	private HttpConfig httpConfig;

	/**
	 * 停止服务
	 */
	public void stopServer(){
		if(server != null){
			server.stop();
			server = null;
		}
	}

	public static SocketIOServer getServer() {
		return server;
	}


	public void startSokectIO(){
		try {
			if (getServer() == null) {
				new Thread(new Runnable() {
					@Override
					public void run() {
						try {
							startServer();
							checkClient();
						} catch (InterruptedException e) {
							logger.error(e.getLocalizedMessage());
						}
					}
				}).start();
			}else{
				checkClient();
			}
		} catch (Exception e) {
			logger.error(e.getLocalizedMessage());
		}

	}

	private void checkClient() {
		if(chat1namespace!=null){
			Collection<SocketIOClient> socketIOClients = chat1namespace.getAllClients();
			Iterator it =socketIOClients.iterator();
			while(it.hasNext()){
				SocketIOClient socketIOClient = (SocketIOClient)it.next();
			}//针对remove方法存在问题

		}

	}

	private void startServer() throws InterruptedException{
		Configuration config = new Configuration();
		config.setHostname(httpConfig.getSocket());
		config.setPort(9091);
		config.setMaxFramePayloadLength(1024 * 1024);
		config.setMaxHttpContentLength(1024 * 1024);

		server = new SocketIOServer(config);
	    chat1namespace = server.addNamespace("/sign");
		chat1namespace.addEventListener("chatevent", ChatObject.class, new DataListener<ChatObject>() {
			@Override
			public void onData(SocketIOClient client, ChatObject data, AckRequest ackRequest) {
				// broadcast messages to all clients
				chat1namespace.getBroadcastOperations().sendEvent("chatevent", data);
			}
		});



//		final SocketIONamespace chat2namespace = server.addNamespace("/chat2");
//		chat2namespace.addEventListener("message", ChatObject.class, new DataListener<ChatObject>() {
//			@Override
//			public void onData(SocketIOClient client, ChatObject data, AckRequest ackRequest) {
//				// broadcast messages to all clients
//				chat2namespace.getBroadcastOperations().sendEvent("message", data);
//			}
//		});


		server.addDisconnectListener(new DisconnectListener() {
			@Override
			public void onDisconnect(SocketIOClient socketIOClient) {
				logger.debug("==socketIOClient onDisconnect=="+socketIOClient.toString());
			}
		});

		//添加客户端连接事件
		server.addConnectListener(new ConnectListener() {

			@Override
			public void onConnect(SocketIOClient client) {
				logger.debug("==socketIOClient onConnect=="+client.toString());


			}
		});


		server.start();

		Thread.sleep(Integer.MAX_VALUE);

		server.stop();



	}

}
