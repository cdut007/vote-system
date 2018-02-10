package com.itender.ms.service;

import com.itender.ms.domain.ItenderDevice;
import com.itender.ms.exception.APIException;

import java.util.List;

/**
 * @Author james chen
 * @Date 2018/2/08 15:48
 */
public interface ItenderDeviceService extends ItenderServiceBase<ItenderDevice> {

	public ItenderDevice findByDeviceId(String deviceId);
	/**
	 * 按设备名查询
	 * @param deviceName
	 * @return
	 */
	public ItenderDevice findByDeviceName(String deviceName) throws APIException;
	
	/**
	 * 更新设备信息
	 * @param device
	 * @return
	 */
	public ItenderDevice updateDevice(ItenderDevice device) throws APIException;




	public List<ItenderDevice> getAvailableDeviceList() throws APIException;


	public List<ItenderDevice> getRoomDeviceList() throws APIException;


	/**
	 * 绑定房间信息
	 * @param device
	 * @param roomId
	 * @return
	 */
	public ItenderDevice bindRoom(ItenderDevice device,String roomId) throws APIException;


	/**
	 * 解除绑定房间信息
	 * @param device
	 * @return
	 */
	public ItenderDevice unbindRoom(ItenderDevice device) throws APIException;
	

}
