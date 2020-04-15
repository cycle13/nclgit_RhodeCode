;-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=- 
; vprofile_cldfracRHliqice.ncl
;
; produce a figure that shows the vertical profile of clouds, RH, cloud 
; liquid, cloud ice, and temperature from the 
; rcemip simulations run with CAM5 and CAM6
;
; initially the focus is to plot the profiles in temperature coordinates
; 
; this script should also be able to plot the profiles in pressure, height, 
; or temperature coordinates.
;
; levi silvers							march 30
;-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=- 
;
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_code.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_csm.ncl"

begin

; ta_avg
; cldfrac_avg

; temperature
fileta_c5="/glade/scratch/levi/RCEMIP/CAM5_GCM/RCE_large295/1D/CAM5_GCM_RCE_large295_1D_ta_avg.nc"
fileta_c5_b="/glade/scratch/levi/RCEMIP/CAM5_GCM/RCE_large300/1D/CAM5_GCM_RCE_large300_1D_ta_avg.nc"
fileta_c5_c="/glade/scratch/levi/RCEMIP/CAM5_GCM/RCE_large305/1D/CAM5_GCM_RCE_large305_1D_ta_avg.nc"
fileta_c6="/glade/scratch/levi/RCEMIP/CAM6_GCM/RCE_large295/1D/CAM6_GCM_RCE_large295_1D_ta_avg.nc"
fileta_c6_b="/glade/scratch/levi/RCEMIP/CAM6_GCM/RCE_large300/1D/CAM6_GCM_RCE_large300_1D_ta_avg.nc"
fileta_c6_c="/glade/scratch/levi/RCEMIP/CAM6_GCM/RCE_large305/1D/CAM6_GCM_RCE_large305_1D_ta_avg.nc"

; cloud fraction
filecld_c5_a="/glade/scratch/levi/RCEMIP/CAM5_GCM/RCE_large295/1D/CAM5_GCM_RCE_large295_1D_cldfrac_avg.nc"
filecld_c5_b="/glade/scratch/levi/RCEMIP/CAM5_GCM/RCE_large300/1D/CAM5_GCM_RCE_large300_1D_cldfrac_avg.nc"
filecld_c5_c="/glade/scratch/levi/RCEMIP/CAM5_GCM/RCE_large305/1D/CAM5_GCM_RCE_large305_1D_cldfrac_avg.nc"
filecld_c6_a="/glade/scratch/levi/RCEMIP/CAM6_GCM/RCE_large295/1D/CAM6_GCM_RCE_large295_1D_cldfrac_avg.nc"
filecld_c6_b="/glade/scratch/levi/RCEMIP/CAM6_GCM/RCE_large300/1D/CAM6_GCM_RCE_large300_1D_cldfrac_avg.nc"
filecld_c6_c="/glade/scratch/levi/RCEMIP/CAM6_GCM/RCE_large305/1D/CAM6_GCM_RCE_large305_1D_cldfrac_avg.nc"

; RH hur_avg
filehur_c5_a="/glade/scratch/levi/RCEMIP/CAM5_GCM/RCE_large295/1D/CAM5_GCM_RCE_large295_1D_hur_avg.nc"
filehur_c5_b="/glade/scratch/levi/RCEMIP/CAM5_GCM/RCE_large300/1D/CAM5_GCM_RCE_large300_1D_hur_avg.nc"
filehur_c5_c="/glade/scratch/levi/RCEMIP/CAM5_GCM/RCE_large305/1D/CAM5_GCM_RCE_large305_1D_hur_avg.nc"
filehur_c6_a="/glade/scratch/levi/RCEMIP/CAM6_GCM/RCE_large295/1D/CAM6_GCM_RCE_large295_1D_hur_avg.nc"
filehur_c6_b="/glade/scratch/levi/RCEMIP/CAM6_GCM/RCE_large300/1D/CAM6_GCM_RCE_large300_1D_hur_avg.nc"
filehur_c6_c="/glade/scratch/levi/RCEMIP/CAM6_GCM/RCE_large305/1D/CAM6_GCM_RCE_large305_1D_hur_avg.nc"

