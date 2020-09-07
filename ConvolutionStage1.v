`define wordlength 16
`timescale 1ns / 10ps
/*
`define stridex 1
`define stridey 2
`define width 166
`define height 586
`define depth 1
`define kernalx 2
`define kernaly 5
*/
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

module ConvolutionStage1(
	input clk,
	input reset,
	input enable,
	input signed[`wordlength-1:0]datain1,
	input signed[`wordlength-1:0]datain2,
	input signed[`wordlength-1:0]datain3,
	input signed[`wordlength-1:0]datain4,
	input signed[`wordlength-1:0]datain5,
	input signed[`wordlength-1:0]datain6,
	input signed[`wordlength-1:0]datain7,
	input signed[`wordlength-1:0]datain8,
	input signed[`wordlength-1:0]datain9,
	input signed[`wordlength-1:0]datain10,
	output signed[`wordlength-1:0]dataout,
	output reg donesignal
	);
	
	wire signed [`wordlength-1:0] add1,add2,add3,add4,add5,add6,add7;
	reg signed[`wordlength-1:0]filterout1;
	reg signed[`wordlength-1:0]filterout2;
	reg signed[`wordlength-1:0]filterout3;
	reg signed[`wordlength-1:0]filterout4;
	reg signed[`wordlength-1:0]filterout5;
	reg signed[`wordlength-1:0]filterout6;
	reg signed[`wordlength-1:0]filterout7;
	reg signed[`wordlength-1:0]filterout8;
	reg signed[`wordlength-1:0]filterout9;
	reg signed[`wordlength-1:0]filterout10;
	
	
	
	always @(posedge clk )
	begin
	if (reset==1'b1)
	begin
		filterout1<=0;
		filterout2<=0;
		filterout3<=0;
		filterout4<=0;
		filterout5<=0;
		filterout6<=0;
		filterout7<=0;
		filterout8<=0;
		filterout9<=0;
		filterout10<=0;
		donesignal<=0;
	end
	/*
	else if(enable==1)
	begin
		filterout1<=datain1*`weight1;
		filterout2<=datain2*`weight2;
		filterout3<=datain3*`weight3;
		filterout4<=datain4*`weight4;
		filterout5<=datain5*`weight5;
		filterout6<=datain6*`weight6;
		filterout7<=datain7*`weight7;
		filterout8<=datain8*`weight8;
		filterout9<=datain9*`weight9;
		filterout10<=datain10*`weight10;
		donesignal<=1'b1;
	end
	*/
	else if(enable==1)
	begin
		filterout1<=$signed(datain1)*$signed(16'd1);
		filterout2<=$signed(datain2)*$signed(16'd2);
		filterout3<=$signed(datain3)*$signed(16'd3);
		filterout4<=$signed(datain4)*$signed(16'd0);
		filterout5<=$signed(datain5)*$signed(16'd0);
		filterout6<=$signed(datain6)*$signed(16'd1);
		filterout7<=$signed(datain7)*$signed(16'd2);
		filterout8<=$signed(datain8)*$signed(16'd3);
		filterout9<=$signed(datain9)*$signed(16'd0);
		filterout10<=$signed(datain10)*$signed(16'd0);
		donesignal<=1'b1;
	end
	else
	begin
		filterout1<=0;
		filterout2<=0;
		filterout3<=0;
		filterout4<=0;
		filterout5<=0;
		filterout6<=0;
		filterout7<=0;
		filterout8<=0;
		filterout9<=0;
		filterout10<=0;
		donesignal<=0;
	end
	
	
	end
	
	assign add1=filterout1+filterout2;
	assign add2=filterout3+filterout4;
	assign add3=filterout5+filterout6;
	assign add4=filterout7+filterout8;
	assign add5=filterout9+filterout10;
	assign add6=add1+add2;
	assign add7=add3+add4;

	assign dataout=add6+add7+add5;	
	
endmodule
	
	