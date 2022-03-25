#INCLUDE "TOTVS.CH"

/*{Protheus.doc} PrxCODIGO
Sequencia para os campos: A1_COD, A2_COD e A4_COD 
@type function
@version 1.0
@author Marcos Araujo - ACOS G3 - ATRIA
@since 24/03/2022
@return Proximo CÓDIGO 

Parametro cParam - (C)liente, (F)ornecedor e (T)ransportadora

*/

User Function PrxCODIGO(cParam)  // Proximo Codigo Cliente

	Local aArea 	:= getArea()
	Local cProximo 	:= ""
	Local cAlias 	:= ""

	DO CASE

	CASE upper(cParam)="C"
		cAlias := "SA1"
		cProximo := SuperGetMv("MV_XPRXCLI", .F. , "001075" ,xFilial())

	CASE upper(cParam)="F"
		cAlias := "SA2"
		cProximo := SuperGetMv("MV_XPRXFOR", .F. , "000714" ,xFilial())

	CASE upper(cParam)="T"
		cAlias := "SA4"
		cProximo := SuperGetMv("MV_XPRXTRS", .F. , "000075" ,xFilial())

	ENDCASE

	DbSelectArea(cAlias)
	dbsetorder(1)

	While dbseek(xFilial(cAlias)+cProximo)
		cProximo = strzero(val(cProximo) +1,6)
		Loop
	End

	RestArea(aArea)
Return cProximo
