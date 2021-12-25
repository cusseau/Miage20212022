Class BO.Reservation Extends Ens.BusinessOperation
{

Property Adapter As EnsLib.File.OutboundAdapter;

Parameter ADAPTER = "EnsLib.File.OutboundAdapter";

Parameter INVOCATION = "Queue";

Method creerReservation(pRequest As msg.createReservationDmde, Output pResponse As msg.createReservationRpse) As %Status
{
    set pResponse = ##class(msg.createReservationRpse).%New()
    set sql = "select plaque from data.Voiture where categorie = '"_pRequest.categorie_"' and plaque not in ("
    set sql = sql_" SELECT voiture->plaque FROM data.Reservation where voiture->categorie = '"_pRequest.categorie_"'"
    set sql = sql_" and ((datDeb >= '"_pRequest.datDeb_"' and datDeb <= '"_pRequest.datFin_"' ) "
    set sql = sql_" or (datFin >= '"_pRequest.datDeb_"' and datFin <= '"_pRequest.datFin_"' ) "
    set sql = sql_" or (datDeb <= '"_pRequest.datDeb_"' and datFin >= '"_pRequest.datFin_"' ) "
    set sql = sql_" or (datDeb >= '"_pRequest.datDeb_"' and datFin <= '"_pRequest.datFin_"' )) "
    set sql = sql_ " ) "
    set statement=##class(%SQL.Statement).%New() 
	do statement.%Prepare(sql)
	set SQLrequest = statement.%Execute()
    do SQLrequest.%Next()
    set plaque = SQLrequest.%Get("plaque")

    
    set idVoiture = ##class(data.Voiture).consulterParPlaqueExists(plaque)
    if (idVoiture){
    set dataVoiture = ##class(data.Voiture).%OpenId(idVoiture)
    set reservation = ##class(data.Reservation).%New()
    set reservation.voiture = dataVoiture
    set reservation.datDeb = pRequest.datDeb
    set reservation.datFin = pRequest.datFin
    set tsc = reservation.%Save()
    if (tsc){
        set pResponse.codeRetour = "OK"
    }
    else {
        set pResponse.codeRetour = "KO"
    }
    } else {
        set pResponse.codeRetour = "KO"
    }
    
    
    
    Quit $$$OK
}

Method checkReservation(pRequest As msg.createVerifyReservationDmde, Output pResponse As msg.createVerifyReservationRpse) As %Status
{
    set pResponse = ##class(msg.createVerifyReservationRpse).%New()
    set sql = "select voiture from data.Reservation where voiture->plaque = '"_pRequest.plaque_"' and (datDeb >= GETDATE() or datFin >= GETDATE())"
    set statement=##class(%SQL.Statement).%New() 
	do statement.%Prepare(sql)
	set SQLrequest = statement.%Execute()
    do SQLrequest.%Next()
    if (SQLrequest.%Get("voiture")){
        set pResponse.codeRetour = "KO"
    }else{
        set pResponse.codeRetour = "OK"
    }
    
    Quit $$$OK
}

XData MessageMap
{
<MapItems>
    <MapItem MessageType="msg.createReservationDmde">
        <Method>creerReservation</Method>
    </MapItem>
    <MapItem MessageType="msg.createVerifyReservationDmde">
    <Method>checkReservation</Method>
    </MapItem>
</MapItems>
}

}