; cloud liquid clw_avg
fileclw_c5_a="/glade/scratch/levi/RCEMIP/CAM5_GCM/RCE_large295/1D/CAM5_GCM_RCE_large295_1D_clw_avg.nc"
fileclw_c5_b="/glade/scratch/levi/RCEMIP/CAM5_GCM/RCE_large300/1D/CAM5_GCM_RCE_large300_1D_clw_avg.nc"
fileclw_c5_c="/glade/scratch/levi/RCEMIP/CAM5_GCM/RCE_large305/1D/CAM5_GCM_RCE_large305_1D_clw_avg.nc"
fileclw_c6_a="/glade/scratch/levi/RCEMIP/CAM6_GCM/RCE_large295/1D/CAM6_GCM_RCE_large295_1D_clw_avg.nc"
fileclw_c6_b="/glade/scratch/levi/RCEMIP/CAM6_GCM/RCE_large300/1D/CAM6_GCM_RCE_large300_1D_clw_avg.nc"
fileclw_c6_c="/glade/scratch/levi/RCEMIP/CAM6_GCM/RCE_large305/1D/CAM6_GCM_RCE_large305_1D_clw_avg.nc"

; cloud ice cli_avg 
filecli_c5_a="/glade/scratch/levi/RCEMIP/CAM5_GCM/RCE_large295/1D/CAM5_GCM_RCE_large295_1D_cli_avg.nc"
filecli_c5_b="/glade/scratch/levi/RCEMIP/CAM5_GCM/RCE_large300/1D/CAM5_GCM_RCE_large300_1D_cli_avg.nc"
filecli_c5_c="/glade/scratch/levi/RCEMIP/CAM5_GCM/RCE_large305/1D/CAM5_GCM_RCE_large305_1D_cli_avg.nc"
filecli_c6_a="/glade/scratch/levi/RCEMIP/CAM6_GCM/RCE_large295/1D/CAM6_GCM_RCE_large295_1D_cli_avg.nc"
filecli_c6_b="/glade/scratch/levi/RCEMIP/CAM6_GCM/RCE_large300/1D/CAM6_GCM_RCE_large300_1D_cli_avg.nc"
filecli_c6_c="/glade/scratch/levi/RCEMIP/CAM6_GCM/RCE_large305/1D/CAM6_GCM_RCE_large305_1D_cli_avg.nc"


fta_c5_a   =addfile(fileta_c5,"r")
fta_c5_b   =addfile(fileta_c5_b,"r")
fta_c5_c   =addfile(fileta_c5_c,"r")

fta_c6_a   =addfile(fileta_c6,"r")
fta_c6_b   =addfile(fileta_c6_b,"r")
fta_c6_c   =addfile(fileta_c6_c,"r")

fcl_5a=addfile(filecld_c5_a,"r")
fcl_5b=addfile(filecld_c5_b,"r")
fcl_5c=addfile(filecld_c5_c,"r")
fcl_6a=addfile(filecld_c6_a,"r")
fcl_6b=addfile(filecld_c6_b,"r")
fcl_6c=addfile(filecld_c6_c,"r")

frh_5a=addfile(filehur_c5_a,"r")
frh_5b=addfile(filehur_c5_b,"r")
frh_5c=addfile(filehur_c5_c,"r")
frh_6a=addfile(filehur_c6_a,"r")
frh_6b=addfile(filehur_c6_b,"r")
frh_6c=addfile(filehur_c6_c,"r")

fclw_5a=addfile(fileclw_c5_a,"r")
fclw_5b=addfile(fileclw_c5_b,"r")
fclw_5c=addfile(fileclw_c5_c,"r")
fclw_6a=addfile(fileclw_c6_a,"r")
fclw_6b=addfile(fileclw_c6_b,"r")
fclw_6c=addfile(fileclw_c6_c,"r")

fcli_5a=addfile(filecli_c5_a,"r")
fcli_5b=addfile(filecli_c5_b,"r")
fcli_5c=addfile(filecli_c5_c,"r")
fcli_6a=addfile(filecli_c6_a,"r")
fcli_6b=addfile(filecli_c6_b,"r")
fcli_6c=addfile(filecli_c6_c,"r")



; read data from files into variables
temp_5_a       = fta_c5_a->ta_avg(:,:)
temp_5_b       = fta_c5_b->ta_avg(:,:)
temp_5_c       = fta_c5_c->ta_avg(:,:)
temp_6_a       = fta_c6_a->ta_avg(:,:)
temp_6_b       = fta_c6_b->ta_avg(:,:)
temp_6_c       = fta_c6_c->ta_avg(:,:)

cldfrac_5a = fcl_5a->cldfrac_avg(:,:)
cldfrac_5b = fcl_5b->cldfrac_avg(:,:)
cldfrac_5c = fcl_5c->cldfrac_avg(:,:)
cldfrac_6a = fcl_6a->cldfrac_avg(:,:)
cldfrac_6b = fcl_6b->cldfrac_avg(:,:)
cldfrac_6c = fcl_6c->cldfrac_avg(:,:)

