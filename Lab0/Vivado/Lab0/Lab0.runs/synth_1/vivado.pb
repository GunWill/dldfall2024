
�
Command: %s
1870*	planAhead2�
�read_checkpoint -auto_incremental -incremental C:/Users/ekravch/Documents/GitHub/dldfall2024/Lab0/Vivado/Lab0/Lab0.srcs/utils_1/imports/synth_1/top_demo.dcpZ12-2866h px� 
�
;Read reference checkpoint from %s for incremental synthesis3154*	planAhead2o
mC:/Users/ekravch/Documents/GitHub/dldfall2024/Lab0/Vivado/Lab0/Lab0.srcs/utils_1/imports/synth_1/top_demo.dcpZ12-5825h px� 
T
-Please ensure there are no constraint changes3725*	planAheadZ12-7989h px� 
c
Command: %s
53*	vivadotcl22
0synth_design -top top_demo -part xc7z020clg484-1Z4-113h px� 
:
Starting synth_design
149*	vivadotclZ4-321h px� 
z
@Attempting to get a license for feature '%s' and/or device '%s'
308*common2
	Synthesis2	
xc7z020Z17-347h px� 
j
0Got license for feature '%s' and/or device '%s'
310*common2
	Synthesis2	
xc7z020Z17-349h px� 
D
Loading part %s157*device2
xc7z020clg484-1Z21-403h px� 

