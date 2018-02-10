package com.itender.ms.domain;

import javax.persistence.*;
import java.util.ArrayList;
import java.util.List;
import java.util.Objects;

/**
 * 设备
 * @Author jameschen
 * @Date 2018/2/10 15:20
 */
@Table(name = "itender_room")
public class ItenderRoom {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private String id;

    @Column(name="name")
    private String name;//房间名

    @Column(name="description")
    private String description;//房间描述




    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }


    public String getDevices_info() {
        return devices_info;
    }

    public void setDevices_info(String devices_info) {
        this.devices_info = devices_info;
    }

    @Transient
    private  String devices_info;//设备信息


    @Transient
    private  List<ItenderDevice> deviceList;//添加设备信息


    public List<ItenderDevice> getDeviceList() {
        if(deviceList == null){
            return  new ArrayList<>();
        }
        return deviceList;
    }

    public void setDeviceList(List<ItenderDevice> deviceList) {
        this.deviceList = deviceList;
    }



    @Override
    public String toString() {
        return "ItenderRoom{" +
                "id='" + id + '\'' +
                ", name='" + name + '\'' +
                ", description='" + description + '\'' +
                '}';
    }
}
