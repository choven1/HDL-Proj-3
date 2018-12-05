module RandomPoint(CLK_100MHz, randX, randY);
	input CLK_100MHz;
	output reg [9:0]randX;
	output reg [9:0]randY;
	
	reg [9:0]pointX, pointY;

	always @(posedge CLK_100MHz) 
	begin
	if(pointX<770) 
		pointX <= pointX+10; 
	else
		pointX <= 20;
		
	if (pointX<570)
		pointX <= pointY+10;
	else		
		pointY <= 20;
		
	end
	
	assign randX = pointX;
	assign randY = pointY;
endmodule

