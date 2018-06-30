package com.sxca.pspde.webservice.server;

import com.itender.ms.platform.Config;

import javax.xml.namespace.QName;
import javax.xml.ws.Service;
import javax.xml.ws.WebEndpoint;
import javax.xml.ws.WebServiceClient;
import java.net.MalformedURLException;
import java.net.URL;
import java.util.logging.Logger;

/**
 * This class was generated by the JAX-WS RI. JAX-WS RI 2.1.3-hudson-390-
 * Generated source version: 2.0
 * <p>
 * An example of how this class may be used:
 * 
 * <pre>
 * PspdeWSService service = new PspdeWSService();
 * PspdeWS portType = service.getPspdeWSPort();
 * portType.extract(...);
 * </pre>
 * 
 * </p>
 * 
 */
@WebServiceClient(name = "PspdeWSService", targetNamespace = "http://server.webservice.pspde.sxca.com/", wsdlLocation = Config.shanxiDomain+"/pspde/services/pspdews?wsdl")
public class PspdeWSService extends Service {

	private final static URL PSPDEWSSERVICE_WSDL_LOCATION;
	private final static Logger logger = Logger
			.getLogger(com.sxca.pspde.webservice.server.PspdeWSService.class
					.getName());

	static {
		URL url = null;
		try {
			URL baseUrl;
			baseUrl = com.sxca.pspde.webservice.server.PspdeWSService.class
					.getResource(".");
			url = new URL(baseUrl,
					Config.shanxiDomain+"/pspde/services/pspdews?wsdl");
		} catch (MalformedURLException e) {
			logger.warning("Failed to create URL for the wsdl Location: '"+Config.shanxiDomain+"/pspde/services/pspdews?wsdl', retrying as a local file");
			logger.warning(e.getMessage());
		}
		PSPDEWSSERVICE_WSDL_LOCATION = url;
	}

	public PspdeWSService(URL wsdlLocation, QName serviceName) {
		super(wsdlLocation, serviceName);
	}

	public PspdeWSService() {
		super(PSPDEWSSERVICE_WSDL_LOCATION, new QName(
				"http://server.webservice.pspde.sxca.com/", "PspdeWSService"));
	}

	/**
	 * 
	 * @return returns PspdeWS
	 */
	@WebEndpoint(name = "PspdeWSPort")
	public PspdeWS getPspdeWSPort() {
		return super.getPort(new QName(
				"http://server.webservice.pspde.sxca.com/", "PspdeWSPort"),
				PspdeWS.class);
	}

}
