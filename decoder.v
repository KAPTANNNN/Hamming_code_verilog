`timescale 1ns / 1ps
module decoder(c_in,clk,s,c2,d );
input clk;
input [1:7] c_in;
output reg[1:3]s;
output reg[1:7]c2;
output reg[1:4]d;
always@(posedge clk)
begin
s[3] = c_in[1]^c_in[3]^c_in[5]^c_in[7];
s[2] = c_in[2]^c_in[3]^c_in[6]^c_in[7];
s[1] = c_in[4]^c_in[5]^c_in[6]^c_in[7];
c2=c_in;
if(s)
c2[s]=~c_in[s];
end
always@(c2)
begin
d[1]=c2[3];
d[2]=c2[5];
d[3]=c2[6];
d[4]=c2[7];
end
endmodule


