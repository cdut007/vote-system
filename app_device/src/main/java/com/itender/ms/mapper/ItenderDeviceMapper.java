package com.itender.ms.mapper;

import com.itender.ms.domain.ItenderDevice;

import tk.mybatis.mapper.common.Mapper;

/**
 * @Author james chen
 * @Date 2018/2/08 15:48
 */
public interface ItenderDeviceMapper extends Mapper<ItenderDevice> {
	
	public ItenderDevice selectByDeviceId(String deviceId);
	
	public ItenderDevice selectByDeviceName(String deviceName);
	
	public int updateDevice(ItenderDevice itenderDevice);

	public int insertDevice(ItenderDevice itenderDevice);

	public int deleteByDeviceId(String deviceId);

}
