package com.sxca.pspde.webservice.server;

import javax.xml.bind.JAXBElement;
import javax.xml.bind.annotation.XmlElementDecl;
import javax.xml.bind.annotation.XmlRegistry;
import javax.xml.namespace.QName;

/**
 * This object contains factory methods for each Java content interface and Java
 * element interface generated in the com.sxca.pspde.webservice.server package.
 * <p>
 * An ObjectFactory allows you to programatically construct new instances of the
 * Java representation for XML content. The Java representation of XML content
 * can consist of schema derived interfaces and classes representing the binding
 * of schema type definitions, element declarations and model groups. Factory
 * methods for each of these are provided in this class.
 * 
 */
@XmlRegistry
public class ObjectFactory {

	private final static QName _ExpertSpecialtyEdit_QNAME = new QName(
			"http://server.webservice.pspde.sxca.com/", "expertSpecialtyEdit");
	private final static QName _ExpertApplyResponse_QNAME = new QName(
			"http://server.webservice.pspde.sxca.com/", "expertApplyResponse");
	private final static QName _ReceiveInfo_QNAME = new QName(
			"http://server.webservice.pspde.sxca.com/", "receiveInfo");
	private final static QName _GetExtractResult_QNAME = new QName(
			"http://server.webservice.pspde.sxca.com/", "getExtractResult");
	private final static QName _ExpertSpecialtyEditResponse_QNAME = new QName(
			"http://server.webservice.pspde.sxca.com/",
			"expertSpecialtyEditResponse");
	private final static QName _GetExtractResultResponse_QNAME = new QName(
			"http://server.webservice.pspde.sxca.com/",
			"getExtractResultResponse");
	private final static QName _ExpertApply_QNAME = new QName(
			"http://server.webservice.pspde.sxca.com/", "expertApply");
	private final static QName _Extract_QNAME = new QName(
			"http://server.webservice.pspde.sxca.com/", "extract");
	private final static QName _GetExpertApplyStatus_QNAME = new QName(
			"http://server.webservice.pspde.sxca.com/", "getExpertApplyStatus");
	private final static QName _ExtractResponse_QNAME = new QName(
			"http://server.webservice.pspde.sxca.com/", "extractResponse");
	private final static QName _GetExpertApplyStatusResponse_QNAME = new QName(
			"http://server.webservice.pspde.sxca.com/",
			"getExpertApplyStatusResponse");
	private final static QName _ReceiveInfoResponse_QNAME = new QName(
			"http://server.webservice.pspde.sxca.com/", "receiveInfoResponse");
    private final static QName _AttachmentsWS_QNAME = new QName("http://server.webservice.pspde.sxca.com/", "attachmentsWS");
    private final static QName _SaveAttachments_QNAME = new QName("http://server.webservice.pspde.sxca.com/", "saveAttachments");
    private final static QName _SaveAttachmentsResponse_QNAME = new QName("http://server.webservice.pspde.sxca.com/", "saveAttachmentsResponse");
    /**
     * Create an instance of {@link AttachmentsWS }
     * 
     */
    public AttachmentsWS createAttachmentsWS() {
        return new AttachmentsWS();
    }

    /**
     * Create an instance of {@link SaveAttachments }
     * 
     */
    public SaveAttachments createSaveAttachments() {
        return new SaveAttachments();
    }

    /**
     * Create an instance of {@link SaveAttachmentsResponse }
     * 
     */
    public SaveAttachmentsResponse createSaveAttachmentsResponse() {
        return new SaveAttachmentsResponse();
    }

    /**
     * Create an instance of {@link BaseWSEntity }
     * 
     */
    public BaseWSEntity createBaseWSEntity() {
        return new BaseWSEntity();
    }


    /**
     * Create an instance of {@link JAXBElement }{@code <}{@link AttachmentsWS }{@code >}}
     * 
     */
    @XmlElementDecl(namespace = "http://server.webservice.pspde.sxca.com/", name = "attachmentsWS")
    public JAXBElement<AttachmentsWS> createAttachmentsWS(AttachmentsWS value) {
        return new JAXBElement<AttachmentsWS>(_AttachmentsWS_QNAME, AttachmentsWS.class, null, value);
    }

    /**
     * Create an instance of {@link JAXBElement }{@code <}{@link SaveAttachments }{@code >}}
     * 
     */
    @XmlElementDecl(namespace = "http://server.webservice.pspde.sxca.com/", name = "saveAttachments")
    public JAXBElement<SaveAttachments> createSaveAttachments(SaveAttachments value) {
        return new JAXBElement<SaveAttachments>(_SaveAttachments_QNAME, SaveAttachments.class, null, value);
    }

    /**
     * Create an instance of {@link JAXBElement }{@code <}{@link SaveAttachmentsResponse }{@code >}}
     * 
     */
    @XmlElementDecl(namespace = "http://server.webservice.pspde.sxca.com/", name = "saveAttachmentsResponse")
    public JAXBElement<SaveAttachmentsResponse> createSaveAttachmentsResponse(SaveAttachmentsResponse value) {
        return new JAXBElement<SaveAttachmentsResponse>(_SaveAttachmentsResponse_QNAME, SaveAttachmentsResponse.class, null, value);
    }
	/**
	 * Create a new ObjectFactory that can be used to create new instances of
	 * schema derived classes for package: com.sxca.pspde.webservice.server
	 * 
	 */
	public ObjectFactory() {
	}

