;-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=- 
;
; produce a figure that shows the vertical profile of clouds from the 
; rcemip simulations run with CAM5 and CAM6
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
levels_c5a        = fcl_5a->lev(:) 
;levels_c5b        = fcl_5b->lev(:) 
;levels_c5c        = fcl_5c->lev(:) 
levels_c6        = fcl_6a->lev(:) 

cf_5a         = dim_avg_n(cldfrac_5a,0)
cf_5b         = dim_avg_n(cldfrac_5b,0)
cf_5c         = dim_avg_n(cldfrac_5c,0)
cf_6a         = dim_avg_n(cldfrac_6a,0)
cf_6b         = dim_avg_n(cldfrac_6b,0)
cf_6c         = dim_avg_n(cldfrac_6c,0)

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
plot=new(2,graphic)

res                                     = True

  res@gsnDraw          = False
  res@gsnFrame         = False

  res@xyDashPattern          = 0  
  ;res@xyLineColors           = (/"sienna2","sienna1","deepskyblue"/)
  ;res@xyLineThicknesses      = (/2.0,2.0,3.5/)
  ;res@xyExplicitLegendLabels = (/ "we","are","not"/)
  ;res@tiMainString           = "Where are the Anvils?"
  res@tiYAxisString          = "Pressure (hPa)"
  res@tiXAxisString          = "Cloud Fraction"

;  res@pmLegendDisplayMode    = "Always"                      ; turn on legend
;  res@pmLegendSide           = "Bottom"                      ; Change location of
;  res@pmLegendParallelPosF   = .2                           ; move units right
;  res@pmLegendOrthogonalPosF = -.48                          ; move units down
;  res@pmLegendWidthF         = 0.12                          ; Change width and
;  res@pmLegendHeightF        = 0.06                           ; height of legend.
;  res@lgPerimOn              = False                         ; turn off box around
  res@lgLabelFontHeightF     = .015                          ; label font height

  res@trYReverse             = True     ; reverse the y-axis
  res@trXMaxF                =  1.0
  res@trXMinF                =  0.0
  res@tmYROn            = False
  res@tmXTOn            = False
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

  res@vpWidthF               = 0.35
  res@vpHeightF              = 0.7

;  plot(0)   = gsn_csm_xy(wks,time/365.,avg_ts,res)
  res@xyLineColors = "chocolate2"
  ;res@xyLineThicknessF  = lthick
  res@xyLineThicknessF  = 1.0
  plot0a = gsn_csm_xy(wks,cf_5a(:),vaxis1a,res)

  res@xyLineColors = "chocolate2"
  res@xyLineThicknessF  = 2.5
  plot0b = gsn_csm_xy(wks,cf_5b(:),vaxis1a,res)

  res@xyLineColors = "chocolate2"
  res@xyLineThicknessF  = 4.0
  plot0c = gsn_csm_xy(wks,cf_5c(:),vaxis1a,res)

  res@trYMaxF                =  305
  res@trYMinF                =  190
  res@xyLineColors = "aquamarine3"
  res@xyLineThicknessF  = 1.0
  plot0d = gsn_csm_xy(wks,cf_6a(:),vaxis2,res)

  res@xyLineColors = "aquamarine3"
  res@xyLineThicknessF  = 2.5
  plot0e = gsn_csm_xy(wks,cf_6b(:),vaxis2,res)

  res@xyLineColors = "aquamarine3"
  res@xyLineThicknessF  = 4.0
  plot0f = gsn_csm_xy(wks,cf_6c(:),vaxis2,res)
  
  overlay(plot0a,plot0b) 
  overlay(plot0a,plot0c) 
  overlay(plot0a,plot0d) 
  overlay(plot0a,plot0e) 
  overlay(plot0a,plot0f) 


  res@tiYAxisString          = "Temperature (K)"

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


  plot(0) =plot0a
  plot(1) =plot1a

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
  amres@amOrthogonalPosF = 0.47     ; Move legend down

  annoid = gsn_add_annotation(plot(0),legend,amres) ; add legend to plot

respanel = True
;respanel@txString = maintitle

gsn_panel(wks,plot,(/1,2/),respanel)

end





