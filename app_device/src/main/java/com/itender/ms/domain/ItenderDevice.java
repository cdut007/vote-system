package com.itender.ms.domain;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.itender.ms.enums.DeviceStatus;

import javax.persistence.*;
import java.util.List;
import java.util.Objects;

/**
 * 设备
 * @Author jameschen
 * @Date 2018/2/08 15:20
 */
@Table(name = "itender_device")
public class ItenderDevice {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private String id;

    @Column(name="model")
    private String model;//设备型号


    @Column(name="name")
    private String name;//设备名称


    //设备地址信息
    @Column(name="ip")
    private String ip;//设备ip
    //设备地址信息
    @Column(name="port")
    private String port;//设备端口

    //登录信息
    @Column(name="account")
    private String account;//设备账号
    //登录信息
    @Column(name="password")
    private String password;//设备密码


    @Column(name="status")
    private String status;//设备状态 ，normal 正常， unavailable 不可用


    @Column(name="maintenance_phone")
    private String maintenancePhone;//维护电话



    @Column(name="room_id")
    private String roomId;//房间号


    @Transient
    private String statusLabel;//显示中文


    @JsonIgnore
    public String toJson() {
        ObjectMapper jsonMapper = new ObjectMapper();
        try {
            return jsonMapper.writeValueAsString(this);
        } catch (JsonProcessingException e) {
            e.printStackTrace();
        }
        return  null;
    }


    public String getStatusLabel() {
        if(DeviceStatus.normal.name().equals(status)){
            statusLabel = "正常";
        }else{
            statusLabel = "损坏";
        }
        return statusLabel;
    }

    public String getRoomId() {
        return roomId;
    }

    public void setRoomId(String roomId) {
        this.roomId = roomId;
    }


    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getModel() {
        return model;
    }

    public void setModel(String model) {
        this.model = model;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getIp() {
        return ip;
    }

    public void setIp(String ip) {
        this.ip = ip;
    }

    public String getPort() {
        return port;
    }

    public void setPort(String port) {
        this.port = port;
    }

    public String getAccount() {
        return account;
    }

    public void setAccount(String account) {
        this.account = account;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getMaintenancePhone() {
        return maintenancePhone;
    }

    public void setMaintenancePhone(String maintenancePhone) {
        this.maintenancePhone = maintenancePhone;
    }

    public boolean equals(Object object) {
        if (this == object) return true;
        if (object == null || getClass() != object.getClass()) return false;
        if (!super.equals(object)) return false;
        ItenderDevice that = (ItenderDevice) object;
        return java.util.Objects.equals(id, that.id) &&
                java.util.Objects.equals(model, that.model) &&
                java.util.Objects.equals(name, that.name) &&
                java.util.Objects.equals(ip, that.ip) &&
                java.util.Objects.equals(port, that.port) &&
                java.util.Objects.equals(account, that.account) &&
                java.util.Objects.equals(password, that.password) &&
                java.util.Objects.equals(status, that.status) &&
                java.util.Objects.equals(maintenancePhone, that.maintenancePhone);
    }

    public int hashCode() {

        return Objects.hash(super.hashCode(), id, model, name, ip, port, account, password, status, maintenancePhone);
    }

    @Override
    public String toString() {
        return "ItenderDevice{" +
                "id='" + id + '\'' +
                ", model='" + model + '\'' +
                ", name='" + name + '\'' +
                ", ip='" + ip + '\'' +
                ", port='" + port + '\'' +
                ", account='" + account + '\'' +
                ", password='" + password + '\'' +
                ", status='" + status + '\'' +
                ", maintenancePhone='" + maintenancePhone + '\'' +
                ", roomId='" + roomId + '\'' +
                '}';
    }
}
