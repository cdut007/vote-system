package com.itender.ms.platform.webservice;

public class PspdeWSProxy implements PspdeWS {
  private String _endpoint = null;
  private PspdeWS pspdeWS = null;
  
  public PspdeWSProxy() {
    _initPspdeWSProxy();
  }
  
  public PspdeWSProxy(String endpoint) {
    _endpoint = endpoint;
    _initPspdeWSProxy();
  }
  
  private void _initPspdeWSProxy() {
    try {
      pspdeWS = (new PspdeWSServiceLocator()).getPspdeWSPort();
      if (pspdeWS != null) {
        if (_endpoint != null)
          ((javax.xml.rpc.Stub)pspdeWS)._setProperty("javax.xml.rpc.service.endpoint.address", _endpoint);
        else
          _endpoint = (String)((javax.xml.rpc.Stub)pspdeWS)._getProperty("javax.xml.rpc.service.endpoint.address");
      }
      
    }
    catch (javax.xml.rpc.ServiceException serviceException) {}
  }
  
  public String getEndpoint() {
    return _endpoint;
  }
  
  public void setEndpoint(String endpoint) {
    _endpoint = endpoint;
    if (pspdeWS != null)
      ((javax.xml.rpc.Stub)pspdeWS)._setProperty("javax.xml.rpc.service.endpoint.address", _endpoint);
    
  }
  
  public PspdeWS getPspdeWS() {
    if (pspdeWS == null)
      _initPspdeWSProxy();
    return pspdeWS;
  }
  
  public Result receiveInfo(String arg0, String arg1, String arg2, String arg3, String arg4, String arg5, String arg6, String arg7, String arg8) throws java.rmi.RemoteException{
    if (pspdeWS == null)
      _initPspdeWSProxy();
    return pspdeWS.receiveInfo(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8);
  }
  
  
}