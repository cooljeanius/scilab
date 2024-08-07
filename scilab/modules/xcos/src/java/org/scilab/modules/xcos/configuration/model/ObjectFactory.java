//
// This file was generated by the JavaTM Architecture for XML Binding(JAXB) Reference Implementation, v2.2.4 
// See <a href="http://java.sun.com/xml/jaxb">http://java.sun.com/xml/jaxb</a> 
// Any modifications to this file will be lost upon recompilation of the source schema. 
// Generated on: 2011.12.01 at 03:54:28 PM CET 
//


package org.scilab.modules.xcos.configuration.model;

import javax.xml.bind.JAXBElement;
import javax.xml.bind.annotation.XmlElementDecl;
import javax.xml.bind.annotation.XmlRegistry;
import javax.xml.namespace.QName;


/**
 * This object contains factory methods for each 
 * Java content interface and Java element interface 
 * generated in the org.scilab.modules.xcos.configuration.model package. 
 * <p>An ObjectFactory allows you to programatically 
 * construct new instances of the Java representation 
 * for XML content. The Java representation of XML 
 * content can consist of schema derived interfaces 
 * and classes representing the binding of schema 
 * type definitions, element declarations and model 
 * groups.  Factory methods for each of these are 
 * provided in this class.
 * 
 */
@XmlRegistry
public class ObjectFactory {

    private final static QName _Settings_QNAME = new QName("", "settings");

    /**
     * Create a new ObjectFactory that can be used to create new instances of schema derived classes for package: org.scilab.modules.xcos.configuration.model
     * 
     */
    public ObjectFactory() {
    }

    /**
     * Create an instance of {@link SettingType }
     * 
     */
    public SettingType createSettingType() {
        return new SettingType();
    }

    /**
     * Create an instance of {@link DocumentType }
     * 
     */
    public DocumentType createDocumentType() {
        return new DocumentType();
    }

    /**
     * Create an instance of {@link JAXBElement }{@code <}{@link SettingType }{@code >}}
     * 
     */
    @XmlElementDecl(namespace = "", name = "settings")
    public JAXBElement<SettingType> createSettings(SettingType value) {
        return new JAXBElement<SettingType>(_Settings_QNAME, SettingType.class, null, value);
    }

}
