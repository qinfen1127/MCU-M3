#-----------------------------------------------------------------------------------
#  author   : hr_li
#  data     : 2020/3/1
#  function : run vivado tcl script
#-----------------------------------------------------------------------------------

#-----------------------------------------------------------------------------------
#  echo vivado start time & set top design
#-----------------------------------------------------------------------------------
set            top_file       fpga_top
set            fmat_time      [clock format [clock seconds] -format {%D %T}]
puts           stdout         "vivado start : $fmat_time"

#-----------------------------------------------------------------------------------
#  read verilog file
#-----------------------------------------------------------------------------------
source		   rtl.tcl
read_verilog   $FILELIST

#-----------------------------------------------------------------------------------
#  auto detect xpm ip
#-----------------------------------------------------------------------------------
auto_detect_xpm

#-----------------------------------------------------------------------------------
#  read xdc file
#-----------------------------------------------------------------------------------
read_xdc       fpga_location.xdc
read_xdc       constrain.xdc

#-----------------------------------------------------------------------------------
#  synth design
#-----------------------------------------------------------------------------------
puts		   stdout		  $INC_PATH
synth_design -top $top_file -part xc7z035ffg676-2 -flatten rebuilt \
-directive AlternateRoutability -include_dirs $INC_PATH

#-----------------------------------------------------------------------------------
#  place design
#-----------------------------------------------------------------------------------
place_design -directive ExtraNetDelay_high


#-----------------------------------------------------------------------------------
#  route design
#-----------------------------------------------------------------------------------
route_design -directive Explore

#-----------------------------------------------------------------------------------
#  output bit file
#-----------------------------------------------------------------------------------
write_bitstream -force $top_file.bit

