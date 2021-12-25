Class BS.ServiceVoitureSoap Extends EnsLib.SOAP.Service
{

/// Name of the WebService
Parameter SERVICENAME = "ServiceVoitureSoap";

Method CommanderVoiture(marque As %String, modele As %String, couleur As %String) As msg.commandeVoitureRpse [ WebMethod ]
{
    set pOutput = ##class(msg.commandeVoitureRpse).%New()

    /*TO DO LE LOU*/

    set tsc = ..SendRequestSync("CommandeVoiture",msg,.pOutput)

    Quit pOutput
}

}
