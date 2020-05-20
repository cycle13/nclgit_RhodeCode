;-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
; aqua_ecs_camrce.ncl
;
; compute the climate sensitivity using the Cess method, from the cmip6
; +4K aquaplanet experiments 
;
; originally written for: macbook
;
; levi silvers                                                 April 2020
;-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-

load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_code.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_csm.ncl"

begin 

file_1="/Users/silvers/data/CAM/CESM2/tas_Amon_CESM2_aqua-control_r1i1p1f1_gn_000101-001012.nc"
file_2="/Users/silvers/data/CAM/CESM2/tas_Amon_CESM2_aqua-p4K_r1i1p1f1_gn_000101-001012.nc"

; radiative fluxes from control experiment
file_3="/Users/silvers/data/CAM/CESM2/rlut_Amon_CESM2_aqua-control_r1i1p1f1_gn_000101-001012.nc"
file_4="/Users/silvers/data/CAM/CESM2/rlutcs_Amon_CESM2_aqua-control_r1i1p1f1_gn_000101-001012.nc"
file_5="/Users/silvers/data/CAM/CESM2/rsdt_Amon_CESM2_aqua-control_r1i1p1f1_gn_000101-001012.nc"
file_6="/Users/silvers/data/CAM/CESM2/rsut_Amon_CESM2_aqua-control_r1i1p1f1_gn_000101-001012.nc"
file_7="/Users/silvers/data/CAM/CESM2/rsutcs_Amon_CESM2_aqua-control_r1i1p1f1_gn_000101-001012.nc"

; radiative fluxes from p4K experiment
file_3b="/Users/silvers/data/CAM/CESM2/rlut_Amon_CESM2_aqua-p4K_r1i1p1f1_gn_000101-001012.nc"
file_4b="/Users/silvers/data/CAM/CESM2/rlutcs_Amon_CESM2_aqua-p4K_r1i1p1f1_gn_000101-001012.nc"
file_5b="/Users/silvers/data/CAM/CESM2/rsdt_Amon_CESM2_aqua-p4K_r1i1p1f1_gn_000101-001012.nc"
file_6b="/Users/silvers/data/CAM/CESM2/rsut_Amon_CESM2_aqua-p4K_r1i1p1f1_gn_000101-001012.nc"
file_7b="/Users/silvers/data/CAM/CESM2/rsutcs_Amon_CESM2_aqua-p4K_r1i1p1f1_gn_000101-001012.nc"

F0=addfile(file_1,"r")
F1=addfile(file_2,"r")

F3=addfile(file_3,"r")
F4=addfile(file_4,"r")
F5=addfile(file_5,"r")
F6=addfile(file_6,"r")
F7=addfile(file_7,"r")

F3b=addfile(file_3b,"r")
F4b=addfile(file_4b,"r")
F5b=addfile(file_5b,"r")
F6b=addfile(file_6b,"r")
F7b=addfile(file_7b,"r")

time = F0->time

tas_cont=F0->tas
tas_p4K =F1->tas

rlut_c=F3->rlut
rlutcs_c=F4->rlutcs
rsdt_c=F5->rsdt
rsut_c=F6->rsut
rsutcs_c=F7->rsutcs

rsutcs_e=F7b->rsutcs
rsut_e=F6b->rsut
rsdt_e=F5b->rsdt
rlutcs_e=F4b->rlutcs
rlut_e=F3b->rlut

print("tas_cont dims are: "+dimsizes(tas_cont))

printVarSummary(tas_p4K)

endtime=120
tas_cont_weighted =new(endtime,float)
tas_p4K_weighted  =new(endtime,float)

rlut_cont_weighted      =new(endtime,float)
rlutcs_cont_weighted    =new(endtime,float)
rsdt_cont_weighted      =new(endtime,float)
rsut_cont_weighted      =new(endtime,float)
rsutcs_cont_weighted    =new(endtime,float)

rlut_p4K_weighted      =new(endtime,float)
rlutcs_p4K_weighted    =new(endtime,float)
rsdt_p4K_weighted      =new(endtime,float)
rsut_p4K_weighted      =new(endtime,float)
rsutcs_p4K_weighted    =new(endtime,float)

; compute global mean
;---------------------------------------------------------------------
; compute lat weights to determine the global mn
  lat  = F0->lat
  rad  = 4.0*atan(1.0)/180.0
  clat = cos(lat*rad)
  ;field1_test = where(field1.gt.-900., field1,default_fillvalue("float"))

  tas_cont_weighted        = wgt_areaave(tas_cont,clat,1.0,0)
  tas_p4K_weighted         = wgt_areaave(tas_p4K,clat,1.0,0)

  rlut_cont_weighted       = wgt_areaave(rlut_c,clat,1.0,0)
  rlutcs_cont_weighted     = wgt_areaave(rlutcs_c,clat,1.0,0)
  rsdt_cont_weighted       = wgt_areaave(rsdt_c,clat,1.0,0)
  rsut_cont_weighted       = wgt_areaave(rsut_c,clat,1.0,0)
  rsutcs_cont_weighted     = wgt_areaave(rsutcs_c,clat,1.0,0)

  rlut_p4K_weighted        = wgt_areaave(rlut_e,clat,1.0,0)
  rlutcs_p4K_weighted      = wgt_areaave(rlutcs_e,clat,1.0,0)
  rsdt_p4K_weighted        = wgt_areaave(rsdt_e,clat,1.0,0)
  rsut_p4K_weighted        = wgt_areaave(rsut_e,clat,1.0,0)
  rsutcs_p4K_weighted      = wgt_areaave(rsutcs_e,clat,1.0,0)
;---------------------------------------------------------------------


tas_cont_mn =dim_avg_n(tas_cont_weighted,0)
tas_p4K_mn  =dim_avg_n(tas_p4K_weighted,0)

delT=tas_p4K_mn-tas_cont_mn

print("change in surface temperature for +4K aqua experiment is: "+delT)

; compute the radiative balance at the TOA
; sw in - sw out - lw out

rad_c=rsdt_cont_weighted-rsut_cont_weighted-rlut_cont_weighted
rad_e=rsdt_p4K_weighted-rsut_p4K_weighted-rlut_p4K_weighted

rad_c_mn=dim_avg_n(rad_c,0)
rad_e_mn=dim_avg_n(rad_e,0)

cs_mn=(rad_c_mn-rad_e_mn)/delT

print("cess sensitivity is: "+cs_mn)

end
