xquery version "3.1";

(:==========
Part of pr-app
Build model (in model namespace, with "m:" prefix) for titles list
==========:)

(:==========
Declare namespaces
==========:)
declare namespace hoax = "http://obdurodon.org/hoax";
declare namespace m = "http://www.obdurodon.org/model";
declare namespace tei = "http://www.tei-c.org/ns/1.0";

(:==========
Declare global variables to path
=======∏===:)
declare variable $exist:root as xs:string := 
    request:get-parameter("exist:root", "xmldb:exist:///db/apps");
declare variable $exist:controller as xs:string := 
    request:get-parameter("exist:controller", "/03-titles-model");
declare variable $path-to-data as xs:string := 
    $exist:root || $exist:controller || '/data';
(:===
Declare variable
===:)
declare variable $articles-coll := collection($path-to-data || '/hoax_xml');
declare variable $articles as element(tei:TEI)+ := $articles-coll/tei:TEI;

<m:titles> 
{
    for $article in $articles 
    return
        <m:title>{ 
            $article//tei:titleStmt/tei:title ! fn:string(.)
        }</m:title>
}
</m:titles>