hur_5a = frh_5a->hur_avg(:,:)
hur_5b = frh_5b->hur_avg(:,:)
hur_5c = frh_5c->hur_avg(:,:)
hur_6a = frh_6a->hur_avg(:,:)
hur_6b = frh_6b->hur_avg(:,:)
hur_6c = frh_6c->hur_avg(:,:)

clw_5a = fclw_5a->clw_avg(:,:)
clw_5b = fclw_5b->clw_avg(:,:)
clw_5c = fclw_5c->clw_avg(:,:)
clw_6a = fclw_6a->clw_avg(:,:)
clw_6b = fclw_6b->clw_avg(:,:)
clw_6c = fclw_6c->clw_avg(:,:)

cli_5a = fcli_5a->cli_avg(:,:)
cli_5b = fcli_5b->cli_avg(:,:)
cli_5c = fcli_5c->cli_avg(:,:)
cli_6a = fcli_6a->cli_avg(:,:)
cli_6b = fcli_6b->cli_avg(:,:)
cli_6c = fcli_6c->cli_avg(:,:)



levels_c5a        = fcl_5a->lev(:) 
;levels_c5b        = fcl_5b->lev(:) 
;levels_c5c        = fcl_5c->lev(:) 
levels_c6        = fcl_6a->lev(:) 

; probably need to exclude the initial spin up time...
cf_5a         = dim_avg_n(cldfrac_5a,0)
cf_5b         = dim_avg_n(cldfrac_5b,0)
cf_5c         = dim_avg_n(cldfrac_5c,0)
cf_6a         = dim_avg_n(cldfrac_6a,0)
cf_6b         = dim_avg_n(cldfrac_6b,0)
cf_6c         = dim_avg_n(cldfrac_6c,0)

lw_5a         = dim_avg_n(clw_5a,0)
lw_5b         = dim_avg_n(clw_5b,0)
lw_5c         = dim_avg_n(clw_5c,0)
lw_6a         = dim_avg_n(clw_6a,0)
lw_6b         = dim_avg_n(clw_6b,0)
lw_6c         = dim_avg_n(clw_6c,0)

li_5a         = dim_avg_n(cli_5a,0)
li_5b         = dim_avg_n(cli_5b,0)
li_5c         = dim_avg_n(cli_5c,0)
li_6a         = dim_avg_n(cli_6a,0)
li_6b         = dim_avg_n(cli_6b,0)
li_6c         = dim_avg_n(cli_6c,0)

rh_5a         = dim_avg_n(hur_5a,0)
rh_5b         = dim_avg_n(hur_5b,0)
rh_5c         = dim_avg_n(hur_5c,0)
rh_6a         = dim_avg_n(hur_6a,0)
rh_6b         = dim_avg_n(hur_6b,0)
rh_6c         = dim_avg_n(hur_6c,0)

temp_c5a_mn       = dim_avg_n(temp_5_a,0)
temp_c5b_mn       = dim_avg_n(temp_5_b,0)
temp_c5c_mn       = dim_avg_n(temp_5_c,0)
temp_c6a_mn       = dim_avg_n(temp_6_a,0)
temp_c6b_mn       = dim_avg_n(temp_6_b,0)
temp_c6c_mn       = dim_avg_n(temp_6_c,0)

vaxis1a = levels_c5a
;vaxis1b = levels_c5b
;vaxis1c = levels_c5c
vaxis2 = levels_c6
vaxis_t_5a = temp_c5a_mn
vaxis_t_5b = temp_c5b_mn
vaxis_t_5c = temp_c5c_mn
vaxis_t_6a = temp_c6a_mn
vaxis_t_6b = temp_c6b_mn
vaxis_t_6c = temp_c6c_mn

  print("dimension sizes of temp are:"+dimsizes(temp_c5a_mn))
  print("dimension sizes of cldfrac are:"+dimsizes(cldfrac_5a))

;**************************************************************************
;      create plot
;**************************************************************************

wks=gsn_open_wks("eps","testplot")
gsn_define_colormap(wks,"CBR_drywet")
plot=new(4,graphic)

res                                     = True

  res@gsnDraw          = False
  res@gsnFrame         = False

  res@xyDashPattern          = 0  
  ;res@xyLineColors           = (/"sienna2","sienna1","deepskyblue"/)
  ;res@xyLineThicknesses      = (/2.0,2.0,3.5/)
  ;res@xyExplicitLegendLabels = (/ "we","are","not"/)
  ;res@tiMainString           = "Where are the Anvils?"