VNo compile time benefit to using incremental synthesis; A full resynthesis will be run2353*designutilsZ20-5440h px� 
�
�Flow is switching to default flow due to incremental criteria not met. If you would like to alter this behaviour and have the flow terminate instead, please set the following parameter config_implementation {autoIncr.Synth.RejectBehavior Terminate}2229*designutilsZ20-4379h px� 
o
HMultithreading enabled for synth_design using a maximum of %s processes.4828*oasys2
2Z8-7079h px� 
a
?Launching helper process for spawning children vivado processes4827*oasysZ8-7078h px� 
N
#Helper process launched with PID %s4824*oasys2
96052Z8-7075h px� 
�
%s*synth2{
yStarting RTL Elaboration : Time (s): cpu = 00:00:04 ; elapsed = 00:00:04 . Memory (MB): peak = 1429.965 ; gain = 440.871
h px� 
�
5undeclared symbol '%s', assumed default net type '%s'7502*oasys2
y2
wire2B
>C:/Users/ekravch/Documents/GitHub/dldfall2024/Lab0/SV/silly.sv2
38@Z8-11241h px� 
�
synthesizing module '%s'%s4497*oasys2

top_demo2
 2r
nC:/Users/ekravch/Documents/GitHub/dldfall2024/Lab0/Vivado/Lab0/Lab0.srcs/sources_1/imports/Desktop/top_demo.sv2
238@Z8-6157h px� 
�
synthesizing module '%s'%s4497*oasys2
	fulladder2
 2B
>C:/Users/ekravch/Documents/GitHub/dldfall2024/Lab0/SV/silly.sv2
68@Z8-6157h px� 
�
'done synthesizing module '%s'%s (%s#%s)4495*oasys2
	fulladder2
 2
02
12B
>C:/Users/ekravch/Documents/GitHub/dldfall2024/Lab0/SV/silly.sv2
68@Z8-6155h px� 
�
'done synthesizing module '%s'%s (%s#%s)4495*oasys2

top_demo2
 2
02
12r
nC:/Users/ekravch/Documents/GitHub/dldfall2024/Lab0/Vivado/Lab0/Lab0.srcs/sources_1/imports/Desktop/top_demo.sv2
238@Z8-6155h px� 
�
0Net %s in module/entity %s does not have driver.3422*oasys2
led2

top_demo2r
nC:/Users/ekravch/Documents/GitHub/dldfall2024/Lab0/Vivado/Lab0/Lab0.srcs/sources_1/imports/Desktop/top_demo.sv2
278@Z8-3848h px� 
q
9Port %s in module %s is either unconnected or has no load4866*oasys2
led[7]2

top_demoZ8-7129h px� 
q
9Port %s in module %s is either unconnected or has no load4866*oasys2
led[6]2

top_demoZ8-7129h px� 
q
9Port %s in module %s is either unconnected or has no load4866*oasys2
led[5]2

top_demoZ8-7129h px� 
q
9Port %s in module %s is either unconnected or has no load4866*oasys2
led[4]2

top_demoZ8-7129h px� 
q
9Port %s in module %s is either unconnected or has no load4866*oasys2
led[3]2

top_demoZ8-7129h px� 
q
9Port %s in module %s is either unconnected or has no load4866*oasys2
led[2]2

top_demoZ8-7129h px� 
p
9Port %s in module %s is either unconnected or has no load4866*oasys2
sw[3]2

top_demoZ8-7129h px� 
p
9Port %s in module %s is either unconnected or has no load4866*oasys2
sw[2]2

top_demoZ8-7129h px� 
p
9Port %s in module %s is either unconnected or has no load4866*oasys2
sw[1]2

top_demoZ8-7129h px� 
p
9Port %s in module %s is either unconnected or has no load4866*oasys2
sw[0]2

top_demoZ8-7129h px� 
q
9Port %s in module %s is either unconnected or has no load4866*oasys2
btn[3]2

top_demoZ8-7129h px� 
�
%s*synth2{
yFinished RTL Elaboration : Time (s): cpu = 00:00:05 ; elapsed = 00:00:05 . Memory (MB): peak = 1536.387 ; gain = 547.293
h px� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
;
%s
*synth2#
!Start Handling Custom Attributes
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
�
%s*synth2�
�Finished Handling Custom Attributes : Time (s): cpu = 00:00:05 ; elapsed = 00:00:05 . Memory (MB): peak = 1536.387 ; gain = 547.293
h px� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
�
%s*synth2�
�Finished RTL Optimization Phase 1 : Time (s): cpu = 00:00:05 ; elapsed = 00:00:05 . Memory (MB): peak = 1536.387 ; gain = 547.293
h px� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
�
I%sTime (s): cpu = %s ; elapsed = %s . Memory (MB): peak = %s ; gain = %s
268*common2
Netlist sorting complete. 2

00:00:002

00:00:002

1536.3872
0.000Z17-268h px� 
K
)Preparing netlist for logic optimization
349*projectZ1-570h px� 
>

Processing XDC Constraints
244*projectZ1-262h px� 
=
Initializing timing engine
348*projectZ1-569h px� 
�
Parsing XDC File [%s]
179*designutils2q
mC:/Users/ekravch/Documents/GitHub/dldfall2024/Lab0/Vivado/Lab0/Lab0.srcs/constrs_1/imports/Desktop/constr.xdc8Z20-179h px� 
�
Finished Parsing XDC File [%s]
178*designutils2q
mC:/Users/ekravch/Documents/GitHub/dldfall2024/Lab0/Vivado/Lab0/Lab0.srcs/constrs_1/imports/Desktop/constr.xdc8Z20-178h px� 
�
�Implementation specific constraints were found while reading constraint file [%s]. These constraints will be ignored for synthesis but will be used in implementation. Impacted constraints are listed in the file [%s].
233*project2o
mC:/Users/ekravch/Documents/GitHub/dldfall2024/Lab0/Vivado/Lab0/Lab0.srcs/constrs_1/imports/Desktop/constr.xdc2
.Xil/top_demo_propImpl.xdcZ1-236h px� 
H
&Completed Processing XDC Constraints

245*projectZ1-263h px� 
�
I%sTime (s): cpu = %s ; elapsed = %s . Memory (MB): peak = %s ; gain = %s
268*common2
Netlist sorting complete. 2

00:00:002

00:00:002

1588.1952
0.000Z17-268h px� 
l
!Unisim Transformation Summary:
%s111*project2'
%No Unisim elements were transformed.
Z1-111h px� 
�
I%sTime (s): cpu = %s ; elapsed = %s . Memory (MB): peak = %s ; gain = %s
268*common2"
 Constraint Validation Runtime : 2

00:00:002
00:00:00.0022

1588.1952
0.000Z17-268h px� 

VNo compile time benefit to using incremental synthesis; A full resynthesis will be run2353*designutilsZ20-5440h px� 
�
�Flow is switching to default flow due to incremental criteria not met. If you would like to alter this behaviour and have the flow terminate instead, please set the following parameter config_implementation {autoIncr.Synth.RejectBehavior Terminate}2229*designutilsZ20-4379h px� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
�
%s*synth2�
Finished Constraint Validation : Time (s): cpu = 00:00:10 ; elapsed = 00:00:10 . Memory (MB): peak = 1588.195 ; gain = 599.102
h px� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
D
%s
*synth2,
*Start Loading Part and Timing Information
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
8
%s
*synth2 
Loading part: xc7z020clg484-1
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
�
%s*synth2�
�Finished Loading Part and Timing Information : Time (s): cpu = 00:00:10 ; elapsed = 00:00:10 . Memory (MB): peak = 1588.195 ; gain = 599.102
h px� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
H
%s
*synth20
.Start Applying 'set_property' XDC Constraints
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
�
%s*synth2�
�Finished applying 'set_property' XDC Constraints : Time (s): cpu = 00:00:10 ; elapsed = 00:00:10 . Memory (MB): peak = 1588.195 ; gain = 599.102
h px� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
�
%s*synth2�
�Finished RTL Optimization Phase 2 : Time (s): cpu = 00:00:10 ; elapsed = 00:00:11 . Memory (MB): peak = 1588.195 ; gain = 599.102
h px� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
:
%s
*synth2"
 Start RTL Component Statistics 
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
9
%s
*synth2!
Detailed RTL Component Info : 
h p
x
� 
&
%s
*synth2
+---XORs : 
h p
x
� 
H
%s
*synth20
.	   3 Input      1 Bit         XORs := 1     
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
=
%s
*synth2%
#Finished RTL Component Statistics 
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
6
%s
*synth2
Start Part Resource Summary
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
q
%s
*synth2Y
WPart Resources:
DSPs: 220 (col length:60)
BRAMs: 280 (col length: RAMB18 60 RAMB36 30)
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
9
%s
*synth2!
Finished Part Resource Summary
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
E
%s
*synth2-
+Start Cross Boundary and Area Optimization
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
H
&Parallel synthesis criteria is not met4829*oasysZ8-7080h px� 
q
9Port %s in module %s is either unconnected or has no load4866*oasys2
led[7]2

top_demoZ8-7129h px� 
q
9Port %s in module %s is either unconnected or has no load4866*oasys2
led[6]2

top_demoZ8-7129h px� 
q
9Port %s in module %s is either unconnected or has no load4866*oasys2
led[5]2

top_demoZ8-7129h px� 
q
9Port %s in module %s is either unconnected or has no load4866*oasys2
led[4]2

top_demoZ8-7129h px� 
q
9Port %s in module %s is either unconnected or has no load4866*oasys2
led[3]2

top_demoZ8-7129h px� 
q
9Port %s in module %s is either unconnected or has no load4866*oasys2
led[2]2

top_demoZ8-7129h px� 
p
9Port %s in module %s is either unconnected or has no load4866*oasys2
sw[3]2

top_demoZ8-7129h px� 
p
9Port %s in module %s is either unconnected or has no load4866*oasys2
sw[2]2

top_demoZ8-7129h px� 
p
9Port %s in module %s is either unconnected or has no load4866*oasys2
sw[1]2

top_demoZ8-7129h px� 
p
9Port %s in module %s is either unconnected or has no load4866*oasys2
sw[0]2

top_demoZ8-7129h px� 
q
9Port %s in module %s is either unconnected or has no load4866*oasys2
btn[3]2

top_demoZ8-7129h px� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
�
%s*synth2�
�Finished Cross Boundary and Area Optimization : Time (s): cpu = 00:00:11 ; elapsed = 00:00:12 . Memory (MB): peak = 1588.195 ; gain = 599.102
h px� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
@
%s
*synth2(
&Start Applying XDC Timing Constraints
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
�
%s*synth2�
�Finished Applying XDC Timing Constraints : Time (s): cpu = 00:00:15 ; elapsed = 00:00:16 . Memory (MB): peak = 1588.195 ; gain = 599.102
h px� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
4
%s
*synth2
Start Timing Optimization
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
�
%s*synth2
}Finished Timing Optimization : Time (s): cpu = 00:00:15 ; elapsed = 00:00:16 . Memory (MB): peak = 1588.195 ; gain = 599.102
h px� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
3
%s
*synth2
Start Technology Mapping
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
�
%s*synth2~
|Finished Technology Mapping : Time (s): cpu = 00:00:15 ; elapsed = 00:00:16 . Memory (MB): peak = 1588.195 ; gain = 599.102
h px� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
-
%s
*synth2
Start IO Insertion
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
?
%s
*synth2'
%Start Flattening Before IO Insertion
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
B
%s
*synth2*
(Finished Flattening Before IO Insertion
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
6
%s
*synth2
Start Final Netlist Cleanup
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
9
%s
*synth2!
Finished Final Netlist Cleanup
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
�
%s*synth2x
vFinished IO Insertion : Time (s): cpu = 00:00:18 ; elapsed = 00:00:19 . Memory (MB): peak = 1588.195 ; gain = 599.102
h px� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
=
%s
*synth2%
#Start Renaming Generated Instances
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
�
%s*synth2�
�Finished Renaming Generated Instances : Time (s): cpu = 00:00:18 ; elapsed = 00:00:19 . Memory (MB): peak = 1588.195 ; gain = 599.102
h px� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
:
%s
*synth2"
 Start Rebuilding User Hierarchy
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
�
%s*synth2�
�Finished Rebuilding User Hierarchy : Time (s): cpu = 00:00:18 ; elapsed = 00:00:19 . Memory (MB): peak = 1588.195 ; gain = 599.102
h px� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
9
%s
*synth2!
Start Renaming Generated Ports
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
�
%s*synth2�
�Finished Renaming Generated Ports : Time (s): cpu = 00:00:18 ; elapsed = 00:00:19 . Memory (MB): peak = 1588.195 ; gain = 599.102
h px� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
;
%s
*synth2#
!Start Handling Custom Attributes
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
�
%s*synth2�
�Finished Handling Custom Attributes : Time (s): cpu = 00:00:18 ; elapsed = 00:00:19 . Memory (MB): peak = 1588.195 ; gain = 599.102
h px� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
8
%s
*synth2 
Start Renaming Generated Nets
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
�
%s*synth2�
�Finished Renaming Generated Nets : Time (s): cpu = 00:00:18 ; elapsed = 00:00:19 . Memory (MB): peak = 1588.195 ; gain = 599.102
h px� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
9
%s
*synth2!
Start Writing Synthesis Report
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
/
%s
*synth2

Report BlackBoxes: 
h p
x
� 
8
%s
*synth2 
+-+--------------+----------+
h p
x
� 
8
%s
*synth2 
| |BlackBox name |Instances |
h p
x
� 
8
%s
*synth2 
+-+--------------+----------+
h p
x
� 
8
%s
*synth2 
+-+--------------+----------+
h p
x
� 
/
%s*synth2

Report Cell Usage: 
h px� 
1
%s*synth2
+------+------+------+
h px� 
1
%s*synth2
|      |Cell  |Count |
h px� 
1
%s*synth2
+------+------+------+
h px� 
1
%s*synth2
|1     |LUT3  |     2|
h px� 
1
%s*synth2
|2     |IBUF  |     3|
h px� 
1
%s*synth2
|3     |OBUF  |     2|
h px� 
1
%s*synth2
|4     |OBUFT |     6|
h px� 
1
%s*synth2
+------+------+------+
h px� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
�
%s*synth2�
�Finished Writing Synthesis Report : Time (s): cpu = 00:00:18 ; elapsed = 00:00:19 . Memory (MB): peak = 1588.195 ; gain = 599.102
h px� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
a
%s
*synth2I
GSynthesis finished with 0 errors, 0 critical warnings and 12 warnings.
h p
x
� 
�
%s
*synth2�
Synthesis Optimization Runtime : Time (s): cpu = 00:00:12 ; elapsed = 00:00:18 . Memory (MB): peak = 1588.195 ; gain = 547.293
h p
x
� 
�
%s
*synth2�
�Synthesis Optimization Complete : Time (s): cpu = 00:00:18 ; elapsed = 00:00:19 . Memory (MB): peak = 1588.195 ; gain = 599.102
h p
x
� 
B
 Translating synthesized netlist
350*projectZ1-571h px� 
�
I%sTime (s): cpu = %s ; elapsed = %s . Memory (MB): peak = %s ; gain = %s
268*common2
Netlist sorting complete. 2

00:00:002

00:00:002

1588.1952
0.000Z17-268h px� 
K
)Preparing netlist for logic optimization
349*projectZ1-570h px� 
Q
)Pushed %s inverter(s) to %s load pin(s).
98*opt2
02
0Z31-138h px� 
�
I%sTime (s): cpu = %s ; elapsed = %s . Memory (MB): peak = %s ; gain = %s
268*common2
Netlist sorting complete. 2

