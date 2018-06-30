package com.itender.ms.platform.webservice;

import org.apache.axis.AxisFault;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import javax.xml.bind.JAXBContext;
import javax.xml.bind.Marshaller;
import java.io.StringWriter;
import java.net.MalformedURLException;
import java.rmi.RemoteException;
import java.text.SimpleDateFormat;
import java.util.Date;

public class ServiceClient {
	private   static Logger logger = LoggerFactory.getLogger(ServiceClient.class);

    private String requestUrl;
    private String appId;
    private String appKey;
    private PspdeWSServiceLocator service = null;
    private PspdeWSServiceSoapBindingStub stub = null;

    public ServiceClient(String url, String userId, String key) throws AxisFault, MalformedURLException {
        this.requestUrl = url;
        this.appId = userId;
        this.appKey = key;

        init();
    }

    private void init() throws MalformedURLException, AxisFault {
        service = new PspdeWSServiceLocator();
        java.net.URL url = new java.net.URL(this.requestUrl);
        stub = new PspdeWSServiceSoapBindingStub(url, service);
    }

    /**
     * @param SERIALNUMBER 10位用户ID+8位日期(yyyyMMdd)+6位自增长整数
     * @param DATASETCODE  XML内容根节点（类型标示符必须和业务对象清单标示符一致）
     * @param obj          业务对象
     * @param platId       数据在平台的唯一标识
     * @param creditCode   用户在公共服务平台注册的组织机构代码
     * @return
     * @throws RemoteException
     */
    public Result receiveInfo(String SERIALNUMBER, String DATASETCODE, Object obj, String platId,String creditCode)
            throws RemoteException {
        // serLogic.ReceiveInfo(USERID, KEY, SERIALNUMBER, DATASETCODE,
        // XMLCONTENT, REQUESTTIME,VERSIONNUMBER, PLATID);
        // stub.receiveInfo(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7,
        // arg8);
        // serLogic.ReceiveInfo(USERID, KEY, SERIALNUMBER, DATASETCODE,
        // XMLCONTENT, REQUESTTIME,VERSIONNUMBER, PLATID);
        Date date = new Date();
        String REQUESTTIME = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(date);
        String VERSIONNUMBER = new SimpleDateFormat("yyyyMMddHHmmss").format(date);

//        return stub.receiveInfo(this.appId, this.appKey, SERIALNUMBER, DATASETCODE, convertToXml(obj, "UTF-8"),
//                REQUESTTIME, VERSIONNUMBER, platId, null);

        return stub.receiveInfo(this.appId, this.appKey, SERIALNUMBER, DATASETCODE, convertToXml(obj, "UTF-8"),
                REQUESTTIME, VERSIONNUMBER, platId, creditCode);
    }

    public static String convertToXml(Object obj, String encoding) {
        String result = null;
        try {
            JAXBContext context = JAXBContext.newInstance(obj.getClass());
            Marshaller marshaller = context.createMarshaller();
            marshaller.setProperty(Marshaller.JAXB_FORMATTED_OUTPUT, true);
            marshaller.setProperty(Marshaller.JAXB_ENCODING, encoding);

            StringWriter writer = new StringWriter();
            marshaller.marshal(obj, writer);
            result = writer.toString();
        } catch (Exception e) {
            logger.error(e.getMessage(), e);;
        }
        return result;
    }

    public static class ResponseEntity {
        String ResponseEntity;
        String SERVICEFLAG;
        String RESULTNUM;
        String MESSAGE;
        String RESPONSETIME;


        String errorCode;

        private String errorMessage;

        private boolean success;

    }


}
