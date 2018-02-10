package com.itender.ms.service.impl;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.itender.ms.domain.ItenderDevice;
import com.itender.ms.enums.DeviceStatus;
import com.itender.ms.exception.APIException;
import com.itender.ms.mapper.ItenderDeviceMapper;
import com.itender.ms.service.ItenderDeviceService;
import com.itender.ms.util.CommonUtility;
import com.itender.ms.util.PasswordUtil;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;
import tk.mybatis.mapper.entity.Example;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

/**
 * @Author james chen
 * @Date 2018/2/08 16:48
 */
@Service
public class ItenderDeviceServiceImpl implements ItenderDeviceService {
	private static final Logger logger = LoggerFactory.getLogger(ItenderDeviceServiceImpl.class);
	private static final String KEY = "com.itender";
    @Autowired
    private ItenderDeviceMapper itenderDeviceMapper;





	public static void main(String[] args) throws APIException{
		ItenderDeviceServiceImpl s = new ItenderDeviceServiceImpl();
		String ss = "123";
		String dss = "iAWSYC2JKHXp8Mxue3ObBg==";
		//System.out.println(s.enPassword(ss));

	}


	@Override
	public Integer deleteById(String id) {
		ItenderDevice itenderDevice = new ItenderDevice();
		itenderDevice.setId(id);
		return itenderDeviceMapper.delete(itenderDevice);
	}

	@Override
	public ItenderDevice findById(String id) {
		return itenderDeviceMapper.selectByPrimaryKey(id);
	}


	@Override
	public ItenderDevice findByDeviceId(String deviceId) {
		 return itenderDeviceMapper.selectByPrimaryKey(deviceId);
	}

	@Override
	public ItenderDevice findByDeviceName(String deviceName) throws APIException {
		return itenderDeviceMapper.selectByDeviceName(deviceName);
	}

	@Override
	public ItenderDevice updateDevice(ItenderDevice device) throws APIException {
		if(device == null){
			return null;
		}

		int rows = itenderDeviceMapper.updateDevice(device);
		return rows == 0?null:device;
	}

	@Override
	public List<ItenderDevice> getRoomDeviceList() throws APIException {
		List<ItenderDevice>  deviceList = itenderDeviceMapper.selectAll();
		List<ItenderDevice> available = new ArrayList<>();
		if(deviceList!=null && deviceList.size() > 0){
			for (int i = 0; i < deviceList.size(); i++) {
				ItenderDevice device = deviceList.get(i);
				if(CommonUtility.isNonEmpty(device.getRoomId())){
					available.add(device);
				}

			}
		}
		return available;
	}

	@Override
	public List<ItenderDevice> getAvailableDeviceList() throws APIException {
		List<ItenderDevice>  deviceList = itenderDeviceMapper.selectAll();
		List<ItenderDevice> available = new ArrayList<>();
		if(deviceList!=null && deviceList.size() > 0){
			for (int i = 0; i < deviceList.size(); i++) {
				ItenderDevice device = deviceList.get(i);
				if(!CommonUtility.isNonEmpty(device.getRoomId()) && DeviceStatus.normal.name().equals(device.getStatus())){
					available.add(device);
				}

			}
		}
		return available;
	}

	@Override
	public ItenderDevice bindRoom(ItenderDevice device, String roomId) throws APIException {
		device.setRoomId(roomId);
		int rows = itenderDeviceMapper.updateDevice(device);
		return rows == 0?null:device;
	}

	@Override
	public ItenderDevice unbindRoom(ItenderDevice device) throws APIException {
		device.setRoomId("");
		return updateDevice(device);
	}

	@Override
	public ItenderDevice add(ItenderDevice device) throws APIException {
		int rows = itenderDeviceMapper.insertSelective(device);

		return rows == 0?null:device;
	}

	@Override
	public List<ItenderDevice> findAll() throws APIException {
		return itenderDeviceMapper.selectAll();
	}

	@Override
	public PageInfo<ItenderDevice> findPage(Integer pageNum, Integer pagesize) throws APIException {
		PageHelper.startPage(pageNum,pagesize);

        Example example = new Example(ItenderDevice.class);
        List<ItenderDevice> itenderDevice = itenderDeviceMapper.selectByExample(example);
        return new PageInfo<>(itenderDevice);
	}


}
