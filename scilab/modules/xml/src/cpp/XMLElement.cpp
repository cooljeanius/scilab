/*
 * Scilab ( http://www.scilab.org/ ) - This file is part of Scilab
 * Copyright (C) 2012 - Scilab Enterprises - Calixte DENIZET
 *
 * This file must be used under the terms of the CeCILL.
 * This source file is licensed as described in the file COPYING, which
 * you should have received as part of this distribution.  The terms
 * are also available at
 * http://www.cecill.info/licences/Licence_CeCILL_V2-en.txt
 *
 */

#include "XMLObject.hxx"
#include "XMLElement.hxx"
#include "XMLDocument.hxx"
#include "XMLNodeList.hxx"
#include "XMLNs.hxx"
#include "XMLAttr.hxx"
#include "VariableScope.hxx"

extern "C"
{
    extern const char *nodes_type[];
}

namespace org_modules_xml
{

XMLElement::XMLElement(const XMLDocument & _doc, xmlNode * _node): XMLObject(), doc(_doc)
{
    node = _node;
    scope->registerPointers(node, this);
    scilabType = XMLELEMENT;
    id = scope->getVariableId(*this);
}

XMLElement::XMLElement(const XMLDocument & _doc, const char *name): XMLObject(), doc(_doc)
{
    node = xmlNewNode(0, reinterpret_cast<const xmlChar *>(name));
    scope->registerPointers(node, this);
    scilabType = XMLELEMENT;
    id = scope->getVariableId(*this);
}

XMLElement::~XMLElement()
{
    scope->unregisterPointer(node);
    scope->removeId(id);
}

void *XMLElement::getRealXMLPointer() const
{
    return static_cast<void *>(node);
}

void XMLElement::remove() const
{
    xmlUnlinkNode(node);
    xmlFreeNode(node);
}

const XMLObject *XMLElement::getXMLObjectParent() const
{
    return &doc;
}

const char *XMLElement::getNodeContent() const
{
    return reinterpret_cast<const char *>(xmlNodeGetContent(node));
}

void XMLElement::setNodeName(const std::string & name) const
{
    xmlNodeSetName(node, reinterpret_cast<const xmlChar *>(name.c_str()));
}

void XMLElement::setNodeNameSpace(const XMLNs & ns) const
{
    xmlNs *n = ns.getRealNs();
    if (n)
    {
        if (!n->prefix || !xmlSearchNs(doc.getRealDocument(), node, n->prefix))
        {
            n = xmlNewNs(node, reinterpret_cast<const xmlChar *>(ns.getHref()),
                         reinterpret_cast<const xmlChar *>(ns.getPrefix()));
        }
        xmlSetNs(node, n);
    }
}

void XMLElement::setNodeContent(const std::string & content) const
{
    xmlNodeSetContent(node, reinterpret_cast<const xmlChar *>(content.c_str()));
}

void XMLElement::setAttributes(const XMLAttr & attrs) const
{
    xmlNode *attrNode = attrs.getElement().getRealNode();
    if (node != attrNode)
    {
        xmlFreePropList(node->properties);
        node->properties = 0;
        xmlCopyPropList(node, attrNode->properties);
    }
}

void XMLElement::setAttributeValue(const char **prefix, const char **name, const char **value, int size) const
{
    XMLAttr::setAttributeValue(node, prefix, name, value, size);
}

void XMLElement::setAttributeValue(const char **name, const char **value, int size) const
{
    XMLAttr::setAttributeValue(node, name, value, size);
}

void XMLElement::setChildren(const XMLElement & elem) const
{
    xmlNode *n = elem.getRealNode();
    if (n && n->parent != node)
    {
        xmlNode *cpy = xmlCopyNode(n, 1);
        xmlUnlinkNode(cpy);
        xmlUnlinkNode(node->children);
        xmlFreeNodeList(node->children);
        node->children = 0;
        xmlAddChild(node, cpy);
    }
}

void XMLElement::setChildren(const XMLNodeList & list) const
{
    xmlNode *n = list.getRealNode();
    if (n && n->parent != node)
    {
        xmlNode *cpy = xmlCopyNodeList(n);
        xmlUnlinkNode(node->children);
        xmlFreeNodeList(node->children);
        node->children = 0;
        xmlAddChildList(node, cpy);
    }
}

void XMLElement::setChildren(const std::string & xmlCode) const
{
    std::string error;
    XMLDocument document = XMLDocument(xmlCode, false, &error);

    if (error.empty())
    {
        setChildren(*document.getRoot());
    }
    else
    {
        xmlNode *n = xmlNewText(reinterpret_cast<xmlChar *>(const_cast<char *>(xmlCode.c_str())));

        setChildren(XMLElement(doc, n));
    }
}

void XMLElement::addNamespace(const XMLNs & ns) const
{
    xmlNewNs(node, reinterpret_cast<const xmlChar *>(ns.getHref()),
             reinterpret_cast<const xmlChar *>(ns.getPrefix()));
}

const XMLNs *XMLElement::getNamespaceByPrefix(const char *prefix) const
{
    xmlNs *ns = xmlSearchNs(doc.getRealDocument(), node,
                            reinterpret_cast<const xmlChar *>(prefix));
    XMLObject *obj = scope->getXMLObjectFromLibXMLPtr(ns);
    if (obj)
    {
        return static_cast < XMLNs * >(obj);
    }

    return new XMLNs(*this, ns);
}

const XMLNs *XMLElement::getNamespaceByHref(const char *href) const
{
    xmlNs *ns = xmlSearchNsByHref(doc.getRealDocument(), node,
                                  reinterpret_cast<const xmlChar *>(href));
    XMLObject *obj = scope->getXMLObjectFromLibXMLPtr(ns);
    if (obj)
    {
        return static_cast < XMLNs * >(obj);
    }

    return new XMLNs(*this, ns);
}

const std::string XMLElement::dump(bool indent) const
{
    xmlBufferPtr buffer = xmlBufferCreate();
    xmlNodeDump(buffer, doc.getRealDocument(), node, 0, indent ? 1 : 0);
    std::string str = std::string(reinterpret_cast<const char *>(buffer->content));
    xmlBufferFree(buffer);

    return str;
}

const std::string XMLElement::toString() const
{
    std::ostringstream oss;
    std::string ns = "";
    std::string prefix = "";

    if (node->ns)
    {
        if (node->ns->href)
        {
            ns = std::string(reinterpret_cast<const char *>(node->ns->href));
        }

        if (node->ns->prefix)
        {
            prefix = std::string(reinterpret_cast<const char *>(node->ns->prefix));
        }
    }

    oss << "XML Element" << std::endl;
    oss << "name: " << getNodeName() << std::endl;
    oss << "namespace href: " << ns << std::endl;
    oss << "namespace prefix: " << prefix << std::endl;
    oss << "type: " << nodes_type[getNodeType() - 1] << std::endl;
    oss << "definition line: " << node->line;

    return oss.str();
}

int XMLElement::getDefinitionLine() const
{
    return node->line;
}

const XMLNs *XMLElement::getNodeNameSpace() const
{
    if (node->ns)
    {
        XMLObject *obj = scope->getXMLObjectFromLibXMLPtr(node->ns);
        if (obj)
        {
            return static_cast < XMLNs * >(obj);
        }

        return new XMLNs(*this, node->ns);
    }
    else
    {
        return 0;
    }
}

const XMLNodeList *XMLElement::getChildren() const
{
    XMLNodeList *obj = scope->getXMLNodeListFromLibXMLPtr(node->children);
    if (obj)
    {
        return obj;
    }

    return new XMLNodeList(doc, node);
}

const XMLAttr *XMLElement::getAttributes() const
{
    XMLObject *obj = scope->getXMLObjectFromLibXMLPtr(node->properties);
    if (obj)
    {
        return static_cast < XMLAttr * >(obj);
    }

    return new XMLAttr(*this);
}

const XMLElement *XMLElement::getParentElement() const
{
    if (node->parent && node->parent->type == XML_ELEMENT_NODE)
    {
        XMLObject *obj = scope->getXMLObjectFromLibXMLPtr(node->parent);
        if (obj)
        {
            return static_cast < XMLElement * >(obj);
        }

        return new XMLElement(doc, node->parent);
    }
    else
    {
        return 0;
    }
}
}
