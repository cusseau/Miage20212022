Class BS.ServiceDeReservation Extends Ens.BusinessService
{

/// Name of the WebService
Parameter SERVICENAME = "ServiceDeReservation";

Method OnProcessInput(pInput As %RegisteredObject, Output pOutput As %RegisteredObject, ByRef pHint As %String) As %Status
{
    set tsc = $CASE(pHint,
        "createReservation":..createReservation(pInput,.pOutput),
        "verifyReservation":..verifyReservation(pInput,.pOutput),
	 	: $$$ERROR($$$NotImplemented)
    )
    Quit tsc
}

Method createReservation(pInput As %RegisteredObject, Output pOutput As %RegisteredObject) As %Status
{
    set tsc = ..SendRequestSync("Reservation",pInput,.pOutput)
    Quit $$$OK
}

Method verifyReservation(pInput As %RegisteredObject, Output pOutput As %RegisteredObject) As %Status
{
    set tsc = ..SendRequestSync("Reservation",pInput,.pOutput)
    Quit $$$OK
}

}