	/**
	 * Create an instance of {@link ReceiveInfo }
	 * 
	 */
	public ReceiveInfo createReceiveInfo() {
		return new ReceiveInfo();
	}

	/**
	 * Create an instance of {@link ExpertSpecialtyWS }
	 * 
	 */
	public ExpertSpecialtyWS createExpertSpecialtyWS() {
		return new ExpertSpecialtyWS();
	}

	/**
	 * Create an instance of {@link ExpertApply }
	 * 
	 */
	public ExpertApply createExpertApply() {
		return new ExpertApply();
	}

	/**
	 * Create an instance of {@link Result }
	 * 
	 */
	public Result createResult() {
		return new Result();
	}

	/**
	 * Create an instance of {@link ExpertInfoWS }
	 * 
	 */
	public ExpertInfoWS createExpertInfoWS() {
		return new ExpertInfoWS();
	}

	/**
	 * Create an instance of {@link ExpertApplyStatusResult }
	 * 
	 */
	public ExpertApplyStatusResult createExpertApplyStatusResult() {
		return new ExpertApplyStatusResult();
	}

	/**
	 * Create an instance of {@link ExtractResponse }
	 * 
	 */
	public ExtractResponse createExtractResponse() {
		return new ExtractResponse();
	}

	/**
	 * Create an instance of {@link ExpertSpecialtyEdit }
	 * 
	 */
	public ExpertSpecialtyEdit createExpertSpecialtyEdit() {
		return new ExpertSpecialtyEdit();
	}

	/**
	 * Create an instance of {@link ReceiveInfoResponse }
	 * 
	 */
	public ReceiveInfoResponse createReceiveInfoResponse() {
		return new ReceiveInfoResponse();
	}

	/**
	 * Create an instance of {@link GetExpertApplyStatus }
	 * 
	 */
	public GetExpertApplyStatus createGetExpertApplyStatus() {
		return new GetExpertApplyStatus();
	}

	/**
	 * Create an instance of {@link ExpertApplyResponse }
	 * 
	 */
	public ExpertApplyResponse createExpertApplyResponse() {
		return new ExpertApplyResponse();
	}

	/**
	 * Create an instance of {@link ExtractResult }
	 * 
	 */
	public ExtractResult createExtractResult() {
		return new ExtractResult();
	}

	/**
	 * Create an instance of {@link Extract }
	 * 
	 */
	public Extract createExtract() {
		return new Extract();
	}

	/**
	 * Create an instance of {@link GetExtractResult }
	 * 
	 */
	public GetExtractResult createGetExtractResult() {
		return new GetExtractResult();
	}

	/**
	 * Create an instance of {@link GetExpertApplyStatusResponse }
	 * 
	 */
	public GetExpertApplyStatusResponse createGetExpertApplyStatusResponse() {
		return new GetExpertApplyStatusResponse();
	}

	/**
	 * Create an instance of {@link GetExtractResultResponse }
	 * 
	 */
	public GetExtractResultResponse createGetExtractResultResponse() {
		return new GetExtractResultResponse();
	}

	/**
	 * Create an instance of {@link ExpertSpecialtyEditResponse }
	 * 
	 */
	public ExpertSpecialtyEditResponse createExpertSpecialtyEditResponse() {
		return new ExpertSpecialtyEditResponse();
	}

	/**
	 * Create an instance of {@link JAXBElement }{@code <}
	 * {@link ExpertSpecialtyEdit }{@code >}
	 * 
	 */
	@XmlElementDecl(namespace = "http://server.webservice.pspde.sxca.com/", name = "expertSpecialtyEdit")
	public JAXBElement<ExpertSpecialtyEdit> createExpertSpecialtyEdit(
			ExpertSpecialtyEdit value) {
		return new JAXBElement<ExpertSpecialtyEdit>(_ExpertSpecialtyEdit_QNAME,
				ExpertSpecialtyEdit.class, null, value);
	}

	/**
	 * Create an instance of {@link JAXBElement }{@code <}
	 * {@link ExpertApplyResponse }{@code >}
	 * 
	 */
	@XmlElementDecl(namespace = "http://server.webservice.pspde.sxca.com/", name = "expertApplyResponse")
	public JAXBElement<ExpertApplyResponse> createExpertApplyResponse(
			ExpertApplyResponse value) {
		return new JAXBElement<ExpertApplyResponse>(_ExpertApplyResponse_QNAME,
				ExpertApplyResponse.class, null, value);
	}

	/**
	 * Create an instance of {@link JAXBElement }{@code <}{@link ReceiveInfo }
	 * {@code >}
	 * 
	 */
	@XmlElementDecl(namespace = "http://server.webservice.pspde.sxca.com/", name = "receiveInfo")
	public JAXBElement<ReceiveInfo> createReceiveInfo(ReceiveInfo value) {
		return new JAXBElement<ReceiveInfo>(_ReceiveInfo_QNAME,
				ReceiveInfo.class, null, value);
	}

