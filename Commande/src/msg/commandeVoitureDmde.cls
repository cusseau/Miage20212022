/// Description
Class msg.commandeVoitureDmde Extends Ens.Request
{

/// Marque
Property marque As %String;

/// Model
Property modele As %String;

/// Couleur
Property couleur As %String;

Storage Default
{
<Data name="commandeVoitureDmdeDefaultData">
<Subscript>"commandeVoitureDmde"</Subscript>
<Value name="1">
<Value>marque</Value>
</Value>
<Value name="2">
<Value>modele</Value>
</Value>
<Value name="3">
<Value>couleur</Value>
</Value>
</Data>
<DefaultData>commandeVoitureDmdeDefaultData</DefaultData>
<Type>%Storage.Persistent</Type>
}

}