;  res@tiYAxisString          = "Pressure (hPa)"
;  res@tiXAxisString          = "Cloud Fraction"
  res@tiXAxisString          = "RH (%)"
  res@tmXBMinorOn          = False

;  res@pmLegendDisplayMode    = "Always"                      ; turn on legend
;  res@pmLegendSide           = "Bottom"                      ; Change location of
;  res@pmLegendParallelPosF   = .2                           ; move units right
;  res@pmLegendOrthogonalPosF = -.48                          ; move units down
;  res@pmLegendWidthF         = 0.12                          ; Change width and
;  res@pmLegendHeightF        = 0.06                           ; height of legend.
;  res@lgPerimOn              = False                         ; turn off box around
  res@lgLabelFontHeightF     = .015                          ; label font height

  res@trYReverse             = True     ; reverse the y-axis
  res@trXMaxF                =  100.
  res@trXMinF                =  0.
  res@trYMaxF                =  305
  res@trYMinF                =  190
  res@tmYROn            = False
  res@tmXTOn            = False
  res@tiYAxisString          = "Temperature (K)"
  res@tmYRBorderOn      = False
  res@tmXTBorderOn      = False
;  res@trYMinF                =  20.0
;  res@trYMaxF                =  30.0

;  res@tmYUseLeft             = False
  ;res@tmYRLabelsOn           = True
  res@tmYLLabelsOn           = True
  ;res@tmEqualizeXYSizes      = True
  ;res@tmYRMode               = "Explicit"              ; explicitly set YR tick marks
  ;res@tmYRValues             = (/29.0,26.4,21.6/)                ; set the YR values (in F) where the major tick marks will be

  res@vpWidthF               = 0.3
  res@vpHeightF              = 0.49

  res@xyLineColors = "chocolate2"
  res@xyLineThicknessF  = 1.0
  plot0a = gsn_csm_xy(wks,rh_5a(:),vaxis_t_5a,res)
  res@xyLineThicknessF  = 2.5
  plot0b = gsn_csm_xy(wks,rh_5b(:),vaxis_t_5b,res)
  res@xyLineThicknessF  = 4.0
  plot0c = gsn_csm_xy(wks,rh_5c(:),vaxis_t_5c,res)

  res@xyLineColors = "aquamarine3"
  res@xyLineThicknessF  = 1.0
  plot0d = gsn_csm_xy(wks,rh_6a(:),vaxis_t_6a,res)
  res@xyLineThicknessF  = 2.5
  plot0e = gsn_csm_xy(wks,rh_6b(:),vaxis_t_6b,res)
  res@xyLineThicknessF  = 4.0
  plot0f = gsn_csm_xy(wks,rh_6c(:),vaxis_t_6c,res)

  overlay(plot0a,plot0b) 
  overlay(plot0a,plot0c) 
  overlay(plot0a,plot0d) 
  overlay(plot0a,plot0e) 
  overlay(plot0a,plot0f) 


  ;res@tiYAxisString          = "Temperature (K)"
  res@tiYAxisString          = ""
  res@tiXAxisString          = "Cloud Fraction"
  res@trXMaxF                =  1.0
  res@trXMinF                =  0.0

  res@xyLineColors = "chocolate2"
  res@xyLineThicknessF  = 1.0
  plot1a = gsn_csm_xy(wks,cf_5a(:),vaxis_t_5a,res)
  res@xyLineThicknessF  = 2.5
  plot1b = gsn_csm_xy(wks,cf_5b(:),vaxis_t_5b,res)
  res@xyLineThicknessF  = 4.0
  plot1c = gsn_csm_xy(wks,cf_5c(:),vaxis_t_5c,res)

  res@xyLineColors = "aquamarine3"
  res@xyLineThicknessF  = 1.0
  plot1d = gsn_csm_xy(wks,cf_6a(:),vaxis_t_6a,res)
  res@xyLineThicknessF  = 2.5
  plot1e = gsn_csm_xy(wks,cf_6b(:),vaxis_t_6b,res)
  res@xyLineThicknessF  = 4.0
  plot1f = gsn_csm_xy(wks,cf_6c(:),vaxis_t_6c,res)

  overlay(plot1a,plot1b) 
  overlay(plot1a,plot1c) 
  overlay(plot1a,plot1d) 
  overlay(plot1a,plot1e) 
  overlay(plot1a,plot1f) 
 
