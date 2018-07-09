package com.sxca.pspde.webservice.server;

import javax.xml.bind.annotation.XmlAccessType;
import javax.xml.bind.annotation.XmlAccessorType;
import javax.xml.bind.annotation.XmlType;



@XmlAccessorType(XmlAccessType.FIELD)
@XmlType(name = "getExtractResultInform", propOrder = { "arg0", "arg1", "arg2","arg3"})
public class GetExtractResultInform{

    protected String arg0;
    protected String arg1;
    protected String arg2;
    protected String arg3;

    /**
     * Gets the value of the arg0 property.
     *
     * @return possible object is {@link String }
     *
     */
    public String getArg0() {
        return arg0;
    }

    /**
     * Sets the value of the arg0 property.
     *
     * @param value
     *            allowed object is {@link String }
     *
     */
    public void setArg0(String value) {
        this.arg0 = value;
    }

    /**
     * Gets the value of the arg1 property.
     *
     * @return possible object is {@link String }
     *
     */
    public String getArg1() {
        return arg1;
    }

    /**
     * Sets the value of the arg1 property.
     *
     * @param value
     *            allowed object is {@link String }
     *
     */
    public void setArg1(String value) {
        this.arg1 = value;
    }

    /**
     * Gets the value of the arg2 property.
     *
     * @return possible object is {@link String }
     *
     */
    public String getArg2() {
        return arg2;
    }

    /**
     * Sets the value of the arg2 property.
     *
     * @param value
     *            allowed object is {@link String }
     *
     */
    public void setArg2(String value) {
        this.arg2 = value;
    }


    public void setArg3(String value) {
        this.arg3 = value;
    }

    public String getArg3() {
        return arg3;
    }
}
