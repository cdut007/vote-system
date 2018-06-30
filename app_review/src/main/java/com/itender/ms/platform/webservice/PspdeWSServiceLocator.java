/**
 * PspdeWSServiceLocator.java
 *
 * This file was auto-generated from WSDL
 * by the Apache Axis 1.4 Apr 22, 2006 (06:55:48 PDT) WSDL2Java emitter.
 */

package com.itender.ms.platform.webservice;

import com.itender.ms.platform.Config;

public class PspdeWSServiceLocator extends org.apache.axis.client.Service implements PspdeWSService {

    public PspdeWSServiceLocator() {
    }


    public PspdeWSServiceLocator(org.apache.axis.EngineConfiguration config) {
        super(config);
    }

    public PspdeWSServiceLocator(String wsdlLoc, javax.xml.namespace.QName sName) throws javax.xml.rpc.ServiceException {
        super(wsdlLoc, sName);
    }

    // Use to get a proxy class for PspdeWSPort
    private String PspdeWSPort_address = Config.shanxiDomain+"/pspde/services/pspdews";

    public String getPspdeWSPortAddress() {
        return PspdeWSPort_address;
    }

    // The WSDD service name defaults to the port name.
    private String PspdeWSPortWSDDServiceName = "PspdeWSPort";

    public String getPspdeWSPortWSDDServiceName() {
        return PspdeWSPortWSDDServiceName;
    }

    public void setPspdeWSPortWSDDServiceName(String name) {
        PspdeWSPortWSDDServiceName = name;
    }

    public PspdeWS getPspdeWSPort() throws javax.xml.rpc.ServiceException {
       java.net.URL endpoint;
        try {
            endpoint = new java.net.URL(PspdeWSPort_address);
        }
        catch (java.net.MalformedURLException e) {
            throw new javax.xml.rpc.ServiceException(e);
        }
        return getPspdeWSPort(endpoint);
    }

    public PspdeWS getPspdeWSPort(java.net.URL portAddress) throws javax.xml.rpc.ServiceException {
        try {
            PspdeWSServiceSoapBindingStub _stub = new PspdeWSServiceSoapBindingStub(portAddress, this);
            _stub.setPortName(getPspdeWSPortWSDDServiceName());
            return _stub;
        }
        catch (org.apache.axis.AxisFault e) {
            return null;
        }
    }

    public void setPspdeWSPortEndpointAddress(String address) {
        PspdeWSPort_address = address;
    }

    /**
     * For the given interface, get the stub implementation.
     * If this service has no port for the given interface,
     * then ServiceException is thrown.
     */
    public java.rmi.Remote getPort(Class serviceEndpointInterface) throws javax.xml.rpc.ServiceException {
        try {
            if (PspdeWS.class.isAssignableFrom(serviceEndpointInterface)) {
                PspdeWSServiceSoapBindingStub _stub = new PspdeWSServiceSoapBindingStub(new java.net.URL(PspdeWSPort_address), this);
                _stub.setPortName(getPspdeWSPortWSDDServiceName());
                return _stub;
            }
        }
        catch (Throwable t) {
            throw new javax.xml.rpc.ServiceException(t);
        }
        throw new javax.xml.rpc.ServiceException("There is no stub implementation for the interface:  " + (serviceEndpointInterface == null ? "null" : serviceEndpointInterface.getName()));
    }

    /**
     * For the given interface, get the stub implementation.
     * If this service has no port for the given interface,
     * then ServiceException is thrown.
     */
    public java.rmi.Remote getPort(javax.xml.namespace.QName portName, Class serviceEndpointInterface) throws javax.xml.rpc.ServiceException {
        if (portName == null) {
            return getPort(serviceEndpointInterface);
        }
        String inputPortName = portName.getLocalPart();
        if ("PspdeWSPort".equals(inputPortName)) {
            return getPspdeWSPort();
        }
        else  {
            java.rmi.Remote _stub = getPort(serviceEndpointInterface);
            ((org.apache.axis.client.Stub) _stub).setPortName(portName);
            return _stub;
        }
    }

    public javax.xml.namespace.QName getServiceName() {
        return new javax.xml.namespace.QName("http://server.webservice.pspde.sxca.com/", "PspdeWSService");
    }

    private java.util.HashSet ports = null;

    public java.util.Iterator getPorts() {
        if (ports == null) {
            ports = new java.util.HashSet();
            ports.add(new javax.xml.namespace.QName("http://server.webservice.pspde.sxca.com/", "PspdeWSPort"));
        }
        return ports.iterator();
    }

    /**
    * Set the endpoint address for the specified port name.
    */
    public void setEndpointAddress(String portName, String address) throws javax.xml.rpc.ServiceException {

if ("PspdeWSPort".equals(portName)) {
            setPspdeWSPortEndpointAddress(address);
        }
        else
{ // Unknown Port Name
            throw new javax.xml.rpc.ServiceException(" Cannot set Endpoint Address for Unknown Port" + portName);
        }
    }

    /**
    * Set the endpoint address for the specified port name.
    */
    public void setEndpointAddress(javax.xml.namespace.QName portName, String address) throws javax.xml.rpc.ServiceException {
        setEndpointAddress(portName.getLocalPart(), address);
    }

}
