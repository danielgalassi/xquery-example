declare namespace LogicalDataModel="http:///com/ibm/db/models/logical/logical.ecore";
declare namespace xmi="http://www.omg.org/XMI";
for $x in //LogicalDataModel:Entity
return concat($x/@xmi:id, " ---> ", $x/@name)
