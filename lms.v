`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/24/2021 09:51:21 AM
// Design Name: 
// Module Name: lms
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module lms(x1,x2,x3,x4,w1,w2,w3,w4,d,m,y,clk,wp1,wp2,wp3,wp4);
input clk;
input [7:0]x1,x2,x3,x4,m;
input [31:0]w1,w2,w3,w4,d;
output reg [31:0]y,wp1,wp2,wp3,wp4;
reg [31:0]e;
reg [31:0]me,me_shift,mex1,mex1_shift,mex2,mex2_shift,mex3,mex3_shift,mex4,mex4_shift,lout,acc,acc_shift,wn1,wn2,wn3,wn4,l,l1,l2,l3,l4,y1,y2,y3,y4,y5;
reg msb,start,msb1,msb2,msb3,msb4,msb5;
reg [2:0]i,j,k;
integer update=0;
initial
begin
me=0;me_shift=0;mex1=0;mex1_shift=0;acc=0;acc_shift=0;start=1;y1=0;y2=0;y3=0;y4=0;y5=0;mex2=0;mex2_shift=0;mex3=0;mex3_shift=0;l=0;l1=0;l2=0;l4=0;l3=0;
mex4=0;mex4_shift=0;e=0;i=0;
end
always @(posedge clk)  //x[n]w[n] calculation
begin
if(start)
    begin
    wp1=w1;wp2=w2;wp3=w3;wp4=w4;
    start=0;
    end
    else if(update==24)
    begin
        wp1=wp1+y1;wp2=wp2+y2;wp3=wp3+y3;wp4=wp4+y4;update=0;
    end
i=(update<8)?update:0;
update=update+1;
    case({x1[i],x2[i],x3[i],x4[i]})
    0:lout=0;
    1:lout=wp4;
    2:lout=wp3;
    3:lout=wp4+wp3;
    4:lout=wp2;
    5:lout=wp2+wp4;
    6:lout=wp2+wp3;
    7:lout=wp2+wp3+wp4;
    8:lout=wp1;
    9:lout=wp1+wp4;
    10:lout=wp1+wp3;
    11:lout=wp1+wp3+wp4;
    12:lout=wp1+wp2;
    13:lout=wp1+wp2+wp4;
    14:lout=wp1+wp2+wp3;
    15:lout=wp1+wp2+wp3+wp4;
endcase
if(i==7)
begin
    y=acc_shift-lout;
    e=(d-y);
    acc=0;acc_shift=0;
    if(e==0)
    begin
    start=1;
    end
end
else
begin
    acc=acc_shift+lout;
    msb=acc[31];
    acc_shift=acc>>1;
    acc_shift[31]=msb;
end
end
always @(posedge clk) //me calculation
begin
j=((update>7)&&(update<16)&&(start==0))?(update-8):0;
l=(m[j]==0)?0:e;
    if(j==7)
    begin
    y5=me_shift-l;
    me=0;me_shift=0;
    end
    else
    begin
    me=me_shift+l;
    msb5=me[31];
    me_shift=me>>1;
    me_shift[31]=msb5;
    end
end
always @(posedge clk) //mex calculation
begin
k=((update>15)&&(update<24)&&(start==0))?(update-16):0;
l1=(x1[k]==0)?0:y5;
l2=(x2[k]==0)?0:y5;
l3=(x3[k]==0)?0:y5;
l4=(x4[k]==0)?0:y5;
    if(k==7)
    begin
    y1=mex1_shift-l1;
    y2=mex2_shift-l2;
    y3=mex3_shift-l3;
    y4=mex4_shift-l4;
    mex1=0;mex1_shift=0;mex2=0;mex2_shift=0;mex3=0;mex3_shift=0;mex4=0;mex4_shift=0;
    end
    else
    begin
    mex1=mex1_shift+l1;
    msb1=mex1[31];
    mex1_shift=mex1>>1;
    mex1_shift[31]=msb1; //mex1
    mex2=mex2_shift+l2;
    msb2=mex2[31];
    mex2_shift=mex2>>1;
    mex2_shift[31]=msb2; //mex2
    mex3=mex3_shift+l3;
    msb3=mex3[31];
    mex3_shift=mex3>>1;
    mex3_shift[31]=msb3; //mex3
    mex4=mex4_shift+l4;
    msb4=mex4[31];
    mex4_shift=mex4>>1;
    mex4_shift[31]=msb4; //mex4
    end
end
endmodule