transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+M:/Academics/Sem5/WorkPlace/Circuits\ and\ Systems\ Design/Digital/Final\ Processor\ Design/hydra {M:/Academics/Sem5/WorkPlace/Circuits and Systems Design/Digital/Final Processor Design/hydra/bcd7seg.v}

