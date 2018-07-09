package com.sxca.pspde.webservice.server;

import javax.jws.WebMethod;
import javax.jws.WebParam;
import javax.jws.WebResult;
import javax.jws.WebService;
import javax.xml.bind.annotation.XmlSeeAlso;
import javax.xml.ws.RequestWrapper;
import javax.xml.ws.ResponseWrapper;

/**
 * This class was generated by Apache CXF 3.1.12
 * 2017-07-27T11:06:05.842+08:00
 * Generated source version: 3.1.12
 * 
 */
@WebService(targetNamespace = "http://server.webservice.pspde.sxca.com/", name = "PspdeFileWS")
@XmlSeeAlso({ObjectFactory.class})
public interface PspdeFileWS {

    @WebMethod
    @RequestWrapper(localName = "saveAttachments", targetNamespace = "http://server.webservice.pspde.sxca.com/", className = "com.sxca.pspde.webservice.server.SaveAttachments")
    @ResponseWrapper(localName = "saveAttachmentsResponse", targetNamespace = "http://server.webservice.pspde.sxca.com/", className = "com.sxca.pspde.webservice.server.SaveAttachmentsResponse")
    @WebResult(name = "return", targetNamespace = "")
    public com.sxca.pspde.webservice.server.Result saveAttachments(
            @WebParam(name = "arg0", targetNamespace = "")
                    com.sxca.pspde.webservice.server.AttachmentsWS arg0
    );
}