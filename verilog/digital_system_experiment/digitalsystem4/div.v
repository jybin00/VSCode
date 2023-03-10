module divider(A,B,QUO,REM);

input [3:0]A;
inout [3:0]B;
output [3:0] QUO;
output [3:0] REM;

reg [3:0] QUO=4'b0000;
reg [3:0] REM=4'b0000;
reg [3:0] a1,b1;
reg [3:0] p1;
integer i;

always@(A or B)

begin
a1=A;
b1=B;
p1=0;

for(i=0; i<4; i=i+1) 
    begin
    p1={p1[2:0], a1[3]};
    a1[3:1] = a1[2:0];
    p1=p1-b1;

    if(p1[3] == 1) 
        begin
        a1[0]=1'b0;
        p1=p1+b1;
        end
    else 
        begin
        a1[0]=1'b1;
        end
    end
    QUO=a1;
    REM=p1;
end

endmodule