package com.itender.ms.service;

import com.itender.ms.domain.ItenderDevice;
import com.itender.ms.exception.APIException;

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
	

}