; cld liq 
  res@tiYAxisString          = ""
  res@tiXAxisString          = "Cloud Liquid (g/kg)"
  res@trXMaxF                =  0.06
  res@trXMinF                =  0.0

  res@xyLineColors = "chocolate2"
  res@xyLineThicknessF  = 1.0
  plot2a = gsn_csm_xy(wks,1000.*lw_5a(:),vaxis_t_5a,res)
  res@xyLineThicknessF  = 2.5
  plot2b = gsn_csm_xy(wks,1000.*lw_5b(:),vaxis_t_5b,res)
  res@xyLineThicknessF  = 4.0
  plot2c = gsn_csm_xy(wks,1000.*lw_5c(:),vaxis_t_5c,res)

  res@xyLineColors = "aquamarine3"
  res@xyLineThicknessF  = 1.0
  plot2d = gsn_csm_xy(wks,1000.*lw_6a(:),vaxis_t_6a,res)
  res@xyLineThicknessF  = 2.5
  plot2e = gsn_csm_xy(wks,1000.*lw_6b(:),vaxis_t_6b,res)
  res@xyLineThicknessF  = 4.0
  plot2f = gsn_csm_xy(wks,1000.*lw_6c(:),vaxis_t_6c,res)

  overlay(plot2a,plot2b) 
  overlay(plot2a,plot2c) 
  overlay(plot2a,plot2d) 
  overlay(plot2a,plot2e) 
  overlay(plot2a,plot2f) 

; cld ice
  res@tiYAxisString          = ""
  res@tiXAxisString          = "Cloud Ice (g/kg)"
  res@trXMaxF                =  0.024
  res@trXMinF                =  0.0

  res@xyLineColors = "chocolate2"
  res@xyLineThicknessF  = 1.0
  plot3a = gsn_csm_xy(wks,1000.*li_5a(:),vaxis_t_5a,res)
  res@xyLineThicknessF  = 2.5
  plot3b = gsn_csm_xy(wks,1000.*li_5b(:),vaxis_t_5b,res)
  res@xyLineThicknessF  = 4.0
  plot3c = gsn_csm_xy(wks,1000.*li_5c(:),vaxis_t_5c,res)

  res@xyLineColors = "aquamarine3"
  res@xyLineThicknessF  = 1.0
  plot3d = gsn_csm_xy(wks,1000.*li_6a(:),vaxis_t_6a,res)
  res@xyLineThicknessF  = 2.5
  plot3e = gsn_csm_xy(wks,1000.*li_6b(:),vaxis_t_6b,res)
  res@xyLineThicknessF  = 4.0
  plot3f = gsn_csm_xy(wks,1000.*li_6c(:),vaxis_t_6c,res)

  overlay(plot3a,plot3b) 
  overlay(plot3a,plot3c) 
  overlay(plot3a,plot3d) 
  overlay(plot3a,plot3e) 
  overlay(plot3a,plot3f) 


  plot(0) =plot0a
  plot(1) =plot1a
  plot(2) =plot2a
  plot(3) =plot3a

;maintitle="try again bafoon"

  lgres                      = True
  lgres@xyLabelMode            = "Custom"
  lgres@xyLineLabelFontHeightF = 0.015                ; font height
  lgres@lgLineColors         = (/"aquamarine3","chocolate2"/)
  lgres@lgItemType           = "Lines"
  lgres@lgLabelFontHeightF   = .06
  lgres@vpWidthF             = 0.2        ; width of legend
  lgres@vpHeightF            = 0.18        ; height of legend
  lgres@lgPerimOn            = False                         ; turn off box around
  lgres@lgLineThicknessF     = 3.0
;  lgres@lgPerimThicknessF    = 2.0
  lgres@lgMonoDashIndex      = False 
  lgres@lgDashIndexes          = (/"0","0"/)

  title1="CAM6"
  title2="CAM5"
  labels = (/title1,title2/)
  legend  = gsn_create_legend (wks, 2, labels, lgres)

  amres = True
  amres@amJust = "BottomRight"

  amres@amParallelPosF   = 0.44    ; Move legend to right
  ;amres@amParallelPosF   = 0.05    ; Move legend to right
  amres@amOrthogonalPosF = 0.47     ; Move legend down

  annoid = gsn_add_annotation(plot(1),legend,amres) ; add legend to plot

respanel = True
;respanel@txString = maintitle

;gsn_panel(wks,plot,(/1,3/),respanel)
gsn_panel(wks,plot,(/1,4/),respanel)

end





