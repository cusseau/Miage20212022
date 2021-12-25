/// 
Class BP.CommandeVoiture Extends Ens.BusinessProcessBPL
{

/// BPL Definition
XData BPL [ XMLNamespace = "http://www.intersystems.com/bpl" ]
{
<process language='objectscript' request='msg.commandeVoitureDmde' response='msg.commandeVoitureRpse' height='2000' width='2000' >
<context>
<property name='voiture' type='webObjet.wsVoiture' instantiate='0' />
<property name='catalogue' type='webObjet.wsCatalogue' instantiate='0' />
</context>
<sequence xend='711' yend='737' >
<call name='Check catalogue' target='plaque' async='1' xpos='506' ypos='144' >
<request type='Ens.Request' />
<response type='Ens.Response' />
</call>
<if name='Catalogue OK' condition='response.codeRetour="OK"' xpos='507' ypos='230' xend='687' yend='647' >
<true>
<call name='Plaque' target='plaque' async='1' xpos='905' ypos='323' >
<request type='msg.generationPlaqueDmde' />
<response type='msg.generationPlaqueRpse' >
<assign property="response.libErreur" value="callresponse.libErreur" action="set" />
<assign property="response.codeRetour" value="callresponse.codeRetour" action="set" />
<assign property="context.voiture" value="callresponse.plaque" action="set" />
</response>
</call>
<transform name='CatalogueToVoiture' class='Transform.CatalogueToVoiture' source='context.catalogue' target='context.voiture' xpos='903' ypos='414' />
<call name='creerVoiture' target='Voiture' async='1' xpos='905' ypos='491' >
<request type='msg.creerVoitureDmde' >
<assign property="callrequest.voiture" value="context.voiture" action="set" />
<assign property="callrequest.voiture.couleur" value="request.couleur" action="set" />
</request>
<response type='msg.creerVoitureRpse' >
<assign property="response.libErreur" value="callresponse.libErreur" action="set" />
<assign property="response.codeRetour" value="callresponse.codeRetour" action="set" />
</response>
</call>
<call name='Dépôt Fichier' target='File' async='1' xpos='900' ypos='570' >
<request type='msg.pushVoitureFileDmde' >
<assign property="callrequest.voiture.couleur" value="request.couleur" action="set" />
<assign property="callrequest.voiture" value="context.voiture" action="set" />
</request>
<response type='msg.pushVoitureFileRpse' >
<assign property="response.libErreur" value="callresponse.libErreur" action="set" />
<assign property="response.codeRetour" value="callresponse.codeRetour" action="set" />
</response>
</call>
</true>
</if>
</sequence>
</process>
}

Storage Default
{
<Type>%Storage.Persistent</Type>
}

}