	/**
	 * Create an instance of {@link JAXBElement }{@code <}
	 * {@link GetExtractResult }{@code >}
	 * 
	 */
	@XmlElementDecl(namespace = "http://server.webservice.pspde.sxca.com/", name = "getExtractResult")
	public JAXBElement<GetExtractResult> createGetExtractResult(
			GetExtractResult value) {
		return new JAXBElement<GetExtractResult>(_GetExtractResult_QNAME,
				GetExtractResult.class, null, value);
	}

	/**
	 * Create an instance of {@link JAXBElement }{@code <}
	 * {@link ExpertSpecialtyEditResponse }{@code >}
	 * 
	 */
	@XmlElementDecl(namespace = "http://server.webservice.pspde.sxca.com/", name = "expertSpecialtyEditResponse")
	public JAXBElement<ExpertSpecialtyEditResponse> createExpertSpecialtyEditResponse(
			ExpertSpecialtyEditResponse value) {
		return new JAXBElement<ExpertSpecialtyEditResponse>(
				_ExpertSpecialtyEditResponse_QNAME,
				ExpertSpecialtyEditResponse.class, null, value);
	}

	/**
	 * Create an instance of {@link JAXBElement }{@code <}
	 * {@link GetExtractResultResponse }{@code >}
	 * 
	 */
	@XmlElementDecl(namespace = "http://server.webservice.pspde.sxca.com/", name = "getExtractResultResponse")
	public JAXBElement<GetExtractResultResponse> createGetExtractResultResponse(
			GetExtractResultResponse value) {
		return new JAXBElement<GetExtractResultResponse>(
				_GetExtractResultResponse_QNAME,
				GetExtractResultResponse.class, null, value);
	}

	/**
	 * Create an instance of {@link JAXBElement }{@code <}{@link ExpertApply }
	 * {@code >}
	 * 
	 */
	@XmlElementDecl(namespace = "http://server.webservice.pspde.sxca.com/", name = "expertApply")
	public JAXBElement<ExpertApply> createExpertApply(ExpertApply value) {
		return new JAXBElement<ExpertApply>(_ExpertApply_QNAME,
				ExpertApply.class, null, value);
	}

	/**
	 * Create an instance of {@link JAXBElement }{@code <}{@link Extract }{@code >}
	 * 
	 */
	@XmlElementDecl(namespace = "http://server.webservice.pspde.sxca.com/", name = "extract")
	public JAXBElement<Extract> createExtract(Extract value) {
		return new JAXBElement<Extract>(_Extract_QNAME, Extract.class, null,
				value);
	}

	/**
	 * Create an instance of {@link JAXBElement }{@code <}
	 * {@link GetExpertApplyStatus }{@code >}
	 * 
	 */
	@XmlElementDecl(namespace = "http://server.webservice.pspde.sxca.com/", name = "getExpertApplyStatus")
	public JAXBElement<GetExpertApplyStatus> createGetExpertApplyStatus(
			GetExpertApplyStatus value) {
		return new JAXBElement<GetExpertApplyStatus>(
				_GetExpertApplyStatus_QNAME, GetExpertApplyStatus.class, null,
				value);
	}

	/**
	 * Create an instance of {@link JAXBElement }{@code <}{@link ExtractResponse }
	 * {@code >}
	 * 
	 */
	@XmlElementDecl(namespace = "http://server.webservice.pspde.sxca.com/", name = "extractResponse")
	public JAXBElement<ExtractResponse> createExtractResponse(
			ExtractResponse value) {
		return new JAXBElement<ExtractResponse>(_ExtractResponse_QNAME,
				ExtractResponse.class, null, value);
	}

	/**
	 * Create an instance of {@link JAXBElement }{@code <}
	 * {@link GetExpertApplyStatusResponse }{@code >}
	 * 
	 */
	@XmlElementDecl(namespace = "http://server.webservice.pspde.sxca.com/", name = "getExpertApplyStatusResponse")
	public JAXBElement<GetExpertApplyStatusResponse> createGetExpertApplyStatusResponse(
			GetExpertApplyStatusResponse value) {
		return new JAXBElement<GetExpertApplyStatusResponse>(
				_GetExpertApplyStatusResponse_QNAME,
				GetExpertApplyStatusResponse.class, null, value);
	}

	/**
	 * Create an instance of {@link JAXBElement }{@code <}
	 * {@link ReceiveInfoResponse }{@code >}
	 * 
	 */
	@XmlElementDecl(namespace = "http://server.webservice.pspde.sxca.com/", name = "receiveInfoResponse")
	public JAXBElement<ReceiveInfoResponse> createReceiveInfoResponse(
			ReceiveInfoResponse value) {
		return new JAXBElement<ReceiveInfoResponse>(_ReceiveInfoResponse_QNAME,
				ReceiveInfoResponse.class, null, value);
	}

}
