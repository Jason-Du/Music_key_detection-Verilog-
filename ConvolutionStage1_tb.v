`define wordlength 16
`timescale 1ns / 10ps
`define stridex 1
`define stridey 2
`define width 4
`define height 20
`define depth 1
`define kernalx 2
`define kernaly 1
`define weight1 1
`define weight2 2
`define weight3 3
`define weight4 0
`define weight5 0
`define weight6 1
`define weight7 2
`define weight8 3
`define weight9 0
`define weight10 0
`include "ConvolutionStage1.v"
module CNN_tb();
parameter 	CYCLE_HIGH = 1 , 
			CYCLE_LOW  = 1;
parameter	worldlengthbit =16'd0;
reg signed clk,reset;

					
					
					
wire [`wordlength-1:0]dataout;
wire donesignal;
			
`define		MODULE_NAME 	ConvolutionStage1
//`define 	SDF_FILE    	"bubblesort.sdf"
//`define		WAVE_FILE		"bubblesort_v2.vcd"
`define		MEM_FILE		"init.dat"
//FIX
reg signed[`wordlength-1:0] mem[165:0][585:0];





`ifdef MEM_FILE
initial
	begin 
		$readmemh(`MEM_FILE,mem);
	end
`else
initial
	begin
		$display("");
		$display("---------------------------------------------");
		$display("| You have not define the memory file name! |");
		$display("---------------------------------------------");
		$display("");
		#0.01 $finish;
	end
//clk
`endif



always
begin
	#CYCLE_HIGH clk = 0;
	#CYCLE_LOW  clk = 1;
end


reg [15:0]count;
reg [15:0] jcount;
wire [15:0]icount;
reg enableread;

//Initialize
initial
begin

	clk=1'b0;
	reset=1'b1;
	#10 reset=1'b0;
end




//------------------------------------------------Combinational--------------------------//
//FIX
assign icount=count<<1;


