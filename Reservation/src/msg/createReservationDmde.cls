Class msg.createReservationDmde Extends (Ens.Request, %JSON.Adaptor)
{

Property datDeb As %TimeStamp;

Property datFin As %TimeStamp;

Property categorie As %String;

Storage Default
{
<Data name="createReservationDmdeDefaultData">
<Subscript>"createReservationDmde"</Subscript>
<Value name="1">
<Value>dateDeb</Value>
</Value>
<Value name="2">
<Value>dateFin</Value>
</Value>
<Value name="3">
<Value>categorie</Value>
</Value>
<Value name="4">
<Value>datDeb</Value>
</Value>
<Value name="5">
<Value>datFin</Value>
</Value>
</Data>
<DefaultData>createReservationDmdeDefaultData</DefaultData>
<Type>%Storage.Persistent</Type>
}

}
