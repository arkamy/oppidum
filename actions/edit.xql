xquery version "1.0";
(: --------------------------------------
  Oppidum framework

  Author: Stéphane Sire <s.sire@free.fr>

  Generates a model to edit a resource from an XTiger Template. 
  Raises a 'ACTION-EDIT-NO-TEMPLATE' if the command does not carry 
  a template declaration .

  See also bootstrap.xql, edit.xsl and edit.js (companion Javascript library)

  August 2011
  -------------------------------------- :)

import module namespace xdb = "http://exist-db.org/xquery/xmldb";  
import module namespace oppidum = "http://oppidoc.com/oppidum/util" at "../lib/util.xqm";   
                                              
let          
  $cmd := request:get-attribute('oppidum.command')
  
return
  <Edit>
    <Resource>{concat($cmd/@base-url, $cmd/@trail)}.xml</Resource>
    { 
      if ($cmd/resource/@template) then
        <Template>{concat($cmd/@base-url, $cmd/resource/@template)}</Template>
      else
        (
        oppidum:add-error('ACTION-EDIT-NO-TEMPLATE', $cmd/@trail, true()),
        <Error>Template not found</Error>
        )                      
    }
  </Edit>