//-------------------------------------------Sequential----------------------------------//
reg [15:0]outputcolomn,outputrow;
reg lastrowsignal;
reg mentionlastrow;
always @ (posedge clk)
begin
	if (reset==1'b1)
		lastrowsignal<=1'b0;
	if(outputrow==16'd164 && mentionlastrow==1'b1)
		lastrowsignal<=1'b1;
end

always @ (posedge clk)
begin
	if(reset==1'b1)
	begin
		count=16'd0;
		jcount=16'd0;
		enableread=1'b0;
		mentionlastrow=1'b0;
	end
	//(`height/`stridey)FIX
	else if (count==16'd293)
	begin
		count<=16'd0;
		jcount<=jcount+16'd1;
		enableread=1'b0;
		mentionlastrow=1'b0;
	end
	else if (count==16'd292)
	begin
		count<=count+16'd1;
		enableread=1'b1;
		mentionlastrow=1'b1;
	end
	else
	begin
		count<=count+16'd1;
		enableread=1'b1;
		mentionlastrow=1'b0;
	end	
end



reg signed[`wordlength-1:0]	datarin1,
							datarin2,
							datarin3,
							datarin4,
							datarin5,
							datarin6,
							datarin7,
							datarin8,
							datarin9,
							datarin10;

always @(posedge clk)
begin
	if (enableread==1'b0)
	begin
		datarin1<=mem[0][0];
		datarin2<=mem[0][1];
		datarin3<=mem[0][2];
		datarin4<=mem[0][3];
		datarin5<=mem[0][4];
		datarin6<=(lastrowsignal==1'b1)?0:mem[1][0];
		datarin7<=(lastrowsignal==1'b1)?0:mem[1][1];
		datarin8<=(lastrowsignal==1'b1)?0:mem[1][2];
		datarin9<=(lastrowsignal==1'b1)?0:mem[1][3];
		datarin10<=(lastrowsignal==1'b1)?0:mem[1][4];
	end
//(count==(`height/`stridey)-1)FIX
	else if (count==16'd292)
	begin
		datarin1<=mem[0+jcount][0+icount];
		datarin2<=0;
		datarin3<=0;
		datarin4<=0;
		datarin5<=0;
		datarin6<=(lastrowsignal==1'b1)?0:mem[1+jcount][0+icount];
		datarin7<=0;
		datarin8<=0;
		datarin9<=0;
		datarin10<=0;
	end
//(count==((`height/`stridey)-2))FIX
	else if (count==16'd291)
	begin
		datarin1<=mem[0+jcount][0+icount];
		datarin2<=mem[0+jcount][1+icount];
		datarin3<=0;
		datarin4<=0;
		datarin5<=0;
		datarin6<=(lastrowsignal==1'b1)?0:mem[1+jcount][0+icount];
		datarin7<=(lastrowsignal==1'b1)?0:mem[1+jcount][1+icount];
		datarin8<=0;
		datarin9<=0;
		datarin10<=0;
	
	end
//(count==((`height/`stridey)-3))FIX
	else if (count==16'd290)
	begin
		datarin1<=mem[0+jcount][0+icount];
		datarin2<=mem[0+jcount][1+icount];
		datarin3<=mem[0+jcount][2+icount];
		datarin4<=0;
		datarin5<=0;
		datarin6<=(lastrowsignal==1'b1)?0:mem[1+jcount][0+icount];
		datarin7<=(lastrowsignal==1'b1)?0:mem[1+jcount][1+icount];
		datarin8<=(lastrowsignal==1'b1)?0:mem[1+jcount][2+icount];
		datarin9<=0;
		datarin10<=0;
	end
//(count==((`height/`stridey)-4))FIX
	else if (count==16'd289)
	begin
		datarin1<=mem[0+jcount][0+icount];
		datarin2<=mem[0+jcount][1+icount];
		datarin3<=mem[0+jcount][2+icount];
		datarin4<=mem[0+jcount][3+icount];
		datarin5<=0;
		datarin6<=(lastrowsignal==1'b1)?0:mem[1+jcount][0+icount];
		datarin7<=(lastrowsignal==1'b1)?0:mem[1+jcount][1+icount];
		datarin8<=(lastrowsignal==1'b1)?0:mem[1+jcount][2+icount];
		datarin9<=(lastrowsignal==1'b1)?0:mem[1+jcount][3+icount];
		datarin10<=0;
	end
	else
	begin
		datarin1<=mem[0+jcount][0+icount];
		datarin2<=mem[0+jcount][1+icount];
		datarin3<=mem[0+jcount][2+icount];
		datarin4<=mem[0+jcount][3+icount];
		datarin5<=mem[0+jcount][4+icount];
		datarin6<=(lastrowsignal==1'b1)?0:mem[1+jcount][0+icount];
		datarin7<=(lastrowsignal==1'b1)?0:mem[1+jcount][1+icount];
		datarin8<=(lastrowsignal==1'b1)?0:mem[1+jcount][2+icount];
		datarin9<=(lastrowsignal==1'b1)?0:mem[1+jcount][3+icount];
		datarin10<=(lastrowsignal==1'b1)?0:mem[1+jcount][4+icount];
	end
end
//FIX
reg signed[`wordlength-1:0]outmem[165:0][292:0];

reg cnndonesignal;


always @(posedge clk)
begin
	if (reset==1'b1)
	begin
		outputcolomn<=0;
		outputrow<=0;
		cnndonesignal<=0;
	end
	
	else if (donesignal==1'b1)
	begin
		outputcolomn<=outputcolomn+1;
//(count==(`height/`stridey)-1)
		if (outputcolomn==16'd292)
		begin
			outputrow=outputrow+1;
			outputcolomn<=0;
//width
			if (outputrow==16'd166)
				cnndonesignal<=1'b1;
				outputcolomn<=0;
		end	
	end
	else
		cnndonesignal<=0;
	
	

end


always @ (posedge clk)
begin
	if (cnndonesignal==1'b1)
		$writememh("memoryout.txt", outmem);
end



always @(negedge clk)
begin
	if(donesignal==1'b1)
		outmem[outputrow][outputcolomn]<=dataout;
end

`MODULE_NAME test(	.clk(clk),.reset(reset),
						.enable(enableread),
						.datain1(datarin1),
						.datain2(datarin2),
						.datain3(datarin3),
						.datain4(datarin4),
						.datain5(datarin5),
						.datain6(datarin6),
						.datain7(datarin7),
						.datain8(datarin8),
						.datain9(datarin9),
						.datain10(datarin10),
						.dataout(dataout),
						.donesignal(donesignal));
				

endmodule



