00:00:002

00:00:002

1588.1952
0.000Z17-268h px� 
l
!Unisim Transformation Summary:
%s111*project2'
%No Unisim elements were transformed.
Z1-111h px� 
V
%Synth Design complete | Checksum: %s
562*	vivadotcl2

13965b28Z4-1430h px� 
C
Releasing license: %s
83*common2
	SynthesisZ17-83h px� 

G%s Infos, %s Warnings, %s Critical Warnings and %s Errors encountered.
28*	vivadotcl2
242
242
02
0Z4-41h px� 
L
%s completed successfully
29*	vivadotcl2
synth_designZ4-42h px� 
�
I%sTime (s): cpu = %s ; elapsed = %s . Memory (MB): peak = %s ; gain = %s
268*common2
synth_design: 2

00:00:222

00:00:292

1588.1952

1021.625Z17-268h px� 
�
I%sTime (s): cpu = %s ; elapsed = %s . Memory (MB): peak = %s ; gain = %s
268*common2
Write ShapeDB Complete: 2

00:00:002
00:00:00.0012

1588.1952
0.000Z17-268h px� 
�
 The %s '%s' has been generated.
621*common2

checkpoint2_
]C:/Users/ekravch/Documents/GitHub/dldfall2024/Lab0/Vivado/Lab0/Lab0.runs/synth_1/top_demo.dcpZ17-1381h px� 
�
%s4*runtcl2h
fExecuting : report_utilization -file top_demo_utilization_synth.rpt -pb top_demo_utilization_synth.pb
h px� 
\
Exiting %s at %s...
206*common2
Vivado2
Thu Aug 29 16:47:16 2024Z17-206h px� 


End Record