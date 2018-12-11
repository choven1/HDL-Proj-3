module RandomPoint(CLK_100MHz, randX, randY);
	input CLK_100MHz;
	output [10:0]randX;
	output [10:0]randY;
	
	reg [10:0]pointX, pointY;

	always @(posedge CLK_100MHz) 
	begin
        if(pointX<760) 
            pointX <= pointX+20; 
        else
            pointX <= 20;
            
        if (pointY<560)
            pointY <= pointY+20;
        else		
            pointY <= 20;	
	end
	
	assign randX = pointX;
	assign randY = pointY;
endmodule

