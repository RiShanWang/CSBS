CREATE MATERIALIZED VIEW DM_MDS.MV_BLG_DATA
   BUILD IMMEDIATE
   REFRESH ON DEMAND
   AS SELECT EE.QUARTER_DESC QUARTER
      , FF.*
      FROM DM_MDS.LK_QUARTER_OF_YEAR EE
      JOIN
      (SELECT CC.QUARTER_DESC
      , CC.QUARTER_IN_YEAR
      , CC.YEAR_ID
      , DD.*
      FROM DM_MDS.LK_QUARTER CC
      JOIN
      (SELECT QUARTER_ID
      --, CALDATE
      --, BB.QDATE
      , SUM(BB.BMDRAMR) BMDRAMR
      , SUM(BB.BMDRAM90D) BMDRAM90D
      , SUM(BB.BMDRAM60D) BMDRAM60D
      , SUM(BB.BMDRAMF) BMDRAMF
      , SUM(BB.BMDRAM30D) BMDRAM30D
      , SUM(BB.UPFDLFETSNY) UPFDLFETSNY
      , SUM(BB.UPFDLFETSM) UPFDLFETSM
      , SUM(BB.UPFDLFEYN) UPFDLFEYN
      , SUM(BB.UPFDLFEMS) UPFDLFEMS
      , SUM(BB.UPFDYN) UPFDYN
      , SUM(BB.UPFDMS) UPFDMS
      , SUM(BB.MURIS) MURIS
      , SUM(BB.MUPIS) MUPIS
      , SUM(BB.MUMMIWCSOM) MUMMIWCSOM
      , SUM(BB.BUWCCI) BUWCCI
      , SUM(BB.UCUCLFEYN) UCUCLFEYN
      , SUM(BB.UCUCYN) UCUCYN
      , SUM(BB.UCUCLFEMS) UCUCLFEMS
      , SUM(BB.UCUCMS) UCUCMS
      , SUM(BB.UIJCWMAS) UIJCWMAS
      , SUM(BB.UIJCS) UIJCS
      , SUM(BB.NSBOI) NSBOI
      , SUM(BB.FCORCRELEFCB) FCORCRELEFCB
      , SUM(BB.NCORRELSF) NCORRELSF
      , SUM(BB.NCORCEFLFRM) NCORCEFLFRM
      , SUM(BB.MUTPALSU) MUTPALSU
      , SUM(BB.MUCTALSNM) MUCTALSNM
      , SUM(BB.UPPIREAF) UPPIREAF
      , SUM(BB.SCRELSFNU) SCRELSFNU
      , SUM(BB.SCMOGFMFM) SCMOGFMFM
      , SUM(BB.MUTAALSU) MUTAALSU
      , SUM(BB.SCMOPR) SCMOPR
      , SUM(BB.MCMOPR) MCMOPR
      , SUM(BB.LCMOPR) LCMOPR
      , SUM(BB.UMOTU) UMOTU
      , SUM(BB.UFMOTU) UFMOTU
      , SUM(BB.CSFHRVWRMA) CSFHRVWRMA
      , SUM(BB.CSFHRVSRMA) CSFHRVSRMA
      , SUM(BB.CSFHRVNRMA) CSFHRVNRMA
      , SUM(BB.CSFHRVMRMA) CSFHRVMRMA
      , SUM(BB.NMMAPIUSU) NMMAPIUSU
      , SUM(BB.MUNALSQDS) MUNALSQDS
      , SUM(BB.TRHELCU) TRHELCU
      , SUM(BB.TOHELCU) TOHELCU
      , SUM(BB.HELMCNCO) HELMCNCO
      , SUM(BB.MMFFHMHSSU) MMFFHMHSSU
      , SUM(BB.MMFFIRYTY) MMFFIRYTY
      , SUM(BB.MMFFIRYFRM) MMFFIRYFRM
      , SUM(BB.MMFFMORU) MMFFMORU
      , SUM(BB.MMFFMOPU) MMFFMOPU
      , SUM(BB.AOMIRMLU) AOMIRMLU
      , SUM(BB.REITHMAU) REITHMAU
      , SUM(BB.GSEHMAU) GSEHMAU
      , SUM(BB.FCHMAU) FCHMAU
      , SUM(BB.UCDIHIFANU) UCDIHIFANU
      , SUM(BB.CUHMAU) CUHMAU
      , SUM(BB.AGBMPHMAU) AGBMPHMAU
      , SUM(BB.IABSHMAU) IABSHMAU
      , SUM(BB.MMFFHMMPTEH) MMFFHMMPTEH
      , SUM(BB.MMFFHMMPNHU) MMFFHMMPNHU
      , SUM(BB.FRPBDDHR) FRPBDDHR
      , SUM(BB.SFAOTLN) SFAOTLN
      , SUM(BB.PFAOTLN) PFAOTLN
      , SUM(BB.UHFFT) UHFFT
      , SUM(BB.SLDAOTSLS) SLDAOTSLS
      , SUM(BB.PLDAOPLS) PLDAOPLS
      , SUM(BB.MUDAOTLS) MUDAOTLS
      , SUM(BB.SPER) SPER
      , SUM(BB.IWRGCA) IWRGCA
      , SUM(BB.CFEIY) CFEIY
      , SUM(BB.URG) URG
      , SUM(BB.UENPTMNCS) UENPTMNCS
      , SUM(BB.SFFSI) SFFSI
      , SUM(BB.KCFFSI) KCFFSI
      , SUM(BB.GSFCI) GSFCI
      , SUM(BB.CFFCI) CFFCI
      , SUM(BB.CFFSI) CFFSI
      , SUM(BB.BFCI) BFCI
      FROM DM_MDS.LK_DAY AA
      JOIN
      (SELECT * FROM DM_MDS.F_BLOOMBERG_DATA) BB
      ON AA.DATE_ID = BB.QDATE
      GROUP BY AA.QUARTER_ID) DD
      ON CC.QUARTER_ID = DD.QUARTER_ID) FF
      ON EE.QUARTER_ID = FF.QUARTER_IN_YEAR;
      --ORDER BY FF.QUARTER_ID DESC;